-- CRIAÇÃO E SELEÇÃO DO BANCO DE DADOS
CREATE DATABASE IF NOT EXISTS db_lojinha;
USE db_lojinha;

-- CRIAÇÃO DA TABELA CLIENTE
CREATE TABLE IF NOT EXISTS tb_cliente(
	id_cliente INT PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(100),
    email VARCHAR(100),
    telefone VARCHAR(100),
    cidade VARCHAR(100)
);

CREATE TABLE IF NOT EXISTS tb_venda(
	id_venda INT PRIMARY KEY AUTO_INCREMENT,
    produto VARCHAR(100),
    valor DECIMAL(10,2),
    data_venda DATETIME,
    id_cliente INT,
    FOREIGN KEY (id_cliente) REFERENCES tb_cliente (id_cliente)
);

-- CADASTRO DE CLIENTES
INSERT INTO tb_cliente (nome, email, telefone, cidade) VALUES
('Pedro Neves', 'pedro.neves@email.com', '84567654323', 'Taguatinga'),
('João Silva', 'joao.silva@email.com', '11987654321', 'Gama'),
('Maria Oliveira', 'maria.oliveira@email.com', '1134556677', 'Ceilândia'),
('Carlos Pereira', 'carlos.pereira@email.com', '11911223344', 'Taguatinga'),
('Ana Souza', 'ana.souza@email.com', '1177889900', 'Taguatinga'),
('Luiz Santos', 'luiz.santos@email.com', '11922334455', 'Taguatinga'),
('Patrícia Costa', 'patricia.costa@email.com', '1144556677', 'Gama'),
('Roberto Lima', 'roberto.lima@email.com', '11999887766', 'Gama'),
('Fernanda Alves', 'fernanda.alves@email.com', '1133445566', 'Gama'),
('Eduardo Martins', 'eduardo.martins@email.com', '11986543210', 'Ceilândia'),
('Isabela Gomes', 'isabela.gomes@email.com', '1166778899', 'Ceilândia');

-- CADASTRO DE VENDAS
INSERT INTO tb_venda(id_cliente, produto, valor, data_venda) VALUES
(null, 'Telado sem Fio', 250.00, null),
(1, 'Notebook', 2500.00, '2024-12-01 10:30:00'),
(2, 'Smartphone', 1500.00, '2024-11-02 15:00:00'),
(3, 'Cadeira Ergonômica', 800.00, '2024-03-05 09:30:00'),
(4, 'Mouse Óptico', 100.00, '2024-10-10 14:15:00'),
(5, 'Teclado Mecânico', 350.00, '2024-03-12 18:45:00'),
(6, 'Fone de Ouvido Bluetooth', 200.00, '2024-12-15 11:00:00'),
(7, 'Câmera DSLR', 4500.00, '2024-11-16 16:30:00'),
(8, 'Impressora Laser', 1200.00, '2024-10-18 10:00:00'),
(9, 'Monitor 27" LED', 1800.00, '2024-03-20 12:45:00'),
(1, 'Mouse Óptico', 100.00, '2024-10-10 14:15:00'),
(3, 'Teclado Mecânico', 350.00, '2024-03-12 18:45:00'),
(9, 'Fone de Ouvido Bluetooth', 200.00, '2024-12-15 11:00:00'),
(10, 'Gabinete para PC', 300.00, '2024-11-22 17:00:00');

-- 1. Listar todos os produtos vendidos com o nome do cliente.
SELECT v.produto, c.nome FROM tb_venda AS v
INNER JOIN tb_cliente AS c ON v.id_cliente = c.id_cliente;

-- 2. Listar todos os clientes que compraram um produto cujo valor seja superior a 1000 reais.
SELECT c.nome, v.produto, v.valor FROM tb_venda AS v
INNER JOIN  tb_cliente as c ON v.id_cliente = c.id_cliente
WHERE v.valor > '1000'
ORDER BY v.valor;

-- 3. Exibir todos os clientes que fizeram compras, incluindo os que não realizaram nenhuma compra.
SELECT c.nome, v.produto FROM tb_cliente as c
LEFT JOIN tb_venda as v ON c.id_cliente = v.id_cliente;

-- 4. Exibir todos os produtos vendidos, incluindo aqueles que não têm cliente associado.
SELECT v.produto, c.nome FROM tb_cliente AS c
RIGHT JOIN tb_venda AS v ON v.id_cliente = c.id_cliente;

-- 5. Listar todas as vendas realizadas em novembro de 2024 realizadas depois das 16h e quem comprou.
SELECT c.nome, v.id_venda, v.data_venda FROM tb_venda AS v
INNER JOIN tb_cliente AS c ON v.id_cliente = c.id_cliente
WHERE MONTHNAME(v.data_venda) = 'november' AND TIME(v.data_venda) > '16:00';
select * from tb_venda;
-- 6. Exibir os clientes que possuem o nome "Silva" e que tenha gastado mais de 1000 reais.
SELECT c.nome, v.valor FROM tb_cliente AS c
INNER JOIN tb_venda AS v ON c.id_cliente = v.id_cliente
WHERE c.nome LIKE '%Silva%' AND v.valor > '1000';

-- 7. Exibir a quantidade de vendas realizadas por cada cliente.
SELECT c.nome, COUNT(v.id_venda) `Total de vendas por cliente` FROM tb_cliente AS c
INNER JOIN tb_venda AS v ON c.id_cliente = v.id_cliente
GROUP BY c.nome
ORDER BY c.nome;

-- 8. Calcular o total gasto por cada cliente.
SELECT c.nome, SUM(v.valor) `Total gasto por cliente` FROM tb_cliente AS c
INNER JOIN tb_venda AS v ON c.id_cliente = v.id_cliente
GROUP BY c.nome
ORDER BY c.nome;

-- 9. Exibir clientes que gastaram mais de 1500 reais no ano de 2024.
SELECT c.nome, SUM(v.valor) AS `Total de vendas por cliente`, v.data_venda FROM tb_cliente AS c
INNER JOIN tb_venda AS v ON c.id_cliente = v.id_cliente
GROUP BY c.nome
HAVING YEAR(v.data_venda) = '2024' AND SUM(v.valor) > '1500';

SELECT c.nome, SUM(v.valor) AS `Total de vendas por cliente`, GROUP_CONCAT(date_format(v.data_venda, ' %d de %M de %Y')) AS `Data da venda` FROM tb_cliente AS c
INNER JOIN tb_venda AS v ON c.id_cliente = v.id_cliente
WHERE YEAR(v.data_venda)= '2024'
GROUP BY c.nome
HAVING  SUM(v.valor) > '1500';
