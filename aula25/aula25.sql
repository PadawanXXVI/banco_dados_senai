/*
AULA 08 SQL
Relacionamento entre tabelas
*/

-- CRIAÇÃO DO BANCO DE DADOS
CREATE DATABASE IF NOT EXISTS db_empresa;

-- SELEÇÃO PARA USO DO BANCO DE DADOS
USE db_empresa;

-- CRIAÇÃO DA TABELA FUNCIONÁRIO
CREATE TABLE tb_funcionario(
	id_funcionario INT PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(125),
    cargo VARCHAR(125)
);

-- CRIAÇÃO DA TABELA DEPENDENTE
CREATE TABLE tb_dependente(
	id_dependente INT PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(125)
);

-- COMANDOS PARA AUXÍLIO
SHOW TABLES;
DESC tb_funcionario;
DESC tb_dependente;
DESC tb_projeto;

INSERT INTO tb_funcionario VALUES
(1, 'João Pedro', 'Analista'),
(2, 'Joana Silva', 'Anaçlista');

INSERT INTO tb_dependente VALUES
(1, 'Pedrinho'),
(2, 'Pedrinha');

SELECT * FROM tb_funcionario;
SELECT * FROM tb_dependente;

-- INSERIR UMA FK NA TABELA DEPENDENTE PARA FAZER A IDENTIFICAÇÃOPTIMIZE
ALTER TABLE tb_dependente
ADD COLUMN id_funcionario INT;

-- INFORMANDO ID_FUNCIONARIO COMO FK
ALTER TABLE tb_dependente
ADD FOREIGN KEY (id_funcionario)
REFERENCES tb_funcionario (id_funcionario); -- faz referência à tabela com a PK
-- MUL (Multiple): chave composta ou chave estrangeira

-- ALIMENTANDO A COLUNA FK DA TABELA DEPENDENTE COM A PK DA TABELA FUNCIONÁRIO
UPDATE tb_dependente
SET id_funcionario = '1'
WHERE id_dependente in ('1','2');

-- ADICIONAR MAIS UM DEPENDENTE
INSERT INTO tb_dependente (nome) VALUES
('Pedrinho');

-- CRIAÇÃO DA TABELA PROJETO
CREATE TABLE tb_projeto(
	id_projeto INT PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(125),
    descricao TEXT
);

-- CRIAÇÃO DA TABELA PARTICIPAÇÃO
CREATE TABLE tb_participacao(
	id_participacao INT PRIMARY KEY AUTO_INCREMENT,
    id_projeto INT NOT NULL,
    id_funcionario INT NOT NULL,
    data_inicio DATE,
    data_fim DATE,
    FOREIGN KEY (id_projeto) REFERENCES tb_projeto (id_projeto),
    FOREIGN KEY (id_funcionario) REFERENCES tb_funcionario (id_funcionario),
    UNIQUE (id_projeto, id_funcionario)
);

SHOW TABLES;

INSERT INTO tb_projeto (nome, descricao) values
('Projeto A', 'Iniciando o projeto A'),
('Projeto B', 'Iniciando o projeto B');

SELECT * FROM tb_projeto;

INSERT INTO tb_participacao 
	(id_participacao, id_projeto, id_funcionario, data_inicio, data_fim)
VALUES
	(1, 1, 1, '2024-05-05', '2024-06-05'),
    (2, 1, 2, '2024-05-05', '2024-06-05');
SELECT * FROM tb_participacao;

INSERT INTO tb_participacao 
	(id_participacao, id_projeto, id_funcionario, data_inicio, data_fim)
VALUES
	(3, 1, 1, '2024-05-05', '2024-06-05');    