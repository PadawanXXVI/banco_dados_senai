CREATE DATABASE db_firma;
USE db_firma;

CREATE TABLE tb_funcionario(
matricula INT PRIMARY KEY AUTO_INCREMENT,
nome VARCHAR(125),
data_nascimento DATE,
nacionalidade VARCHAR(125) DEFAULT 'Brasileira',
sexo ENUM('F', 'M'),
estado_civil ENUM('casada(o)', 'divorciada(o)', 'separada(o)', 'solteira(o)', 'viúva(o)'),
rg VARCHAR(125),
cpf VARCHAR(20),
data_admissao DATE
);

CREATE TABLE tb_cargo(
	id_cargo INT PRIMARY KEY AUTO_INCREMENT,
    cargo VARCHAR(125),
    data_inicio DATE,
    data_fim DATE
);

CREATE TABLE tb_dependente(
	id_dependente INT PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(125),
    data_nascimento DATE,
    matricula_func INT,
    FOREIGN KEY (matricula_func) REFERENCES tb_funcionario (matricula)
);

CREATE TABLE tb_tel_func(
	id_tel_fun INT PRIMARY KEY AUTO_INCREMENT,
    pessoal VARCHAR(20),
    residencial VARCHAR(20)
);

CREATE TABLE tb_endereco(
	id_endereco INT PRIMARY KEY AUTO_INCREMENT,
    logradouro VARCHAR(125),
    numero VARCHAR(125),
    complemento VARCHAR(125),
    cidade VARCHAR(125),
    estado VARCHAR(125),
    cep VARCHAR(125)
);

CREATE TABLE tb_func_cargo(
	id_func_cargo INT PRIMARY KEY AUTO_INCREMENT,
    matricula_func INT,
    id_cargo INT,
    FOREIGN KEY (matricula_func) REFERENCES tb_funcionario (matricula),
    FOREIGN KEY (id_cargo) REFERENCES tb_cargo (id_cargo)
);

DESC tb_endereco;
DESC tb_tel_func;
DESC tb_funcionario;
DESC tb_dependente;
DESCRIBE tb_cargo;
DESC tb_func_cargo;

INSERT INTO tb_funcionario
	(nome, data_nascimento, nacionalidade, sexo, estado_civil, rg, cpf, data_admissao)
VALUES
	('João Silva', '1980-01-01', 'Brasileira', 'M', 'Solteira(o)', '12345678', '123.456.789-00', '2020-01-01'),
	('Maria Oliveira', '1985-02-02', 'Brasileira', 'F', 'Casada(o)', '23456789', '234.567.890-01', '2020-02-01'),
	('Carlos Souza', '1990-03-03', 'Brasileira', 'M', 'Casada(o)', '34567890', '345.678.901-02', '2020-03-01'),
	('Ana Lima', '1995-04-04', 'Brasileira', 'F', 'Solteira(o)', '45678901', '456.789.012-03', '2020-04-01'),
	('Pedro Santos', '2000-05-05', 'Brasileira', 'M', 'Solteira(o)', '56789012', '567.890.123-04', '2020-05-01');
    
INSERT INTO tb_cargo (id_cargo, cargo) VALUES
(1, 'Gerente'),
(2, 'Analista'),
(3, 'Desenvolvedor'),
(4, 'Designer'),
(5, 'Estagiário');

INSERT INTO tb_endereco 
	(id_endereco, logradouro, numero, complemento, bairro, cidade, estado, cep)
VALUES
	(1, 'Rua A', 123, 'Apto 1', 'Bairro A', 'Cidade A', 'Estado A', '12345-678'),
	(2, 'Rua B', 456, 'Apto 2', 'Bairro B', 'Cidade B', 'Estado B', '23456-789'),
	(3, 'Rua C', 789, 'Casa 3', 'Bairro C', 'Cidade C', 'Estado C', '34567-890'),
	(4, 'Avenida D', 101, 'Sala 4', 'Bairro D', 'Cidade D', 'Estado D', '45678-901'),
	(5, 'Travessa E', 112, 'Loja 5', 'Bairro E', 'Cidade E', 'Estado E', '56789-012');

INSERT INTO tb_tel_func
	(id_tel_fun, pessoal, residencial) 
VALUES
	(1, '999999999', '888888888'),
	(2, '999888888', '877777777'),
	(3, '999777777', '866666666'),
	(4, '999666666', '855555555'),
	(5, '999555555', '844444444');

SELECT * FROM tb_func_cargo;
