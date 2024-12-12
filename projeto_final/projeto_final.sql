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

-- Tabela de Pedidos
CREATE TABLE tb_pedidos (
    id_pedido INT AUTO_INCREMENT PRIMARY KEY,
    id_cliente INT,
    data_pedido DATE NOT NULL,
    status VARCHAR(50) NOT NULL,
    id_funcionario INT,
    FOREIGN KEY (id_cliente) REFERENCES tb_clientes(id_cliente),
    FOREIGN KEY (id_funcionario) REFERENCES tb_funcionarios(id_funcionario)
);

-- Tabela de Pagamentos
CREATE TABLE tb_pagamentos (
    id_pagamento INT AUTO_INCREMENT PRIMARY KEY,
    valor DECIMAL(10,2) NOT NULL,
    data_pagamento DATE NOT NULL
);

-- Tabela de Mesas
CREATE TABLE tb_mesas (
    id_mesa INT AUTO_INCREMENT PRIMARY KEY,
    capacidade INT NOT NULL,
    localizacao VARCHAR(255) NOT NULL
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

INSERT INTO tb_funcionarios (nome, cargo, salario) VALUES
-- Gerente
('Carlos Silva', 'Gerente', 8000.00),
-- Maître
('Fernanda Costa', 'Maître', 5000.00),
-- Caixa
('Ricardo Santos', 'Caixa', 2900.00),
-- Outros funcionários
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

INSERT INTO tb_formas_pagamento (descricao) VALUES
('Dinheiro'),
('Pix'),
('Cartão de Débito'),
('Cartão de Crédito'),
('Voucher'),
('Vale Refeição');

SELECT * FROM tb_formas_pagamento;












