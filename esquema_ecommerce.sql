-- CRIAÇÃO DO BANCO DE DADOS PARA O CENÁRIO DE E-COMMERCE
CREATE DATABASE IF NOT EXISTS ecommerce;
USE ecommerce;

-- Tabela cliente
-- Refinamento: Adicionada a coluna 'TipoCliente' para diferenciar Pessoa Física e Jurídica
CREATE TABLE Cliente (
    idCliente INT AUTO_INCREMENT PRIMARY KEY,
    Nome VARCHAR(100) NOT NULL,
    TipoCliente ENUM('PF', 'PJ') NOT NULL,
    CPF CHAR(11),
    CNPJ CHAR(14),
    Endereco VARCHAR(255),
    Contato VARCHAR(45),
    CONSTRAINT unique_cpf_cliente UNIQUE (CPF),
    CONSTRAINT unique_cnpj_cliente UNIQUE (CNPJ)
);

-- Tabela produto
CREATE TABLE Produto (
    idProduto INT AUTO_INCREMENT PRIMARY KEY,
    NomeProduto VARCHAR(100) NOT NULL,
    Categoria VARCHAR(45),
    Descricao VARCHAR(255),
    Valor DECIMAL(10, 2) NOT NULL
);

-- Tabela pedido
CREATE TABLE Pedido (
    idPedido INT AUTO_INCREMENT PRIMARY KEY,
    idCliente INT,
    StatusPedido ENUM('Em andamento', 'Processando', 'Enviado', 'Entregue', 'Cancelado') DEFAULT 'Processando',
    Descricao VARCHAR(255),
    Frete FLOAT DEFAULT 0,
    CONSTRAINT fk_pedido_cliente FOREIGN KEY (idCliente) REFERENCES Cliente(idCliente)
);

-- Tabela Estoque
CREATE TABLE Estoque (
    idEstoque INT AUTO_INCREMENT PRIMARY KEY,
    Local VARCHAR(100) NOT NULL
);

-- Tabela Fornecedor
CREATE TABLE Fornecedor (
    idFornecedor INT AUTO_INCREMENT PRIMARY KEY,
    RazaoSocial VARCHAR(255) NOT NULL,
    CNPJ CHAR(14) NOT NULL,
    Contato VARCHAR(45),
    CONSTRAINT unique_cnpj_fornecedor UNIQUE (CNPJ)
);

-- Tabela de relacionamento: Produto em Estoque
CREATE TABLE Produto_Estoque (
    idProduto INT,
    idEstoque INT,
    Quantidade INT NOT NULL DEFAULT 0,
    PRIMARY KEY (idProduto, idEstoque),
    CONSTRAINT fk_estoque_produto FOREIGN KEY (idProduto) REFERENCES Produto(idProduto),
    CONSTRAINT fk_produto_estoque FOREIGN KEY (idEstoque) REFERENCES Estoque(idEstoque)
);

-- Tabela de relacionamento: Produto por Fornecedor
CREATE TABLE Produto_Fornecedor (
    idFornecedor INT,
    idProduto INT,
    PRIMARY KEY (idFornecedor, idProduto),
    CONSTRAINT fk_produto_fornecedor FOREIGN KEY (idFornecedor) REFERENCES Fornecedor(idFornecedor),
    CONSTRAINT fk_fornecedor_produto FOREIGN KEY (idProduto) REFERENCES Produto(idProduto)
);

-- Tabela de relacionamento: Produto em Pedido (Carrinho)
CREATE TABLE Produto_Pedido (
    idPedido INT,
    idProduto INT,
    Quantidade INT NOT NULL DEFAULT 1,
    Status ENUM('Disponível', 'Sem estoque') DEFAULT 'Disponível',
    PRIMARY KEY (idPedido, idProduto),
    CONSTRAINT fk_pedido_produto FOREIGN KEY (idPedido) REFERENCES Pedido(idPedido),
    CONSTRAINT fk_produto_pedido FOREIGN KEY (idProduto) REFERENCES Produto(idProduto)
);

-- Refinamento: Tabela Pagamento para permitir múltiplas formas
CREATE TABLE Pagamento (
    idPagamento INT AUTO_INCREMENT PRIMARY KEY,
    idPedido INT,
    FormaPagamento ENUM('Boleto', 'Cartão de Crédito', 'PIX', 'Dois Cartões') NOT NULL,
    Valor DECIMAL(10, 2) NOT NULL,
    Status ENUM('Pendente', 'Confirmado', 'Recusado') DEFAULT 'Pendente',
    CONSTRAINT fk_pagamento_pedido FOREIGN KEY (idPedido) REFERENCES Pedido(idPedido)
);

-- Refinamento: Tabela Entrega com status e código de rastreio
CREATE TABLE Entrega (
    idEntrega INT AUTO_INCREMENT PRIMARY KEY,
    idPedido INT,
    StatusEntrega ENUM('Preparando', 'Em trânsito', 'Entregue', 'Problema na entrega') NOT NULL,
    CodigoRastreio VARCHAR(50),
    DataPrevista DATE,
    CONSTRAINT fk_entrega_pedido FOREIGN KEY (idPedido) REFERENCES Pedido(idPedido)
);