/*
AULA 12 FUNCTION / Funções

Funções predefinidas
	Funções de agregação - COUNT, AVG, SUM, MAX MIN
	Funções data - DAY, MONTH, YEAR, CURDATE, TIMESTAMPDIFF, NOW
    
Funções criadas pelo usuário (UDF - User Defined Functions)
As funções sempre vão retornar um valor (texto, número ou data).
Podemos usar as funções em conjunto com o SELECT, WHERE, HAVING ...
Vai permitir aproveitar blocos de código.
Vamos criar para resolver um problema específico.
*/

-- CRIAÇÃO E SELEÇÃO PARA USO DO BANCO DE DADOS
CREATE DATABASE IF NOT EXISTS db_funcao;
USE db_funcao;

-- ESTRUTURA DE UMA FUNCTION
DELIMITER $$ -- altera o delimitador padrão (;) para um novo delimitador ($$) para evitar conflito
CREATE FUNCTION nome_funcao (param1 tipo1, param2 tipo2) -- parâmetros e tipos de dados de cada parâmetro
RETURNS tipo -- o tipo de dado que será retornado
DETERMINISTIC -- reaproveita o resultado para futuras consultas
BEGIN -- inicia o código da função
	codigo1;
    codigo2;
    codigo3;
    RETURN expressao; -- o que você quer retornar
END $$
DELIMITER ; -- retorna para o delimitador padrão

-- EXEMPLO 01: função para calcular idade
DELIMITER $$
CREATE FUNCTION calculaIdade(data_nascimento DATE)
RETURNS INT DETERMINISTIC
BEGIN
	DECLARE idade INT;
    SET idade = timestampdiff(YEAR, data_nascimento, curdate());
    RETURN idade;
END $$
DELIMITER ;

SELECT calculaIdade('1994-09-14'); -- chama a função.

-- EXEMPLO 02: calcular o IMC
DELIMITER $$
CREATE FUNCTION calculaimc(peso DECIMAL(5,2), altura DECIMAL(5,2))
RETURNS DECIMAL(5,2) DETERMINISTIC
BEGIN 
	DECLARE imc DECIMAL(5,2);
    SET imc = peso / (altura * altura);
	RETURN imc;
END $$
DELIMITER ;

SELECT calculaimc(107, 1.74);

-- EXEMPLO 03: calcular desconto
DELIMITER $$
CREATE FUNCTION calculaDesconto (preco DECIMAL(10,2), desconto DEC(10,2))
RETURNS DEC(10,2) DETERMINISTIC
BEGIN
	RETURN preco - (preco * (desconto/100));
END $$
DELIMITER ;

SELECT calculaDesconto(100, 50);

-- EXEMPLO 04: somar dois números
DELIMITER $$
CREATE FUNCTION soma (numero1 INT, numero2 INT)
RETURNS INT DETERMINISTIC
BEGIN
	RETURN numero1 + numero2;
END $$
DELIMITER ;

SELECT soma(15, 17) AS Adição;

-- EXEMPLO 05: verifica se o número é positivo ou negativo
DELIMITER $$
CREATE FUNCTION verificar (num INT)
RETURNS VARCHAR(15) DETERMINISTIC
BEGIN
	RETURN CASE
		WHEN num >= 0 THEN 'Positivo'
        ELSE 'Negativo'
	END;
END $$
DELIMITER ;
SELECT verificar(-5);

-- EXEMPLO 06: Verficiar se um número é par ou ímpar

DELIMITER $$
CREATE FUNCTION paridade (numero INT)
RETURNS TEXT DETERMINISTIC
BEGIN
    DECLARE resultado TEXT;
    IF MOD(numero, 2) = 0 THEN
        SET resultado = 'O número é par';
    ELSE
        SET resultado = 'O número é ímpar';
    END IF;
    RETURN resultado;
END $$
DELIMITER ;

DELIMITER $$
CREATE FUNCTION paridade2 (numero INT)
RETURNS TEXT DETERMINISTIC
BEGIN
	DECLARE resultado TEXT;
    CASE
		WHEN MOD(numero, 2) = 0 THEN
			SET resultado = 'O número é par';
		ELSE SET resultado = 'O numero é ímpar';
	END CASE;
	RETURN resultado;
END $$
DELIMITER ;
SELECT paridade2(13) AS Paridade;

-- VISUALIZAR AS FUNÇÕES CRIADAS
SHOW FUNCTION STATUS WHERE db = 'db_funcao'; -- visualiza a partir de um banco de dados específico
SHOW FUNCTION STATUS; -- visualiza a partir do banco de dados selecionado

-- APAGAR UMA FUNÇÃO
DROP FUNCTION nome_function;

-- MOSTRAR A ESTRUTURA DE UMA FUNÇÃO
SHOW CREATE FUNCTION soma;

###################### ATIVIDADES #####################
-- AT01: CRIE UMA FUNÇÃO QUE RECEBA UMA IDADE E RETORNE SE É MAIOR OU MENOR DE IDADE
DELIMITER $$
CREATE FUNCTION maioridade(idade INT)
RETURNS TEXT DETERMINISTIC
BEGIN
	RETURN CASE
		WHEN idade >= 18 THEN 'Maior de idade'
        ELSE 'Menor de idade'
	END;
END $$
DELIMITER ;

SELECT maioridade(25) AS `Condição penal`;

-- AT02: CRIE UMA FUNÇÃO QUE RECEBA DOIS NÚMEROS E RETORNE O MAIOR DELES
DELIMITER $$
CREATE FUNCTION maior (numero1 INT, numero2 INT)
RETURNS INT DETERMINISTIC
BEGIN
	RETURN CASE
		WHEN numero1 > numero2 THEN numero1
        ELSE numero2
	END;
END $$
DELIMITER ;

SELECT maior(-5,-4);

-- AT03: CRIE UMA FUNÇÃO QUE CONVERTA UMA STRING PARA MAIÚSCULA
DELIMITER $$
CREATE FUNCTION maiusculo(enunciado TEXT)
RETURNS TEXT DETERMINISTIC
BEGIN
	RETURN upper(enunciado);
END $$
DELIMITER ;

SELECT maiusculo('a vida é bela');

-- AT04: CRIE UMA FUNÇÃO PARA RETORNAR O QUADRADO DE UM NÚMERO
DELIMITER $$
CREATE FUNCTION quadrado(numero INT)
RETURNS INT DETERMINISTIC
BEGIN
	RETURN power(numero,2);
END $$
DELIMITER ;

SELECT quadrado(25);

-- AT05: CRIE UMA FUNÇÃO PARA CONTAR A QUANTIDADE DE CARACTERES DE UMA STRING
DELIMITER $$
CREATE FUNCTION tamanho (enunciado TEXT)
RETURNS INT DETERMINISTIC
BEGIN
	RETURN length(enunciado);
END $$
DELIMITER ;

SELECT tamanho ('Anderson');

-- AT06: CRIE UMA FUNÇÃO QUE SOME DOIS NÚMEROS E RETRONE SE ELE É POSITIVO OU NEGATIVO
DELIMITER $$
CREATE FUNCTION par (a INT, b INT)
RETURNS TEXT DETERMINISTIC
BEGIN
	DECLARE soma INT;
    SET soma = a + b;
    RETURN CONCAT('O resultado é ', soma, ' e ', IF (soma >= 0, 'a soma é positiva', 'a soma é negativa'));
END $$
DELIMITER ;

SELECT par(-20,4) AS Resultado;
    
    