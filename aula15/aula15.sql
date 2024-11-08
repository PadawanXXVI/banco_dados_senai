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
CHARSET utfmb4; -- dentro da coleção acima estamos usando esta
