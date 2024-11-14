-- CRIAÇÃO DO BANCO DE DADOS
CREATE DATABASE IF NOT EXISTS db_escola;

-- SELECÇÃO DO BANCO DE DADOS
USE db_escola;

-- CRIAÇÃO DA TABELA ALUNO
CREATE TABLE IF NOT EXISTS tb_aluno(
	id_aluno INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(50),
    sexo ENUM('M','F'),
    nota FLOAT,
    cidade VARCHAR(50)
);

-- ALIMENTAÇÃO DOS DADOS
INSERT INTO tb_aluno
	(nome, sexo, nota, cidade)
VALUES
	('Carlos Silva', 'M', 8.5, 'Brasília'),
	('Mariana Oliveira', 'F', 7.3, 'Taguatinga'),
	('João Souza', 'M', 6.2, 'Ceilândia'),
	('Ana Paula Costa', 'F', 9.0, 'Gama'),
	('Pedro Almeida', 'M', 5.8, 'Planaltina'),
	('Fernanda Ribeiro', 'F', 8.1, 'Sobradinho'),
	('Roberto Lima', 'M', 7.9, 'Samambaia'),
	('Beatriz Santos', 'F', 6.5, 'Recanto das Emas'),
	('Lucas Fernandes', 'M', 8.7, 'Águas Claras'),
	('Julia Mendes', 'F', 9.2, 'Guará');

-- 1. Exiba todas as tabelas existentes no banco de dados. 
SHOW TABLES;
 
-- 2. Use um comando para exibir a estrutura da tabela. 
DESCRIBE tb_aluno;
 
-- 3. Traga somente o nome dos alunos. 
SELECT nome FROM tb_aluno;

-- 4. Selecione todos os registros da tabela `alunos`. 
SELECT * FROM tb_aluno;
 
-- 5. Exiba apenas os nomes e notas dos alunos. 
SELECT nome, nota FROM tb_aluno;
 
-- 6. Mostre todos os alunos que têm nota maior que 7.
Select * FROM tb_aluno
WHERE nota > '7';
 
-- 7. Selecione todos os alunos do sexo feminino (`f`) que moram na cidade de “Brasília”. 
SELECT * FROM tb_aluno
WHERE sexo = 'f' AND cidade ='Brasília';
 
-- 8. Exiba os alunos que têm nota maior que 5 e são do sexo masculino. 
SELECT * FROM tb_aluno
WHERE nota > 5 AND sexo = 'M';
 
-- 9. Exiba os alunos que têm nota entre 6 e 8. 
SELECT * FROM tb_aluno
WHERE nota BETWEEN '6' AND '8';
 
-- 10. Selecione somente os alunos da Samambaia com nota maior que 8. 
SELECT * FROM tb_aluno
WHERE cidade = 'Samambaia' AND nota > '8';
 
-- 11. Mostre todos os alunos cuja nota não esteja entre 5 e 9. 
SELECT * FROM tb_aluno
WHERE nota NOT BETWEEN '5' AND '9';
 
-- 12. Exiba todos os alunos que estão nas cidades de “Brasília” ou “Novo Gama”.
SELECT * FROM tb_aluno
WHERE cidade IN ('Brasília', 'Novo Gama'); 
 
-- 13. Liste todos os alunos que têm notas `4`, `6`, ou `8`. 
SELECT * FROM tb_aluno
WHERE nota IN ('4', '6', '8');

-- 14. Selecione os alunos cujo nome começa com a letra "A". 
SELECT * FROM tb_aluno
WHERE nome LIKE 'A%';
 
-- 15. Exiba todos os alunos cuja cidade termina com a letra "a". 
SELECT * FROM tb_aluno
WHERE cidade LIKE '%a';
 
-- 16. Adicione uma coluna `data_nascimento` do tipo `DATE` à tabela `alunos`. 
 ALTER TABLE tb_aluno
 ADD COLUMN data_nascimento DATE;
 
-- 17. Remova a coluna `data_nascimento` da tabela.
ALTER TABLE tb_aluno
DROP COLUMN data_nascimento;
 
-- 18. Modifique o tipo de dado da coluna nome para `varchar(150)`. 
ALTER TABLE tb_aluno
MODIFY COLUMN nome VARCHAR(150);
 
-- 19. Renomeie a coluna `sexo` para `genero`. 
ALTER TABLE tb_aluno
CHANGE COLUMN sexo genero ENUM('M','F');
 
-- 20. Adicione uma coluna `email` do tipo `varchar(50)` à tabela `alunos`. 
ALTER TABLE tb_aluno
ADD COLUMN email VARCHAR(50);
 
-- 21. Remova a coluna `email` que foi adicionada anteriormente. 
ALTER TABLE tb_aluno
DROP COLUMN email;
 
-- 22. Modifique a coluna `cidade` para ter o tipo `varchar(100)`. 
ALTER TABLE tb_aluno
MODIFY COLUMN cidade VARCHAR(100);
 
-- 23. Mostre somente os nomes dos alunos do sexo masculino. 
SELECT nome FROM tb_aluno
WHERE genero = 'M';
 
-- 24. Renomeie a tabela `tb_alunos` para `tb_estudante`. 
RENAME TABLE tb_aluno TO tb_estudante;
 
-- 25. Atualize a nota para `10` de todos os alunos que estão na cidade de "Gama". 
UPDATE tb_estudante
SET nota = '10'
WHERE cidade = 'Gama';
 
-- 26. Adicione o sobrenome Silva para o aluno Pedro. 
UPDATE tb_estudante
SET nome = 'Pedro Almeida Silva'
WHERE id_aluno = '5';
 
-- 27. Delete todos os alunos que têm nota menor que 6. 
DELETE FROM tb_estudante
WHERE nota < 6;
 
-- 28. Exclua todos os alunos que estão na cidade de “Samambaia”. 
DELETE FROM tb_estudante
WHERE cidade = 'Samambaia';
 
-- 29. Selecione todos os alunos do sexo feminino que estão nas cidades de “Brasília” ou “Goiânia” e têm notas entre 6 e 10. 
SELECT * FROM tb_estudante
WHERE cidade IN ('Brasília', 'Goiânia') AND nota BETWEEN '6' AND '10';
 
-- 30. Apague todos os dados da tabela onde estão os registros dos alunos, sem remover sua estrutura.
TRUNCATE TABLE tb_estudante;

-- DROP DATABASE db_escola;