/*
AULA 02 - ALTER e seus subcomando/parâmetros
Vamos alterar a estrutura das tabelas
*/

CREATE DATABASE IF NOT EXISTS db_academia;
USE db_academia;

CREATE TABLE tb_cliente (
	id_cliente INT AUTO_INCREMENT,
    nome VARCHAR(30) NOT NULL,
    sexo ENUM ('M', 'F', 'OUTROS'), -- ENUM : tipo enumarate
    peso DECIMAL (5,2), -- cinco algarismo, duas são casas decimais
    data_nascimento DATE,
    nacionalidade VARCHAR(20) DEFAULT 'Brasil', -- DEFUAL : caso o valor do campo não seja informado, o sistema coloca o valor padrão, nesse caso, Brasil.
    PRIMARY KEY (id_cliente)
);

INSERT INTO tb_cliente
	(nome, sexo, peso, data_nascimento)
VALUES
-- ('1', 'Maria', 'F', '70', '2000-12-15', 'Brasileira'); item jpa inserido, exemplo agora sem informar o id
-- ('João', 'M', '70', '2000-12-15', 'Brasileira');
('José', 'M', '70', '2000-12-15'); -- sem o campo nacionalidade

SELECT * FROM tb_cliente;

-- Adicionar coluna
ALTER TABLE tb_cliente
ADD COLUMN altura DECIMAL(3,2);

-- Apagar uma coluna
ALTER TABLE tb_cliente
DROP COLUMN altura;

-- Escolher a posição da coluna que for criada
ALTER TABLE tb_cliente
ADD COLUMN altura DECIMAL(3,2) AFTER nome;

-- Adicionar uma coluna na primeira posição da tabela
ALTER TABLE tb_cliente
ADD COLUMN email VARCHAR(30) FIRST;

-- Altera o tipo de dado
ALTER TABLE tb_cliente
MODIFY COLUMN email VARCHAR(100);

-- ALterar o nome da coluna, informando a nova coluna e o tipo de dado dela
ALTER TABLE tb_cliente
CHANGE COLUMN email carta VARCHAR(100);

-- Alterar o nome da tabela com ALTER
ALTER TABLE tb_cliente
RENAME TO tb_assistente;

SELECT * FROM tb_assistente; -- visualizando a nova tabela
SHOW TABLES; -- visualizando todas as tabelas do Banco de Dados

-- Nova tabela
CREATE TABLE tb_plano(
	nome VARCHAR(30) NOT NULL,
    descrição TEXT,
    valor DECIMAL(5,2) UNSIGNED, -- UNSIGNED informa que não recebe valores negativos
    ano YEAR DEFAULT '2024'); -- YEAR retorna apenas o ano
