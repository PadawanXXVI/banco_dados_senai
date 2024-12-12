/*
PROJETO FINAL
Banco de Dados de um Restaurante apresentado ao Curso de Administrador de Banco de Dados
do Senai SIG-DF sob orientação do Professor Yor Rio Pardo Felix
*/

-- Criação do Banco de Dados
CREATE DATABASE IF NOT EXISTS db_restaurante;
USE db_restaurante;

-- Tabela de Clientes 01/13
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

-- Tabela de Funcionários 02/13
CREATE TABLE tb_funcionarios (
    id_funcionario INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(255) NOT NULL,
    cargo VARCHAR(255) NOT NULL,
    salario DECIMAL(10,2) NOT NULL
);

-- Tabela de Endereços dos Funcionários 03/13
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

-- Tabela de Formas de Pagamento 04/13
CREATE TABLE tb_formas_pagamento (
    id_forma_pagamento INT AUTO_INCREMENT PRIMARY KEY,
    descricao VARCHAR(255) NOT NULL
);

-- Tabela de Mesas 05/13
CREATE TABLE tb_mesas (
    id_mesa INT AUTO_INCREMENT PRIMARY KEY,
    capacidade INT NOT NULL,
    localizacao VARCHAR(255) NOT NULL
);

-- Tabela de Pedidos 06/13
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

-- Tabela de Pagamentos 07/13
CREATE TABLE tb_pagamentos (
    id_pagamento INT AUTO_INCREMENT PRIMARY KEY,
    valor DECIMAL(10,2) NOT NULL,
    data_pagamento DATE NOT NULL,
    id_pedido INT,
    FOREIGN KEY (id_pedido) REFERENCES tb_pedidos (id_pedido)
);

-- Tabela de Menu 08/13
CREATE TABLE tb_menu (
    id_item INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(255) NOT NULL,
    descricao VARCHAR(255) NOT NULL,
    preco DECIMAL(10,2) NOT NULL
);

-- Tabela de Detalhes dos Pedidos 09/13
CREATE TABLE tb_detalhes_pedido (
    id_detalhe_pedido INT AUTO_INCREMENT PRIMARY KEY,
    id_pedido INT,
    id_item INT,
    quantidade INT NOT NULL,
    preco_unitario DECIMAL(10,2) NOT NULL,
    FOREIGN KEY (id_pedido) REFERENCES tb_pedidos(id_pedido),
    FOREIGN KEY (id_item) REFERENCES tb_menu(id_item)
);

-- Tabela Cliente Formas de Pagamento 10/13
CREATE TABLE tb_cliente_forma_pgto (
    id_cliente INT,
    id_forma_pagamento INT,
    PRIMARY KEY (id_cliente, id_forma_pagamento),
    FOREIGN KEY (id_cliente) REFERENCES tb_clientes(id_cliente),
    FOREIGN KEY (id_forma_pagamento) REFERENCES tb_formas_pagamento(id_forma_pagamento)
);

-- Tabela Funcionario Pedido 11/13
CREATE TABLE tb_funcionario_pedido (
    id_funcionario INT,
    id_pedido INT,
    PRIMARY KEY (id_funcionario, id_pedido),
    FOREIGN KEY (id_funcionario) REFERENCES tb_funcionarios(id_funcionario),
    FOREIGN KEY (id_pedido) REFERENCES tb_pedidos(id_pedido)
);

-- Tabela Pagamento Formas de Pagamento 12/13
CREATE TABLE tb_pagamento_forma_pgto (
    id_pagamento INT,
    id_forma_pagamento INT,
    PRIMARY KEY (id_pagamento, id_forma_pagamento),
    FOREIGN KEY (id_pagamento) REFERENCES tb_pagamentos(id_pagamento),
    FOREIGN KEY (id_forma_pagamento) REFERENCES tb_formas_pagamento(id_forma_pagamento)
);

-- Tabela Menu Detalhes 13/13
CREATE TABLE tb_menu_detalhes (
    id_item INT,
    id_detalhe_pedido INT,
    PRIMARY KEY (id_item, id_detalhe_pedido),
    FOREIGN KEY (id_item) REFERENCES tb_menu(id_item),
    FOREIGN KEY (id_detalhe_pedido) REFERENCES tb_detalhes_pedido(id_detalhe_pedido)
);

SHOW TABLES;

-- 	POPULANDO AS TABELAS
-- Registro de clientes 01/13
INSERT INTO tb_clientes (nome, tipo_cliente, documento, email) VALUES
-- Clientes Pessoa Física
('Ana Silva', 'Física', '12345678901', 'ana.silva@example.com'),
('João Souza', 'Física', '23456789012', 'joao.souza@example.com'),
('Carlos Pereira', 'Física', '34567890123', 'carlos.pereira@example.com'),
('Maria Oliveira', 'Física', '45678901234', 'maria.oliveira@example.com'),
('Paulo Santos', 'Física', '56789012345', 'paulo.santos@example.com'),
('Lucas Rodrigues', 'Física', '67890123456', 'lucas.rodrigues@example.com'),
('Juliana Almeida', 'Física', '78901234567', 'juliana.almeida@example.com'),
('Mariana Castro', 'Física', '89012345678', 'mariana.castro@example.com'),
('Rafael Lima', 'Física', '90123456789', 'rafael.lima@example.com'),
('Fernanda Azevedo', 'Física', '01234567890', 'fernanda.azevedo@example.com'),
('Gabriel Melo', 'Física', '11223344556', 'gabriel.melo@example.com'),
('Isabela Costa', 'Física', '22334455667', 'isabela.costa@example.com'),
('Renato Teixeira', 'Física', '33445566778', 'renato.teixeira@example.com'),
('Patrícia Fernandes', 'Física', '44556677889', 'patricia.fernandes@example.com'),
('Leonardo Gomes', 'Física', '55667788990', 'leonardo.gomes@example.com'),
('Sofia Martins', 'Física', '66778899001', 'sofia.martins@example.com'),
('Marcelo Ribeiro', 'Física', '77889900112', 'marcelo.ribeiro@example.com'),
('Aline Duarte', 'Física', '88990011223', 'aline.duarte@example.com'),
('Fábio Cardoso', 'Física', '99001122334', 'fabio.cardoso@example.com'),
('Roberta Monteiro', 'Física', '10111213141', 'roberta.monteiro@example.com'),
('Eduardo Barros', 'Física', '12131415161', 'eduardo.barros@example.com'),
('Tatiana Brito', 'Física', '13141516171', 'tatiana.brito@example.com'),
('Rodrigo Nunes', 'Física', '14151617181', 'rodrigo.nunes@example.com'),
('Cláudia Figueiredo', 'Física', '15161718191', 'claudia.figueiredo@example.com'),
('André Moreira', 'Física', '16171819201', 'andre.moreira@example.com'),
('Bruna Pires', 'Física', '17181920212', 'bruna.pires@example.com'),
('Eliane Magalhães', 'Física', '18192021223', 'eliane.magalhaes@example.com'),
('Vinícius Fernandes', 'Física', '19202122234', 'vinicius.fernandes@example.com'),
-- Clientes Pessoa Jurídica
('Empresa XYZ Ltda', 'Jurídica', '12345678000191', 'contato@xyz.com.br'),
('Tech Solutions Ltda', 'Jurídica', '23456789000102', 'contato@techsolutions.com.br'),
('Comércio ABC Ltda', 'Jurídica', '34567890000113', 'contato@comercioabc.com.br'),
('Serviços Integrados Ltda', 'Jurídica', '45678901000124', 'contato@servicosintegrados.com.br'),
('Construtora Beta Ltda', 'Jurídica', '56789012000135', 'contato@construtorabeta.com.br'),
('Transportes Delta Ltda', 'Jurídica', '67890123000146', 'contato@transportesdelta.com.br'),
('Alimentos Epsilon Ltda', 'Jurídica', '78901234000157', 'contato@alimentosepsilon.com.br'),
('Consultoria Zeta Ltda', 'Jurídica', '89012345000168', 'contato@consultoriazeta.com.br'),
('Educação Omega Ltda', 'Jurídica', '90123456000179', 'contato@educacaoomega.com.br'),
('Moda Alpha Ltda', 'Jurídica', '01234567000180', 'contato@modalpha.com.br'),
('Saúde Gamma Ltda', 'Jurídica', '11234568000191', 'contato@saudegamma.com.br');

SELECT * FROM tb_clientes;

-- Registro de funcionários 02/13
INSERT INTO tb_funcionarios (nome, cargo, salario) VALUES
('Carlos Silva', 'Gerente', 8000.00),
('Fernanda Costa', 'Maître', 5000.00),
('Ricardo Santos', 'Caixa', 2900.00),
('João Souza', 'Garçom', 3000.00),
('Maria Oliveira', 'Garçom', 3000.00),
('Paulo Santos', 'Garçom', 3000.00),
('Bruno Gomes', 'Garçom', 3000.00),
('Helena Alves', 'Garçom', 3000.00),
('Beatriz Souza', 'Recepcionista', 2800.00),
('Roberta Monteiro', 'Recepcionista', 2800.00),
('Aline Duarte', 'Recepcionista', 2800.00),
('Renata Faria', 'Recepcionista', 2800.00),
('Juliana Almeida', 'Chef de Cozinha', 7000.00),
('Lucas Rodrigues', 'Auxiliar de Cozinha', 2500.00),
('Mariana Castro', 'Auxiliar de Cozinha', 2500.00),
('Carla Pinto', 'Auxiliar de Cozinha', 2500.00),
('Pedro Martins', 'Auxiliar de Cozinha', 2500.00),
('Rafael Lima', 'Bartender', 3500.00),
('Gabriel Melo', 'Bartender', 3500.00),
('Fernando Lemos', 'Bartender', 3500.00),
('Eduardo Barros', 'Segurança', 3200.00),
('Tatiana Brito', 'Segurança', 3200.00),
('Diego Fernandes', 'Segurança', 3200.00);

