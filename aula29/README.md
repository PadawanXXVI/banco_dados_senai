# FUNÇÕES DE DATA

## CRIAÇÃO E SELAÇÃO PARA USO DO BANCO DE DADOS

```SQL
CREATE DATABASE IF NOT EXISTS db_data;
USE db_data
```

## CRIAÇÃO DA TABELA VENDA

```SQL
CREATE TABLE IF NOT EXISTS tb_venda(
    id_venda INT PRIMARY KEY AUTO_INCREMENT,
    produto VARCHAR(100),
    valor DECIMAL(10,2),
    data_venda DATETIME
);
```

## CADASTRO DE VENDAS

```SQL
INSERT INTO tb_venda (produto, valor, data_venda) VALUES
('Notebook', 2500.00, '2024-11-01 10:30:00'),
('Smartphone', 1500.00, '2024-10-02 15:00:00'),
('Cadeira Ergonômica', 800.00, '2024-11-05 09:30:00'),
('Mouse Óptico', 100.00, '2024-09-10 14:15:00'),
('Teclado Mecânico', 350.00, '2023-05-12 18:45:00'),
('Fone de Ouvido Bluetooth', 200.00, '2023-02-15 11:00:00'),
('Câmera DSLR', 4500.00, '2023-11-16 16:30:00'),
('Impressora Laser', 1200.00, '2024-02-18 10:00:00'),
('Monitor 27" LED', 1800.00, '2024-04-20 12:45:00'),
('Gabinete para PC', 300.00, '2024-04-22 17:00:00');
```

## VISUALIZAÇÃO DOS DADOS INSERIDOS

```SQL
SELECT * FROM tb_venda;
```

## RETORNAR A DATA ATUAL

```SQL
SELECT CURDATE() AS `Data Atual`
```

## RETORNAR A DATA E HORA ATUAIS

```SQL
SELECT NOW()
```

## ADICIONAR OU SUBTRAIR INTERVALO DE TEMPO

```SQL
SELECT DATE_ADD('2024-12-02', INTERVAL 23 DAY); -- adiciona 23 dias
SELECT DATE_SUB('2024-12-02', INTERVAL 1 MONTH); -- subtrai 1 mês
SELECT DATE_SUB('2024-12-02', INTERVAL 1 YEAR); -- subtrai 1 ano
```

## CALCULAR A DIFERENÇA ENTRE DUAS DATAS

```SQL
SELECT produto, datediff(CURDATE(), data_venda) AS `Dias desde a venda` FROM tb_venda
```

[Página Inicial](../README.md)
