/*
PROJETO FINAL
Banco de Dados de um Restaurante apresentado ao Curso de Administrador de Banco de Dados
do Senai SIG-DF sob orientação do Professor Yor Rio Pardo Felix
*/

-- Criação do Banco de Dados
CREATE DATABASE IF NOT EXISTS db_restaurante;
USE db_restaurante;

-- Tabela de Clientes
CREATE TABLE tb_clientes (
    id_cliente INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(255) NOT NULL,
    tipo_cliente ENUM('Física', 'Jurídica') NOT NULL,
    documento VARCHAR(14) UNIQUE NOT NULL,
    email VARCHAR(255) NOT NULL,
    CHECK (
        (tipo_cliente = 'Física' AND LENGTH(documento) = 11) OR
        (tipo_cliente = 'Jurídica' AND LENGTH(documento) = 14)
    )
);

-- Tabela de Funcionários
CREATE TABLE tb_funcionarios (
    id_funcionario INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(255) NOT NULL,
    cargo VARCHAR(255) NOT NULL,
    salario DECIMAL(10,2) NOT NULL
);

-- Tabela de Endereços dos Funcionários
CREATE TABLE tb_endereco_funcionario (
    id_endereco INT AUTO_INCREMENT PRIMARY KEY,
    id_funcionario INT,
    logradouro VARCHAR(255) NOT NULL,
    numero VARCHAR(10) NOT NULL,
    complemento VARCHAR(255),
    bairro VARCHAR(255) NOT NULL,
    cidade VARCHAR(255) NOT NULL,
    estado VARCHAR(2) NOT NULL,
    cep VARCHAR(8) NOT NULL,
    FOREIGN KEY (id_funcionario) REFERENCES tb_funcionarios(id_funcionario)
);

-- Tabela de Formas de Pagamento
CREATE TABLE tb_formas_pagamento (
    id_forma_pagamento INT AUTO_INCREMENT PRIMARY KEY,
    descricao VARCHAR(255) NOT NULL
);

-- Tabela de Mesas
CREATE TABLE tb_mesas (
    id_mesa INT AUTO_INCREMENT PRIMARY KEY,
    capacidade INT NOT NULL,
    localizacao VARCHAR(255) NOT NULL
);

-- Tabela de Pedidos
CREATE TABLE tb_pedidos (
    id_pedido INT AUTO_INCREMENT PRIMARY KEY,
    id_cliente INT,
    id_mesa INT,
    data_pedido DATE NOT NULL,
    status VARCHAR(50) NOT NULL,
    id_funcionario INT,
    FOREIGN KEY (id_cliente) REFERENCES tb_clientes(id_cliente),
    FOREIGN KEY (id_mesa) REFERENCES tb_mesas(id_mesa),
    FOREIGN KEY (id_funcionario) REFERENCES tb_funcionarios(id_funcionario)
);

-- Tabela de Pagamentos
CREATE TABLE tb_pagamentos (
    id_pagamento INT AUTO_INCREMENT PRIMARY KEY,
    valor DECIMAL(10,2) NOT NULL,
    data_pagamento DATE NOT NULL
);

-- Tabela de Menu
CREATE TABLE tb_menu (
    id_item INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(255) NOT NULL,
    descricao VARCHAR(255) NOT NULL,
    preco DECIMAL(10,2) NOT NULL
);

-- Tabela de Detalhes dos Pedidos
CREATE TABLE tb_detalhes_pedido (
    id_detalhe_pedido INT AUTO_INCREMENT PRIMARY KEY,
    id_pedido INT,
    id_item INT,
    quantidade INT NOT NULL,
    preco_unitario DECIMAL(10,2) NOT NULL,
    FOREIGN KEY (id_pedido) REFERENCES tb_pedidos(id_pedido),
    FOREIGN KEY (id_item) REFERENCES tb_menu(id_item)
);

-- Tabela Cliente Formas de Pagamento
CREATE TABLE tb_cliente_forma_pgto (
    id_cliente INT,
    id_forma_pagamento INT,
    PRIMARY KEY (id_cliente, id_forma_pagamento),
    FOREIGN KEY (id_cliente) REFERENCES tb_clientes(id_cliente),
    FOREIGN KEY (id_forma_pagamento) REFERENCES tb_formas_pagamento(id_forma_pagamento)
);

-- Tabela Funcionario Pedido
CREATE TABLE tb_funcionario_pedido (
    id_funcionario INT,
    id_pedido INT,
    PRIMARY KEY (id_funcionario, id_pedido),
    FOREIGN KEY (id_funcionario) REFERENCES tb_funcionarios(id_funcionario),
    FOREIGN KEY (id_pedido) REFERENCES tb_pedidos(id_pedido)
);

-- Tabela Pagamento Formas de Pagamento
CREATE TABLE tb_pagamento_forma_pgto (
    id_pagamento INT,
    id_forma_pagamento INT,
    PRIMARY KEY (id_pagamento, id_forma_pagamento),
    FOREIGN KEY (id_pagamento) REFERENCES tb_pagamentos(id_pagamento),
    FOREIGN KEY (id_forma_pagamento) REFERENCES tb_formas_pagamento(id_forma_pagamento)
);

