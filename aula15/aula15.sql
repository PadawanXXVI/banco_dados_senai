/*
Comentário de mais de uma linha

CRIAÇÃO DO BANCO DE DADOS: CREATE DATABASE db_nome;
*/
CREATE DATABASE db_aula;

-- Comando para usar o banco de dados criado:
USE db_aula;

-- vai verificar se existe antes de criar (isso é apenas um comentário):
CREATE DATABASE IF NOT EXISTS db_escola
COLLATE utf8mb4_general_ci -- padrão/coleção de caracteres
CHARSET utf8mb4; -- dentro da coleção acima estamos usando esta

-- comando para visualizar todos os BD
SHOW DATABASES;

-- comando para apagar um banco de dados
DROP DATABASE db_aula;

-- criar tabela
CREATE TABLE tb_aluno(
	id_aluno INT,
    nome VARCHAR(125),
    email VARCHAR(125),
    data_nascimento DATE
);

-- comando para mostrar todas as tabelas criadas
SHOW TABLES;

-- comando para mostrar a descrição da tabela
DESCRIBE tb_aluno;
DESC tb_aluno;

-- comando para apagar tabela
DROP TABLE tb_aluno;

-- criação da tabela com restrições nos atributos
CREATE TABLE tb_aluno(
	id_aluno INT PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(125) NOT NULL,
    email VARCHAR(125),
    data_nascimento DATE NOT NULL
);

DESC tb_aluno;

-- comando para alimentar a tabela
INSERT INTO tb_aluno
	(id_aluno,nome,email,data_nascimento)
VALUES 
    (1,'Maria','maria@email.com',20001020); -- data ANOMÊSDIA
    
-- comando para visualizar a tabela com os dados inseridos
SELECT * FROM tb_aluno; -- o asterisco informa que quer trazer todas as colunas

-- comando para visualizar uma coluna da tabela
SELECT nome FROM tb_aluno; -- informa quais colunas quer visualizar colocando o nome delas no lugar do asterisco

-- comando para visualizar mais de uma coluna
SELECT nome,email FROM tb_aluno;

-- comando para alterar o nome da tabela
RENAME TABLE tb_aluno TO tb_pessoa;
    