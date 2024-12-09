/*
Aula 13 - STORE PROCEDURE: procedimentos de armazenamento
São consultas avançadas que ficam armazenadas no banco de dados.
Podem modificar os dados.
Vamos chamar com o CALL.
Consegue utulizar o SELECT, UPDATE, DELETE.
*/

-- CRIAÇÃO E SELEÇÃO PARA USO DO BANCO DE DADOS
CREATE DATABASE IF NOT EXISTS db_procedimentos;
USE db_procedimentos;

-- CRIAÇÃO DA TABELA FUNCIONÁRIO
CREATE TABLE IF NOT EXISTS tb_funcionario(
    id_funcionario INT PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(100),
    cargo VARCHAR(100),
    salario_base DECIMAL(10,2),
    bonus DECIMAL(10,2),
    departamento VARCHAR(100),
    data_admissao DATE
);

-- CADASTRO DOS FUNCIONÁRIOS
INSERT INTO tb_funcionario
    (nome, cargo, salario_base, bonus, departamento, data_admissao)
VALUES
    ('Ana Souza', 'Analista', 3500.00, 500.00, 'TI', '2022-03-15'),
    ('Carlos Lima', 'Gerente', 5000.00, 800.00, 'Marketing', '2020-07-01'),
    ('Joana Santos', 'Desenvolvedora', 4000.00, 600.00, 'TI', '2021-11-20'),
    ('Pedro Almeida', 'Coordenador', 4500.00, 700.00, 'RH', '2019-04-10'),
    ('Mariana Oliveira', 'Assistente', 2500.00, 400.00, 'Financeiro', '2023-01-10');

-- VISUALIZAÇÃO DOS FUNCIONÁRIOS CADASTRADOS
SELECT * FROM tb_funcionario;