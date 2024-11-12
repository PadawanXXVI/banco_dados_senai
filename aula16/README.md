# STRUCTURED QUERY LANGUAGE SQL

## Comando ALTER e seus subcomandos/parâmetros

Vamos alteraer a estrutura das tabelas

## Criação do Banco de Dados e da tabela

```SQL
CREATE DATABASE db_academia;
USE db_academia;
CREATE TABLE tb_cliente (
    id_cliente INT AUTO_INCREMENT,
    nome VARCHAR(30) NOT NULL,
    sexo ENUM ('M', 'F', 'OUTROS'),
    peso DECIMAL(5,2),
    data_nascimento DATE,
    nacionalidade VARCHAR(20) DEFAULT 'Brasileira'
);
```

## Alimentação da tabela

```SQL 
INSERT INTO tb_cliente
    (id, nome, sexo, peso, data_nacimento, nacionalidade)
VALUES
-- ('1', 'Maria', 'F', '70', '2000-12-15', 'Brasileira') todos os valores foram passados porque todos os atribustos foram informados acima
-- ('João', 'Z', '70', '2000-12-15', 'Brasileira') valor 'z' errado na coluna sexo. Observar que para não inserir o id que é autoincremento, não informar o atribuito id
-- ('José', 'M', '70', 2000-12-15') nao informado o valor de nacionalidade, porém, não informar o atributo nacionalidade.
;
```

## Visualizar os dados inseridos

```SQL
SELECT * FROM tb_cliente;
```

## Adicionar coluna à tabela

```SQL
-- Adicionar coluna ao final
ALTER TABLE tb_cliente
ADD COLUMN altura DECIMAL(3,2)

-- Apagar um coluna
ALTER TABLE tb_cliente
DROP COLUMN altura;

-- Adicionar uma coluna em uma posição específica
ALTER TABLE tb_cliente
ADD COLUMN altura DECIMAL(3,2) AFTER nome;

-- Adcionar coluna na primeira posição
ALTER TABLE tb_cliente
ADD COLUMN email VARCHAR(30) FIRST;

-- Alterar o tipo de dado
ALTER TABLE tb_cliente
MODIFY COLUMN email VARCHAR(100); -- altera a quantidade de caracteres no VARCHAR, porém, pode ser usado para mudar o tipo: VARCHAR para INT, por exemplo.

-- Alterar o nome da coluna
ALTER TABLE tb_cliente
CHANGE COLUMN email carta VARCHAR(100);

-- Renomar o nome da tabela com ALTER
ALTER TABLE tb_cliente
RENAME TO tb_assistente;
```

## Nova tabela

```SQL
CREATE TABLE tb_plano(
    nome VARCHAR(30) NOT NULL,
    descrição TEXT,
    valor DECIMAL(5,2) UNSIGNED, -- UNSIGNED não permite valores negativos.
    ano YEAR DEFAULT '2024');
```

## Criar coluna na primeira posição

```SQL
ALTER TABLE tb_plano
ADD id_plano INT FIRST
```

## Colocar o campo como PK

```SQL
ALTER TABLE tb_plano
ADD PRIMARY KEY (id_plano);
```

## Mostrar a tabela preenchida

```SQL
DESC tb_plano;
```

[PÁGINA INICIAL](../README.md)
