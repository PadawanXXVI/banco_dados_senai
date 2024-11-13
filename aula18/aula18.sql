/*
Aula 04 - Operadores Lógicos e Relacionais (comparação)
*/

-- Criar e selecionar o Banco de Dados
CREATE DATABASE IF NOT EXISTS db_loja;
USE db_loja;


-- Criar tabela
CREATE TABLE IF NOT EXISTS tb_produto (
    id INT PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(100),
    categoria VARCHAR(50),
    preco DECIMAL(10, 2),
    quantidade_estoque INT,
    fornecedor VARCHAR(50)
);

-- Alimentar a tabela
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

-- Visualizar a tabela com os campos preenchidos
SELECT * FROM tb_produto;

-- Operador Lógico AND/e
SELECT * FROM tb_produto
WHERE categoria = 'eletrônicos'
AND preco > '1000';

-- Operador Lógico OR/ou
SELECT * FROM tb_produto
WHERE categoria = 'eletrônicos'
OR preco > '1000';

-- Operador Lógico NOT/não
SELECT * FROM tb_produto
WHERE NOT categoria = 'eletrônicos';

-- Operador Relacional BETWEEN/entre: mostra se o valor na coluna estiver entre o escolhido
SELECT * FROM tb_produto
WHERE preco BETWEEN 500 AND 2500;

-- Operador Relacional IN: verifica se o valor da coluna é o mesmo do valor escolhido
SELECT * FROM tb_produto
WHERE fornecedor IN ('LG', 'Samsung', 'Dell');

-- Operador Relacional LIKE: comparador
SELECT * FROM tb_produto
WHERE nome LIKE 'M%'; -- pesquisa tudo que começa com 'm'. Obs: % após o m informa que começa com m, se fosse antes, informa que termina com m

SELECT * FROM tb_produto
WHERE nome LIKE '%on%'; -- pesquisa onde houver 'on' no meio da palavra.
/*
Exemplos:
%Silva - onde começa com Silva
Silva% - onde termina com Silva
%Silva% - pesquisa onde tiver Silva, independentemente da posição
*/

-- Operador > (maior)
SELECT * FROM tb_produto
WHERE quantidade_estoque > 20;

-- Operador > (menor)
SELECT * FROM tb_produto
WHERE quantidade_estoque < 20;

-- Operador != OU <> (diferente)
SELECT * FROM tb_produto
WHERE categoria <> 'eletrônicos';