SELECT * FROM tb_funcionarios;

-- Registro dos endereço dos funcionários 03/13
INSERT INTO tb_endereco_funcionario (id_funcionario, logradouro, numero, complemento, bairro, cidade, estado, cep) VALUES
(1, 'Rua das Flores', '123', 'Apto 201', 'Asa Sul', 'Brasília', 'DF', '70040120'),
(2, 'Avenida Central', '45', NULL, 'Taguatinga', 'Brasília', 'DF', '72000000'),
(3, 'Rua das Palmeiras', '678', 'Casa 2', 'Ceilândia', 'Brasília', 'DF', '72220000'),
(4, 'Rua dos Lírios', '234', NULL, 'Águas Claras', 'Brasília', 'DF', '71900000'),
(5, 'Avenida das Nações', '789', 'Bloco A', 'Guará', 'Brasília', 'DF', '71000000'),
(6, 'Rua dos Cravos', '12', 'Apto 302', 'Samambaia', 'Brasília', 'DF', '72300000'),
(7, 'Avenida Independência', '56', NULL, 'Sobradinho', 'Brasília', 'DF', '73000000'),
(8, 'Rua das Mangueiras', '90', 'Casa 1', 'Planaltina', 'Brasília', 'DF', '73300000'),
(9, 'Avenida dos Estados', '123', 'Apto 101', 'Riacho Fundo', 'Brasília', 'DF', '71800000'),
(10, 'Rua das Acácias', '456', NULL, 'Núcleo Bandeirante', 'Brasília', 'DF', '71700000'),
(11, 'Avenida Brasil', '789', 'Casa 3', 'Paranoá', 'Brasília', 'DF', '71500000'),
(12, 'Rua dos Jacarandás', '123', 'Bloco B', 'São Sebastião', 'Brasília', 'DF', '71600000'),
(13, 'Avenida das Palmeiras', '456', 'Apto 203', 'Gama', 'Brasília', 'DF', '72400000'),
(14, 'Rua dos Lírios', '789', NULL, 'Cruzeiro', 'Brasília', 'DF', '70600000'),
(15, 'Avenida das Flores', '12', 'Casa 4', 'Brasília', 'Brasília', 'DF', '70100000'),
(16, 'Rua dos Coqueiros', '34', 'Apto 204', 'Lago Sul', 'Brasília', 'DF', '71650000'),
(17, 'Avenida Central', '56', NULL, 'Lago Norte', 'Brasília', 'DF', '71500000'),
(18, 'Rua das Rosas', '78', 'Bloco C', 'Taguatinga', 'Brasília', 'DF', '72010000'),
(19, 'Avenida Independência', '90', 'Casa 5', 'Ceilândia', 'Brasília', 'DF', '72220001'),
(20, 'Rua das Magnólias', '12', 'Apto 305', 'Samambaia', 'Brasília', 'DF', '72300001'),
(21, 'Avenida das Américas', '34', NULL, 'Sobradinho', 'Brasília', 'DF', '73010000'),
(22, 'Rua dos Cedros', '56', 'Casa 2', 'Planaltina', 'Brasília', 'DF', '73310000'),
(23, 'Avenida dos Ipês', '78', 'Bloco D', 'Riacho Fundo', 'Brasília', 'DF', '71810000');

SELECT * FROM tb_endereco_funcionario;

-- Registro das formas de pagamento aceitas 04/13
INSERT INTO tb_formas_pagamento (descricao) VALUES
('Dinheiro'),
('PIX'),
('Cartão de Débito'),
('Cartão de Crédito'),
('Voucher'),
('Vale Restaurante');

SELECT * FROM tb_formas_pagamento;

-- Cadastro das mesas 05/13
INSERT INTO tb_mesas (id_mesa, capacidade, localizacao) VALUES
(101, 4, 'Área Interna - Perto da Janela'),
(102, 2, 'Área Interna - Próximo ao Bar'),
(103, 6, 'Área Interna - Centro do Salão'),
(104, 4, 'Área Externa - Jardim'),
(105, 2, 'Área Externa - Varanda'),
(106, 8, 'Área VIP - Sala Privativa'),
(107, 4, 'Área Interna - Perto da Porta'),
(108, 4, 'Área Interna - Próximo à Cozinha'),
(109, 6, 'Área Externa - Perto da Piscina'),
(110, 2, 'Área Interna - Cantinho Romântico'),
(111, 4, 'Área Interna - Perto da Parede de Arte'),
(112, 4, 'Área Interna - Próximo à Entrada'),
(113, 6, 'Área Externa - Perto da Fonte'),
(114, 2, 'Área Interna - Mesa Redonda'),
(115, 4, 'Área Interna - Próximo ao Aquário'),
(116, 6, 'Área Interna - Família'),
(117, 4, 'Área Externa - Perto do Estacionamento'),
(118, 4, 'Área Interna - Perto do Banheiro'),
(119, 2, 'Área Interna - Perto da Escada'),
(120, 4, 'Área Externa - Perto das Flores'),
(121, 6, 'Área VIP - Mesa Redonda'),
(122, 4, 'Área Interna - Perto do Palco'),
(123, 4, 'Área Externa - Perto do Lago'),
(124, 6, 'Área Interna - Perto da Lareira'),
(125, 2, 'Área Interna - Mesa para Amigos'),
(126, 4, 'Área Interna - Perto da Biblioteca'),
(127, 4, 'Área Interna - Próximo ao Buffet'),
(128, 6, 'Área Externa - Perto do Parquinho'),
(129, 4, 'Área VIP - Mesa Quadrada'),
(130, 4, 'Área Interna - Perto do Mural'),
(131, 2, 'Área Interna - Perto do Espelho'),
(132, 4, 'Área Externa - Perto do Mirante'),
(133, 6, 'Área Interna - Perto do Piano'),
(134, 4, 'Área Interna - Próximo ao Lounge'),
(135, 2, 'Área Interna - Próximo ao Jardim');

SELECT * FROM tb_mesas;

