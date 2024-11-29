-- CRIANDO E SELECIONANDO O BANCO DE DADOS
CREATE DATABASE IF NOT EXISTS db_loja_eletronicos02;
USE db_loja_eletronicos02;

-- CRIANDO A TABELA CLIENTE
CREATE TABLE IF NOT EXISTS tb_cliente(
	id_cliente INT PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(125),
    cidade VARCHAR(125),
    telefone VARCHAR(125)
);

-- CRIANDO A TABELA PRODUTO
CREATE TABLE IF NOT EXISTS tb_produto(
	id_produto INT PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(125),
    categoria VARCHAR(125),
    preco DECIMAL(10,2)
);

-- CRIANDO A TABELA VENDA
CREATE TABLE IF NOT EXISTS tb_venda(
	id_venda INT PRIMARY KEY AUTO_INCREMENT,
    data_venda DATE,
    quantidade INT,
    id_cliente INT,
    id_produto INT,
    FOREIGN KEY (id_cliente) REFERENCES tb_cliente (id_cliente),
    FOREIGN KEY (id_produto) REFERENCES tb_produto (id_produto)   
);

DESC tb_cliente;
DESC tb_produto;
DESC tb_venda;

-- Inserindo dados na tabela tb_cliente
INSERT INTO tb_cliente (id_cliente, nome, cidade, telefone) VALUES
(1, 'João Silva', 'Brasília', '61999999999'),
(2, 'Maria Oliveira', 'São Paulo', '11988888888'),
(3, 'Pedro Santos', 'Rio de Janeiro', '21977777777'),
(4, 'Ana Souza', 'Brasília', '41966666666'),
(5, 'Carlos Lima', 'Belo Horizonte', '71955555555'),
(6, 'Fernanda Mendes', 'Recife', '85944444444'),
(7, 'Lucas Almeida', 'Brasília', '92933333333'),
(8, 'Juliana Costa', 'Belo Horizonte', '31922222222'),
(9, 'Rafael Pereira', 'Recife', '51911111111'),
(10, 'Clara Martins', 'Recife', '81900000000');

SELECT * FROM tb_cliente;

-- Inserindo dados na tabela tb_produto
INSERT INTO tb_produto (id_produto, nome, categoria, preco) VALUES
(1, 'Notebook', 'Eletrônicos', 3500.00),
(2, 'Smartphone', 'Eletrônicos', 2500.00),
(3, 'TV 50 polegadas', 'Eletrônicos', 2800.00),
(4, 'Geladeira', 'Eletrodomésticos', 4500.00),
(5, 'Microondas', 'Eletrodomésticos', 800.00),
(6, 'Cadeira Gamer', 'Móveis', 1200.00),
(7, 'Mesa de Escritório', 'Móveis', 600.00),
(8, 'Fone de Ouvido', 'Acessórios', 150.00),
(9, 'Câmera Fotográfica', 'Eletrônicos', 3000.00),
(10, 'Impressora', 'Eletrônicos', 900.00);

SELECT * FROM tb_produto;

-- Inserindo dados na tabela tb_venda
INSERT INTO tb_venda (id_venda, data_venda, quantidade, id_cliente, id_produto)
VALUES
(1, '2024-01-10', 10, 1, 1),
(2, '2024-01-15', 2, 2, 3),
(3, '2024-01-20', 1, 3, 2),
(4, '2024-01-25', 3, 4, 4),
(5, '2024-02-01', 2, 5, 6),
(6, '2024-02-05', 1, 6, 5),
(7, '2024-02-10', 4, 7, 8),
(8, '2024-02-15', 1, 8, 9),
(9, '2024-02-20', 2, 9, 7),
(10, '2024-02-25', 1, 10, 10);

SELECT * FROM tb_venda;

-- Questão 1: Exibir o nome do cliente e a data da venda.
SELECT c.nome, v.data_venda FROM tb_cliente AS c
INNER JOIN tb_venda AS v
ON c.id_cliente = v.id_cliente;

-- Questão 2: Exibir o nome do cliente e o nome do produto vendido.
SELECT c.nome, p.nome FROM tb_cliente AS c
INNER JOIN tb_venda AS v ON c.id_cliente = v.id_cliente
INNER JOIN tb_produto AS p ON p.id_produto = v.id_produto;

-- Questão 3: Exibir a data da venda, o nome do cliente e o nome do produto.
SELECT v.data_venda, c.nome, p.nome FROM tb_cliente AS c
INNER JOIN tb_venda AS v ON v.id_cliente = c.id_cliente
INNER JOIN tb_produto AS p ON p.id_produto = v.id_produto;

-- Questão 4: Exibir todos os produtos vendidos e o nome do cliente que comprou cada produto.
SELECT p.nome, c.nome FROM tb_produto AS p
INNER JOIN tb_venda AS v ON p.id_produto = v.id_produto
INNER JOIN tb_cliente AS c ON c.id_cliente = v.id_cliente;

-- Questão 5: Exibir o nome do cliente, o nome do produto e a quantidade comprada.
SELECT c.nome, p.nome, v.quantidade FROM tb_cliente AS c
INNER JOIN tb_venda	AS v ON c.id_cliente = v.id_cliente
INNER JOIN tb_produto AS p ON p.id_produto = v.id_produto;

-- Questão 6: Exibir todos os clientes e os produtos comprados por eles com a quantidade maior que 2.
SELECT c.nome, p.nome, v.quantidade FROM tb_cliente AS c
INNER JOIN tb_venda AS v ON c.id_cliente = v.id_cliente
INNER JOIN tb_produto AS p ON p.id_produto = v.id_produto
WHERE v.quantidade > '2';

