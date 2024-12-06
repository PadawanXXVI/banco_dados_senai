# FUNCTION / FUNÇÕES

## Funções predefinidas

- Funções de agregação: COUNT, AVG, SUM, MAX, MIN etc.
- Funções de data: DAY, MONTH, YEAR, CURDATE, TIMESTAMPDIFF, NOW etc.

## Funções criadas pelo usuário (UDF - User Defined Functions)

- As funções sempre vão retornar um valor (text, número ou data).
- Podemos sar as funções em um conjunto com o SELECT, WHERE, HAVING etc.
- Vão permitir aproveitar blocos de código.
- São criadas para resolver um problema específico.

## CRIAÇÃO E SELEÇÃO PARA USO DO BANCO DE DADOS

```SQL
CREATE DATABASE IF NOT EXISTS db_funcao;
USE db_funcao;
```

## ESTRUTURA DE UMA FUNCTION

```SQL
DELIMITER $$ -- altera o delimitador padrão (;) para um novo delimitador ($$) para evitar conflitos
CREATE FUNCTION nome_funcao (param1 tipo1, param2 tipo2) -- parâmetros e tipos de dados de cada parâmetro
RETURNS tipo -- o tipo de dado que será retornado
DETERMINISTIC -- reaproveita o resultado para futuras consultas
BEGIN -- inicia o código da função
    código1;
    código2;
    código3
    RETURN expressao; -- o que você quer retornar
END $$
DELIMITER ; -- retorna o delimitador padrão
```

## EXEMPLO 01: função para calcular idade

```SQL
DELIMITER $$
CREATE FUNCTION calculaIdade(data_nascimento DATE)
RETURNS INT DETERMINISTIC
BEGIN
    DECLARE idade INT; -- declaração da variável idade do tipo inteiro
    SET idade = timestampdiff(YEAR, data_nascimento, curdate());
    RETURN idade;
END $$
DELIMITER ;

SELECT claculaIdade('1994-09-14') -- chama a função
```

## EXEMPLO 02: função para calcular o IMC

```SQL
DELIMITER $$
CREATE FUNCTION calculaIMC(peso DECIMAL(5,2), altura DECIMAL(5,2))
RETURNS DECIMAL(5,2) DETERMINISTIC
BEGIN
    DECLARE imc DECIMAL(5,2);
    SET imc = peso / (altura * altura);
    RETURN imc;
END $$
DELIMITER ;

SELECT calculaIMC(107, 1.74);
```

## EXEMPLO 03: calcular desconto

```SQL
DELIMITER $$
CREATE FUNCTION calculaDesconto(preco DECIMAL(10,2), desconto DEC(10,2))
RETURNS DEC(10,2) DETERMINISTIC
BEGIN
    RETURN preco - (preco * (descont/100));
END $$
DELIMITER ;

SELECT calculaDesconto(100,50);
```

## EXEMPLO 04: somar dois números

```SQL
DELIMITER $$
CREATE FUNCTION soma(numero1 INT, numero2 INT)
RETURNS INT DETERMINISTIC
BEGIN
    RETURN numero1 + numero2;
END $$
DELIMITER ;

SELECT soma(3,5);
```

## EXEMPLO 05: verifica se o numero é positivo ou negativo

```SQL
DELIMITER $$
CREATE FUNCTION verificar(numero INT)
RETURNS VARCHAR(15) DETERMINISTIC
BEGIN
    RETURN CASE
        WHEN numero >= 0 THEN 'Positivo'
    ELSE 'Negativo'
    END;
END $$
DELIMITER ;

SELECT verificar(-5);
```

[Página Inicial](../README.md)