-- Registros dos pedidos 06/13
INSERT INTO tb_pedidos (id_cliente, id_mesa, data_pedido, status, id_funcionario) VALUES
(1, 101, '2022-12-01', 'Concluído', 1),
(2, 102, '2022-12-02', 'Pendente', 2),
(3, 103, '2022-12-03', 'Concluído', 3),
(4, 104, '2022-12-04', 'Pendente', 4),
(5, 105, '2022-12-05', 'Concluído', 5);
INSERT INTO tb_pedidos (id_cliente, id_mesa, data_pedido, status, id_funcionario) VALUES
(6, 106, '2022-12-06', 'Pendente', 6),
(7, 107, '2022-12-07', 'Concluído', 7),
(8, 108, '2022-12-08', 'Pendente', 8),
(9, 109, '2022-12-09', 'Concluído', 9),
(10, 110, '2022-12-10', 'Pendente', 10),
(11, 111, '2022-12-11', 'Concluído', 11),
(12, 112, '2022-12-12', 'Pendente', 12),
(13, 113, '2022-12-13', 'Concluído', 13),
(14, 114, '2022-12-14', 'Pendente', 14),
(15, 115, '2022-12-15', 'Concluído', 15),
(16, 116, '2022-12-16', 'Pendente', 16),
(17, 117, '2022-12-17', 'Concluído', 17),
(18, 118, '2022-12-18', 'Pendente', 18),
(19, 119, '2022-12-19', 'Concluído', 19),
(20, 120, '2022-12-20', 'Pendente', 20),
(21, 121, '2022-12-21', 'Concluído', 21),
(22, 122, '2022-12-22', 'Pendente', 22),
(23, 123, '2022-12-23', 'Concluído', 23),
(24, 124, '2022-12-24', 'Pendente', 1),
(25, 125, '2022-12-25', 'Concluído', 2),
(26, 126, '2022-12-26', 'Pendente', 3);
INSERT INTO tb_pedidos (id_cliente, id_mesa, data_pedido, status, id_funcionario) VALUES
(27, 127, '2022-12-27', 'Concluído', 4),
(28, 128, '2022-12-28', 'Pendente', 5),
(29, 129, '2022-12-29', 'Concluído', 6),
(30, 130, '2022-12-30', 'Pendente', 7),
(31, 131, '2022-12-31', 'Concluído', 8),
(32, 132, '2023-01-01', 'Pendente', 9),
(33, 133, '2023-01-02', 'Concluído', 10),
(34, 134, '2023-01-03', 'Pendente', 11),
(35, 135, '2023-01-04', 'Concluído', 12),
(36, 101, '2023-01-05', 'Pendente', 13),
(37, 102, '2023-01-06', 'Concluído', 14),
(38, 103, '2023-01-07', 'Pendente', 15),
(39, 104, '2023-01-08', 'Concluído', 16),
(1, 105, '2023-01-09', 'Pendente', 17),
(2, 106, '2023-01-10', 'Concluído', 18),
(3, 107, '2023-01-11', 'Pendente', 19),
(4, 108, '2023-01-12', 'Concluído', 20),
(5, 109, '2023-01-13', 'Pendente', 21),
(6, 110, '2023-01-14', 'Concluído', 22),
(7, 111, '2023-01-15', 'Pendente', 23),
(8, 112, '2023-01-16', 'Concluído', 1),
(9, 113, '2023-01-17', 'Pendente', 2),
(10, 114, '2023-01-18', 'Concluído', 3),
(11, 115, '2023-01-19', 'Pendente', 4),
(12, 116, '2023-01-20', 'Concluído', 5),
(13, 117, '2023-01-21', 'Pendente', 6);
INSERT INTO tb_pedidos (id_cliente, id_mesa, data_pedido, status, id_funcionario) VALUES
(14, 118, '2023-01-22', 'Concluído', 7),
(15, 119, '2023-01-23', 'Pendente', 8),
(16, 120, '2023-01-24', 'Concluído', 9),
(17, 121, '2023-01-25', 'Pendente', 10),
(18, 122, '2023-01-26', 'Concluído', 11),
(19, 123, '2023-01-27', 'Pendente', 12),
(20, 124, '2023-01-28', 'Concluído', 13),
(21, 125, '2023-01-29', 'Pendente', 14),
(22, 126, '2023-01-30', 'Concluído', 15),
(23, 127, '2023-01-31', 'Pendente', 16),
(24, 128, '2023-02-01', 'Concluído', 17),
(25, 129, '2023-02-02', 'Pendente', 18),
(26, 130, '2023-02-03', 'Concluído', 19),
(27, 131, '2023-02-04', 'Pendente', 20),
(28, 132, '2023-02-05', 'Concluído', 21),
(29, 133, '2023-02-06', 'Pendente', 22),
(30, 134, '2023-02-07', 'Concluído', 23),
(31, 135, '2023-02-08', 'Pendente', 1),
(32, 101, '2023-02-09', 'Concluído', 2),
(33, 102, '2023-02-10', 'Pendente', 3),
(34, 103, '2023-02-11', 'Concluído', 4),
(35, 104, '2023-02-12', 'Pendente', 5),
(36, 105, '2023-02-13', 'Concluído', 6),
(37, 106, '2023-02-14', 'Pendente', 7),
(38, 107, '2023-02-15', 'Concluído', 8),
(39, 108, '2023-02-16', 'Pendente', 9),
(1, 109, '2023-02-17', 'Concluído', 10),
(2, 110, '2023-02-18', 'Pendente', 11),
(3, 111, '2023-02-19', 'Concluído', 12),
(4, 112, '2023-02-20', 'Pendente', 13),
(5, 113, '2023-02-21', 'Concluído', 14),
(6, 114, '2023-02-22', 'Pendente', 15);
INSERT INTO tb_pedidos (id_cliente, id_mesa, data_pedido, status, id_funcionario) VALUES
(7, 115, '2023-02-23', 'Concluído', 16),
(8, 116, '2023-02-24', 'Pendente', 17),
(9, 117, '2023-02-25', 'Concluído', 18),
(10, 118, '2023-02-26', 'Pendente', 19),
(11, 119, '2023-02-27', 'Concluído', 20),
(1, 101, '2023-07-01', 'Concluído', 1),
(2, 102, '2023-07-02', 'Pendente', 2),
(3, 103, '2023-07-03', 'Concluído', 3),
(4, 104, '2023-07-04', 'Pendente', 4),
(5, 105, '2023-07-05', 'Concluído', 5),
(6, 106, '2023-07-06', 'Pendente', 6),
(7, 107, '2023-07-07', 'Concluído', 7),
(8, 108, '2023-07-08', 'Pendente', 8),
(9, 109, '2023-07-09', 'Concluído', 9),
(10, 110, '2023-07-10', 'Pendente', 10),
(11, 111, '2023-07-11', 'Concluído', 11),
(12, 112, '2023-07-12', 'Pendente', 12),
(13, 113, '2023-07-13', 'Concluído', 13),
(14, 114, '2023-07-14', 'Pendente', 14),
(15, 115, '2023-07-15', 'Concluído', 15),
(16, 116, '2023-07-16', 'Pendente', 16),
(17, 117, '2023-07-17', 'Concluído', 17),
(18, 118, '2023-07-18', 'Pendente', 18),
(19, 119, '2023-07-19', 'Concluído', 19),
(20, 120, '2023-07-20', 'Pendente', 20),
(21, 121, '2023-07-21', 'Concluído', 21),
(22, 122, '2023-07-22', 'Pendente', 22),
(23, 123, '2023-07-23', 'Concluído', 23),
(24, 124, '2023-07-24', 'Pendente', 1),
(25, 125, '2023-07-25', 'Concluído', 2),
(26, 126, '2023-07-26', 'Pendente', 3),
(27, 127, '2023-07-27', 'Concluído', 4),
(28, 128, '2023-07-28', 'Pendente', 5),
(29, 129, '2023-07-29', 'Concluído', 6),
(30, 130, '2023-07-30', 'Pendente', 7),
(31, 131, '2023-07-31', 'Concluído', 8),
(32, 132, '2023-08-01', 'Pendente', 9);
INSERT INTO tb_pedidos (id_cliente, id_mesa, data_pedido, status, id_funcionario) VALUES
(33, 133, '2023-08-02', 'Concluído', 10),
(34, 134, '2023-08-03', 'Pendente', 11),
(35, 135, '2023-08-04', 'Concluído', 12),
(36, 101, '2023-08-05', 'Pendente', 13),
(37, 102, '2023-08-06', 'Concluído', 14),
(38, 103, '2023-08-07', 'Pendente', 15),
(39, 104, '2023-08-08', 'Concluído', 16),
(1, 105, '2023-08-09', 'Pendente', 17),
(2, 106, '2023-08-10', 'Concluído', 18),
(3, 107, '2023-08-11', 'Pendente', 19),
(4, 108, '2023-08-12', 'Concluído', 20),
(5, 109, '2023-08-13', 'Pendente', 21),
(6, 110, '2023-08-14', 'Concluído', 22),
(7, 111, '2023-08-15', 'Pendente', 23),
(8, 112, '2023-08-16', 'Concluído', 1),
(9, 113, '2023-08-17', 'Pendente', 2),
(10, 114, '2023-08-18', 'Concluído', 3),
(11, 115, '2023-08-19', 'Pendente', 4),
(12, 116, '2023-08-20', 'Concluído', 5),
(13, 117, '2023-08-21', 'Pendente', 6),
(14, 118, '2023-08-22', 'Concluído', 7),
(15, 119, '2023-08-23', 'Pendente', 8),
(16, 120, '2023-08-24', 'Concluído', 9),
(17, 121, '2023-08-25', 'Pendente', 10),
(18, 122, '2023-08-26', 'Concluído', 11),
(19, 123, '2023-08-27', 'Pendente', 12),
(20, 124, '2023-08-28', 'Concluído', 13),
(21, 125, '2023-08-29', 'Pendente', 14),
(22, 126, '2023-08-30', 'Concluído', 15),
(23, 127, '2023-08-31', 'Pendente', 16),
(24, 128, '2023-09-01', 'Concluído', 17),
(25, 129, '2023-09-02', 'Pendente', 18),
(26, 130, '2023-09-03', 'Concluído', 19),
(27, 131, '2023-09-04', 'Pendente', 20);
INSERT INTO tb_pedidos (id_cliente, id_mesa, data_pedido, status, id_funcionario) VALUES
(28, 132, '2023-09-05', 'Concluído', 21),
(29, 133, '2023-09-06', 'Pendente', 22),
(30, 134, '2023-09-07', 'Concluído', 23),
(31, 135, '2023-09-08', 'Pendente', 1),
(32, 101, '2023-09-09', 'Concluído', 2),
(33, 102, '2023-09-10', 'Pendente', 3),
(34, 103, '2023-09-11', 'Concluído', 4),
(35, 104, '2023-09-12', 'Pendente', 5),
(36, 105, '2023-09-13', 'Concluído', 6),
(37, 106, '2023-09-14', 'Pendente', 7),
(38, 107, '2023-09-15', 'Concluído', 8),
(39, 108, '2023-09-16', 'Pendente', 9),
(1, 109, '2023-09-17', 'Concluído', 10),
(2, 110, '2023-09-18', 'Pendente', 11),
(3, 111, '2023-09-19', 'Concluído', 12),
(4, 112, '2023-09-20', 'Pendente', 13),
(5, 113, '2023-09-21', 'Concluído', 14),
(6, 114, '2023-09-22', 'Pendente', 15),
(7, 115, '2023-09-23', 'Concluído', 16),
(8, 116, '2023-09-24', 'Pendente', 17),
(9, 117, '2023-09-25', 'Concluído', 18),
(10, 118, '2023-09-26', 'Pendente', 19),
(11, 119, '2023-09-27', 'Concluído', 20),
(12, 120, '2023-09-28', 'Pendente', 21),
(13, 121, '2023-09-29', 'Concluído', 22),
(1, 101, '2024-01-01', 'Concluído', 1),
(2, 102, '2024-01-02', 'Pendente', 2),
(3, 103, '2024-01-03', 'Concluído', 3),
(4, 104, '2024-01-04', 'Pendente', 4),
(5, 105, '2024-01-05', 'Concluído', 5),
(6, 106, '2024-01-06', 'Pendente', 6),
(7, 107, '2024-01-07', 'Concluído', 7),
(8, 108, '2024-01-08', 'Pendente', 8),
(9, 109, '2024-01-09', 'Concluído', 9),
(10, 110, '2024-01-10', 'Pendente', 10),
(11, 111, '2024-01-11', 'Concluído', 11),
(12, 112, '2024-01-12', 'Pendente', 12);
INSERT INTO tb_pedidos (id_cliente, id_mesa, data_pedido, status, id_funcionario) VALUES
(13, 113, '2024-01-13', 'Concluído', 13),
(14, 114, '2024-01-14', 'Pendente', 14),
(15, 115, '2024-01-15', 'Concluído', 15),
(16, 116, '2024-01-16', 'Pendente', 16),
(17, 117, '2024-01-17', 'Concluído', 17),
(18, 118, '2024-01-18', 'Pendente', 18),
(19, 119, '2024-01-19', 'Concluído', 19),
(20, 120, '2024-01-20', 'Pendente', 20),
(21, 121, '2024-01-21', 'Concluído', 21),
(22, 122, '2024-01-22', 'Pendente', 22),
(23, 123, '2024-01-23', 'Concluído', 23),
(24, 124, '2024-01-24', 'Pendente', 1),
(25, 125, '2024-01-25', 'Concluído', 2),
(26, 126, '2024-01-26', 'Pendente', 3),
(27, 127, '2024-01-27', 'Concluído', 4),
(28, 128, '2024-01-28', 'Pendente', 5),
(29, 129, '2024-01-29', 'Concluído', 6),
(30, 130, '2024-01-30', 'Pendente', 7),
(31, 131, '2024-01-31', 'Concluído', 8),
(32, 132, '2024-02-01', 'Pendente', 9),
(33, 133, '2024-02-02', 'Concluído', 10),
(34, 134, '2024-02-03', 'Pendente', 11),
(35, 135, '2024-02-04', 'Concluído', 12),
(36, 101, '2024-02-05', 'Pendente', 13),
(37, 102, '2024-02-06', 'Concluído', 14),
(38, 103, '2024-02-07', 'Pendente', 15),
(39, 104, '2024-02-08', 'Concluído', 16),
(1, 105, '2024-02-09', 'Pendente', 17),
(2, 106, '2024-02-10', 'Concluído', 18),
(3, 107, '2024-02-11', 'Pendente', 19),
(4, 108, '2024-02-12', 'Concluído', 20),
(5, 109, '2024-02-13', 'Pendente', 21),
(6, 110, '2024-02-14', 'Concluído', 22),
(7, 111, '2024-02-15', 'Pendente', 23),
(8, 112, '2024-02-16', 'Concluído', 1),
(9, 113, '2024-02-17', 'Pendente', 2),
(10, 114, '2024-02-18', 'Concluído', 3),
(11, 115, '2024-02-19', 'Pendente', 4),
(12, 116, '2024-02-20', 'Concluído', 5),
(13, 117, '2024-02-21', 'Pendente', 6),
(14, 118, '2024-02-22', 'Concluído', 7),
(15, 119, '2024-02-23', 'Pendente', 8),
(16, 120, '2024-02-24', 'Concluído', 9),
(17, 121, '2024-02-25', 'Pendente', 10),
(18, 122, '2024-02-26', 'Concluído', 11),
(19, 123, '2024-02-27', 'Pendente', 12),
(20, 124, '2024-02-28', 'Concluído', 13),
(21, 125, '2024-03-01', 'Pendente', 14),
(22, 126, '2024-03-02', 'Concluído', 15);
INSERT INTO tb_pedidos (id_cliente, id_mesa, data_pedido, status, id_funcionario) VALUES
(23, 127, '2024-03-03', 'Pendente', 16),
(24, 128, '2024-03-04', 'Concluído', 17),
(25, 129, '2024-03-05', 'Pendente', 18),
(26, 130, '2024-03-06', 'Concluído', 19),
(27, 131, '2024-03-07', 'Pendente', 20),
(28, 132, '2024-03-08', 'Concluído', 21),
(29, 133, '2024-03-09', 'Pendente', 22),
(30, 134, '2024-03-10', 'Concluído', 23),
(31, 135, '2024-03-11', 'Pendente', 1),
(32, 101, '2024-03-12', 'Concluído', 2),
(33, 102, '2024-03-13', 'Pendente', 3),
(34, 103, '2024-03-14', 'Concluído', 4),
(35, 104, '2024-03-15', 'Pendente', 5),
(36, 105, '2024-03-16', 'Concluído', 6),
(37, 106, '2024-03-17', 'Pendente', 7),
(38, 107, '2024-03-18', 'Concluído', 8),
(39, 108, '2024-03-19', 'Pendente', 9),
(1, 109, '2024-03-20', 'Concluído', 10),
(2, 110, '2024-03-21', 'Pendente', 11),
(3, 111, '2024-03-22', 'Concluído', 12),
(4, 112, '2024-03-23', 'Pendente', 13),
(5, 113, '2024-03-24', 'Concluído', 14),
(6, 114, '2024-03-25', 'Pendente', 15),
(7, 115, '2024-03-26', 'Concluído', 16),
(8, 116, '2024-03-27', 'Pendente', 17),
(9, 117, '2024-03-28', 'Concluído', 18),
(10, 118, '2024-03-29', 'Pendente', 19),
(11, 119, '2024-03-30', 'Concluído', 20),
(12, 120, '2024-03-31', 'Pendente', 21),
(13, 121, '2024-04-01', 'Concluído', 22),
(1, 101, '2024-07-01', 'Concluído', 1),
(2, 102, '2024-07-03', 'Pendente', 2),
(3, 103, '2024-07-05', 'Concluído', 3),
(4, 104, '2024-07-07', 'Pendente', 4),
(5, 105, '2024-07-09', 'Concluído', 5),
(6, 106, '2024-07-11', 'Pendente', 6),
(7, 107, '2024-07-13', 'Concluído', 7),
(8, 108, '2024-07-15', 'Pendente', 8),
(9, 109, '2024-07-17', 'Concluído', 9),
(10, 110, '2024-07-19', 'Pendente', 10),
(11, 111, '2024-07-21', 'Concluído', 11);
INSERT INTO tb_pedidos (id_cliente, id_mesa, data_pedido, status, id_funcionario) VALUES
(12, 112, '2024-07-23', 'Pendente', 12),
(13, 113, '2024-07-25', 'Concluído', 13),
(14, 114, '2024-07-27', 'Pendente', 14),
(15, 115, '2024-07-29', 'Concluído', 15),
(16, 116, '2024-07-31', 'Pendente', 16),
(17, 117, '2024-08-02', 'Concluído', 17);
INSERT INTO tb_pedidos (id_cliente, id_mesa, data_pedido, status, id_funcionario) VALUES
(18, 118, '2024-08-04', 'Pendente', 18);
INSERT INTO tb_pedidos (id_cliente, id_mesa, data_pedido, status, id_funcionario) VALUES
(19, 119, '2024-08-06', 'Concluído', 19),
(20, 120, '2024-08-08', 'Pendente', 20),
(21, 121, '2024-08-10', 'Concluído', 21);
INSERT INTO tb_pedidos (id_cliente, id_mesa, data_pedido, status, id_funcionario) VALUES
(22, 122, '2024-08-12', 'Pendente', 22),
(23, 123, '2024-08-14', 'Concluído', 23);