-- Tabela Menu Detalhes
CREATE TABLE tb_menu_detalhes (
    id_item INT,
    id_detalhe_pedido INT,
    PRIMARY KEY (id_item, id_detalhe_pedido),
    FOREIGN KEY (id_item) REFERENCES tb_menu(id_item),
    FOREIGN KEY (id_detalhe_pedido) REFERENCES tb_detalhes_pedido(id_detalhe_pedido)
);

-- CONSULTAS
-- View para listar todos os clientes
CREATE VIEW vw_lista_clientes AS
SELECT id_cliente, nome, tipo_cliente, documento, email
FROM tb_clientes;

-- View para listar todos os pedidos com detalhes dos clientes, funcionários e mesas:
CREATE VIEW vw_detalhes_pedidos AS
SELECT p.id_pedido, c.nome AS nome_cliente, f.nome AS nome_funcionario, m.localizacao AS mesa, p.data_pedido, p.status
FROM tb_pedidos p
JOIN tb_clientes c ON p.id_cliente = c.id_cliente
JOIN tb_funcionarios f ON p.id_funcionario = f.id_funcionario
JOIN tb_mesas m ON p.id_mesa = m.id_mesa;

-- View para listar todos os funcionários com seus endereços:
CREATE VIEW vw_funcionarios_enderecos AS
SELECT f.id_funcionario, f.nome, f.cargo, e.logradouro, e.numero, e.complemento, e.bairro, e.cidade, e.estado, e.cep
FROM tb_funcionarios f
JOIN tb_endereco_funcionario e ON f.id_funcionario = e.id_funcionario;

-- View para listar todas as formas de pagamento utilizadas em pedidos:
CREATE VIEW vw_formas_pagamento_pedidos AS
SELECT p.id_pedido, c.nome AS nome_cliente, f.descricao AS forma_pagamento
FROM tb_pedidos p
JOIN tb_cliente_forma_pgto cpf ON p.id_cliente = cpf.id_cliente
JOIN tb_formas_pagamento f ON cpf.id_forma_pagamento = f.id_forma_pagamento;

-- Procedimento para inserir um novo pedido:
DELIMITER $$
CREATE PROCEDURE sp_inserir_pedido(
    IN id_cliente_pedido INT,
    IN id_mesa_pedido INT,
    IN data_pedido_pedido DATE,
    IN status_pedido VARCHAR(50),
    IN id_funcionario_pedido INT
)
BEGIN
    INSERT INTO tb_pedidos (id_cliente, id_mesa, data_pedido, status, id_funcionario)
    VALUES (id_cliente_pedido, id_mesa_pedido, data_pedido_pedido, status_pedido, id_funcionario_pedido);
END $$
DELIMITER ;

-- Procedimento para atualizar o status de um pedido:
DELIMITER $$
CREATE PROCEDURE sp_atualizar_status_pedido(
    IN id_pedido_atualizar INT,
    IN novo_status VARCHAR(50)
)
BEGIN
    UPDATE tb_pedidos
    SET status = novo_status
    WHERE id_pedido = id_pedido_atualizar;
END $$
DELIMITER ;

-- Procedimento para listar todos os pedidos de um cliente:
DELIMITER $$
CREATE PROCEDURE sp_listar_pedidos_cliente(
    IN id_cliente_consulta INT
)
BEGIN
    SELECT p.id_pedido, p.data_pedido, p.status, m.localizacao AS mesa
    FROM tb_pedidos p
    JOIN tb_mesas m ON p.id_mesa = m.id_mesa
    WHERE p.id_cliente = id_cliente_consulta;
END $$
DELIMITER ;

-- Procedimento para inserir um novo cliente:
DELIMITER //
CREATE PROCEDURE sp_inserir_cliente(
    IN nome_cliente VARCHAR(255),
    IN tipo_cliente ENUM('Física', 'Jurídica'),
    IN documento_cliente VARCHAR(14),
    IN email_cliente VARCHAR(255)
)
BEGIN
    INSERT INTO tb_clientes (nome, tipo_cliente, documento, email)
    VALUES (nome_cliente, tipo_cliente, documento_cliente, email_cliente);
END //
DELIMITER ;

-- Procedimento para atualizar o status de um pedido:
DELIMITER //
CREATE PROCEDURE sp_atualizar_status_pedido(
    IN id_pedido_atualizar INT,
    IN novo_status VARCHAR(50)
)
BEGIN
    UPDATE tb_pedidos
    SET status = novo_status
    WHERE id_pedido = id_pedido_atualizar;
END //
DELIMITER ;

-- Procedimento para excluir um cliente:
DELIMITER //
CREATE PROCEDURE sp_excluir_cliente(
    IN id_cliente_excluir INT
)
BEGIN
    DELETE FROM tb_clientes
    WHERE id_cliente = id_cliente_excluir;
