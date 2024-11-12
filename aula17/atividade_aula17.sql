CREATE DATABASE IF NOT EXISTS db_mercearia;
USE db_mercearia;

CREATE TABLE IF NOT EXISTS tb_produto(
	id_produto INT PRIMARY KEY AUTO_INCREMENT,
    nome_produto VARCHAR(100),
    descricao_produto TEXT,
    preco DECIMAL(10,2),
    quantidade INT,
    data_fabricacao DATE,
    data_validade DATE,
    fornecedor VARCHAR(100));

INSERT INTO tb_produto
	(id_produto, nome_produto, descricao_produto, preco, quantidade, data_fabricacao, data_validade, fornecedor)
VALUES
(1, 'Sabonete', 'Sabonete perfumado', 2.50, 100, '2024-01-01', '2025-01-01', 'Fornecedor A'), 
(2, 'Shampoo', 'Shampoo para cabelos secos', 12.00, 50, '2023-12-15', '2025-12-15', 'Fornecedor B'), 
(3, 'Condicionador', 'Condicionador hidratante', 15.00, 70, '2023-11-20', '2025-11-20', 'Fornecedor B'),
(4, 'Creme Dental', 'Creme dental com flúor', 5.00, 200, '2024-02-10', '2026-02-10', 'Fornecedor C'), 
(5, 'Desodorante', 'Desodorante aerosol', 10.00, 150, '2023-10-05', '2024-10-05', 'Fornecedor D'), 
(6, 'Hidratante', 'Hidratante corporal', 20.00, 30, '2024-03-15', '2025-03-15', 'Fornecedor A'), 
(7, 'Protetor Solar', 'Protetor solar fator 50', 35.00, 80, '2024-04-01', '2025-04-01', 'Fornecedor E'), 
(8, 'Perfume', 'Perfume floral', 60.00, 20, '2024-01-20', '2026-01-20', 'Fornecedor F'), 
(9, 'Sabão Líquido', 'Sabão líquido para roupas', 25.00, 60, '2023-09-10', '2024-09-10', 'Fornecedor G'), 
(10, 'Álcool Gel', 'Álcool gel 70%', 8.00, 500, '2024-05-01', '2026-05-01', 'Fornecedor H'); 

    
-- 1. Altere o tipo do campo nome_produto para VARCHAR(150) na tabela tb_produto. 
ALTER TABLE tb_produto
MODIFY COLUMN nome_produto VARCHAR(150);

-- 2. Adicione o campo categoria do tipo VARCHAR(50) à tabela tb_produto. 
ALTER TABLE tb_produto
ADD COLUMN categoria VARCHAR(50);

-- 3. Renomeie O campo data_fabricacao para data_producao na tabela tb_produto. 
ALTER TABLE tb_produto
CHANGE COLUMN data_fabricacao data_producao DATE;

-- 4. Exclua o campo descricao_produto da tabela tb_produto.
ALTER TABLE tb_produto
DROP COLUMN descricao_produto;

-- 5. Atualize o campo preco para 13.00 onde o nome_produto é Shampoo. 
SELECT * FROM tb_produto;
UPDATE tb_produto
SET preco = '13'
WHERE id_produto = '2';

-- 6. Adicione o campo estoque_minimo do tipo INT à tabela tb_produto. 
ALTER TABLE tb_produto
ADD COLUMN estoque_minimo INT;

-- 7. Renomeie o campo preco para preco_unitario na tabela tb_produto.
ALTER TABLE tb_produto
CHANGE COLUMN preco preco_unitario DECIMAL(10,2);

-- 8. Exclua o campo fornecedor da tabela tb_produto. 
ALTER TABLE tb_produto
DROP COLUMN fornecedor;

-- 9. Atualize o campo quantidade para 0 onde o data_validade é anterior a 2024-10-01. 
UPDATE tb_aluno
SET quantidade = '0'
WHERE data_validade < 2024-10-01;

-- 10. Adicione o campo data_reposicao do tipo DATE na tabela tb_produto.
ALTER TABLE tb_produto
ADD COLUMN data_reposicao DATE;

-- 11. Renomeie o campo data_validade para data_expiracao. 
ALTER TABLE tb_produto
CHANGE COLUMN data_validade data_expiracao DATE;

-- 12. Atualize o campo data_expiracao para 2025-12-31 onde nome_produto é Protetor Solar. 
UPDATE tb_produto
SET data_expiracao = '2025-12-31'
WHERE id_produto = '7';
SELECT * FROM tb_produto;

-- 13. Exclua o campo estoque_minimo da tabela tb_produto. 
ALTER TABLE tb_produto
DROP COLUMN estoque_minimo;

-- 14. Renomeie o campo quantidade para estoque_atual na tabela tb_produto. 
ALTER TABLE tb_produto
CHANGE quantidade estoque_atual INT;

-- 15. Altere o tipo do campo categoria para ENUM('higiene', 'saúde')
ALTER TABLE tb_produto
MODIFY COLUMN categoria ENUM('higiene', 'saúde');

-- 16. Adicione o campo codigo_barras do tipo VARCHAR(13) para armazenar o código de barras dos produtos. 
ALTER TABLE tb_produto
ADD codigo_barras VARCHAR(13);

-- 17. Exclua perfume do estoque. 
DELETE FROM tb_produto
WHERE id_produto = '8';

-- 18. Adicione o campo data_entrada do tipo DATE para registrar a data de entrada dos produtos em estoque
ALTER TABLE tb_produto
ADD COLUMN data_entrega DATE;

-- 19. Atualize o campo estoque_atual para 50 para todos os produtos onde o preco_unitario seja igual que 10.00. 
UPDATE tb_produto
SET estoque_atual = '50'
WHERE preco_unitario = '10';

-- 20. Renomeie a tabela tb_produto para tb_estoque_produto.
RENAME TABLE tb_produto TO tb_estoque_produto;

-- 21. Altere o tipo do campo nome_produto para VARCHAR(200) na tabela tb_estoque_produto. 
ALTER TABLE tb_estoque_produto
MODIFY COLUMN nome_produto VARCHAR(200);

-- 22. Adicione na table tb_estoque_produto um campo unidade_medida do tipo VARCHAR(10) à tabela
ALTER TABLE tb_estoque_produto
ADD COLUMN unidade_medida VARCHAR(10);

-- 23. Delete os produtos que tenham o estoque zero. 
SELECT * FROM tb_estoque_produto;
DELETE FROM tb_estoque_produto
WHERE estoque_atual = '0';

-- 24. Renomeie o campo estoque_atual para quantidade_estoque. 
DESC tb_estoque_produto;
ALTER TABLE tb_estoque_produto
CHANGE COLUMN estoque_atual quantidade_estoque INT;

-- 25. Exclua a tabela tb_estoque_produto. 
DROP TABLE tb_estoque_produto;