SELECT * FROM tb_pedidos;

-- Registro dos pagamentos 07/13
INSERT INTO tb_pagamentos (id_pagamento, valor, data_pagamento, id_pedido) VALUES
(1, 100.00, '2022-12-02', 1),
(2, 50.00, '2022-12-03', 2),
(3, 75.00, '2022-12-04', 3),
(4, 60.00, '2022-12-05', 4),
(5, 90.00, '2022-12-06', 5),
(6, 80.00, '2022-12-07', 6),
(7, 70.00, '2022-12-08', 7),
(8, 65.00, '2022-12-09', 8),
(9, 85.00, '2022-12-10', 9),
(10, 95.00, '2022-12-11', 10),
(11, 55.00, '2022-12-12', 11),
(12, 45.00, '2022-12-13', 12),
(13, 100.00, '2022-12-14', 13),
(14, 50.00, '2022-12-15', 14),
(15, 75.00, '2022-12-16', 15),
(16, 60.00, '2022-12-17', 16),
(17, 90.00, '2022-12-18', 17),
(18, 80.00, '2022-12-19', 18),
(19, 70.00, '2022-12-20', 19),
(20, 65.00, '2022-12-21', 20),
(21, 85.00, '2022-12-22', 21),
(22, 95.00, '2022-12-23', 22),
(23, 55.00, '2022-12-24', 23),
(24, 45.00, '2022-12-25', 24),
(25, 100.00, '2022-12-26', 25),
(26, 50.00, '2022-12-27', 26),
(27, 75.00, '2022-12-28', 27),
(28, 60.00, '2022-12-29', 28),
(29, 90.00, '2022-12-30', 29),
(30, 80.00, '2022-12-31', 30),
(31, 70.00, '2023-01-01', 31),
(32, 65.00, '2023-01-02', 32),
(33, 85.00, '2023-01-03', 33),
(34, 95.00, '2023-01-04', 34),
(35, 55.00, '2023-01-05', 35),
(36, 45.00, '2023-01-06', 36),
(37, 100.00, '2023-01-07', 37),
(38, 50.00, '2023-01-08', 38),
(39, 75.00, '2023-01-09', 39),
(40, 60.00, '2023-01-10', 40),
(41, 90.00, '2023-01-11', 41),
(42, 80.00, '2023-01-12', 42),
(43, 70.00, '2023-01-13', 43),
(44, 65.00, '2023-01-14', 44),
(45, 85.00, '2023-01-15', 45),
(46, 95.00, '2023-01-16', 46),
(47, 55.00, '2023-01-17', 47),
(48, 45.00, '2023-01-18', 48),
(49, 100.00, '2023-01-19', 49),
(50, 50.00, '2023-01-20', 50);
INSERT INTO tb_pagamentos (id_pagamento, valor, data_pagamento, id_pedido) VALUES
(51, 100.00, '2023-01-20', 51),
(52, 50.00, '2023-01-21', 52),
(53, 75.00, '2023-01-22', 53),
(54, 60.00, '2023-01-23', 54),
(55, 90.00, '2023-01-24', 55),
(56, 80.00, '2023-01-25', 56),
(57, 70.00, '2023-01-26', 57),
(58, 65.00, '2023-01-27', 58),
(59, 85.00, '2023-01-28', 59),
(60, 95.00, '2023-01-29', 60),
(61, 55.00, '2023-01-30', 61),
(62, 45.00, '2023-01-31', 62),
(63, 100.00, '2023-02-01', 63),
(64, 50.00, '2023-02-02', 64),
(65, 75.00, '2023-02-03', 65),
(66, 60.00, '2023-02-04', 66),
(67, 90.00, '2023-02-05', 67),
(68, 80.00, '2023-02-06', 68),
(69, 70.00, '2023-02-07', 69),
(70, 65.00, '2023-02-08', 70),
(71, 85.00, '2023-02-09', 71),
(72, 95.00, '2023-02-10', 72),
(73, 55.00, '2023-02-11', 73),
(74, 45.00, '2023-02-12', 74),
(75, 100.00, '2023-02-13', 75),
(76, 50.00, '2023-02-14', 76),
(77, 75.00, '2023-02-15', 77),
(78, 60.00, '2023-02-16', 78),
(79, 90.00, '2023-02-17', 79),
(80, 80.00, '2023-02-18', 80),
(81, 70.00, '2023-02-19', 81),
(82, 65.00, '2023-02-20', 82),
(83, 85.00, '2023-02-21', 83),
(84, 95.00, '2023-02-22', 84),
(85, 55.00, '2023-02-23', 85),
(86, 45.00, '2023-02-24', 86),
(87, 100.00, '2023-02-25', 87),
(88, 50.00, '2023-02-26', 88),
(89, 75.00, '2023-02-27', 89),
(90, 60.00, '2023-02-28', 90),
(91, 90.00, '2023-03-01', 91),
(92, 80.00, '2023-03-02', 92),
(93, 70.00, '2023-03-03', 93),
(94, 65.00, '2023-03-04', 94),
(95, 85.00, '2023-03-05', 95),
(96, 95.00, '2023-03-06', 96),
(97, 55.00, '2023-03-07', 97),
(98, 45.00, '2023-03-08', 98),
(99, 100.00, '2023-03-09', 99),
(100, 50.00, '2023-03-10', 100);
INSERT INTO tb_pagamentos (id_pagamento, valor, data_pagamento, id_pedido) VALUES
(101, 100.00, '2023-07-12', 101),
(102, 50.00, '2023-07-13', 102),
(103, 75.00, '2023-07-14', 103),
(104, 60.00, '2023-07-15', 104),
(105, 90.00, '2023-07-16', 105),
(106, 80.00, '2023-07-17', 106),
(107, 70.00, '2023-07-18', 107),
(108, 65.00, '2023-07-19', 108),
(109, 85.00, '2023-07-20', 109),
(110, 95.00, '2023-07-21', 110),
(111, 55.00, '2023-07-22', 111),
(112, 45.00, '2023-07-23', 112),
(113, 100.00, '2023-07-24', 113),
(114, 50.00, '2023-07-25', 114),
(115, 75.00, '2023-07-26', 115),
(116, 60.00, '2023-07-27', 116),
(117, 90.00, '2023-07-28', 117),
(118, 80.00, '2023-07-29', 118),
(119, 70.00, '2023-07-30', 119),
(120, 65.00, '2023-07-31', 120),
(121, 85.00, '2023-08-01', 121),
(122, 95.00, '2023-08-02', 122),
(123, 55.00, '2023-08-03', 123),
(124, 45.00, '2023-08-04', 124),
(125, 100.00, '2023-08-05', 125),
(126, 50.00, '2023-08-06', 126),
(127, 75.00, '2023-08-07', 127),
(128, 60.00, '2023-08-08', 128),
(129, 90.00, '2023-08-09', 129),
(130, 80.00, '2023-08-10', 130),
(131, 70.00, '2023-08-11', 131),
(132, 65.00, '2023-08-12', 132),
(133, 85.00, '2023-08-13', 133),
(134, 95.00, '2023-08-14', 134),
(135, 55.00, '2023-08-15', 135),
(136, 45.00, '2023-08-16', 136),
(137, 100.00, '2023-08-17', 137),
(138, 50.00, '2023-08-18', 138),
(139, 75.00, '2023-08-19', 139),
(140, 60.00, '2023-08-20', 140),
(141, 90.00, '2023-08-21', 141),
(142, 80.00, '2023-08-22', 142),
(143, 70.00, '2023-08-23', 143),
(144, 65.00, '2023-08-24', 144),
(145, 85.00, '2023-08-25', 145),
(146, 95.00, '2023-08-26', 146),
(147, 55.00, '2023-08-27', 147),
(148, 45.00, '2023-08-28', 148),
(149, 100.00, '2023-08-29', 149),
(150, 50.00, '2023-08-30', 150);
INSERT INTO tb_pagamentos (id_pagamento, valor, data_pagamento, id_pedido) VALUES
(151, 100.00, '2023-09-01', 151),
(152, 50.00, '2023-09-02', 152),
(153, 75.00, '2023-09-03', 153),
(154, 60.00, '2023-09-04', 154),
(155, 90.00, '2023-09-05', 155),
(156, 80.00, '2023-09-06', 156),
(157, 70.00, '2023-09-07', 157),
(158, 65.00, '2023-09-08', 158),
(159, 85.00, '2023-09-09', 159),
(160, 95.00, '2023-09-10', 160),
(161, 55.00, '2023-09-11', 161),
(162, 45.00, '2023-09-12', 162),
(163, 100.00, '2023-09-13', 163),
(164, 50.00, '2023-09-14', 164),
(165, 75.00, '2023-09-15', 165),
(166, 60.00, '2023-09-16', 166),
(167, 90.00, '2023-09-17', 167),
(168, 80.00, '2023-09-18', 168),
(169, 70.00, '2023-09-19', 169),
(170, 65.00, '2023-09-20', 170),
(171, 85.00, '2023-09-21', 171),
(172, 95.00, '2023-09-22', 172),
(173, 55.00, '2023-09-23', 173),
(174, 45.00, '2023-09-24', 174),
(175, 100.00, '2023-09-25', 175),
(176, 50.00, '2023-09-26', 176),
(177, 75.00, '2023-09-27', 177),
(178, 60.00, '2023-09-28', 178),
(179, 90.00, '2023-09-29', 179),
(180, 80.00, '2023-09-30', 180),
(181, 70.00, '2023-10-01', 181),
(182, 65.00, '2023-10-02', 182),
(183, 85.00, '2023-10-03', 183),
(184, 95.00, '2023-10-04', 184),
(185, 55.00, '2023-10-05', 185),
(186, 45.00, '2023-10-06', 186),
(187, 100.00, '2023-10-07', 187),
(188, 50.00, '2023-10-08', 188),
(189, 75.00, '2023-10-09', 189),
(190, 60.00, '2023-10-10', 190),
(191, 90.00, '2023-10-11', 191),
(192, 80.00, '2023-10-12', 192),
(193, 70.00, '2023-10-13', 193),
(194, 65.00, '2023-10-14', 194),
(195, 85.00, '2023-10-15', 195),
(196, 95.00, '2023-10-16', 196),
(197, 55.00, '2023-10-17', 197),
(198, 45.00, '2023-10-18', 198),
(199, 100.00, '2023-10-19', 199),
(200, 50.00, '2023-10-20', 200);
INSERT INTO tb_pagamentos (id_pagamento, valor, data_pagamento, id_pedido) VALUES
(201, 100.00, '2024-01-21', 201),
(202, 50.00, '2024-01-22', 202),
(203, 75.00, '2024-01-23', 203),
(204, 60.00, '2024-01-24', 204),
(205, 90.00, '2024-01-25', 205),
(206, 80.00, '2024-01-26', 206),
(207, 70.00, '2024-01-27', 207),
(208, 65.00, '2024-01-28', 208),
(209, 85.00, '2024-01-29', 209),
(210, 95.00, '2024-01-30', 210),
(211, 55.00, '2024-01-31', 211),
(212, 45.00, '2024-02-01', 212),
(213, 100.00, '2024-02-02', 213),
(214, 50.00, '2024-02-03', 214),
(215, 75.00, '2024-02-04', 215),
(216, 60.00, '2024-02-05', 216),
(217, 90.00, '2024-02-06', 217),
(218, 80.00, '2024-02-07', 218),
(219, 70.00, '2024-02-08', 219),
(220, 65.00, '2024-02-09', 220),
(221, 85.00, '2024-02-10', 221),
(222, 95.00, '2024-02-11', 222),
(223, 55.00, '2024-02-12', 223),
(224, 45.00, '2024-02-13', 224),
(225, 100.00, '2024-02-14', 225),
(226, 50.00, '2024-02-15', 226),
(227, 75.00, '2024-02-16', 227),
(228, 60.00, '2024-02-17', 228),
(229, 90.00, '2024-02-18', 229),
(230, 80.00, '2024-02-19', 230),
(231, 70.00, '2024-02-20', 231),
(232, 65.00, '2024-02-21', 232),
(233, 85.00, '2024-02-22', 233),
(234, 95.00, '2024-02-23', 234),
(235, 55.00, '2024-02-24', 235),
(236, 45.00, '2024-02-25', 236),
(237, 100.00, '2024-02-26', 237),
(238, 50.00, '2024-02-27', 238),
(239, 75.00, '2024-02-28', 239),
(240, 60.00, '2024-02-29', 240),
(241, 90.00, '2024-03-01', 241),
(242, 80.00, '2024-03-02', 242),
(243, 70.00, '2024-03-03', 243),
(244, 65.00, '2024-03-04', 244),
(245, 85.00, '2024-03-05', 245),
(246, 95.00, '2024-03-06', 246),
(247, 55.00, '2024-03-07', 247),
(248, 45.00, '2024-03-08', 248),
(249, 100.00, '2024-03-09', 249),
(250, 50.00, '2024-03-10', 250);
INSERT INTO tb_pagamentos (id_pagamento, valor, data_pagamento, id_pedido) VALUES
(251, 100.00, '2024-03-12', 251),
(252, 50.00, '2024-03-13', 252),
(253, 75.00, '2024-03-14', 253),
(254, 60.00, '2024-03-15', 254),
(255, 90.00, '2024-03-16', 255),
(256, 80.00, '2024-03-17', 256),
(257, 70.00, '2024-03-18', 257),
(258, 65.00, '2024-03-19', 258),
(259, 85.00, '2024-03-20', 259),
(260, 95.00, '2024-03-21', 260),
(261, 55.00, '2024-03-22', 261),
(262, 45.00, '2024-03-23', 262),
(263, 100.00, '2024-03-24', 263),
(264, 50.00, '2024-03-25', 264),
(265, 75.00, '2024-03-26', 265),
(266, 60.00, '2024-03-27', 266),
(267, 90.00, '2024-03-28', 267),
(268, 80.00, '2024-03-29', 268),
(269, 70.00, '2024-03-30', 269),
(270, 65.00, '2024-03-31', 270),
(271, 85.00, '2024-04-01', 271),
(272, 95.00, '2024-04-02', 272),
(273, 55.00, '2024-04-03', 273),
(274, 45.00, '2024-04-04', 274),
(275, 100.00, '2024-04-05', 275),
(276, 50.00, '2024-04-06', 276),
(277, 75.00, '2024-04-07', 277),
(278, 60.00, '2024-04-08', 278),
(279, 90.00, '2024-04-09', 279),
(280, 80.00, '2024-04-10', 280),
(281, 70.00, '2024-04-11', 281),
(282, 65.00, '2024-04-12', 282),
(283, 85.00, '2024-04-13', 283),
(284, 95.00, '2024-04-14', 284),
(285, 55.00, '2024-04-15', 285),
(286, 45.00, '2024-04-16', 286),
(287, 100.00, '2024-04-17', 287),
(288, 50.00, '2024-04-18', 288),
(289, 75.00, '2024-04-19', 289),
(290, 60.00, '2024-04-20', 290),
(291, 90.00, '2024-04-21', 291),
(292, 80.00, '2024-04-22', 292),
(293, 70.00, '2024-04-23', 293),
(294, 65.00, '2024-04-24', 294);

