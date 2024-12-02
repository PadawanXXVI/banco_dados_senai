/*
Aula 09 - Funções de data
*/

-- CRIAÇÃO E SELEÇÃO PARA USO DO BANCO DE DADOS
CREATE DATABASE IF NOT EXISTS db_data;
USE db_data;

-- CRIAÇÃO DA TABELA VENDA
CREATE TABLE IF NOT EXISTS tb_venda(
	id_venda INT PRIMARY KEY AUTO_INCREMENT,
    produto VARCHAR(100),
    valor DECIMAL(10,2),
    data_venda DATETIME
);

-- CADASTRO DE VENDAS
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

-- VISUALIZAÇÃO DOS DADOS INSERIDOS
SELECT * FROM tb_venda;

-- RETORNAR A DATA ATUAL
SELECT CURDATE() AS `Data atual`;

-- Retonrar a data e hora atuais
SELECT NOW();

-- ADCIONAR OU SUBTRAIR INTERVALO DE TEMPO
SELECT DATE_ADD('2024-12-02', INTERVAL 23 DAY);
SELECT DATE_SUB('2024-12-02', INTERVAL 1 MONTH);
SELECT DATE_SUB('2024-12-02', INTERVAL 1 YEAR);

-- CALCULAR A DIFERENÇA ENTRE DUAS DATAS
SELECT produto, datediff(CURDATE(), data_venda) AS `Dias desde a venda` FROM tb_venda; -- data de hoje menos a data da venda, curdate não considera a hora.

-- RETORNAR APENAS O ANO
SELECT produto, YEAR(data_venda) AS `Ano da venda` FROM tb_venda;

-- RETORNAR APENAS O MÊS
SELECT produto, (MONTH(data_venda)) AS `Mês de venda` FROM tb_venda;

-- RETORNAR APENAS O DIA
SELECT produto, DAY(data_venda) AS `Dia da venda` FROM tb_venda;

-- RETORNAR DIA, MÊS E ANO EM COLUNAS SEPARADAS
SELECT produto, DAY(data_venda), MONTH(data_venda), YEAR(data_venda) FROM tb_venda;

-- RETORNAR O NOME DO MÊS
SELECT produto, MONTHNAME(data_venda) FROM tb_venda;

-- ALTERAR PARA O PADRÃO pt-BR
SET lc_time_names = 'pt_BR'; -- altera as configurações para o padrão brasileiro ('en_US' - para voltar para o padrão inglês)

-- VERIFICAR O IDIOMA
SHOW VARIABLES LIKE 'lc_time_names';

-- RETORNAR O DIA DA SEMANA POR EXTENSO
SELECT produto, DAYNAME(data_venda) FROM tb_venda;

-- FORMATAR A DATA
SELECT produto, DATE_FORMAT(data_venda, '%d/%m/%y') FROM tb_venda; -- y minúsculo retorna o ano com 2 dígitos, Y maiúsculo retorna com 4 dígitos
SELECT produto, DATE_FORMAT(data_venda, '%d de %M/%y') FROM tb_venda; -- m minúsculo retorna o mês em número, M maiúsculo retorna o nome do mês
SELECT produto, DATE_FORMAT(data_venda, '%W, %d/%m/%y') FROM tb_venda; -- w retorna o dia da semana, se não houver sábados e domingos poderia ser usado %w-feira, para trazer os dias com a palavra feira
-- W maiúsculo retorna por extenso, w minúsculo retorna o número do dia da semana.

-- VENDAS QUE OCORRERAM EM NOVEMBRO
SELECT produto, DATE_FORMAT(data_venda, '%M') AS `Vendas de novembro` FROM tb_venda
WHERE MONTH(data_venda) = '11';
-- OU
SELECT produto, DATE_FORMAT(data_venda, '%M') AS `Vendas do Mês` FROM tb_venda
WHERE MONTHNAME(data_venda) = 'novembro';