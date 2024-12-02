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
('Clara Martins', 'Recife', '81900000000')
```

[Página Inicial](../README.md)
