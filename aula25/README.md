# RELAÇÃO ENTRE TABELAS

## CRIAÇÃO DO BANCO DE DADOS

```SQL
CREATE DATABASE IF NOT EXISTS tb_empresa;
```

## SELEÇÃO PARA USO DO BANCO DE DADOS

```SQL
USE db_empresa;
```

## CRIAÇÃO DA TABELA FUNCIONÁRIO

```SQL
CREATE TABLE tb_funcionario(
    id_funcionario INT PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(125),
    cargo VARCHAR(125)
);
```

## CRIAÇÃO DA TABELA DEPENDENTE

```SQL
CREATE TABLE tb_dependente(
    id_dependente INT PRIMARY KEY AUTO_INCREMENT,
    dependente VARCHAR(125)
);
```

## COMANDOS PARA AUXÍLIO

```SQL
SHOW TABLES;
DESC tb_funcionario;
DESC tb_dependente;
```

## ALIMENTANDO AS TABELAS

```SQL
INSERT INTO tb_funcionario VALUES
(1, 'João Pedro', 'Analista'),
(2, 'Joana Silva', 'Analista');

INSERT INTO tb_dependente VALUES
(1, 'Pedrinho'),
(2, 'Pedrinha');
```
## VERIFICANDO AS TABELAS PREENCHIDAS

```SQL
SELECT * FROM tb_funcionario;
SELECT * FROM tb_dependente;
```


[Página Inicial](../aula25/)
