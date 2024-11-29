# INNER JOIN

JOIN: junção  
INNER: interna

Vai combinar registros de duas ou mais tabelas com base em um coluna em comum.  
vai retornar os registros que possuem correspondência PK+FK.

## Estrutura do INNER

```SQL
SELECT colunas
FROM tabela1 INNER JOIN tabela2
ON tabela1.colunaPK = tabela2.colunaFK;
```

## Criação e seleção do banco de dados

```SQL
CREATE DATABASE IF NOT EXISTS db_join;
USE db_join;
```

## Criação da tabela cliente

```SQL
CREATE TABLE IF NOT EXISTS tb_cliente(
    id_cliente INT PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(125),
    cidade VARCHAR(125)
);
```

## Criação da tabela pedido

```SQL
CREATE TABLE IF NOT EXISTS tb_pedido(
    id_pedido INT PRIMARY KEY AUTO_INCREMENT,
    produto VARCHAR(125),
    valor DECIMAL(10,2),
    id_cliente INT NOT NULL,
    FOREIGN KEY (id_cliente) REFERENCES tb_cliente (id_cliente)
);
```

## Exibindo a estrutura das tabelas

```SQL
DESC tb_cliente;
DESC tb_produto;
```

## Cadastro de clientes

```SQL
INSERT INTO tb_cliente(nome, cidade) VALUES
('João', 'Brasília'),
('Ana', 'Goiania'),
('Carlos', 'Brasília'),
('Marina', 'São Paulo'),
('Maria', 'Uberaba'),
('Pedro', 'Goiânia');
```

## Cadastro de pedidos

```SQL
```

[Página Inicial](../README.md)
