-- CRIAÇÃO
CREATE DATABASE IF NOT EXISTS db_pedido;
USE db_pedido;

-- CRIAÇÃO DA TABELA CLIENTE
CREATE TABLE IF NOT EXISTS tb_cliente(
	id_cliente INT PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(100),
    sexo ENUM('F', 'M'),
    data_nascimento DATE,
    email VARCHAR(100),
    cidade VARCHAR(100)
);

-- CRIAÇÃO DA TABELA PEDIDO
CREATE TABLE IF NOT EXISTS tb_pedido(
	id_pedido INT PRIMARY KEY AUTO_INCREMENT,
    data_pedido DATE,
    valor DECIMAL(10,2),
    status_pedido ENUM('Pendente', 'Cancelado', 'Finalizado'),
    id_cliente INT,
    FOREIGN KEY (id_cliente) REFERENCES tb_cliente (id_cliente)
);

-- Dados para a tabela clientes
INSERT INTO tb_cliente (nome, sexo, data_nascimento, email, cidade) VALUES
('Pedro Vogado', 'M', '2000-07-25', 'pedro@GMAIL.com', 'Gama'),
('João Silva', 'M', '1990-01-15', 'joao@gmail.com', 'Gama'),
('Maria Oliveira', 'F', '1985-07-22', 'maria@gmail.com', 'Ocidental'),
('Carlos Souza', 'M', '1992-03-11', 'carlos@gmail.com', 'Ocidental'),
('Ana Costa', 'F', '1995-12-05', 'ANA@gmail.com', 'Taguatinga'),
('Roberta Lima', 'F', '2000-06-19', 'roberta@gmail.com', 'Samambaia');

-- Dados para a tabela pedidos
INSERT INTO tb_pedido (id_cliente, data_pedido, valor, status_pedido) VALUES
(1, '2024-01-01', 200, 'FINALIZADO'),
(1, '2024-02-15', 150.50, 'PENDENTE'),
(2, '2024-01-20', 300.75, 'FINALIZADO'),
(3, '2023-03-01', 1000, 'CANCELADO'),
(4, '2023-02-10', 400, 'FINALIZADO'),
(5, '2023-01-25', 50, 'PENDENTE'),
(5, '2024-12-02', 2000, 'FINALIZADO');

# 1. Liste todos os pedidos, mostrando o valor formatado como "R$ 1.000,00".
SELECT p.id_pedido, c.nome, CONCAT('R$ ', FORMAT(p.valor,2,'de_DE')) AS `Pedido` FROM tb_pedido AS p
INNER JOIN tb_cliente AS c ON p.id_cliente = c.id_cliente;

# 2. Crie uma view que mostre os clientes e o valor de seus pedidos.
CREATE VIEW vw_pedido AS
SELECT c.nome, concat('R$ ', FORMAT(p.valor,2,'de_DE')), data_pedido AS `Valor do Pedido` FROM tb_cliente AS c
INNER JOIN  tb_pedido AS p ON c.id_cliente = p.id_cliente
ORDER BY c.nome;

SELECT * FROM vw_pedido;

# 3. Liste todos os pedidos com status finalizado realizados por mulheres.
SELECT c.nome, p.data_pedido, p.status_pedido FROM tb_cliente AS c
INNER JOIN tb_pedido AS p ON c.id_cliente = p.id_cliente
WHERE c.sexo = 'f' AND p.status_pedido like 'F%';

# 4. Quantos pedidos cada cliente realizou?
SELECT c.nome, COUNT(p.id_pedido) AS `Total de Pedidos` FROM tb_cliente AS c
INNER JOIN tb_pedido AS p ON c.id_cliente = p.id_cliente
GROUP BY c.nome;

# 5. Liste os clientes que não possuem pedidos registrados.
SELECT c.nome, p.id_pedido FROM tb_cliente AS c
LEFT JOIN tb_pedido AS p ON c.id_cliente = p.id_cliente
WHERE p.id_cliente IS NULL;

# 6. Mostre o total de vendas (apenas pedidos finalizados).
SELECT status_pedido, COUNT(id_pedido) AS `Total de Pedidos` FROM tb_pedido
WHERE status_pedido = 'finalizado';

# 7. Liste os aniversariantes do mês atual.
SELECT nome, CONCAT(DAY(data_nascimento),' de ',  MONTHNAME(data_nascimento)) AS `Aniversariante do mês` FROM tb_cliente
WHERE MONTH (data_nascimento) = MONTH(curdate());

# 8. Crie uma consulta que retorne "Olá Senhora <nome>" baseado no sexo femino.
SELECT CONCAT('Olá Senhora, ', nome,'!') `Saudação` FROM tb_cliente
WHERE sexo = 'F';

# 9. Calcule a idade de cada cliente. Trazer no seguinte formato 'fulano tem 10 anos.'
SELECT CONCAT(nome, ' tem ', timestampdiff(YEAR, data_nascimento, current_date), ' anos.') AS Idade FROM tb_cliente;

# 10. Mostre todos os pedidos realizados nos últimos 30 dias.
SELECT c.nome, p.data_pedido FROM tb_cliente AS c
INNER JOIN tb_pedido AS p ON c.id_cliente = p.id_cliente
WHERE p.data_pedido >= curdate() - INTERVAL 1 MONTH;

# 11. Liste somente o cliente mais velho.
# 12. Exiba todos os emails dos clientes em letras maiusculas.
# 13. Liste o valor médio dos pedidos.
# 14. Exiba todos os pedidos agrupados por status e a quantidade de cada um.
# 15. Qual é o total de pedidos pendentes?
# 16. Mostre o número de clientes por cidade.
# 17. Liste os pedidos realizados por clientes do Gama.
# 18. Crie uma VIEW para exibir clientes com o valor total de pedidos
# 19. Criar uma VIEW para exibir clientes e seus pedidos finalizados com valor acima de 500