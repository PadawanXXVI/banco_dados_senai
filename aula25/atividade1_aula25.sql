-- ATIVIDADE AULA 25, PK direto

-- CRIAÇAO E SELEÇÃO DO BANCO DE DADOS
CREATE DATABASE IF NOT EXISTS db_biblioteca01;
USE db_biblioteca01;

-- CRIAÇÃO DA TABELA CATEGORIA
CREATE TABLE tb_categoria(
	id_categoria INT PRIMARY KEY AUTO_INCREMENT,
    categoria VARCHAR(90)
);

-- CRIAÇÃO DA TABELA LIVRO
CREATE TABLE tb_livro(
	id_livro INT PRIMARY KEY AUTO_INCREMENT,
    id_categoria INT NOT NULL,     
    titulo VARCHAR(125) NOT NULL,
    autor VARCHAR(125) NOT NULL,
    editora VARCHAR(125),
    FOREIGN KEY (id_categoria) REFERENCES tb_categoria (id_categoria)       
);

-- CRIAÇÃO DA TABELA USUÁRIO
CREATE TABLE tb_usuario(
	id_usuario INT PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(125) NOT NULL,
    email VARCHAR(125) NOT NULL,
    data_nascimento DATE
);

-- CRIAÇÃO TABELA EMPRÉSTIMO
CREATE TABLE tb_emprestimo(
	id_emprestimo INT PRIMARY KEY AUTO_INCREMENT,
    id_livro INT NOT NULL,
    id_usuario INT NOT NULL,
    data_emprestimo DATE,
    data_devolucao DATE,
    FOREIGN KEY (id_livro) REFERENCES tb_livro (id_livro),
    FOREIGN KEY (id_usuario) REFERENCES tb_usuario (id_usuario)
);

-- POPULANDO AS TABELAS 
INSERT INTO tb_categoria (categoria) VALUES
('Ficção Científica'),
('Romance'),
('História');
SELECT * FROM tb_categoria;

INSERT INTO tb_livro (id_categoria, titulo, autor, editora) VALUES
(1, 'Duna', 'Frank Herbert', 'Editora Aleph'),
(2, 'Orgulho e Preconceito', 'Jane Austen', 'Penguin Books'),
(3, 'Sapiens: Uma Breve História da Humanidade', 'Yuval Noah Harari', 'Companhia das Letras');
SELECT * FROM tb_livro;

INSERT INTO tb_usuario (nome, email, data_nascimento) VALUES
('Ana Pereira', 'ana.pereira@example.com', '1990-05-12'),
('Carlos Silva', 'carlos.silva@example.com', '1985-08-23'),
('Beatriz Oliveira', 'beatriz.oliveira@example.com', '1992-11-30');
SELECT * FROM tb_usuario;

INSERT INTO tb_emprestimo (id_livro, id_usuario, data_emprestimo, data_devolucao) VALUES
(1, 1, '2024-11-11', '2024-11-18'),
(2, 2, '2024-11-12', '2024-11-19'),
(3, 1, '2024-11-13', '2024-11-20');
SELECT * FROM tb_emprestimo;
