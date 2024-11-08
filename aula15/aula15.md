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
``` sql
CREATE DATABSE biblioteca; -> cria o banco de dados

USE bd_biblioteca; -> confirma o banco de dados em usao para poder usar as tabelas

DROP DATABASE db_biblioteca; -> remove o banco de dados
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
