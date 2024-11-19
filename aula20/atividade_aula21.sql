CREATE DATABASE db_revisao;

USE db_revisao;

CREATE TABLE tb_tabela1 (
	id INT PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(90) NOT NULL,
    email VARCHAR(90) NOT NULL
);


INSERT INTO tb_tabela1 
	(id, nome, email)
VALUES
	(1, 'Anderson', 'anderson@email.com');
    
SELECT * FROM tb_tabela1;

SELECT * FROM tb_tabela1
WHERE id = '1';

SELECT * FROM tb_tabela1
WHERE id <>10;


SELECT * FROM tb_tabela1
WHERE nome = 'anderson' OR email = 'anderson@email.com';

SELECT * FROM tb_tabela1
WHERE nome LIKE '%a';


SELECT * FROM tb_tabela1
WHERE id BETWEEN '1' AND '100';


DELETE FROM tb_tabela1
WHERE nome = 'Anderson' AND id = '1';


UPDATE tb_tabela1
SET nome = 'Maria'
WHERE id = '1' AND email = 'anderson@email.com';


ALTER TABLE tb_tabela1
CHANGE COLUMN telefone endereco VARCHAR(15);

ALTER TABLE tb_tabela1
ADD COLUMN telefone INT;

ALTER TABLE tb_tabela1
ADD COLUMN codigo INT FIRST;


ALTER TABLE tb_tabela1
MODIFY  endereco VARCHAR(255);

ALTER TABLE tb_tabela1
DROP COLUMN codigo;

ALTER TABLE tb_tabela1
RENAME TO tb_registro;

TRUNCATE TABLE tb_registro;

SELECT DISTINCT email FROM tb_registro;


SELECT AVG(salario) AS `Média de salário`FROM tb_registro;

SELECT COUNT(*) FROM tb_registro;


SELECT SUM(salario) FROM tb_registro;



SELECT AVG(salario) FROM tb_registro;
    
SELECT MIN(salario) FROM tb_registro;


