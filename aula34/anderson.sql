/*
II prova de SQL
*/
DROP DATABASE db_ecommerce2;
-- CRIAÇÃO E SELEÇÃO PARA USO DO BANCO DE DADOS
CREATE DATABASE IF NOT EXISTS db_ecommerce2;
USE db_ecommerce2;

CREATE TABLE tb_endereco_cliente (
    id_end_cliente INT PRIMARY KEY AUTO_INCREMENT,
    logradouto VARCHAR(225),
    numero VARCHAR(20),
    complemento VARCHAR(225),
    bairro  VARCHAR(225),
    cidade VARCHAR(225),
    estado VARCHAR(225),
    cep VARCHAR(10)
);

CREATE TABLE tb_cliente (
    id_cliente INT PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(225),
    email VARCHAR(125),
    telefone VARCHAR(20),
    id_end_cliente INT,
    FOREIGN KEY (id_end_cliente) REFERENCES tb_endereco_cliente (id_end_cliente)
);

CREATE TABLE tb_pedido (
    id_pedido INT PRIMARY KEY AUTO_INCREMENT,
    data DATE,
    descricao TEXT,
    id_cliente INT,
    FOREIGN KEY (id_cliente) REFERENCES tb_cliente(id_cliente)
);


CREATE TABLE tb_produto (
    id_produto INT PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(225),
    descricao TEXT,
    valor DECIMAL(10,2)
);
CREATE TABLE tb_pedido_produto (
    id_pedido_produto INT PRIMARY KEY AUTO_INCREMENT,
    id_pedido INT,
    id_produto INT,
    quantidade INT,
    FOREIGN KEY (id_pedido) REFERENCES tb_pedido(id_pedido),
    FOREIGN KEY (id_produto) REFERENCES tb_produto(id_produto)
);
DESC tb_endereco_cliente;
DESC tb_cliente;
DESC tb_pedido;
DESC tb_pedido_produto;
DESC tb_produto;

INSERT INTO tb_endereco_cliente (logradouto, numero, complemento, bairro, cidade, estado, cep) VALUES
('Rua A', '123', 'Apto 101', 'Centro', 'São Paulo', 'SP', '01000-000'),
('Rua B', '456', '', 'Jardins', 'Rio de Janeiro', 'RJ', '02000-000'),
('Rua C', '789', 'Bloco B', 'Bela Vista', 'Belo Horizonte', 'MG', '03000-000'),
('Rua D', '321', 'Casa', 'Moema', 'São Paulo', 'SP', '04000-000'),
('Rua E', '654', '', 'Ipanema', 'Rio de Janeiro', 'RJ', '05000-000'),
('Rua F', '987', 'Apto 202', 'Savassi', 'Belo Horizonte', 'MG', '06000-000'),
('Rua G', '159', '', 'Barra da Tijuca', 'Rio de Janeiro', 'RJ', '07000-000');

SELECT * FROM tb_endereco_cliente;

INSERT INTO tb_cliente (nome, email, telefone, id_end_cliente) VALUES
('João Silva', 'joao.silva@example.com', '1234567890', 1),
('Maria Souza', 'maria.souza@example.com', '0987654321', 2),
('Carlos Santos', 'carlos.santos@example.com', '1111111111', 3),
('Ana Pereira', 'ana.pereira@example.com', '2222222222', 4),
('Pedro Lima', 'pedro.lima@example.com', '3333333333', 5),
('Paula Dias', 'paula.dias@example.com', '4444444444', 6),
('Ricardo Almeida', 'ricardo.almeida@example.com', '5555555555', 7);

SELECT * FROM tb_cliente;

INSERT INTO tb_pedido (data, descricao, id_cliente) VALUES
('2024-12-01', 'Pedido 1', 1),
('2024-12-02', 'Pedido 2', 2),
('2024-12-03', 'Pedido 3', 3),
('2024-12-04', 'Pedido 4', 4),
('2024-12-05', 'Pedido 5', 5),
('2024-12-06', 'Pedido 6', 6),
('2024-12-07', 'Pedido 7', 7);

SELECT * FROM tb_pedido;

INSERT INTO tb_produto (nome, descricao, valor) VALUES
('Produto A', 'Descrição do produto A', 25.00),
('Produto B', 'Descrição do produto B', 15.00),
('Produto C', 'Descrição do produto C', 30.00),
('Produto D', 'Descrição do produto D', 45.00),
('Produto E', 'Descrição do produto E', 50.00),
('Produto F', 'Descrição do produto F', 60.00),
('Produto G', 'Descrição do produto G', 70.00);

