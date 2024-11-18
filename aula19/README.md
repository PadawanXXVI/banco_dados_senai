# PRIMEIRA REVISÃO SQL DDL, DML E DQL.

## Banco de dados

### 1 Criar banco de dados

```SQL
CREATE DATABASE IF NOT EXISTS db_nome_do_banco; -- por convenção, utilizamos db_nomedobanco.
```

### 2 Deletar banco de dados

```SQL
DROP DATABASE nome_do_banco;
```

### 3 Selecionar banco de dados

```SQL
USE nome_do_banco;
```

### 4 Listar os bancos de dados criados

```SQL
SHOW DATABASES;
```

## Tabelas

### 1 Criar tabela

```SQL
CREATE TABLE tb_nome_da_tabela ( -- por convenção, usamos tb_nomedatabela.
    id INT PRIMARY KEY AUTO INCREMENT, -- nome da coluna / tipo de dados / exceções.
    coluna1 VARCHAR(100),
    coluna2 INT,
    ...
);
```

### 2 Deletar tabela

```SQL
DROP TABLE nomedatabela;
```
### 3 Adicionar coluna (última coluna)

```SQL
ALTER TABLE nome_da_tabela
ADD COLUNM coluna3 DECIMAL(3,2); -- coluna3 é o nome da nova coluna criada seguida do tipo de dado. 
```

### 4 Adicionar uma coluna em posição específica

```SQL
ALTER TABLE nome_da_tabela
ADD COLUMN coluna4 INT AFTER column2; -- nome da coluna e tipo de dados after (depois) da coluna2 (nome da coluna que vai anteceder a nova coluna)
```

### 5 Adicionar uma coluna na primeira posição

```SQL
ALTER TABLE nome_da_tabela
ADD COLUMN coluna5 INT FIRST; -- nome da coluna e tipo de dados FIRST (na primeira posição).
```

### 6 Alterar no nome da coluna

```SQL
ALTER TABLE nome_da_tabela
CHANGE COLUMN nome_da_coluna novo_nome_da_coluna VARCHAR(100); -- nomeAntigo novoNome tipo de dado.
```

### 7 Remover coluna

```SQL 
ALTER TABLE nome_da_tabela
DROP COLUMN nome_da_coluna;
```

### 8 Alterar o tipo de dados na coluna

```SQL
ALTER TABLE nome_da_tabela
MODIFY COLUMN email VARCHAR(100); -- pode ser usado para mudar o tipo ou até mesmo para muda a quantidade de caracteres em um tipo determinado.
```

### 9 Renomear uma tabela

```SQL
RENAME TABLE nome_da_tabela TO novo_nome_da_tabela;
```

### 10 Renomear a tabela usando o ALTER

```SQL
ALTER TABLE nome_da_tabela
RENAME TO novo_nome_da_tabela;
```

### Listar as tabelas criadas

```SQL
SHOW TABLES;
```


[Página Inicial](../README.md)
