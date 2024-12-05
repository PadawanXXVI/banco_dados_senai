# CASE ... WHEN

## ESTRUTURA

```SQL
SELECT coluna1, coluna2
    CASE
        WHEN condicao_1 THEN valor_1
        WHEN condicao_2 THEN valor_2
        WHEN condicao_3 THEN valor_3
        ELSE valor_4
    END AS nome_nova_coluna
FROM tabela;
```

## CRIAÇÃO E SELEÇÃO PARA USO DO BANCO DE DADOS

```SQL 
CREATE DATABASE db_case;
USE db_case;
```

## CRIAÇÃO DA TABELA USUÁRIO

```SQL
CREATE TABLE tb_usuario(
    id_usuario INT PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(100) NOT NULL,
    data_nascimento DATE NOT NULL,
    email VARCHAR(150),
    telefone VARCHAR(20),
    endereco VARCHAR(255),
    data_cadastro DATE NOT NULL,
    situacao ENUM('Ativo', 'Inativo', 'Suspenso') DEFAULT 'Ativo'
);
```

## CADASTRO DE USUÁRIOS

```SQL
INSERT INTO tb_usuario 
    (nome,data_nascimento, email, telefone, endereco, data_cadastro, situacao)
VALUES
    ('João da Silva', '2009-01-15', 'joao.silva@gmail.com', '61999998888', 'Rua A, 123, Brasília-DF', '2024-11-20', 'ativo'),
    ('Maria Oliveira', '1985-05-23', NULL, '61988887777', 'Rua B, 456, Asa Sul, Brasília-DF', '2024-10-15', 'ativo'),
    ('Carlos Santos', '1992-07-10', 'carlos.santos@gmail.com', NULL, 'Rua C, 789, Taguatinga-DF', '2020-09-01', 'inativo'),
    ('Ana Costa', '2006-12-20', NULL, NULL, NULL, '2024-08-25', 'suspenso'),
    ('José Lima', '1955-03-05', 'jose.lima@gmail.com', '61955554444', 'Rua E, 654, Gama-DF', '2015-12-01', 'ativo'),
    ('Paula Almeida', '1999-09-12', NULL, '61944443333', NULL, '2024-11-15', 'ativo'),
    ('Felipe Rocha', '1970-11-30', 'felipe.rocha@gmail.com', NULL, 'Rua G, 135, Samambaia-DF', '2024-11-05', 'inativo'),
    ('Clara Mendes', '2005-06-18', 'clara.mendes@gmail.com', '61922221111', NULL, '2024-10-30', 'ativo'),
    ('Renato Barros', '1995-02-25', NULL, NULL, 'Rua I, 357, Planaltina-DF', '2018-09-12', 'suspenso'),
    ('Juliana Araujo', '1965-04-08', 'juliana.araujo@gmail.com', NULL, NULL, '2024-08-22', 'ativo'),
    ('Lucas Martins', '1996-10-15', 'lucas.martins@gmail.com', '61888887777', 'Rua K, 579, Recanto das Emas-DF', '2024-07-19', 'ativo'),
    ('Vanessa Ribeiro', '1990-11-01', NULL, '61877776666', 'Rua L, 680, Núcleo Bandeirante-DF', '2024-06-14', 'inativo'),
    ('Ricardo Souza', '1982-12-24', 'ricardo.souza@gmail.com', NULL, 'Rua M, 791, Cruzeiro-DF', '2020-05-30', 'ativo'),
    ('Mariana Dias', '2004-03-16', 'mariana.dias@gmail.com', '61855554444', NULL, '2021-04-25', 'ativo'),
    ('Gustavo Torres', '1975-07-28', NULL, '61844443333', 'Rua O, 913, Lago Sul-DF', '2021-03-10', 'suspenso'),
    ('Rafael Ferreira', '1998-01-03', NULL, NULL, NULL, '2019-02-15', 'ativo'),
    ('Carolina Moreira', '1993-08-19', 'carolina.moreira@gmail.com', '61822221111', 'Rua Q, 235, Jardim Botânico-DF', '2024-01-12', 'ativo'),
    ('Daniel Pereira', '1950-05-07', NULL, '61811110000', NULL, '2013-12-20', 'ativo'),
    ('Luana Farias', '2002-12-25', 'luana.farias@gmail.com', NULL, 'Rua S, 457, Vicente Pires-DF', '2021-11-15', 'ativo'),
    ('Pedro Gomes', '1989-09-14', 'pedro.gomes@gmail.com', '61899997777', NULL, '2023-10-22', 'inativo');
```

## VERIFICAR OS USUÁRIOS CADASTRADOS

```SQL
SELECT * FROM tb_usuario;
```

## Exemplo 1

```SQL
SELECT nome, situacao,
    CASE
        WHEN situcao = 'Ativo' THEN 'Usuário ativo'
        WHEN situcao = 'Inativo' THEN 'Usuário inativo'
        WHEN situacao = 'Suspenso' THEN 'Usuário suspenso'
        ELSE 'Status desconhecido'
    END AS Situacao
FROM tb_usuario;
```

## Exemplo 2

```SQL
SELECT nome, data_nascimento, timestampdiff(YEAR, data_nascimento, curdate()) AS idade,
    CASE
        WHEN timestampdiff(YEAR, data_nascimento, curdate()) < 18 THEN 'Jovem'
        WHEN timestampdiff(YEAR, data_nascimento, curdate()) BETWEEN 18 AND 59 THEN 'Adulto'
        ELSE 'Idoso'
    END AS categoria_idade
FROM tb_usuario;
```

## Exemplo 3

- Se o funcionário tiver menos de 1 ano de experiência retorne 'Recente'
- Entre 1 e 4 anos é um funcionário 'Exeperiente'
- Maior que 4 anos é um 'Veterano'

```SQL
SELECT nome, data_cadastro, timestampdiff(YEAR, data_cadastro, curdate()) AS 'Anos Serviço',
    CASE
        WHEN timestampdiff(YEAR, data_cadastro, curdate()) < 1 THEN 'Recente'
        WHEN timestampidff(YEAR, data_cadastro, curdate()) BETWEEN 1 AND 4 THEN 'Experiente'
        ELSE 'Veterano(a)'
    END AS 'Categoria Tempo Empresa'
FROM tb_usuario;
```

[Página Inicial](../README.md)