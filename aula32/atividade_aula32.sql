-- CRIAÇÃO E SELEÇÃO DO BANCO DE DADOS
CREATE DATABASE IF NOT EXISTS db_function;
USE db_function;

# 01 Crie uma função que receba uma idade e retorne se é  maior ou menor de idade.
DELIMITER $$
CREATE FUNCTION maioridade(idade INT)
RETURNS TEXT DETERMINISTIC
BEGIN
	RETURN CASE
		WHEN idade >= 18 THEN 'Você é maior de idade'
	ELSE 'Você é menor de idade'
    END;
END $$
DELIMITER ;

SELECT maioridade(20);

#02 Crie uma função que receba dois números e retorne o maior deles
DELIMITER $$
CREATE FUNCTION maior(numero1 INT, numero2 INT)
RETURNS INT DETERMINISTIC
BEGIN
	RETURN CASE
		WHEN numero1 > numero2 THEN numero1
	ELSE numero2
    END;
END $$
DELIMITER ;

SELECT maior(-4,-3);

#03 Crie uma função que converta uma string para maiúscula
DELIMITER $$
CREATE FUNCTION maiuscula(enunciado TEXT)
RETURNS TEXT DETERMINISTIC
BEGIN
	RETURN upper(enunciado);
END $$
DELIMITER ;

SELECT maiuscula('O professor é gente boa');

#04 Crie uma função para retornar o quadrado de um número
DELIMITER $$
CREATE FUNCTION quadrado(numero INT)
RETURNS INT DETERMINISTIC
BEGIN
	RETURN power(numero, 2);
END $$
DELIMITER ;

SELECT quadrado(-5);

#05 Crie uma função para contar a quantidade de caracteres de uma string

DELIMITER $$
CREATE FUNCTION tamanho(enunciado TEXT)
RETURNS INT DETERMINISTIC
BEGIN
	RETURN length(enunciado);
END $$
DELIMITER ;

SELECT tamanho('Anderson');

#06 Crie uma função que some dois números e retorne se ele é positivo ou negativo
DELIMITER $$
CREATE FUNCTION somaPar(numero1 INT, numero2 INT)
RETURNS TEXT DETERMINISTIC
BEGIN
	DECLARE soma INT;
    SET soma = numero1 + numero2;
    RETURN CONCAT('O resultado é ', soma, ' e ', IF (soma >= 0, 'a soma é positiva.', 'a soma é negativa.'));
END $$
DELIMITER ;

SELECT somaPAr(-20,5);