-- Questão 7: Exibir todos os clientes e os produtos comprados por eles, juntamente com o preço do produto.
SELECT c.nome, p.nome, p.preco FROM tb_cliente AS c
INNER JOIN tb_venda AS v ON v.id_cliente = c.id_cliente
INNER JOIN tb_produto as p ON p.id_produto = v.id_produto;

-- Questão 8: Exibir todos os produtos que foram vendidos, juntamente com a quantidade comprada e o preço.
SELECT p.nome, v.quantidade, p.preco AS `Preço Unitário` FROM tb_produto AS p
INNER JOIN tb_venda as V ON p.id_produto = v.id_produto;

-- Questão 9: Exibir os clientes que compraram mais de 5 unidades de algum produto.
SELECT c.nome, p.nome, v.quantidade FROM tb_cliente AS c
INNER JOIN tb_venda AS v ON v.id_cliente = c.id_cliente
INNER JOIN tb_produto AS p ON p.id_produto = v.id_produto
WHERE v.quantidade > '5';

-- Questão 10: Exibir os produtos vendidos com o nome do cliente que comprou, considerando apenas vendas feitas em 2023.
SELECT p.nome, c.nome FROM tb_produto AS p
INNER JOIN tb_venda AS v ON v.id_produto = p.id_produto
INNER JOIN tb_cliente AS c ON c.id_cliente = v.id_cliente
WHERE YEAR (v.data_venda) = 2023;

-- Questão 11: Exibir todos os produtos vendidos e a quantidade total de cada produto vendido.
SELECT p.nome, SUM(v.quantidade) AS `Quantidade Total` FROM tb_venda AS v
INNER JOIN tb_produto AS p ON p.id_produto = v.id_produto
GROUP BY p.nome;

-- Questão 12: Exibir todos os clientes e a soma total das compras de cada um (quantidade * preço do produto).
SELECT c.nome, SUM(v.quantidade * p.preco) AS `Total Compras` FROM tb_cliente AS c
INNER JOIN tb_venda AS v ON c.id_cliente = v.id_cliente
INNER JOIN tb_produto AS p ON p.id_produto = v.id_produto
GROUP BY c.nome;

-- Questão 13: Exibir o nome do cliente e o nome do produto comprado, considerando apenas clientes que compraram produtos da categoria "Eletrônicos".
SELECT c.nome, p.nome, p.categoria FROM tb_cliente AS c
INNER JOIN tb_venda AS v ON c.id_cliente = v.id_cliente
INNER JOIN tb_produto AS p ON p.id_produto = v.id_produto
WHERE p.categoria = 'Eletrônicos';

-- Questão 14: Exibir todos os clientes e os produtos comprados, mostrando também o valor total das compras (quantidade * preço).
SELECT c.nome, GROUP_CONCAT(p.nome), (v.quantidade * p.preco) AS `Total das Compras` FROM tb_venda AS v
INNER JOIN tb_cliente AS c ON v.id_cliente = c.id_cliente
INNER JOIN tb_produto AS p ON v.id_produto = p.id_produto
GROUP BY c.nome;

-- Questão 15: Exibir o nome do cliente, o nome do produto e a data da venda, considerando apenas as vendas que ocorreram em Janeiro de 2023.
SELECT c.nome, p.nome, v.data_venda FROM tb_cliente as c
INNER JOIN tb_venda AS v ON c.id_cliente = v.id_cliente
INNER JOIN tb_produto AS p ON p.id_produto = v.id_produto
WHERE v.data_venda BETWEEN '2023-01-01' AND '2023-01-31';

-- Questão 16: Exibir o nome do cliente e os produtos que ele comprou, considerando apenas os clientes que compraram mais de 3 produtos.
SELECT c.nome, p.nome, COUNT(v.id_produto) FROM tb_cliente AS c
INNER JOIN tb_venda AS v ON c.id_cliente = v.id_cliente
INNER JOIN tb_produto AS p ON p.id_produto = v.id_produto
GROUP BY c.nome, p.nome
HAVING COUNT(v.id_produto) > '3';

select * from tb_venda
order by id_produto;

-- Questão 17: Exibir todos os clientes que compraram produtos da categoria "Roupas".
SELECT c.nome FROM tb_cliente AS c
INNER JOIN tb_venda AS v ON c.id_cliente = v.id_cliente
INNER JOIN  tb_produto AS p ON p.id_produto = v.id_produto
WHERE p.categoria = 'Roupas';

-- Questão 18: Exibir a data da venda, o nome do cliente e o nome do produto comprado, ordenado pela data da venda.
SELECT v.data_venda, c.nome, p.nome AS Produto FROM tb_venda AS v
INNER JOIN tb_cliente AS c ON v.id_cliente = c.id_cliente
INNER JOIN tb_produto AS p ON p.id_produto = v.id_produto
ORDER BY v.data_venda;

-- Questão 19: Exibir o nome do cliente, o nome do produto e o preço do produto para todas as vendas realizadas em 2023.
SELECT c.nome, p.nome, p.preco FROM tb_cliente AS c
INNER JOIN  tb_venda AS v ON c.id_cliente = v.id_cliente
INNER JOIN tb_produto AS p ON p.id_produto = v.id_produto
WHERE data_venda BETWEEN '2023-01-01' AND '2023-12-31';

-- Questão 20: Exibir o nome do cliente e a quantidade total comprada de cada produto.
SELECT c.nome, p.nome, SUM(v.quantidade) AS Quantidade_total FROM tb_cliente AS c
INNER JOIN tb_venda AS v ON c.id_cliente = v.id_cliente
INNER JOIN tb_produto AS p ON p.id_produto = v.id_produto
GROUP BY c.nome, p.nome;