END //
DELIMITER ;

-- Função para calcular o valor total de um pedido:
DELIMITER $$
CREATE FUNCTION fn_valor_total_pedido(id_pedido_consulta INT)
RETURNS DECIMAL(10,2)
BEGIN
    DECLARE total_valor DECIMAL(10,2);
    SELECT SUM(dp.quantidade * dp.preco_unitario) INTO total_valor
    FROM tb_detalhes_pedido dp
    WHERE dp.id_pedido = id_pedido_consulta;
    RETURN total_valor;
END $$
DELIMITER ;

-- Função para calcular a quantidade de pedidos por funcionário:
DELIMITER $$
CREATE FUNCTION fn_pedidos_por_funcionario(id_funcionario_consulta INT)
RETURNS INT
BEGIN
    DECLARE total_pedidos INT;
    SELECT COUNT(*) INTO total_pedidos
    FROM tb_pedidos
    WHERE id_funcionario = id_funcionario_consulta;
    RETURN total_pedidos;
END $$
DELIMITER ;

-- Função para calcular a quantidade de pedidos por funcionário:
DELIMITER $$
CREATE FUNCTION fn_pedidos_por_funcionario(id_funcionario_consulta INT)
RETURNS INT
BEGIN
    DECLARE total_pedidos INT;
    SELECT COUNT(*) INTO total_pedidos
    FROM tb_pedidos
    WHERE id_funcionario = id_funcionario_consulta;
    RETURN total_pedidos;
END $$
DELIMITER ;

-- Função para calcular a média de pedidos por cliente:
DELIMITER //
CREATE FUNCTION fn_media_pedidos_cliente()
RETURNS DECIMAL(10,2)
BEGIN
    DECLARE media_pedidos DECIMAL(10,2);
    SELECT AVG(total_pedidos) INTO media_pedidos
    FROM (SELECT COUNT(*) AS total_pedidos
          FROM tb_pedidos
          GROUP BY id_cliente) AS subquery;
    RETURN media_pedidos;
END //
DELIMITER ;

-- Função para calcular o total de vendas de um período:
DELIMITER //
CREATE FUNCTION fn_total_vendas_periodo(inicio DATE, fim DATE)
RETURNS DECIMAL(10,2)
BEGIN
    DECLARE total_vendas DECIMAL(10,2);
    SELECT SUM(valor) INTO total_vendas
    FROM tb_pagamentos
    WHERE data_pagamento BETWEEN inicio AND fim;
    RETURN total_vendas;
END //
DELIMITER ;

-- Função para verificar se um cliente já possui um determinado documento:
DELIMITER //
CREATE FUNCTION fn_verificar_documento(documento VARCHAR(14))
RETURNS BOOLEAN
BEGIN
    DECLARE existe BOOLEAN;
    SELECT COUNT(*) INTO existe
    FROM tb_clientes
    WHERE documento = documento;
    RETURN existe > 0;
END //
DELIMITER ;


-- Função para calcular a quantidade de pedidos por funcionário:
DELIMITER //
CREATE FUNCTION fn_pedidos_por_funcionario(id_funcionario_consulta INT)
RETURNS INT
BEGIN
    DECLARE total_pedidos INT;
    SELECT COUNT(*) INTO total_pedidos
    FROM tb_pedidos
    WHERE id_funcionario = id_funcionario_consulta;
    RETURN total_pedidos;
END //
DELIMITER ;

-- Função para listar o nome do cliente baseado no ID:
DELIMITER //
CREATE FUNCTION fn_nome_cliente(id_cliente_consulta INT)
RETURNS VARCHAR(255)
BEGIN
    DECLARE nome_cliente VARCHAR(255);
    SELECT nome INTO nome_cliente
    FROM tb_clientes
    WHERE id_cliente = id_cliente_consulta;
    RETURN nome_cliente;
END //
DELIMITER ;

-- Função para calcular o valor total de um pedido:
DELIMITER //
CREATE FUNCTION fn_valor_total_pedido(id_pedido_consulta INT)
RETURNS DECIMAL(10,2)
BEGIN
    DECLARE total_valor DECIMAL(10,2);
    SELECT SUM(dp.quantidade * dp.preco_unitario) INTO total_valor
    FROM tb_detalhes_pedido dp
    WHERE dp.id_pedido = id_pedido_consulta;
    RETURN total_valor;
END //
DELIMITER ;

-- Função para retornar a descrição de uma forma de pagamento baseada no ID:
DELIMITER //
CREATE FUNCTION fn_descricao_forma_pagamento(id_forma_pagamento_consulta INT)
RETURNS VARCHAR(255)
BEGIN
    DECLARE descricao VARCHAR(255);
    SELECT descricao INTO descricao
    FROM tb_formas_pagamento
    WHERE id_forma_pagamento = id_forma_pagamento_consulta;
    RETURN descricao;
END //
DELIMITER ;