SELECT * FROM tb_produto;

INSERT INTO tb_pedido_produto (id_pedido, id_produto, quantidade) VALUES
(1, 1, 2),  -- 2 unidades do Produto A no Pedido 1
(1, 2, 1),  -- 1 unidade do Produto B no Pedido 1
(2, 3, 3),  -- 3 unidades do Produto C no Pedido 2
(2, 4, 2),  -- 2 unidades do Produto D no Pedido 2
(3, 5, 1),  -- 1 unidade do Produto E no Pedido 3
(3, 6, 4),  -- 4 unidades do Produto F no Pedido 3
(4, 7, 1),  -- 1 unidade do Produto G no Pedido 4
(5, 1, 3),  -- 3 unidades do Produto A no Pedido 5
(5, 2, 2),  -- 2 unidades do Produto B no Pedido 5
(6, 3, 1),  -- 1 unidade do Produto C no Pedido 6
(6, 4, 2),  -- 2 unidades do Produto D no Pedido 6
(7, 5, 2),  -- 2 unidades do Produto E no Pedido 7
(7, 6, 1);  -- 1 unidade do Produto F no Pedido 7

SELECT * FROM tb_produto;

SET lc_time_names = 'pt_BR';

-- Consultas:
-- 01 - Traga o nome de todos os clientes que tenham feito compras no ano de 2024.
SELECT c.nome, p.data FROM tb_cliente AS c
INNER JOIN tb_pedido AS p ON c.id_cliente = p.id_cliente
WHERE YEAR(p.data) = '2024';

-- 02 - Crie uma View que exibe o nome do cliente, data do pedido e quantidade total de itens.
CREATE VIEW vw_pedidos AS
SELECT c.nome, p.data, pp.quantidade FROM tb_cliente AS c
INNER JOIN tb_pedido AS p ON c.id_cliente = p.id_cliente
INNER JOIN tb_pedido_produto AS pp ON p.id_pedido = pp.id_pedido;

SELECT * FROM vw_pedidos;

-- 03 - Mostre o valor total de vendas realizadas no 1º semestre do ano.
SELECT SUM(pp.quantidade * pr.valor) AS valor_total FROM tb_pedido AS p
INNER JOIN tb_pedido_produto AS pp ON p.id_pedido = pp.id_pedido 
INNER JOIN tb_produto AS pr ON pp.id_produto = pr.id_produto
WHERE YEAR(p.data) = 2024 AND MONTH(p.data) BETWEEN 1 AND 6;

-- 04 - Liste os 3 produtos mais vendidos.
SELECT p.nome, SUM(pp.quantidade) AS total_quantidade FROM tb_produto AS p
INNER JOIN tb_pedido_produto AS pp ON p.id_produto = pp.id_produto
GROUP BY p.nome
ORDER BY total_quantidade DESC
LIMIT 3;

-- 05 - Crie uma view para visualizar o nome do cliente, nome do produto e quantidade.
CREATE VIEW vw_cliente_produto_quantidade AS SELECT c.nome AS cliente, pr.nome AS produto, pp.quantidade FROM tb_cliente AS c
INNER JOIN tb_pedido AS p ON c.id_cliente = p.id_cliente
INNER JOIN tb_pedido_produto AS pp ON p.id_pedido = pp.id_pedido
INNER JOIN tb_produto AS pr ON pp.id_produto = pr.id_produto;

SELECT * FROM vw_cliente_produto_quantidade;

-- 06 - Crie uma View para exibir os nomes dos clientes e suas datas de pedido.
CREATE VIEW vw_cliente_data AS
SELECT c.nome, p.data FROM tb_cliente AS c
INNER JOIN tb_pedido AS p ON c.id_cliente = p.id_cliente;

SELECT * FROM vw_cliente_data;

-- 07 - Crie uma View que mostra os nomes de produtos e seus preços maiores que R$50,00.
CREATE VIEW vw_preco AS
SELECT nome, valor FROM tb_produto
WHERE valor > 50;

SELECT * FROM vw_preco;

-- 08 - Crie uma Function que receba o ID de um produto e retorne seu preço e quantidade.
DELIMITER $$
CREATE FUNCTION obter_preco_quantidade(id_produto INT)
RETURNS VARCHAR(255) DETERMINISTIC
BEGIN
    DECLARE resultado VARCHAR(255);
    DECLARE preco DECIMAL(10,2);
    DECLARE quantidade INT;
    
    SELECT pr.valor, SUM(pp.quantidade) INTO preco, quantidade
    FROM tb_produto AS pr
    INNER JOIN tb_pedido_produto AS pp ON pr.id_produto = pp.id_produto
    WHERE pr.id_produto = id_produto
    GROUP BY pr.valor;
    
    SET resultado = CONCAT('Preço: ', preco, ', Quantidade: ', quantidade);
    RETURN resultado;