-- Criando o menu 08/13
-- Entradas
INSERT INTO tb_menu (nome, descricao, preco) VALUES
('Salada Caesar', 'Salada de alface romana, croutons e molho Caesar', 18.90),
('Bruschetta', 'Pão torrado com tomate, manjericão e azeite', 12.50),
('Carpaccio de Carne', 'Lâminas finas de carne bovina com molho de mostarda', 22.00),
('Tábua de Frios', 'Variedade de queijos e embutidos', 35.00),
('Camarão Empanado', 'Camarões empanados servidos com molho tártaro', 28.50),
('Bolinho de Bacalhau', 'Bolinho crocante de bacalhau', 16.00),
('Anéis de Lula', 'Anéis de lula empanados', 24.00),
('Patê de Foie Gras', 'Patê de fígado de pato servido com torradas', 32.00),
('Mini Ceviche', 'Pequena porção de ceviche de peixe branco', 20.00),
('Salada Caprese', 'Salada de tomate, mussarela de búfala e manjericão', 18.00);
-- Pratos Principais
INSERT INTO tb_menu (nome, descricao, preco) VALUES
('Filé Mignon ao Molho Madeira', 'Filé mignon grelhado com molho madeira, arroz e batatas', 52.00),
('Salmão Grelhado', 'Salmão grelhado com legumes e purê de batata', 48.00),
('Risoto de Cogumelos', 'Risoto de cogumelos frescos', 36.00),
('Feijoada', 'Feijoada completa com acompanhamentos', 42.00),
('Moqueca de Peixe', 'Moqueca de peixe com pirão e arroz', 46.00),
('Lasanha à Bolonhesa', 'Lasanha de carne à bolonhesa', 38.00),
('Bife à Parmegiana', 'Bife à parmegiana com arroz e fritas', 34.00),
('Frango à Milanesa', 'Frango à milanesa com salada e arroz', 30.00),
('Escondidinho de Carne Seca', 'Escondidinho de carne seca com purê de mandioca', 28.00),
('Polvo à Lagareiro', 'Polvo grelhado com batatas ao murro', 55.00);
-- Bebidas
INSERT INTO tb_menu (nome, descricao, preco) VALUES
('Água Mineral', 'Água mineral sem gás', 4.50),
('Refrigerante', 'Coca-Cola, Fanta ou Sprite', 6.00),
('Suco Natural', 'Suco de laranja, limão ou abacaxi', 8.00),
('Cerveja', 'Cerveja artesanal ou comercial', 9.00),
('Caipirinha', 'Caipirinha tradicional de limão', 12.00),
('Vinho Tinto', 'Taça de vinho tinto', 18.00),
('Vinho Branco', 'Taça de vinho branco', 18.00),
('Café Espresso', 'Café espresso', 6.00),
('Chá Gelado', 'Chá gelado de limão', 7.00),
('Milkshake', 'Milkshake de chocolate ou morango', 10.00);
-- Sobremesas
INSERT INTO tb_menu (nome, descricao, preco) VALUES
('Petit Gâteau', 'Bolo de chocolate com recheio cremoso, servido com sorvete', 15.00),
('Cheesecake', 'Cheesecake tradicional com calda de frutas vermelhas', 14.00),
('Pudim de Leite', 'Pudim de leite condensado', 12.00),
('Sorvete', 'Bolas de sorvete de diferentes sabores', 10.00),
('Torta de Limão', 'Torta de limão com merengue', 14.00),
('Mousse de Maracujá', 'Mousse de maracujá com calda de chocolate', 12.00),
('Brownie', 'Brownie de chocolate com nozes', 13.00),
('Creme Brûlée', 'Creme de baunilha com casca de açúcar caramelizada', 15.00),
('Frutas da Estação', 'Salada de frutas frescas', 10.00),
('Bolo de Cenoura', 'Bolo de cenoura com cobertura de chocolate', 12.00);
-- Acompanhamentos
INSERT INTO tb_menu (nome, descricao, preco) VALUES
('Arroz Branco', 'Arroz branco soltinho', 5.00),
('Batata Frita', 'Batatas fritas crocantes', 8.00),
('Farofa', 'Farofa crocante de ovos e bacon', 7.00),
('Feijão Tropeiro', 'Feijão tropeiro com bacon e linguiça', 10.00),
('Salada Verde', 'Salada de folhas verdes com molho', 9.00),
('Legumes Grelhados', 'Legumes grelhados', 12.00),
('Purê de Batata', 'Purê de batata cremoso', 6.00),
('Vinagrete', 'Molho vinagrete', 4.00),
('Cuscuz', 'Cuscuz paulista', 8.00),
('Onion Rings', 'Anéis de cebola empanados', 9.00);
-- Entradas
INSERT INTO tb_menu (nome, descricao, preco) VALUES
('Ceviche de Camarão', 'Ceviche de camarão com limão e coentro', 22.00),
('Tartar de Salmão', 'Tartar de salmão com molho de mostarda', 24.00),
('Fondue de Queijo', 'Fondue de queijo com pães e vegetais', 30.00),
('Ostras Frescas', 'Ostras frescas com limão', 35.00),
('Guacamole', 'Guacamole com nachos', 18.00);
-- Pratos Principais
INSERT INTO tb_menu (nome, descricao, preco) VALUES
('Bacalhau à Brás', 'Bacalhau desfiado com batata palha, ovos e azeitonas', 48.00),
('Paella Valenciana', 'Paella de frutos do mar', 55.00),
('Churrasco', 'Churrasco misto com carnes, frango e linguiça', 50.00),
('Strogonoff de Carne', 'Strogonoff de carne com arroz e batata palha', 38.00),
('Tacos de Carne', 'Tacos de carne com guacamole e salsa', 28.00);
-- Bebidas
INSERT INTO tb_menu (nome, descricao, preco) VALUES
('Cappuccino', 'Cappuccino com chantilly', 7.00),
('Água de Coco', 'Água de coco natural', 6.00),
('Smoothie de Frutas', 'Smoothie de frutas da estação', 10.00),
('Batida de Coco', 'Batida de coco com leite condensado', 11.00),
('Chá Quente', 'Chá quente de hortelã', 5.00);
-- Sobremesas
INSERT INTO tb_menu (nome, descricao, preco) VALUES
('Tiramisu', 'Tiramisu tradicional italiano', 14.00),
('Banana Split', 'Banana split com sorvete e calda de chocolate', 12.00),
('Crème Caramel', 'Pudim de caramelo', 11.00),
('Mil Folhas', 'Mil folhas de creme', 13.00),
('Pavê', 'Pavê de chocolate e biscoito', 12.00);
-- Acompanhamentos
INSERT INTO tb_menu (nome, descricao, preco) VALUES
('Polenta Frita', 'Polenta frita crocante', 8.00),
('Purê de Mandioquinha', 'Purê de mandioquinha', 9.00),
('Quinoa', 'Quinoa temperada', 10.00),
('Arroz Integral', 'Arroz integral soltinho', 7.00),
('Sopa de Legumes', 'Sopa de legumes com hortelã', 12.00);

