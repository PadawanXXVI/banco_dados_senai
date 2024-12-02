# ATIVIDADE DA AULA 27 SOBRE INNER JOIN

## Criação e uso do banco de dados

```SQL
CREATE DATABASE IF NOT EXISTS db_loja_eletronicos03;
USE db_loja_eletronicos03;
```

## Criação da tabela cliente

```SQL
CREATE TABLE IF NOT EXISTS tb_cliente(
    id_cliente INT PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(125),
    cidade VARCHAR(125),
    telefone VARCHAR(125)
);
```

## Criação da tabela produto

```SQL
CREATE TABLE IF NOT EXISTS tb_produto(
    id_produto INT PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(125),
    categoria VARCHAR(125),
    preco DECIMAL(10,2)
);
```

## Criação da tabela venda

```SQL
CREATE TABLE IF NOT EXISTS tb_venda(
    id_venda INT PRIMARY KEY AUTO_INCREMENT,
    data_venda DATE,
    quantidade INT,
    id_cliente INT NOT NULL, -- para que exista uma venda, precisa ter no mínimo 1 cliente
    id_produto INT NOT NULL, -- para que exista uma venda, precisa existir no mínimo 1 produto comprado
    FOREIGN KEY (id_cliente) REFERENCES tb_cliente (id_cliente),
    FOREIGN KEY (id_produto) REFERENCES tb_produto (id_produto)
);
```

## Verificando as tabelas criadas e a estrutura de cada uma

```SQL
SHOW TABLES;
DESC tb_cliente;
DESC tb_produto;
DESC tb_venda;
```

## Cadastro de clientes

```SQL
INSERT INTO tb_cliente (nome, cidade, telefone) VALUES
('João Silva', 'Brasília', '61999999999'),
('Maria Oliveira', 'São Paulo', '11988888888'),
('Pedro Santos', 'Rio de Janeiro', '21977777777'),
('Ana Souza', 'Brasília', '41966666666'),
('Carlos Lima', 'Belo Horizonte', '71955555555'),
('Fernanda Mendes', 'Recife', '859444444444'),
('Lucas Almeida', 'Brasília', '92933333333'),
('Juliana Costa', 'Belo Horizonte', '31922222222'),
('Rafael Pereira', 'Recife', '51911111111'),
('Clara Martins', 'Recife', '81900000000');
```

## Visaulização dos clientes cadastrados

```SQL
SELECT * FROM tb_cliente;
```

## Cadastro de produtos

```SQL
INSERT INTO tb_produto (nome, categoria, preco) VALUES
('Notebook', 'Eletrônicos', '3500.00'),
('Smartphone', 'Eletrônicos', '2500.00'),
('', '', ''),
```

## Questão 1: Exibir o nome do cliente e a data da venda.
## Questão 2: Exibir o nome do cliente e o nome do produto vendido.
## Questão 3: Exibir a data da venda, o nome do cliente e o nome do produto.
## Questão 4: Exibir todos os produtos vendidos e o nome do cliente que comprou cada produto.
## Questão 5: Exibir o nome do cliente, o nome do produto e a quantidade comprada.
## Questão 6: Exibir todos os clientes e os produtos comprados por eles com a quantidade maior que 2.
## Questão 7: Exibir todos os clientes e os produtos comprados por eles, juntamente com o preço do produto.
## Questão 8: Exibir todos os produtos que foram vendidos, juntamente com a quantidade comprada e o preço.
## Questão 9: Exibir os clientes que compraram mais de 5 unidades de algum produto.
## Questão 10: Exibir os produtos vendidos com o nome do cliente que comprou, considerando apenas vendas feitas em 2023.
## Questão 11: Exibir todos os produtos vendidos e a quantidade total de cada produto vendido.
## Questão 12: Exibir todos os clientes e a soma total das compras de cada um (quantidade * preço do produto).
## Questão 13: Exibir o nome do cliente e o nome do produto comprado, considerando apenas clientes que compraram produtos da categoria  Eletrônicos".
## Questão 14: Exibir todos os clientes e os produtos comprados, mostrando também o valor total das compras (quantidade * preço).
## Questão 15: Exibir o nome do cliente, o nome do produto e a data da venda, considerando apenas as vendas que ocorreram em Janeiro de 2023.
## Questão 16: Exibir o nome do cliente e os produtos que ele comprou, considerando apenas os clientes que compraram mais de 3 produtos.
## Questão 17: Exibir todos os clientes que compraram produtos da categoria "Roupas".
## Questão 18: Exibir a data da venda, o nome do cliente e o nome do produto comprado, ordenado pela data da venda.
## Questão 19: Exibir o nome do cliente, o nome do produto e o preço do produto para todas as vendas realizadas em 2023.
## Questão 20: Exibir o nome do cliente e a quantidade total comprada de cada produto.

[Página Inicial](../README.md)
