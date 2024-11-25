-- CRIAÇÃO E SELEÇÃO DO BANCO DE DADOS
CREATE DATABASE IF NOT EXISTS db_loja_eletronicos;
USE db_loja_eletronicos;

DROP TABLE tb_produto;
-- CRIAÇÃO DA TABELA
CREATE TABLE tb_produto(
	id_produto INT PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(50) NOT NULL,
    categoria VARCHAR(30) NOT NULL,
    preco DECIMAL(10,2) NOT NULL,
    quantidade INT NOT NULL,
    data_venda DATE NOT NULL,
    marca VARCHAR(30) NOT NULL,
    status_estoque VARCHAR(20) NOT NULL
);

-- POPULANDO A TABELA
INSERT INTO tb_produto
	(id_produto, nome, categoria, preco, quantidade, data_venda, marca, status_estoque)
VALUES
	(1, 'Notebook', 'Eletrônicos', 3500.00, 5, '2024-07-01', 'Dell', 'Em Estoque'),
	(2, 'Smartphone', 'Eletrônicos', 2500.00, 10, '2024-07-03', 'Samsung', 'Em Estoque'),
	(3, 'Cadeira Gamer', 'Móveis', 1200.00, 8, '2024-07-05', 'DXRacer', 'Em Estoque'),
	(4, 'Sofá', 'Móveis', 7000.00, 2, '2024-07-10', 'TokStok', 'Em Estoque'),
	(5, 'Geladeira', 'Eletrodomésticos', 3200.00, 3, '2024-08-01', 'Brastemp', 'Em Estoque'),
	(6, 'Smartwatch', 'Acessórios', 1500.00, 7, '2024-08-02', 'Apple', 'Em Estoque'),
	(7, 'Teclado', 'Periféricos', 300.00, 15, '2024-08-04', 'Logitech', 'Em Estoque'),
	(8, 'Mouse', 'Periféricos', 150.00, 20, '2024-08-05', 'Razer', 'Em Estoque'),
	(9, 'Monitor', 'Eletrônicos', 1200.00, 12, '2024-08-07', 'AOC', 'Em Estoque'),
	(10, 'Impressora', 'Periféricos', 800.00, 5, '2024-08-10', 'Epson', 'Em Estoque'),
	(11, 'Fone de Ouvido', 'Acessórios', 250.00, 25, '2024-09-01', 'Sony', 'Em Estoque'),
	(12, 'Câmera', 'Eletrônicos', 4000.00, 4, '2024-09-02', 'Canon', 'Em Estoque'),
	(13, 'Tablet', 'Eletrônicos', 2000.00, 6, '2024-09-04', 'Apple', 'Em Estoque'),
	(14, 'Armário', 'Móveis', 1500.00, 3, '2024-09-06', 'IKEA', 'Em Estoque'),
	(15, 'Cafeteira', 'Eletrodomésticos', 300.00, 10, '2024-09-08', 'Philips', 'Em Estoque'),
	(16, 'Fogão', 'Eletrodomésticos', 2000.00, 2, '2024-09-10', 'Consul', 'Em Estoque'),
	(17, 'Luminária', 'Decoração', 120.00, 8, '2024-09-12', 'Startec', 'Em Estoque'),
	(18, 'Quadro Decorativo', 'Decoração', 450.00, 3, '2024-10-01', 'Casa&Design', 'Em Estoque'),
	(19, 'Tapete', 'Decoração', 700.00, 2, '2024-10-02', 'Karsten', 'Esgotado'),
	(20, 'Máquina de Lavar', 'Eletrodomésticos', 2500.00, 4, '2024-10-03', 'Electrolux', 'Em Estoque'),
	(21, 'Ventilador', 'Eletrodomésticos', 300.00, 15, '2024-10-05', 'Arno', 'Em Estoque'),
	(22, 'Ar-Condicionado', 'Eletrodomésticos', 2200.00, 3, '2024-10-07', 'LG', 'Em Estoque'),
	(23, 'Cadeira Escritório', 'Móveis', 800.00, 10, '2024-10-09', 'Flexform', 'Em Estoque'),
	(24, 'Mesa Escritório', 'Móveis', 2000.00, 4, '2024-10-11', 'TokStok', 'Em Estoque'),
	(25, 'HD Externo', 'Eletrônicos', 500.00, 6, '2024-10-12', 'Seagate', 'Em Estoque'),
	(26, 'TV', 'Eletrônicos', 3000.00, 5, '2024-10-13', 'Samsung', 'Esgotado'),
	(27, 'Playstation', 'Eletrônicos', 5000.00, 3, '2024-10-15', 'Sony', 'Esgotado'),
	(28, 'X-Box', 'Eletrônicos', 4500.00, 2, '2024-10-17', 'Microsoft', 'Em Estoque'),
	(29, 'Carregador Portátil', 'Acessórios', 150.00, 10, '2024-10-18', 'Anker', 'Em Estoque'),
	(30, 'Fritadeira', 'Eletrodomésticos', 800.00, 7, '2024-10-19', 'Mondial', 'Em Estoque');
    
