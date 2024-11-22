CREATE DATABASE IF NOT EXISTS db_eletronico;
USE db_eletronico;

DROP TABLE tb_venda;

CREATE TABLE IF NOT EXISTS tb_venda(
    id_venda INT PRIMARY KEY AUTO_INCREMENT,
    cliente VARCHAR(50) NOT NULL,
    produto VARCHAR(50) NOT NULL,
    categoria VARCHAR(50) NOT NULL,
    valor DECIMAL(10,2),
    data_venda DATE NOT NULL
);

INSERT INTO tb_venda
    (id_venda, cliente, produto, categoria, valor, data_venda)
VALUES
    ('João Pedro', 'Notebook', 'Eletrônicos', 3500.00, '2024-11-01'),
    ('Maria', 'Celular', 'Eletrônicos', 2500.00, '2024-11-02'),
    ('Ana', 'Smartwatch', 'Acessórios', 1500.00, '2024-11-03'),
    ('Lucas Silva', 'Cadeira Gamer', 'Móveis', 1200.00, '2024-11-04'),
    ('Pedro', 'Geladeira', 'Eletrodomésticos', 3200.00, '2024-11-05'),
    ('Carla', 'Notebook', 'Eletrônicos', 3600.00, '2024-11-06'),
    ('Lucas Silva', 'Sofá', 'Móveis', 7000.00, '2024-11-20'),
    ('João Pedro', 'Mouse', 'Acessórios', 150.00, '2024-11-01');

-- 1. Liste todos os clientes distintos (únicos) da tabela.
SELECT DISTINCT cliente FROM tb_venda;

-- 2. Quantos clientes diferentes realizaram compras?

-- 3. Liste as categorias distintas de produtos vendidos.
SELECT DISTINCT categoria FROM tb_venda;

-- 4. Qual o valor total de vendas, realizadas em cada categoria de produto?

-- 5. Qual foi o valor total vendido por cada cliente?

-- 6. Quantos produtos diferentes foram vendidos?

-- 7. Filtre as categorias de produtos que tiveram vendas totais acima de R$5.000,00. Use HAVING.

-- 8. Qual o valor médio das vendas por cliente?

-- 9. Qual foi o maior valor de venda registrado?

-- 10. Qual foi o menor valor de venda registrado?

-- 11. Liste o total de vendas por data, ordenando da mais recente para a mais antiga.

-- 12. Quantas vendas foram realizadas por categoria?

-- 13. Filtre os clientes que tiveram um total de compras acima de R$3.000,00.

-- 14. Liste os produtos vendidos ordenados por ordem alfabética.

-- 15. Quantos produtos de cada categoria foram vendidos?

-- 16. Qual foi o valor total arrecadado nas vendas realizadas em novembro de 2024?

-- 17. Filtre os clientes que realizaram compras acima de R$3.000,00.

-- 18. Liste os clientes que compraram produtos da categoria "Eletrônicos".

-- 19. Quais categorias de produtos tiveram um valor médio de vendas acima deR$1.000,00?

-- 21. Liste os clientes e o valor total gasto por cada um em novembro de 2024.

-- 22. Liste os clientes e o número total de compras realizadas por cada um.

-- 23. Liste as datas em que foram realizadas mais de 1 vendas.

-- 24. Qual o produto mais caro vendido?