SELECT * FROM tb_menu;

-- Criando os detalhes de pagamento 09/13
INSERT INTO tb_detalhes_pedido (id_pedido, id_item, quantidade, preco_unitario) VALUES
(1, 1, 2, 15.00),
(2, 2, 1, 10.00),
(3, 3, 3, 20.00),
(4, 4, 2, 12.50),
(5, 5, 1, 8.00),
(6, 6, 2, 15.00),
(7, 7, 1, 10.00),
(8, 8, 3, 20.00),
(9, 9, 2, 12.50),
(10, 10, 1, 8.00),
(11, 11, 2, 15.00),
(12, 12, 1, 10.00),
(13, 13, 3, 20.00),
(14, 14, 2, 12.50),
(15, 15, 1, 8.00),
(16, 16, 2, 15.00),
(17, 17, 1, 10.00),
(18, 18, 3, 20.00),
(19, 19, 2, 12.50),
(20, 20, 1, 8.00),
(21, 21, 2, 15.00),
(22, 22, 1, 10.00),
(23, 23, 3, 20.00),
(24, 24, 2, 12.50),
(25, 25, 1, 8.00),
(26, 26, 2, 15.00),
(27, 27, 1, 10.00),
(28, 28, 3, 20.00),
(29, 29, 2, 12.50),
(30, 30, 1, 8.00),
(31, 31, 2, 15.00),
(32, 32, 1, 10.00),
(33, 33, 3, 20.00),
(34, 34, 2, 12.50),
(35, 35, 1, 8.00),
(36, 36, 2, 15.00),
(37, 37, 1, 10.00),
(38, 38, 3, 20.00),
(39, 39, 2, 12.50),
(40, 40, 1, 8.00),
(41, 41, 2, 15.00),
(42, 42, 1, 10.00),
(43, 43, 3, 20.00),
(44, 44, 2, 12.50),
(45, 45, 1, 8.00),
(46, 46, 2, 15.00),
(47, 47, 1, 10.00),
(48, 48, 3, 20.00),
(49, 49, 2, 12.50),
(50, 50, 1, 8.00);
INSERT INTO tb_detalhes_pedido (id_pedido, id_item, quantidade, preco_unitario) VALUES
(51, 2, 1, 10.00),
(52, 3, 3, 20.00),
(53, 4, 2, 12.50),
(54, 5, 1, 8.00),
(55, 6, 2, 15.00),
(56, 7, 1, 10.00),
(57, 8, 3, 20.00),
(58, 9, 2, 12.50),
(59, 10, 1, 8.00),
(60, 11, 2, 15.00),
(61, 12, 1, 10.00),
(62, 13, 3, 20.00),
(63, 14, 2, 12.50),
(64, 15, 1, 8.00),
(65, 16, 2, 15.00),
(66, 17, 1, 10.00),
(67, 18, 3, 20.00),
(68, 19, 2, 12.50),
(69, 20, 1, 8.00),
(70, 21, 2, 15.00),
(71, 22, 1, 10.00),
(72, 23, 3, 20.00),
(73, 24, 2, 12.50),
(74, 25, 1, 8.00),
(75, 26, 2, 15.00),
(76, 27, 1, 10.00),
(77, 28, 3, 20.00),
(78, 29, 2, 12.50),
(79, 30, 1, 8.00),
(80, 31, 2, 15.00),
(81, 32, 1, 10.00),
(82, 33, 3, 20.00),
(83, 34, 2, 12.50),
(84, 35, 1, 8.00),
(85, 36, 2, 15.00),
(86, 37, 1, 10.00),
(87, 38, 3, 20.00),
(88, 39, 2, 12.50),
(89, 40, 1, 8.00),
(90, 41, 2, 15.00),
(91, 42, 1, 10.00),
(92, 43, 3, 20.00),
(93, 44, 2, 12.50),
(94, 45, 1, 8.00),
(95, 46, 2, 15.00),
(96, 47, 1, 10.00),
(97, 48, 3, 20.00),
(98, 49, 2, 12.50),
(99, 50, 1, 8.00),
(100, 1, 2, 15.00);
INSERT INTO tb_detalhes_pedido (id_pedido, id_item, quantidade, preco_unitario) VALUES
(101, 1, 2, 15.00),
(102, 2, 1, 10.00),
(103, 3, 3, 20.00),
(104, 4, 2, 12.50),
(105, 5, 1, 8.00),
(106, 6, 2, 15.00),
(107, 7, 1, 10.00),
(108, 8, 3, 20.00),
(109, 9, 2, 12.50),
(110, 10, 1, 8.00),
(111, 11, 2, 15.00),
(112, 12, 1, 10.00),
(113, 13, 3, 20.00),
(114, 14, 2, 12.50),
(115, 15, 1, 8.00),
(116, 16, 2, 15.00),
(117, 17, 1, 10.00),
(118, 18, 3, 20.00),
(119, 19, 2, 12.50),
(120, 20, 1, 8.00),
(121, 21, 2, 15.00),
(122, 22, 1, 10.00),
(123, 23, 3, 20.00),
(124, 24, 2, 12.50),
(125, 25, 1, 8.00),
(126, 26, 2, 15.00),
(127, 27, 1, 10.00),
(128, 28, 3, 20.00),
(129, 29, 2, 12.50),
(130, 30, 1, 8.00),
(131, 31, 2, 15.00),
(132, 32, 1, 10.00),
(133, 33, 3, 20.00),
(134, 34, 2, 12.50),
(135, 35, 1, 8.00),
(136, 36, 2, 15.00),
(137, 37, 1, 10.00),
(138, 38, 3, 20.00),
(139, 39, 2, 12.50),
(140, 40, 1, 8.00),
(141, 41, 2, 15.00),
(142, 42, 1, 10.00),
(143, 43, 3, 20.00),
(144, 44, 2, 12.50),
(145, 45, 1, 8.00),
(146, 46, 2, 15.00),
(147, 47, 1, 10.00),
(148, 48, 3, 20.00),
(149, 49, 2, 12.50),
(150, 50, 1, 8.00);
INSERT INTO tb_detalhes_pedido (id_pedido, id_item, quantidade, preco_unitario) VALUES
(151, 1, 2, 15.00),
(152, 2, 1, 10.00),
(153, 3, 3, 20.00),
(154, 4, 2, 12.50),
(155, 5, 1, 8.00),
(156, 6, 2, 15.00),
(157, 7, 1, 10.00),
(158, 8, 3, 20.00),
(159, 9, 2, 12.50),
(160, 10, 1, 8.00),
(161, 11, 2, 15.00),
(162, 12, 1, 10.00),
(163, 13, 3, 20.00),
(164, 14, 2, 12.50),
(165, 15, 1, 8.00),
(166, 16, 2, 15.00),
(167, 17, 1, 10.00),
(168, 18, 3, 20.00),
(169, 19, 2, 12.50),
(170, 20, 1, 8.00),
(171, 21, 2, 15.00),
(172, 22, 1, 10.00),
(173, 23, 3, 20.00),
(174, 24, 2, 12.50),
(175, 25, 1, 8.00),
(176, 26, 2, 15.00),
(177, 27, 1, 10.00),
(178, 28, 3, 20.00),
(179, 29, 2, 12.50),
(180, 30, 1, 8.00),
(181, 31, 2, 15.00),
(182, 32, 1, 10.00),
(183, 33, 3, 20.00),
(184, 34, 2, 12.50),
(185, 35, 1, 8.00),
(186, 36, 2, 15.00),
(187, 37, 1, 10.00),
(188, 38, 3, 20.00),
(189, 39, 2, 12.50),
(190, 40, 1, 8.00),
(191, 41, 2, 15.00),
(192, 42, 1, 10.00),
(193, 43, 3, 20.00),
(194, 44, 2, 12.50),
(195, 45, 1, 8.00),
(196, 46, 2, 15.00),
(197, 47, 1, 10.00),
(198, 48, 3, 20.00),
(199, 49, 2, 12.50),
(200, 50, 1, 8.00);
INSERT INTO tb_detalhes_pedido (id_pedido, id_item, quantidade, preco_unitario) VALUES
(201, 1, 2, 15.00),
(202, 2, 1, 10.00),
(203, 3, 3, 20.00),
(204, 4, 2, 12.50),
(205, 5, 1, 8.00),
(206, 6, 2, 15.00),
(207, 7, 1, 10.00),
(208, 8, 3, 20.00),
(209, 9, 2, 12.50),
(210, 10, 1, 8.00),
(211, 11, 2, 15.00),
(212, 12, 1, 10.00),
(213, 13, 3, 20.00),
(214, 14, 2, 12.50),
(215, 15, 1, 8.00),
(216, 16, 2, 15.00),
(217, 17, 1, 10.00),
(218, 18, 3, 20.00),
(219, 19, 2, 12.50),
(220, 20, 1, 8.00),
(221, 21, 2, 15.00),
(222, 22, 1, 10.00),
(223, 23, 3, 20.00),
(224, 24, 2, 12.50),
(225, 25, 1, 8.00),
(226, 26, 2, 15.00),
(227, 27, 1, 10.00),
(228, 28, 3, 20.00),
(229, 29, 2, 12.50),
(230, 30, 1, 8.00),
(231, 31, 2, 15.00),
(232, 32, 1, 10.00),
(233, 33, 3, 20.00),
(234, 34, 2, 12.50),
(235, 35, 1, 8.00),
(236, 36, 2, 15.00),
(237, 37, 1, 10.00),
(238, 38, 3, 20.00),
(239, 39, 2, 12.50),
(240, 40, 1, 8.00),
(241, 41, 2, 15.00),
(242, 42, 1, 10.00),
(243, 43, 3, 20.00),
(244, 44, 2, 12.50),
(245, 45, 1, 8.00),
(246, 46, 2, 15.00),
(247, 47, 1, 10.00),
(248, 48, 3, 20.00),
(249, 49, 2, 12.50),
(250, 50, 1, 8.00);
INSERT INTO tb_detalhes_pedido (id_pedido, id_item, quantidade, preco_unitario) VALUES
(251, 1, 2, 15.00),
(252, 2, 1, 10.00),
(253, 3, 3, 20.00),
(254, 4, 2, 12.50),
(255, 5, 1, 8.00),
(256, 6, 2, 15.00),
(257, 7, 1, 10.00),
(258, 8, 3, 20.00),
(259, 9, 2, 12.50),
(260, 10, 1, 8.00),
(261, 11, 2, 15.00),
(262, 12, 1, 10.00),
(263, 13, 3, 20.00),
(264, 14, 2, 12.50),
(265, 15, 1, 8.00),
(266, 16, 2, 15.00),
(267, 17, 1, 10.00),
(268, 18, 3, 20.00),
(269, 19, 2, 12.50),
(270, 20, 1, 8.00),
(271, 21, 2, 15.00),
(272, 22, 1, 10.00),
(273, 23, 3, 20.00),
(274, 24, 2, 12.50),
(275, 25, 1, 8.00),
(276, 26, 2, 15.00),
(277, 27, 1, 10.00),
(278, 28, 3, 20.00),
(279, 29, 2, 12.50),
(280, 30, 1, 8.00),
(281, 31, 2, 15.00),
(282, 32, 1, 10.00),
(283, 33, 3, 20.00),
(284, 34, 2, 12.50),
(285, 35, 1, 8.00),
(286, 36, 2, 15.00),
(287, 37, 1, 10.00),
(288, 38, 3, 20.00),
(289, 39, 2, 12.50),
(290, 40, 1, 8.00),
(291, 41, 2, 15.00),
(292, 42, 1, 10.00),
(293, 43, 3, 20.00),
(294, 44, 2, 12.50);

