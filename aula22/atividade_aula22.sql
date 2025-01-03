-- Criação do banco de dados e seleção para uso
DROP DATABASE db_eletronico;

CREATE DATABASE IF NOT EXISTS db_eletronico;
USE db_eletronico;

-- Criação da tabela vendas
CREATE TABLE IF NOT EXISTS tb_venda(
    id_venda INT PRIMARY KEY AUTO_INCREMENT,
    cliente VARCHAR(50) NOT NULL,
    produto VARCHAR(50) NOT NULL,
    categoria VARCHAR(50) NOT NULL,
    valor DECIMAL(10,2),
    data_venda DATE NOT NULL
);

-- Populando a tabela
INSERT INTO tb_venda
    (cliente, produto, categoria, valor, data_venda)
VALUES
    ('João Pedro', 'Notebook', 'Eletrônicos', 3500.00, '2024-11-01'),
    ('Maria', 'Celular', 'Eletrônicos', 2500.00, '2024-11-02'),
    ('Ana', 'Smartwatch', 'Acessórios', 1500.00, '2024-11-03'),
    ('Lucas Silva', 'Cadeira Gamer', 'Móveis', 1200.00, '2024-11-04'),
    ('Pedro', 'Geladeira', 'Eletrodomésticos', 3200.00, '2024-11-05'),
    ('Carla', 'Notebook', 'Eletrônicos', 3600.00, '2024-11-06'),
    ('Lucas Silva', 'Sofá', 'Móveis', 7000.00, '2024-11-20'),
    ('João Pedro', 'Mouse', 'Acessórios', 150.00, '2024-11-01');
    
SELECT * FROM tb_venda;

-- 1. Liste todos os clientes distintos (únicos) da tabela.
SELECT DISTINCT cliente FROM tb_venda;

-- 2. Quantos clientes diferentes realizaram compras?
SELECT COUNT(DISTINCT cliente) AS `clientes diferentes` FROM tb_venda;

-- 3. Liste as categorias distintas de produtos vendidos.
SELECT DISTINCT categoria FROM tb_venda;

-- 4. Qual o valor total de vendas, realizadas em cada categoria de produto?
SELECT SUM(VALOR), categoria FROM tb_venda
GROUP BY categoria;

-- 5. Qual foi o valor total vendido por cada cliente?
SELECT SUM(valor), cliente FROM tb_venda
GROUP BY cliente;

-- 6. Quantos produtos diferentes foram vendidos?
SELECT COUNT(DISTINCT produto) FROM tb_venda;

-- 7. Filtre as categorias de produtos que tiveram vendas totais acima de R$5.000,00. Use HAVING.
SELECT categoria, SUM(valor) FROM tb_venda
GROUP BY categoria
HAVING SUM(valor) > '5000';

-- 8. Qual o valor médio das vendas por cliente?
SELECT AVG(valor), cliente FROM tb_venda
GROUP BY cliente;

-- 9. Qual foi o maior valor de venda registrado?
SELECT MAX(valor) FROM tb_venda;

-- 10. Qual foi o menor valor de venda registrado?
SELECT MIN(valor) FROM tb_venda;

-- 11. Liste o total de vendas por data, ordenando da mais recente para a mais antiga.
SELECT data_venda, SUM(valor) FROM tb_venda
GROUP BY data_venda
ORDER BY data_venda DESC;

-- 12. Quantas vendas foram realizadas por categoria?
SELECT COUNT(*), categoria FROM tb_venda
GROUP BY categoria;

-- 13. Filtre os clientes que tiveram um total de compras acima de R$3.000,00.
SELECT cliente, SUM(valor) FROM tb_venda
GROUP BY cliente
HAVING SUM(valor) > '300';

-- 14. Liste os produtos vendidos ordenados por ordem alfabética.
SELECT produto FROM tb_venda
ORDER BY produto;

-- 15. Quantos produtos de cada categoria foram vendidos?
SELECT COUNT(produto), categoria FROM tb_venda
GROUP BY categoria;

-- 16. Qual foi o valor total arrecadado nas vendas realizadas em novembro de 2024?
SELECT SUM(valor) FROM tb_venda
WHERE data_venda BETWEEN '2024-11-01' AND '2024-11-31';

-- 17. Filtre os clientes que realizaram compras acima de R$3.000,00.
SELECT cliente, valor FROM tb_venda
WHERE valor > '3000';

-- 18. Liste os clientes que compraram produtos da categoria "Eletrônicos".
SELECT cliente, categoria FROM tb_venda
WHERE categoria = 'eletrônicos';

-- 19. Quais categorias de produtos tiveram um valor médio de vendas acima deR$1.000,00?
SELECT categoria, AVG(valor) FROM tb_venda
GROUP BY categoria
HAVING AVG(valor) > '1000';

-- 21. Liste os clientes e o valor total gasto por cada um em novembro de 2024.
SELECT cliente, SUM(valor) FROM tb_venda
WHERE data_venda BETWEEN '2024-11-01' AND '2024-11-31'
GROUP BY cliente;

-- 22. Liste os clientes e o número total de compras realizadas por cada um.
SELECT cliente, COUNT(cliente) AS `total de compras` FROM tb_venda
GROUP BY cliente;

-- 23. Liste as datas em que foram realizadas mais de 1 vendas.
SELECT data_venda, COUNT(*) from tb_venda
GROUP BY data_venda
HAVING COUNT(*) > 1;

-- 24. Qual o produto mais caro vendido?
SELECT produto, valor FROM tb_venda
ORDER BY valor DESC
LIMIT 1;
