-- REEVISÃO PARA PROVA

-- CRIAÇAO DO BANCO DE DADOS
CREATE DATABASE db_revisao;

-- CRIAÇÃO COMPLETA
CREATE DATABASE IF NOT EXISTS db_revisao
COLLATE utf8mb4_general_ci
CHARSET utf8mb4;

-- EXCLUIR BANCO DE DADOS
DROP DATABASE db_revisao;

-- MOSTRAR OS BANCOS DE DADOS CRIADOS
SHOW DATABASES;

-- SELECIONAR O BANCO DE DADOS PARA USO
USE db_revisao;

-- CRIAÇÃO DE TABELA
CREATE TABLE tb_exemplo(
	id INT PRIMARY KEY NOT NULL AUTO_INCREMENT,
    nome VARCHAR(90) NOT NULL,
    email VARCHAR(90) NOT NULL
);

-- EXIBIR TABELAS CRIADAS
SHOW TABLES;

-- EXIBIR OS DETALHES DE UMA TABELA
DESCRIBE tb_exemplo;
-- OU
DESC tb_exemplo;

-- EXCLUIR TABELA
DROP TABLE tb_exemplo;

-- POPULAR A TABELA
INSERT INTO tb_exemplo
	(id, nome, email)
VALUES 
	(1, 'Anderson de Matos Guimarães', 'anderson.m.guimaraes@icloud.com');
    
INSERT INTO tb_exemplo VALUES
	(2, 'Maria da Anunciação de Matos Guimarães', 'nuncymatos@gmail.com');

INSERT INTO tb_exemplo
	(nome, email)
VALUES
	('Aryna Regina de Matos Guimarães', 'aryna@email.com');

-- MOSTRAR TABELA COM DADOS INSERIDOS
SELECT * FROM tb_exemplo; -- mostra todas as colunas

SELECT nome FROM tb_exemplo; -- mostra uma coluna específica

SELECT nome, email FROM tb_exemplo; -- mostra duas ou mais colunas específicas

-- ALTER O NOME DA TABELA
RENAME TABLE tb_exemplo TO tb_aluno;


