-- REEVISÃO PARA I PROVA DE SQL

/*
CRIAÇÃO E MANIPULAÇÃO DE BANCO DE DADOS E DE TABELAS
*/

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

/*
MANIPULAÇÃO DA ESTRUTURA DAS TABELAS
*/

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

-- ADCIONAR COLUNA AO FINAL DA TABELA
ALTER TABLE tb_aluno
ADD COLUMN telefone VARCHAR(13);

-- APAGAR UMA COLUMN
ALTER TABLE tb_aluno
DROP COLUMN telefone;

-- INSERIR UM COLUNA EM UMA POSIÇÃO ESPECÍFICA
ALTER TABLE tb_aluno
ADD COLUMN telefone VARCHAR(13) AFTER nome;

-- INSERIR UMA COLUNA NA PRIMEIRA POSIÇÃO
ALTER TABLE tb_aluno
ADD COLUMN endereco VARCHAR(125) FIRST;

-- ALTERAR TIPO DE DADOS DA COLUNA
ALTER TABLE tb_aluno
MODIFY COLUMN telefone INT; -- Podemos altera o tipo de dado (VARCHR para INT), ou a quantidade de caratcteres dentro do VARCHAR, por exemplo

-- ALTERAR O NOME DA COLUNA
ALTER TABLE tb_aluno
CHANGE COLUMN telefone contato VARCHAR(15);

-- RENOMEAR O NOME DA TABELA COM ALTER TABLE
ALTER TABLE tb_aluno
RENAME TO tb_candidato;

-- COLOCAR O CAMPO COMO PK
ALTER TABLE tb_candidato
ADD PRIMARY KEY (id);


/*
MANIPULÇÃO DE DADOS DE UMA TABELA
*/

-- ALTERAR DADOS DE UM REGISTRO ESPECÍFICO
UPDATE tb_candidato
SET nome = 'Luiza Nunes'
WHERE nome = 'Anderson de Matos Guimarães'

-- ALTERAR MAIS DE UM DADO DE UM REGISTRO ESPECÍFICO
UPDATE tb_candidato
SET nome = 'Anderson de Matos Guimarães', email = 'anderson.guimaraes@email.com'
WHERE id = '1'

-- ALTERAR TODOS OS REGISTRO COM UM CAMPO COMUM
UPDATE tb_candidato
SET email = 'nome.sobrenome@email.com' 
WHERE nome = 'João';
/*
Supondo que houvesse mais de uma entrada com nome João, poderíamos trocar o email de todos por nome.sobrenome@email.com
*/

/*
Observações:
UPDATE: atualiza
SET: configure
WHERE: onde
*/

-- APAGAR TODOS OS REGISTROS VINCULADO A UMA ENTRADA EM COMUM
DELETE FROM tb_candidato
WHERE email = 'nome.sobrenome@email.com'; -- apaga todos os registros onde o email é nome.sobrenome@email.com

-- APAGA UM REGISTRO ESPECÍFICO
DELETE FROM tb_candidato
WHERE id = '1'; -- como há somente 1 registro com id igual a 1, apagará somente ele

-- EXCLUIR TODOS OS REGISTROS SEM EXCLUIR A TABELA
TRUNCATE TABLE tb_candidato;

/*
OPERADORES LÓGICOS E RELACIONAIS
*/

-- OPERADOR LÓGICO AND
SELECT * FROM tb_candidato
WHERE nome = 'Anderson de Matos Guimarães'
AND email = 'anderson.guimaraes@email.com'; -- traz as informações somente se ambas condições (nome e email) forem atendidas

-- OPERADOR LÓGICO OR
SELECT * FROM tb_candidato
WHERE nome = 'Anderson de Matos Guimarães'
OR email = 'anderson.guimares@email.com'; -- traz as informaçções se pelo menos uma das condições forem atendidas

-- OPERADOR LÓGICO NOT
SELECT * FROM tb_candidato
WHERE NOT nome = 'Anderson de Matos Guimarães';

-- OPERADOR RELACIONAL BETWEEN
SELECT * FROM tb_candidato
WHERE id BETWEEN '1' AND '10';

-- OPERADOR RELACIONAL IN
SELECT * FROM tb_candidato
WHERE nome IN ('Anderson de Matos Guimarães', 'Maria da Anunciação de Matos Guimarães');

-- OPERADOR RELACIONAL LIKE
SELECT * FROM tb_candidato
WHERE nome LIKE 'Ander%';
/*
SILVA% - começa com Silva
%SILVA - termina com Silva
%SILVA% - comtém Silva
*/

-- OPERADOR MAIOR (>) OU MAIOR IGUAL (>=)
SELECT * FROM tb_candidato
WHERE id >= '1';

-- OPERADOR MENOR (<) OU MENOR IGUAL (<=)
SELECT * FROM tb_candidato
WHERE id <= '10';

-- OPERADOR DIFERENTE (!= OU <>)
SELECT * FROM tb_candidato
WHERE id <> '15';

/*
DISTINCT E FUNÇÕES DE AGREGAÇÃO (COUNT, SUM, AVG, MIN, MAX)
*/

-- DISTINCT: RETORNA APENAS AS ENTRADAS ÚNICAS DA COLUNA
SELECT DISTINCT nome FROM tb_candidato;

-- COUNT: retorna o total de registros de uma tabela
SELECT COUNT(*) FROM tb_candidato;

-- USO DO COUNT COM UMA ENTRADA ESPECÍFICA
SELECT COUNT(*) FROM tb_candidato
WHERE nome = 'Anderson de Matos Guimarães';

-- MAX
SELECT MAX(salario) FROM tb_candidato;

-- MIN
SELECT MIN(salario) FROM tb_candidato;

-- SUM
SELECT SUM(salario) FROM tb_candidato;

-- AVG
SELECT AVG(salario) FROM tb_candidato;

-- USO DO AS: RENOMEIA A COLUNA DE RETORNO
SELECT AVG(salario) AS `Média Salarial` FROM tb_candidato;

