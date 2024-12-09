/*
REVISÃO PARA SEGUNDA PROVA DE SQL
Conteúdo:
    Relacionamento entre tabelas;
    INNER JOIN;
    Funções de data;
    VIEW;
    CASE... WHEN;
    FUNCTION;
    STORE PROCEDURE
*/

CREATE DATABASE IF NOT EXISTS db_empresa04;
use db_empresa04;

CREATE TABLE IF NOT EXISTS tb_funcionario(
    id_funcionario INT PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(125),
    cargo VARCHAR(125)
);

CREATE TABLE IF NOT EXISTS tb_dependente(
    id_dependente INT PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(125),
);

INSERT INTO tb_funcionario VALUES
(1, 'João Pedro', 'Analista'),
(2, 'Joana Silva', 'Analista');

INSERT INTO tb_dependente VALUES
(1, 'Pedrinho'),
(2, 'Pedrinha');


-- RELACIONANDO TABELAS APÓS CRIADAS

-- 1º passo: criar a coluna que receberá a chave estrangeira
ALTER TABLE tb_dependente
ADD COLUMN id_funcionario;

-- 2º passo: informando id_funcionario como FK da tabela dependente
ALTER TABLE tb_dependente
ADD FOREIGN KEY (id_funcionario)
REFERENCES tb_funcionario (id_funcionario);

-- 3º passo: alimentando a coluna FK da tabela dependente com a PK da tabela funcionário
UPTDATE tb_dependente
SET id_funcionario = '1'
WHERE id_dependente in ('1', '2');

-- CRIAÇÃO DIRETA
CREATE TABLE IF NOT EXISTS tb_projeto(
    id_projeto INT PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(125),
    descriacao TEXT
);

CREATE TABLE IF NOT EXISTS tb_participacao(
    id_participacao INT PRIMARY KEY AUTO_INCREMENT,
    id_projeto INT NOT NULL,
    id_funcionario INT NOT NULL,
    data_inicio DATE,
    data_fim DATE,
    FOREIGN KEY (id_projeto) REFERENCES tb_projeto (id_projeto),
    FOREIGN KEY (id_funcionario) REFERENCES tb_funcionario (id_funcionario)
);

-- ALIMENTANDO AS TABELAS
INSERT INTO tb_projeto (nome, descriacao) VALUES
('Projeto A', 'Iniciando o projeto A'),
('Projeto B', 'Iniciando o projeto B');

INSERT INTO tb_participacao (id_participacao, id_projeto, id_funcionario, data_inicio, data_fim) VALUES
(1, 1, 1, '2024-05-05', '2024-06-05'),
(2, 1, 2, '2024-05-05', '2024-06-05');

-- INSERINDO NOVO REGISTRO
INSERT INTO tb_participacao
    (id_participacao, id_projeto, id_funcionario, data_inicio, data_fim)
VALUES
    (3, 1, 1, '2024-05-05', '2024-06-05');
