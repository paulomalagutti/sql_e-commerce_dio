# sql_e-commerce_dio
Projeto de Banco de Dados de E-commerce para o desafio da DIO"

# Desafio de Projeto: Modelagem de Banco de Dados para E-commerce

Este repositório documenta a solução para o "Desafio de Projeto de Banco de Dados" proposto pela Digital Innovation One (DIO), focado na criação e refinamento de um esquema para um sistema de e-commerce.

---

## 📝 Descrição do Cenário

O objetivo principal foi projetar um banco de dados relacional que sirva como base para uma aplicação de e-commerce. O sistema deve ser capaz de gerenciar todo o ciclo de uma venda, desde o cadastro de clientes e produtos até a entrega final, passando pelo controle de pedidos, pagamentos e estoque.

---

## 🚀 Refinamentos Implementados no Esquema

Conforme solicitado no desafio, o modelo conceitual inicial foi aprimorado para incluir funcionalidades essenciais e mais robustas:

### 1. Clientes: Pessoa Física (PF) e Pessoa Jurídica (PJ)
A tabela `Cliente` foi modelada para aceitar tanto clientes individuais quanto empresariais.
-   Uma coluna `TipoCliente` do tipo `ENUM('PF', 'PJ')` foi adicionada para diferenciar os dois tipos.
-   Campos distintos para `CPF` e `CNPJ` foram criados, com uma restrição `UNIQUE` para cada, garantindo a integridade dos dados e evitando duplicidade de documentos.

### 2. Múltiplas Formas de Pagamento
Para oferecer flexibilidade nas transações, o sistema agora suporta múltiplos pagamentos para um único pedido.
-   Foi criada a tabela `Pagamento`, que se relaciona diretamente com a tabela `Pedido`.
-   Isso permite que um pedido possa ser pago com 'Cartão de Crédito' e 'PIX' simultaneamente, por exemplo, com cada transação registrada individualmente.

### 3. Sistema de Rastreamento de Entrega
Para melhorar a experiência do cliente no pós-compra, um sistema de acompanhamento de entregas foi implementado.
-   Uma tabela `Entrega` foi criada, associada a cada `Pedido`.
-   Ela armazena informações cruciais como `StatusEntrega` (ex: 'Em trânsito', 'Entregue') e o `CodigoRastreio` fornecido pela transportadora.

---

## 🛠️ Como Utilizar o Esquema

Para recriar este banco de dados em seu próprio ambiente:
1.  Tenha um sistema de gerenciamento de banco de dados MySQL instalado (como MySQL Server ou MariaDB).
2.  Utilize uma ferramenta de sua preferência (MySQL Workbench, DBeaver, etc.) para se conectar ao banco de dados.
3.  Execute o script contido no arquivo `esquema_ecommerce.sql` deste repositório. O script criará o banco de dados `ecommerce` e todas as suas tabelas e relacionamentos.
