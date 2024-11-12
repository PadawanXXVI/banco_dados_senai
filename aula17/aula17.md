# COMANDOS UPDATE, DELETE E TRUNCATE

Gerenciando linhas (UPDATE, DELETE e TRUNCATE)

## Criar o banco de dados

```SQL
CREATE DATABASE db_funcionario;
```

## Selecionar o banco de dados

```SQL
USE db_funcionario
```

## Criar tabela funcionário

```SQL
CREATE TABLE tb_funcionario(
    id_funcionario INT PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(50),
    cargo VARCHAR(30),
    salario DECIMAL(10,2),
    departamento VARCHAR(30)
);
```

# Inserir os registros na tabela

```SQL
INSERT INTO tb_funcionario (id_funcionario, nome, cargo, salario, departamento) VALUES
('1', 'Carlos Silva', 'Analista', '3000.00', 'TI'),
('2', 'Maria Oliveira', 'Gerente', '6000.00', 'Vendas'),
('3', 'João Souza', 'Assistente', '2500.00', 'RH'),
('4', 'Ana Paula', 'Desenvolvedora', '4000.00', 'TI'),
('5', 'Roberto Nunes', 'Analista', '3500.00', 'Financeiro'),
('6', 'Luiza Mendes', 'Supervisora', '4500.00', 'Vendas'),
('7', 'Fernando Lima', 'Desenvolvedor', '3800.00', 'TI'),
('8', 'Patrícia Santos', 'Assistente', '2700.00', 'RH'),
('9', 'Gustavo Moreira', 'Analista', '3200.00', 'Financeiro'),
('10', 'Beatriz Ramos', 'Coordenadora', '5000.00', 'Marketing');
```

## Visualizar a tabela com os dados inseridos

```SQL
SELECT * FROM tb_funcionario;
```

## Alterar o dado de uma coluna específica

```SQL
UPDATE tb_funcionario
SET salario ='5000.00'
WHERE id_funcionario ='1';
```

## Alterar os dados de duas colunas

```SQL
UPDATE tb_funcionario
SET nome = 'Luiza Nunes', departamento = 'Financeiro'
WHERE id_funcionario = '6'
```

## Alterar os dados de uma coluna que possuem um campo comum, no caso departamento TI, usa a coluna no WHERE

```SQL
UPDATE tb_funcionario
SET salario = '2000'
WHERE departamento = 'TI';
```

### Observações:

- UPDATE - atualize
- SET - configure
- WHERE - onde

## Apagar todos os registros vinculados a uma entrada em comum, no exemplo, ao dado da coluna departamento onde há TI

```SQL
DELETE FROM tb_funcionario
WHERE departamento = 'TI';
```

## Apagar um regsitro específico

```SQL
DELETE FROM tb_funcionario
WHERE id_funcionario = '9';
```

## Apagar todos os registros

```SQL
TRUNCATE TABLE tb_funcionario;