SELECT * FROM tb_produto;

-- 1. Produtos eletrônicos com preço acima de 2000
SELECT nome, categoria, preco FROM tb_produto
WHERE categoria = 'eletrônicos' AND preco > '2000';

-- 2. Produtos de decoração ou móveis
SELECT nome, categoria FROM tb_produto
WHERE categoria IN ('decoração', 'móveis');

-- 3. Produtos das marcas 'Apple', 'Samsung' ou 'Sony'
SELECT nome, marca FROM tb_produto
WHERE marca IN ('Apple','Samsung','Sony')
ORDER BY marca;

-- 4. Produtos com preço fora do intervalo 1000 a 3000
SELECT nome, marca, preco FROM tb_produto
WHERE preco NOT BETWEEN '1000' AND '3000'
GROUP BY marca
ORDER BY preco;

-- 5. Deletar produtos com quantidade igual a 2
DELETE FROM tb_produto
WHERE quantidade = '2';

-- 6. Atualizar status para 'Esgotado' onde quantidade é 0
UPDATE tb_produto
SET status_estoque = 'Esgotado'
WHERE quantidade = '0';

-- 7. Renomear a coluna 'quantidade' para 'estoque_disponivel'
ALTER TABLE tb_produto
CHANGE COLUMN quantidade estoque_disponivel INT;

-- 8. Selecionar categorias distintas
SELECT DISTINCT categoria FROM tb_produto
ORDER BY categoria;

-- 9. Contar produtos com status 'Em Estoque'
SELECT COUNT(status_estoque) FROM tb_produto
WHERE status_estoque = 'Em Estoque';

-- 10. Somar o preço total de produtos
SELECT SUM(preco) AS `Valor total do estoque` FROM tb_produto;

-- 11. Calcular o preço médio de produtos
SELECT AVG(preco) AS `Preço médio` FROM tb_produto;

-- 12. Obter o preço máximo de produtos
SELECT MAX(preco) AS `maior valor` FROM tb_produto;

-- 13. Obter o preço mínimo de produtos
SELECT MIN(preco) FROM tb_produto;

-- 14. Contar itens agrupados por categoria
SELECT categoria, COUNT(categoria) FROM tb_produto
GROUP BY categoria;

-- 15. Categorias com mais de 5 produtos
SELECT categoria, COUNT(categoria) FROM tb_produto
GROUP BY categoria
HAVING 	COUNT(categoria) > '5';

-- 16. Preço médio agrupado por marca
SELECT marca, AVG(preco) FROM tb_produto
GROUP BY marca;

-- 17. Marcas com preço médio acima de 2000
SELECT marca, AVG(preco) FROM tb_produto
GROUP BY marca
HAVING AVG(preco) > '2000';

-- 18. Produtos vendidos após 01/08/2024
SELECT nome, data_venda FROM tb_produto
WHERE data_venda > '2024-08-01'
ORDER BY data_venda;

-- 19. Produtos cujo nome começa com 'C'
SELECT nome FROM tb_produto
WHERE nome LIKE 'c%';

-- 20. Produtos cujo nome termina com 'r'
SELECT nome FROM tb_produto
WHERE nome LIKE '%r';

SELECT * FROM tb_produto;
-- 21. Atualizar status para 'Esgotado' com quantidade menor que 3
UPDATE tb_produto
SET status_estoque = 'Esgotado'
WHERE estoque_disponivel < '3';

-- 22. Deletar produtos esgotados
DELETE FROM tb_produto
WHERE status_estoque = 'esgotado';

-- 23. Produtos com quantidade entre 5 e 15
SELECT nome, estoque_disponivel  FROM tb_produto
WHERE estoque_disponivel BETWEEN '5' AND '15'
ORDER BY estoque_disponivel;

-- 24. Produtos com preços de 300, 1200 ou 2500
SELECT nome, preco FROM tb_produto
WHERE preco IN ('300', '1200', '2500')
ORDER BY preco;

-- 25. Total de produtos vendidos após 01/09/2024
SELECT COUNT(nome) FROM tb_produto
WHERE data_venda > '2024-09-01';

-- 26. Soma dos preços agrupados por marca
SELECT marca, SUM(preco) AS `Total de vendas` FROM tb_produto
GROUP BY marca;

-- 27. Atualizar status para 'Em Estoque' onde quantidade maior que 0
UPDATE tb_produto
SET status_estoque = 'Em Estoque'
WHERE estoque_disponivel > '0';

-- 28. Soma dos preços por categoria
SELECT categoria, SUM(preco) `Total venda` FROM tb_produto
GROUP BY categoria;

-- 29. Produtos vendidos antes de 01/09/2024 com estoque maior que 5
SELECT nome, data_venda, estoque_disponivel FROM tb_produto
WHERE data_venda < '2024-09-01' AND estoque_disponivel > '5';

-- 30. Quantidade total de produtos por marca com total maior que 5
SELECT marca, COUNT(nome) AS `total de produto` FROM tb_produto
GROUP BY marca
HAVING COUNT(nome) > '5';
