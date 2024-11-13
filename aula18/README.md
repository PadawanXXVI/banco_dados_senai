# OPERADORES LÓGICOS E RELACIONAIS (COMPARAÇÃO)

## Criar o Banco de Dados

```SQL 
CREATE DATABASE db_loja;
```

## Selecionar o Banco de Dados

```SQL 
USE db_loja;
```

## Criar tabela

```SQL
CREATE TABLE tb_produto (
    id INT PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(100),
    categoria VARCHAR(50),
    preco DECIMAL(10, 2),
    quantidade_estoque INT,
    fornecedor VARCHAR(50)
);

```

## Alimentar a tabela

```SQL
INSERT INTO tb_produto (nome, categoria, preco, quantidade_estoque, fornecedor)
VALUES
    ('Notebook Dell Inspiron', 'Eletrônicos', 3500.00, 10, 'Dell'),
    ('Smartphone Samsung Galaxy', 'Eletrônicos', 1500.00, 25, 'Samsung'),
    ('Geladeira Brastemp', 'Eletrodomésticos', 2800.00, 5, 'Brastemp'),
    ('Fogão Consul 4 bocas', 'Eletrodomésticos', 800.00, 15, 'Consul'),
    ('Cafeteira Mondial', 'Eletrodomésticos', 150.00, 30, 'Mondial'),
    ('Televisão LG 55 polegadas', 'Eletrônicos', 2500.00, 8, 'LG'),
    ('Micro-ondas Panasonic', 'Eletrodomésticos', 600.00, 20, 'Panasonic'),
    ('Headset HyperX', 'Eletrônicos', 300.00, 50, 'HyperX'),
    ('Ventilador Arno Silence', 'Eletrodomésticos', 200.00, 40, 'Arno'),
    ('Impressora HP Deskjet', 'Eletrônicos', 450.00, 12, 'HP'),
    ('Smartwatch Xiaomi Mi Band 6', 'Eletrônicos', 250.00, 35, 'Xiaomi'),
    ('Batedeira Oster Planetária', 'Eletrodomésticos', 300.00, 18, 'Oster'),
    ('Fone de Ouvido JBL Tune', 'Eletrônicos', 120.00, 45, 'JBL'),
    ('Mouse Gamer Logitech G203', 'Eletrônicos', 150.00, 60, 'Logitech'),
    ('Forno Elétrico Philco', 'Eletrodomésticos', 800.00, 10, 'Philco');
```

## Visualizar a tabela com os campos preenchidos

```SQL
SELECT * FROM tb_produto;
```

## OPerador Lógico AND

```SQL
SELECT * FROM tb_produto
WHERE categoria = 'eletrônicos'
AND preco > '1000';
```

## Operador Lógico OR

```SQL
SELECT * FROM tb_produto
WHERE categoria = 'eletrônicos'
OR preco > '1000';
```

## Operador Lógico NOT

```SQL
SELECT * FROM tb_produto
WHERE NOT categoria = 'eletrônicos';
```

## Operador relacional BETWEEN
```SQL
SELECT * FROM tb_produto
WHERE preco BETWEEN 500 AND 2500;
```


[Página Inicial](../README.md)
