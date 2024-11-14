-- CRIAÇÃO DO BANCO DE DADOS
CREATE DATABASE IF NOT EXISTS db_loja_de_jogos;

--  SELEÇÃO DO BANCO DE DADOS
USE db_loja_de_jogos;

-- CRIAÇÃO DA TABLEA JOGOS
CREATE TABLE IF NOT EXISTS tb_jogos(
	id INT PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(50),
    genero VARCHAR(20),
    preco DECIMAL(5,2),
    estoque INT,
    data_lancamento DATE
);

-- VERIFICAÇÃO DA ESTRUTURA DA TABELA
DESC tb_jogos;

-- ALIMENTAÇÃO DA TABELA JOGOS
INSERT INTO tb_jogos
	(nome, genero, preco, estoque, data_lancamento)
VALUES
('Minecraft', 'Sandbox', 26.95, 150, '2011-11-18'),
('The Legend of Zelda: Breath of the Wild', 'Adventure', 59.99, 80, '2017-03-03'),
('The Witcher 3: Wild Hunt', 'RPG', 39.99, 50, '2015-05-19'),
('Fortnite', 'Battle Royale', 0.00, 300, '2017-07-21'),
('Super Mario Odyssey', 'Platform', 59.99, 90, '2017-10-27'),
('Call of Duty: Modern Warfare', 'FPS', 59.99, 120, '2019-10-25'),
('Overwatch', 'FPS', 39.99, 110, '2016-05-24'),
('Rocket League', 'Sports', 19.99, 60, '2015-07-07'),
('Among Us', 'Party', 4.99, 200, '2018-06-15'),
('Apex Legends', 'Battle Royale', 0.00, 210, '2019-02-04'),
('Red Dead Redemption 2', 'Adventure', 59.99, 75, '2018-10-26'),
('Stardew Valley', 'Simulation', 14.99, 100, '2016-02-26'),
('Valorant', 'FPS', 0.00, 250, '2020-06-02'),
('Cyberpunk 2077', 'RPG', 59.99, 70, '2020-12-10'),
('Fall Guys', 'Party', 19.99, 150, '2020-08-04'),
('Animal Crossing: New Horizons', 'Simulation', 59.99, 130, '2020-03-20'),
('The Sims 4', 'Simulation', 39.99, 90, '2014-09-02'),
('Civilization VI', 'Strategy', 59.99, 45, '2016-10-21'),
('League of Legends', 'MOBA', 0.00, 320, '2009-10-27'),
('Halo Infinite', 'FPS', 59.99, 85, '2021-12-08');

-- VERIFICANDO AS TABELAS DO BANCO DE DADOS
SHOW TABLES;

-- 1. Selecionar todos os registros da tabela Jogos
SELECT * FROM tb_jogos;

-- 2. Selecionar jogos cujo gênero é 'FPS'
SELECT * FROM tb_jogos
WHERE genero = 'FPS';

-- 3. Selecionar jogos com preço superior a 50.00
SELECT * FROM tb_jogos
WHERE preco > 50;

-- 4. Selecionar jogos com preço entre 20.00 e 40.00
SELECT * FROM tb_jogos
WHERE preco BETWEEN 20 AND 40;

-- 5. Selecionar jogos de gênero 'Battle Royale' ou 'Party'
SELECT * FROM tb_jogos
WHERE genero IN ('Battle Royale', 'Party');

-- 6. Selecionar jogos lançados depois de 2015
SELECT * FROM tb_jogos
WHERE data_lancamento > '2015-12-31';

 -- 7. Selecionar jogos que não são do gênero 'FPS'
 SELECT * FROM tb_jogos
 WHERE genero <> 'FPS';
 
 -- 8. Selecionar jogos com nomes que começam com 'S'
 SELECT * FROM tb_jogos
 WHERE nome LIKE 'S%';
 
 -- 9. Selecionar jogos com preço igual a 0.00
 SELECT * FROM tb_jogos
 WHERE preco = '0';
 
 -- 10. Selecionar jogos cujo estoque está entre 100 e 200 unidades
 SELECT * FROM tb_jogos
 WHERE estoque BETWEEN '100' AND '200';
 
 -- 11. Atualizar o preço de 'Rocket League' para 29.99
 UPDATE tb_jogos
 SET preco = '29.99'
 WHERE id = '8';
 
 -- 12. Excluir jogos cujo estoque é menor que 50
 DELETE FROM tb_jogos
 WHERE estoque < '50';
 
 -- 13. Excluir jogos cujo nome é 'Fall Guys'
 DELETE FROM tb_jogos
 WHERE nome = 'Fall Guys';
 
 -- 14 Selecionar jogos com nomes que terminam com 's'
 SELECT * FROM tb_jogos
 WHERE nome LIKE '%S';
 
 -- 15. Selecionar jogos com data de lançamento antes de 2010
 SELECT * FROM tb_jogos
 WHERE data_lancamento < '2010-01-01';
 
 -- 16. Selecionar jogos cujo nome está entre 'A' e 'M'
 SELECT * FROM tb_jogos
 WHERE nome BETWEEN 'A' AND 'M';
 
 -- 17. Selecionar jogos com nomes que contêm a palavra 'Legend'
 SELECT * FROM tb_jogos
 WHERE nome LIKE '%Legend%';
 
 -- 18. Selecionar jogos com estoque menor ou igual a 60
DELETE FROM tb_jogos
WHERE estoque <= '60';

-- DROP DATABASE db_loja_de_jogos;
 