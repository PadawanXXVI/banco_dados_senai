/*
II prova de SQL
*/

-- CRIAÇÃO E SELEÇÃO PARA USO DO BANCO DE DADOS
CREATE DATABASE IF NOT EXISTS db_ecommerce2;
USE db_ecommerce2;

-- CRIAÇÃO DAS TABELAS
# Tabela cliente 01/05
CREATE TABLE IF NOT EXISTS tb_cliente(
	id_cliente INT PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(125),
    email VARCHAR(125),
    telefone VARCHAR(20)
);

# Tabela produto 02/05
CREATE TABLE IF NOT EXISTS tb_produto(
	id_produto INT PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(125),
    descricao TEXT
);

# Tabela endereco do cliente 03/05
CREATE TABLE IF NOT EXISTS tb_end_cliente(
	id_end_cliente INT PRIMARY KEY AUTO_INCREMENT,
    logradouro VARCHAR(125),
    numero VARCHAR(20),
    complemento VARCHAR(125),
    bairro VARCHAR(125),
    cidade VARCHAR(125),
    estado VARCHAR(125),
    cep VARCHAR(20),
    id_cliente INT NOT NULL,
    FOREIGN KEY (id_cliente) REFERENCES tb_cliente (id_cliente)
);

# Tabela pedido 04/05
CREATE TABLE tb_pedido(
	id_pedido INT PRIMARY KEY AUTO_INCREMENT,
    data DATE,
    descricao TEXT,
    id_cliente INT NOT NULL,
    FOREIGN KEY (id_cliente) REFERENCES tb_cliente (id_cliente)
);

# Tabela pedido_produto 05/05
CREATE TABLE IF NOT EXISTS tb_pedido_produto(
	id_pedido_produto INT PRIMARY KEY AUTO_INCREMENT,
	qtd_produto INT,
    id_produto INT NOT NULL,
    id_pedido INT NOT NULL,
	FOREIGN KEY (id_produto) REFERENCES tb_produto (id_produto),
    FOREIGN KEY (id_pedido) REFERENCES tb_pedido (id_pedido)
);

-- POPULANDO AS TABELAS
-- Inserindo registros na tabela cliente
INSERT INTO tb_cliente 
	(nome, email, telefone)
VALUES 
	('João Silva', 'joao.silva@example.com', '1234567890'),
	('Maria Souza', 'maria.souza@example.com', '0987654321'),
	('Carlos Santos', 'carlos.santos@example.com', '1111111111'),
	('Ana Pereira', 'ana.pereira@example.com', '2222222222'),
	('Pedro Lima', 'pedro.lima@example.com', '3333333333'),
	('Paula Dias', 'paula.dias@example.com', '4444444444'),
	('Ricardo Almeida', 'ricardo.almeida@example.com', '5555555555');

SELECT * FROM tb_cliente;

-- Inserindo registros na tabela end_cliente
INSERT INTO tb_end_cliente
	(logradouro, numero, complemento, bairro, cidade, estado, cep, id_cliente)
VALUES 
	('Rua A', 123, 'Apto 101', 'Centro', 'São Paulo', 'SP', '01000-000', 1),
	('Rua B', 456, '', 'Jardins', 'Rio de Janeiro', 'RJ', '02000-000', 2),
	('Rua C', 789, 'Bloco B', 'Bela Vista', 'Belo Horizonte', 'MG', '03000-000', 3),
	('Rua D', 321, 'Casa', 'Moema', 'São Paulo', 'SP', '04000-000', 4),
	('Rua E', 654, '', 'Ipanema', 'Rio de Janeiro', 'RJ', '05000-000', 5),
	('Rua F', 987, 'Apto 202', 'Savassi', 'Belo Horizonte', 'MG', '06000-000', 6),
	('Rua G', 159, '', 'Barra da Tijuca', 'Rio de Janeiro', 'RJ', '07000-000', 7);
    
SELECT * FROM tb_end_cliente;

-- Inserindo registros na tabela produto
INSERT INTO tb_produto
	(nome, descricao)
VALUES 
	('Produto A', 'Descrição do produto A'),
	('Produto B', 'Descrição do produto B'),
	('Produto C', 'Descrição do produto C'),
	('Produto D', 'Descrição do produto D'),
	('Produto E', 'Descrição do produto E'),
	('Produto F', 'Descrição do produto F'),
	('Produto G', 'Descrição do produto G');

SELECT * FROM tb_produto;

-- Inserindo registros na tabela pedido
INSERT INTO tb_pedido
	(data, descricao, id_cliente)
VALUES 
	('2024-12-01', 'Pedido 1', 1),
	('2024-12-02', 'Pedido 2', 2),
	('2024-12-03', 'Pedido 3', 3),
	('2024-12-04', 'Pedido 4', 4),
	('2024-12-05', 'Pedido 5', 5),
	('2024-12-06', 'Pedido 6', 6),
	('2024-12-07', 'Pedido 7', 7);

SELECT * FROM tb_pedido;

-- Inserindo registros na tabela pedido_produto
INSERT INTO tb_pedido_produto
	(qtd_produto, id_pedido, id_produto)
VALUES 
	(5,1, 1),
	(3, 1, 2),
	(2, 2, 3),
	(4, 2, 4),
	(7, 3, 5),
	(4, 3, 6),
	(3, 4, 7),
	(1, 4, 1),
	(3, 5, 2),
	(8, 5, 3),
	(10, 6, 4),
	(2, 6, 5),
	(3, 7, 6),
	(5, 7, 7);
    
SELECT * FROM tb_pedido_produto;

-- Consultas:
-- 01 - Traga o nome de todos os clientes que tenham feito compras no ano de 2024.
-- 02 - Crie uma View que exibe o nome do cliente, data do pedido e quantidade total de itens.
-- 03 - Mostre o valor total de vendas realizadas no 1º semestre do ano.
-- 04 - Liste os 3 produtos mais vendidos.
-- 05 - Crie uma view para visualizar o nome do cliente, nome do produto e quantidade.
-- 06 - Crie uma View para exibir os nomes dos clientes e suas datas de pedido.
-- 07 - Crie uma View que mostra os nomes de produtos e seus preços maiores que R$50,00.
-- 08 - Crie uma Function que receba o ID de um produto e retorne seu preço e quantidade.
-- 09 - Classifique os produtos pela faixa de preço (barato, médio e caro).
-- 10- Crie uma Function que retorna a quantidade total de clientes cadastrados.
-- 11 - Obter os nomes dos clientes que realizaram pedidos em 2024 com o valor maior que 300.
-- 12 - Listar os nomes dos clientes, os produtos que compraram, a quantidade e o preço total pago por pedido.
-- 13 - O que é uma VIEW? 
-- 14 - O que é uma FUNCTION?
-- 15 - O que é uma PROCEDURE?
-- 16 - Qual a diferença de FUNCTION para PROCEDURE?
-- 17 - Faça mais 10 consultas que você julgar necessário para este cenário.