SELECT * FROM tb_detalhes_pedido;

-- Inserção de dados para associar cada cliente com todas as formas de pagamento 10/13
INSERT INTO tb_cliente_forma_pgto (id_cliente, id_forma_pagamento)
SELECT c.id_cliente, f.id_forma_pagamento
FROM tb_clientes c, tb_formas_pagamento f;

SELECT * FROM  tb_cliente_forma_pgto;

-- Funcionário e pedido atendido 11/13
INSERT INTO tb_funcionario_pedido (id_funcionario, id_pedido)
SELECT id_funcionario, id_pedido
FROM tb_pedidos
WHERE id_funcionario IS NOT NULL;

SELECT * FROM tb_funcionario_pedido;

-- Dados das tabelas pagamento com forma de pagamento 12/13
-- Inserção de registros para a tabela tb_pagamento_forma_pgto
INSERT INTO tb_pagamento_forma_pgto (id_pagamento, id_forma_pagamento)
SELECT p.id_pagamento, 
       CASE 
           WHEN p.id_pagamento % 6 = 1 THEN 1  -- Dinheiro
           WHEN p.id_pagamento % 6 = 2 THEN 2  -- PIX
           WHEN p.id_pagamento % 6 = 3 THEN 3  -- Cartão de Crédito
           WHEN p.id_pagamento % 6 = 4 THEN 4  -- Cartão de Débito
           WHEN p.id_pagamento % 6 = 5 THEN 5  -- Voucher
           ELSE 6  -- Vale Refeição
       END AS id_forma_pagamento