END $$
DELIMITER ;

-- 09 - Classifique os produtos pela faixa de preço (barato, médio e caro).
SELECT nome, valor, 
CASE 
    WHEN valor < 20 THEN 'Barato'
    WHEN valor BETWEEN 20 AND 50 THEN 'Médio'
    ELSE 'Caro'
END AS faixa_preco
FROM tb_produto;

-- 10- Crie uma Function que retorna a quantidade total de clientes cadastrados.
DELIMITER $$
CREATE FUNCTION total_clientes() 
RETURNS INT DETERMINISTIC
BEGIN
    DECLARE total INT;
    SELECT COUNT(*) INTO total FROM tb_cliente;
    RETURN total;
END $$
DELIMITER ;


-- 11 - Obter os nomes dos clientes que realizaram pedidos em 2024 com o valor maior que 300.
SELECT c.nome, SUM(pp.quantidade*p.valor) AS valor_total FROM tb_cliente AS c
INNER JOIN tb_pedido AS p ON c.id_cliente = p.id_cliente
INNER JOIN tb_pedido_produto AS pp ON p.id_pedido = pp.id_pedido
INNER JOIN tb_produto AS pr ON pr.id_produto = pp.id_produto
WHERE YEAR(p.data) = '2024'
GROUP BY c.nome
HAVING 'valorTotal' > '300';

-- 12 - Listar os nomes dos clientes, os produtos que compraram, a quantidade e o preço total pago por pedido.
SELECT c.nome, pr.nome, pp.quantidade, (pp.quantidade * pr.valor) AS total_pago FROM tb_cliente AS c
INNER JOIN tb_pedido AS p ON c.id_cliente = p.id_cliente
INNER JOIN tb_pedido_produto AS pp ON p.id_pedido = pp.id_pedido
INNER JOIN tb_produto AS pr ON pp.id_produto = pr.id_produto;

-- 13 - O que é uma VIEW?
-- Uma VIEW é uma tabela virtual baseada no resultado de uma consulta SQL. Ela não armazena dados fisicamente, mas sim uma consulta que pode ser executada sempre que a VIEW é acessada.

-- 14 - O que é uma FUNCTION?
-- Uma FUNCTION no MySQL é um bloco de código que pode receber parâmetros, executar uma sequência de instruções e retornar um valor.

-- 15 - O que é uma PROCEDURE?
-- Uma PROCEDURE, ou procedimento armazenado, é semelhante a uma function, mas não necessariamente retorna um valor. É usado para executar uma sequência de instruções SQL.

-- 16 - Diferença de FUNCTION para PROCEDURE
-- A principal diferença é que uma FUNCTION retorna um único valor e pode ser usada em expressões SQL, enquanto uma PROCEDURE pode executar múltiplas operações e não precisa retornar um valor.


-- 17 - Faça mais 10 consultas que você julgar necessário para este cenário.
-- 17.1
SELECT c.nome, e.cidade FROM tb_cliente AS c
INNER JOIN tb_endereco_cliente AS e ON e.id_end_cliente = c.id_end_cliente;

-- 17.2 
SELECT c.nome FROM tb_cliente AS c
WHERE c.id_cliente NOT IN (SELECT p.id_cliente FROM tb_pedido AS p WHERE YEAR(p.data) = 2024);

-- 17.3
SELECT c.nome, COUNT(p.id_pedido) AS total_pedidos FROM tb_cliente AS c
INNER JOIN tb_pedido AS p ON c.id_cliente = p.id_cliente
GROUP BY c.nome;

-- 17.4 
SELECT MAX(valor) FROM tb_produto;

-- 17.5
SELECT MIN(valor) FROM tb_produto;

-- 17.6
SELECT COUNT(id_produto) FROM tb_produto;

-- 17.7 
SELECT DISTINCT(nome) FROM tb_produto;

-- 17.8 
SELECT c.nome, e.estado FROM tb_cliente AS c
INNER JOIN tb_endereco_cliente AS e ON e.id_end_cliente = c.id_end_cliente;

-- 17.9 
SELECT DISTINCT(estado) FROM tb_endereco_cliente;

-- 17.10
SELECT CONCAT(' R$ ', FORMAT(AVG(valor), 2, 'de_DE')) AS `Média de preço` FROM tb_produto;

