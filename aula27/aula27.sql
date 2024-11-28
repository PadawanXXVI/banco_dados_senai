/*
Aula 08
INNER JOIN - junção interna
Vai combinar registros de duas ou mais tabelas com base em uma coluna em comum.
Vai retornar os registros que possuem correspondência PK+FK
*/

-- ESTRUTURA DO INNER
SELECT colunas
FROM tabela1 INNER JOIN tabela2
ON tabela1.colunaPK = tabela2.colunaFK;


-- CRIAÇÃO E SELEÇÃO DO BANCO DE DADOS
CREATE DATABASE IF NOT EXISTS db_join;
USE db_join;

-- CRIAÇÃO DAS TABELAS
CREATE TABLE IF NOT EXISTS tb_cliente(
	id_cliente INT PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(125),
    cidade VARCHAR(125)
);

CREATE TABLE tb_pedido(
	id_pedido INT PRIMARY KEY AUTO_INCREMENT,
    produto VARCHAR(125),
    valor DECIMAL (10,2),
    id_cliente INT NOT NULL,
    FOREIGN KEY (id_cliente) REFERENCES tb_cliente (id_cliente)
);

DESC tb_cliente;
DESC tb_pedido;

-- CADASTRANDO CLIENTES
INSERT INTO tb_cliente (nome, cidade) VALUES
('João', 'Brasília'),
('Ana', 'Goiânia'),
('Carlos', 'Brasília'),
('Mariana', 'São Paulo'),
('Maria', 'Uberaba'),
('Pedro', 'Goiânia');

-- CONFERINDO OS REGISTROS
SELECT * FROM tb_cliente;

-- CADASTRANDO PEDIDOS
INSERT INTO tb_pedido (id_pedido, id_cliente, produto, valor) VALUES
(101, 1, 'Notebook', 2500),
(102, 2, 'Smartphone', 1200),
(103, 3, 'Teclado', 150),
(104, 4, 'Mouse', 75);

-- CONFERINDO OS PEDIDOS
SELECT * FROM tb_pedido;

-- CONSULTA PARA EXIBIR O NOME DO CLIENTE E O PRODUTO
SELECT tb_cliente.nome, tb_pedido.produto FROM tb_cliente 
INNER JOIN tb_pedido
ON tb_cliente.id_cliente = tb_pedido.id_cliente;

-- USANDO ALIAS
SELECT c.nome, p.produto FROM tb_cliente AS c -- definindo a tabela cliente como 'c', por isso c.nome, c.id_cliente 
INNER JOIN tb_pedido AS p -- definindo a tabela produto com 'p', por isso p.produto, p.id_pedido
ON c.id_cliente = p.id_cliente;

-- USANDO O INNER JOIN
SELECT c.nome, p.produto, p.valor FROM tb_cliente AS c 
INNER JOIN tb_pedido AS p
ON c.id_cliente = p.id_cliente;

-- USANDO O LEFT JOIN
SELECT c.nome, p.produto, p.valor FROM tb_cliente AS c 
LEFT JOIN tb_pedido AS p -- faz as consultas a partir da coluna da esquerda, nesse caso, tabela cliente, por isso traria, todos os clientes, inclusive os que não fizeram compras
ON c.id_cliente = p.id_cliente;

-- USANDO O RIGHT JOIN
SELECT c.nome, p.produto, p.valor FROM tb_cliente AS c 
RIGHT JOIN tb_pedido AS p -- faz as consultas a partir da colna da direita, nesse caso, tabela pedido, por isso traz apenas os pedidos que foram feitos
ON c.id_cliente = p.id_cliente;

-- EXIBIR PEDIDOS COM VALOR MAIOR QUE 1.000
SELECT c.nome, p.valor FROM tb_cliente AS c
INNER JOIN tb_pedido AS p
ON c.id_cliente = p.id_cliente
WHERE p.valor > 1000;

-- CRIANDO A TERCEIRA TABELA
CREATE TABLE tb_vendedor(
	id_vendedor INT PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(100)
);

-- CADASTRANDO OS VENDEDORES
INSERT INTO tb_vendedor (nome) VALUES
('Carlos Silva'),
('Mariana Costa');

-- EXIBINDO TABELAS
SHOW TABLES;

-- INSERINDO A FK NA TABELA PEDIDO
ALTER TABLE tb_pedido
ADD COLUMN id_vendedor INT,
ADD FOREIGN KEY (id_vendedor)
REFERENCES tb_vendedor (id_vendedor);

-- CONFERIR A ESTRUTURA DAS TABEKAS
DESC tb_pedido;

-- INFORMANDO AS FK NA TABEA PEDIDO (VENDEDOR CARLOS)
UPDATE tb_pedido
SET id_vendedor = '1'
WHERE id_pedido IN('101','102');

-- INFORMANDO AS FK NA TABEA PEDIDO (VENDEDORA MARIANA)
UPDATE tb_pedido
SET id_vendedor = '2'
WHERE id_pedido IN (103, 104);

SELECT * FROM tb_pedido;

-- CONSULTA NAS 3 TABELAS
SELECT * FROM tb_cliente AS c
INNER JOIN tb_pedido AS p ON c.id_cliente = p.id_cliente
INNER JOIN tb_vendedor AS v ON v.id_vendedor = p.id_vendedor;

-- CONSULTANDO PELO NOME DO CLIENTE, O PRODUTO E O NOME DO VENDEDOR
SELECT c.nome, p.produto, v.nome FROM tb_cliente AS c
INNER JOIN tb_pedido AS p ON c.id_cliente = p.id_cliente
INNER JOIN tb_vendedor AS v ON v.id_vendedor = p.id_vendedor;

-- AGRUPE OS PEDIDFOS POR VENDEDOR SOMANDO OS VALORES DA VENDA
SELECT v.nome, SUM(p.valor) AS `Total vendido` FROM tb_pedido AS p
INNER JOIN tb_vendedor AS v ON v.id_vendedor = p.id_vendedor
GROUP BY v.nome;

-- AGRUPE OS PEDIDFOS POR VENDEDOR SOMANDO OS VALORES DA VENDA e INFORMANDO OS PRODUTOS
SELECT v.nome, SUM(p.valor) AS `Total vendido`, GROUP_CONCAT(p.produto SEPARATOR ' / ') AS `Produtos Vendidos` FROM tb_pedido AS p
INNER JOIN tb_vendedor AS v ON v.id_vendedor = p.id_vendedor
GROUP BY v.nome;

-- TRAZER OS PEDIDOS DO CIENTE CARLOS
SELECT c.nome, p.produto FROM tb_cliente AS c
INNER JOIN tb_pedido AS p ON c.id_cliente = p.id_cliente
WHERE c.nome = 'Carlos';
