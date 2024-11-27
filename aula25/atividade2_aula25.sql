-- ATIVIDADE AULA 25, PK direto

-- CRIAÇAO E SELEÇÃO DO BANCO DE DADOS
CREATE DATABASE IF NOT EXISTS db_biblioteca02;
USE db_biblioteca02;

-- CRIAÇÃO DA TABELA CATEGORIA
CREATE TABLE tb_categoria(
	id_categoria INT PRIMARY KEY AUTO_INCREMENT,
    categoria VARCHAR(90)
);

-- CRIAÇÃO DA TABELA LIVRO
CREATE TABLE tb_livro(
	id_livro INT PRIMARY KEY AUTO_INCREMENT,        
    titulo VARCHAR(125) NOT NULL,
    autor VARCHAR(125) NOT NULL,
    editora VARCHAR(125)    
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
    data_emprestimo DATE,
    data_devolucao DATE    
);

-- POPULANDO AS TABELAS 
INSERT INTO tb_categoria (categoria) VALUES
('Ficção Científica'),
('Romance'),
('História'),
('Tecnologia'),
('Biografia');
SELECT * FROM tb_categoria;

INSERT INTO tb_livro (titulo, autor, editora) VALUES
('1984', 'George Orwell', 'Companhia das Letras'),
('O Senhor dos Anéis', 'J.R.R. Tolkien', 'HarperCollins'),
('A Brief History of Time', 'Stephen Hawking', 'Bantam Books'),
('Pride and Prejudice', 'Jane Austen', 'Penguin Books'),
('The Catcher in the Rye', 'J.D. Salinger', 'Little, Brown and Company');
SELECT * FROM tb_livro;

INSERT INTO tb_usuario (nome, email, data_nascimento) VALUES
('Ana Pereira', 'ana.pereira@example.com', '1990-05-12'),
('Carlos Silva', 'carlos.silva@example.com', '1985-08-23'),
('Beatriz Oliveira', 'beatriz.oliveira@example.com', '1992-11-30');
SELECT * FROM tb_usuario;

INSERT INTO tb_emprestimo (data_emprestimo, data_devolucao) VALUES
('2024-11-18', '2024-11-25'),
('2024-11-19', '2024-11-26'),
('2024-11-20', '2024-11-27'),
('2024-11-21', '2024-11-28'),
('2024-11-22', '2024-11-29');
SELECT * FROM tb_emprestimo;

-- INSERINDO AS COLUNAS QUE RECEBEM AS FK NA TABELA LIVRO
ALTER TABLE tb_livro
ADD COLUMN id_categoria INT AFTER id_livro;
DESC tb_livro;

-- INSERINDO AS CHAVES ESTRANGEIRAS NA TABELA LIVRO
ALTER TABLE tb_livro
ADD FOREIGN KEY (id_categoria)
REFERENCES tb_categoria(id_categoria);
SELECT * FROM tb_livro;

-- ALIMENTANDO A TABELA LIVRO COM A FK CATEGORIA
UPDATE tb_livro
SET id_categoria = '1'
WHERE id_livro = '1';

UPDATE tb_livro
SET id_categoria = '2'
WHERE id_livro IN ('3','5');

UPDATE tb_livro
SET id_categoria = '3'
WHERE id_livro = '4';


-- INSERINDO AS COLUNAS QUE RECEBEM AS FK NA TABELA EMPRÉSTIMO
ALTER TABLE tb_emprestimo
ADD COLUMN id_livro INT AFTER id_emprestimo;
DESC tb_emprestimo;

ALTER TABLE tb_emprestimo
ADD COLUMN id_usuario INT AFTER id_emprestimo
DESC tb_emprestimo;

-- INSERINDO AS CHAVES ESTRANGEIRAS NA TABELA EMPRÉSTIMO
ALTER TABLE tb_emprestimo
ADD FOREIGN KEY (id_usuario) REFERENCES tb_usuario (id_usuario)
ADD FOREIGN KEY (id_livro) REFERENCES tb_livro (id_livro);


-- ALIMENTANDO A TAVBELA EMPRÉSTIMO COM AS FK

-- FK USUÁRIO
UPDATE tb_emprestimo
SET id_usuario = '1'
WHERE id_emprestimo IN ('1','5');

UPDATE tb_emprestimo
SET id_usuario = '2'
WHERE id_emprestimo IN ('3','4');

UPDATE tb_emprestimo
SET id_usuario = '5'
WHERE id_emprestimo = '2';

-- FK LIVRO
UPDATE tb_emprestimo
SET id_livro = '1'
WHERE id_usuario IN ('1','3','5');

UPDATE tb_emprestimo
SET id_livro = '2'
WHERE id_usuario = '4';

UPDATE yb_emprestimo
SET id_livro = '4'
WHERE id_usuario = '2';