FROM tb_pagamentos p
LIMIT 294;

SELECT * FROM tb_pagamento_forma_pgto;

-- Detalhes do menu
-- Inserção de registros para a tabela tb_menu_detalhes
INSERT INTO tb_menu_detalhes (id_item, id_detalhe_pedido)
SELECT id_item, id_detalhe_pedido
FROM tb_detalhes_pedido;

SELECT * FROM tb_menu_detalhes;

-- CONSULTAS
-- View para listar todos os clientes:
CREATE VIEW vw_lista_clientes AS
SELECT id_cliente, nome, tipo_cliente, documento, email
FROM tb_clientes;

SELECT * FROM vw_lista_clientes;

-- View para listar todos os pedidos com detalhes dos clientes, funcionários e mesas:
CREATE VIEW vw_detalhes_pedidos AS
SELECT p.id_pedido, c.nome AS nome_cliente, f.nome AS nome_funcionario, m.localizacao AS mesa, p.data_pedido, p.status
FROM tb_pedidos p
JOIN tb_clientes c ON p.id_cliente = c.id_cliente
JOIN tb_funcionarios f ON p.id_funcionario = f.id_funcionario
JOIN tb_mesas m ON p.id_mesa = m.id_mesa;

SELECT * FROM vw_detalhes_pedidos;

-- View para listar todos os funcionários com seus endereços:
CREATE VIEW vw_funcionarios_enderecos AS
SELECT f.id_funcionario, f.nome, f.cargo, e.logradouro, e.numero, e.complemento, e.bairro, e.cidade, e.estado, e.cep
FROM tb_funcionarios f
JOIN tb_endereco_funcionario e ON f.id_funcionario = e.id_funcionario;

SELECT * FROM vw_funcionarios_enderecos;

-- View para listar todas as formas de pagamento utilizadas em pedidos:
CREATE VIEW vw_formas_pagamento_pedidos AS
SELECT p.id_pedido, c.nome AS nome_cliente, f.descricao AS forma_pagamento
FROM tb_pedidos AS p
JOIN tb_cliente_forma_pgto AS cpf ON p.id_cliente = cpf.id_cliente
JOIN tb_formas_pagamento f ON cpf.id_forma_pagamento = f.id_forma_pagamento;

SELECT * FROM vw_formas_pagamento_pedidos;

-- Procedimento para inserir um novo cliente:
DELIMITER $$
CREATE PROCEDURE sp_inserir_cliente(
    IN nome_cliente VARCHAR(255),
    IN tipo_cliente ENUM('Física', 'Jurídica'),
    IN documento_cliente VARCHAR(14),
    IN email_cliente VARCHAR(255)
)
BEGIN
    INSERT INTO tb_clientes (nome, tipo_cliente, documento, email)
    VALUES (nome_cliente, tipo_cliente, documento_cliente, email_cliente);
END $$
DELIMITER ;

CALL sp_inserir_cliente('Anderson Guimarães', 'Física', '96207187988', 'anderson.guimaraes@example.com');
SELECT * FROM tb_clientes;

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

CALL sp_inserir_pedido(1, 102, '2024-12-12', 'Em Andamento', 3);
SELECT * FROM tb_pedidos;

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

CALL sp_atualizar_status_pedido(10, 'Concluído');
SELECT * FROM tb_pedidos;

-- Procedimento para excluir um cliente:
DELIMITER $$
CREATE PROCEDURE sp_excluir_cliente(
    IN id_cliente_excluir INT
)
BEGIN
    DELETE FROM tb_clientes
    WHERE id_cliente = id_cliente_excluir;
END $$
DELIMITER ;

CALL sp_excluir_cliente(41);
SELECT * FROM tb_clientes;

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

CALL sp_listar_pedidos_cliente(1);
SELECT * FROM tb_pedidos;

-- Função para calcular a média de pedidos por cliente:
DELIMITER $$
CREATE FUNCTION fn_media_pedidos_cliente()
RETURNS DECIMAL(10,2)
BEGIN
    DECLARE media_pedidos DECIMAL(10,2);
    SELECT AVG(total_pedidos) INTO media_pedidos
    FROM (SELECT COUNT(*) AS total_pedidos
          FROM tb_pedidos
          GROUP BY id_cliente) AS subquery;
    RETURN media_pedidos;
END $$
DELIMITER ;

SELECT fn_media_pedidos_cliente() AS media_pedidos_cliente;

-- Função para calcular o total de vendas de um período:
DELIMITER $$
CREATE FUNCTION fn_total_vendas_periodo(inicio DATE, fim DATE)
RETURNS DECIMAL(10,2) DETERMINISTIC
BEGIN
    DECLARE total_vendas DECIMAL(10,2);
    SELECT SUM(valor) INTO total_vendas
    FROM tb_pagamentos
    WHERE data_pagamento BETWEEN inicio AND fim;
    RETURN total_vendas;
END $$
DELIMITER ;

SELECT fn_total_vendas_periodo('2022-01-01', '2022-12-31') AS total_vendas;


-- Função para verificar se um cliente já possui um determinado documento:
DELIMITER $$
CREATE FUNCTION fn_verificar_documento(documento VARCHAR(14))
RETURNS BOOLEAN DETERMINISTIC
BEGIN
    DECLARE existe BOOLEAN;
    SELECT COUNT(*) INTO existe
    FROM tb_clientes
    WHERE documento = documento;
    RETURN existe > 0;
END $$
DELIMITER ;

SELECT fn_verificar_documento('12345678901') AS documento_existe;


-- Função para calcular a quantidade de pedidos por funcionário:
DELIMITER $$
CREATE FUNCTION fn_pedidos_por_funcionario(id_funcionario_consulta INT)
RETURNS INT DETERMINISTIC
BEGIN
    DECLARE total_pedidos INT;
    SELECT COUNT(*) INTO total_pedidos
    FROM tb_pedidos
    WHERE id_funcionario = id_funcionario_consulta;
    RETURN total_pedidos;
END $$
DELIMITER ;

SELECT fn_pedidos_por_funcionario(5) AS total_pedidos;

-- Função para listar o nome do cliente baseado no ID:
DELIMITER $$
CREATE FUNCTION fn_nome_cliente(id_cliente_consulta INT)
RETURNS VARCHAR(255) DETERMINISTIC
BEGIN
    DECLARE nome_cliente VARCHAR(255);
    SELECT nome INTO nome_cliente
    FROM tb_clientes
    WHERE id_cliente = id_cliente_consulta;
    RETURN nome_cliente;
END $$
DELIMITER ;

SELECT fn_nome_cliente(5) AS nome_cliente;

-- Função para calcular o valor total de um pedido:
DELIMITER $$
CREATE FUNCTION fn_valor_total_pedido(id_pedido_consulta INT)
RETURNS DECIMAL(10,2) DETERMINISTIC
BEGIN
    DECLARE total_valor DECIMAL(10,2);
    SELECT SUM(dp.quantidade * dp.preco_unitario) INTO total_valor
    FROM tb_detalhes_pedido dp
    WHERE dp.id_pedido = id_pedido_consulta;
    RETURN total_valor;
END $$
DELIMITER ;

SELECT fn_valor_total_pedido(5) AS total_valor;

-- Função para retornar a descrição de uma forma de pagamento baseada no ID:
DELIMITER $$
CREATE FUNCTION fn_descricao_forma_pagamento(id_forma_pagamento_consulta INT)
RETURNS VARCHAR(255) DETERMINISTIC
BEGIN
    DECLARE descricao VARCHAR(255);
    SELECT descricao INTO descricao
    FROM tb_formas_pagamento
    WHERE id_forma_pagamento = id_forma_pagamento_consulta;
    RETURN descricao;
END $$
DELIMITER ;

SELECT fn_descricao_forma_pagamento(5) AS descricao_forma_pagamento;
