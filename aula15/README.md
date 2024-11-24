# INTRODUÇÃO A SQL

SQL é uma linguagem usada exclusivamente para criar tabelas, manipular dados eda tabelas e, principalmente, consultar os dados. É através do SQL que os programas interagem com um banco de dados relacional.

SQL é uma linguagem de consulta.

Alguns comando SQL mudam de um banco para outro mas, no geral, a sintaxe é a mesma entre todos os SGBD relacionais.

## 1 Grupos de Comandos SQL

### 1.1 DDL

Linguagem de Definição de Dados

É um conjunto de comandos SQL utilizados para definir e modificar a estrutura de objetos em um banco de dados.

#### 1.1.1 
- CREATE: criar um novo banco de dados
- ALTER
- DROP

exemplo: 
```sql
CREATE DATABSE biblioteca; -> cria o banco de dados

USE bd_biblioteca; -- confirma o banco de dados em usao para poder usar as tabelas

DROP DATABASE db_biblioteca; -- remove o banco de dados
```
Observação:

Todo comando SQL termina obrigatoriamente em ; (ponto-e-vírgula)

### 1.2 DML 

Linguagem de Manipulação de Dados

#### 1.2.1 Comandos

- INSERT
- UPDATE
- DELETE

### 1.3 DQL

Linguagem de Consulta de Dados

Comandos utilizados para realizar consultas em um banco de dados

#### 1.3.1 Comandos

- SELECT


## Constraints

São regras aplicadas às colunas:

- NOT NULL: para a coluna ão possui valores nulos
- UNIQUE: garante todos os valores únicos na coluna
- PRIMARY KEY: identifica unicamente cada linha
- FOREIGN KEY: garante a integridade referencial entre tabelas
- DEFAULT: define um valor padrão na coluna se nenhun valor for registrado

## Tipos de dados

- INTEGER ou INT
- VARCHAR
- CHAR
- DATE
- TIME
- DECIMAL ou DEC

# COMANDOS UTILIZADOS EM SALA DE AULA

## Criação de Banco de Dados

```SQL 
-- Criação simples
CREATE DATABASE db_escola; -- por convenção usar db_nome para criação de banco de dados.

-- Criação com restrição (caso o database não exista e com definição dos caracteres)
CREATE DATABASE IF NOT EXISTS db_escola
COLLATE utf8mb4_generic_ci
CHARSET utf8mb4;
```

## Exclusão de Banco de Dados

```SQL
DROP DATABASE tb_escola;
```

## Exibir os Bancos de Dados criados

```SQL
SHOW DATABASES;
```
## Escolher em que Banco de Dados Criar as tabelas

```SQL
USE db_escola;
```

## Criação de Tabela

```SQL
-- Criação simples, apenas o nome da tabela e os atributos e o tipo de dado do atributo
CREATE TABLE tb_aluno ( -- convenção tb_nome
    id_aluno INT,
    nome VARCHAR(125),
    email VARCHAR(125),
    data_nascimento DATE
);

-- Criação com restrições nos atributos
CREATE TABLE tb_aluno(
    id_aluno INT PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(125) NOT NULL,
    email VARCHAR(125) NOT NULL,
    data_nascimento DATE NOT NULL
);
```

## Exibir tabelas criadas

```SQL
SHOW TABLES;
```

## Exibir os detalhes de uma tabela

```SQL
DESCRIBE tb_aluno;
-- ou
DESC tb_aluno;
```

## Comando para apagar um tabela

```SQL
DROP TABLE tb_aluno;
```

## Comando para alimentar a tabela

```SQL
-- Informando em quais tabelas você quer inserir os dados
INSERT INTO tb_aluno
    (id_aluno,nome,email,data_nascimento) -- nomes das colunas
VALUES
    (1,'Anderson de Matos Guimarães',anderson@email.com,20010926); -- data no formato Ano Mês Dia
/*
Caso o id seja auto_increment, não será necessário informar a coluna id nem inserir seu valor. Mesmo com autoincremento, caso você informe o primeiro id, os próximos seguem a sequência, sem ser necessário informá-lo.
Outro valor que pode ser informano no id quando ele for autonincremento é DEFAULT
*/

-- Caso queira inserir em todas as colunas da tabela
INSERT INTO tb_aluno VALUES -- basta omitir os nomes das colunas
    ('Maria', 'maria@email.com', 19520324);
```

## Comandos para visualizar as tabelas com os dados inseridos

```SQL
-- todas as colunas
SELECT * FROM tb_aluno;

-- uma coluna específica
SELECT nome FROM tb_aluno; -- exibir os dados da coluna nome da tabela tb_aluno

-- mais de uma coluna
SELECT nome,data_nascimento FROM tb_aluno;
```
## Comando para alterar o nome da tabela

```SQL
RENAME TABLE tb_aluno TO tb_pessoa;
```
[PÁGINA INICIAL](../README.md)