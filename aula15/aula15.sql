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
