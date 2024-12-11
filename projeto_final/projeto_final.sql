/*
PROJETO FINAL
Banco de Dados de um Restaurante apresentado ao Curso de Administrador de Banco de Dados
do Senai SIG-DF sob orientação do Professor Yor Rio Pardo Felix
*/

-- Criação do Banco de Dados
CREATE DATABASE IF NOT EXISTS db_restaurante;
USE db_restaurante;

-- CRIAÇÃO DAS TABELAS
-- Tabela 01/13
CREATE TABLE tb_clientes (
    id_cliente INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(255) NOT NULL,
    tipo_cliente ENUM('PF', 'PJ') NOT NULL, -- 'F' para pessoa física e 'J' para pessoa jurídica
    cpf VARCHAR(14),
    cnpj VARCHAR(18),
    telefone VARCHAR(15),
    email VARCHAR(255),
    CONSTRAINT chk_cliente CHECK (
        (tipo_cliente = 'PF' AND cpf IS NOT NULL AND cnpj IS NULL) OR
        (tipo_cliente = 'PJ' AND cnpj IS NOT NULL AND cpf IS NULL)
    )
);

-- Tabela 02/13
CREATE TABLE tb_funcionarios (
    id_funcionario INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(255) NOT NULL,
    data_nascimento DATE,
    cpf VARCHAR(14) NOT NULL,
    cargo VARCHAR(255),
    telefone VARCHAR(15),
    email VARCHAR(255),
    salario DECIMAL(10, 2),
    data_contratacao DATE NOT NULL
);

-- Tabela 03/13
CREATE TABLE tb_endereco_funcionario (
    id_funcionario INT PRIMARY KEY,
    logradouro VARCHAR(255),
    numero INT,
    complemento VARCHAR(255),
    bairro VARCHAR(255),
    cidade VARCHAR(255),
    estado VARCHAR(2),
    cep VARCHAR(9),
    FOREIGN KEY (id_funcionario) REFERENCES tb_funcionarios(id_funcionario)
);

-- Tabela 04/13
CREATE TABLE tb_formas_pagamento (
    id_forma_pagamento INT AUTO_INCREMENT PRIMARY KEY,
    forma_pagamento VARCHAR(255) NOT NULL
);

-- Tabela 05/13
CREATE TABLE tb_pedidos (
    id_pedido INT AUTO_INCREMENT PRIMARY KEY,
    data_pedido DATE NOT NULL,
    status VARCHAR(255) NOT NULL
);

-- Tabela 06/13
CREATE TABLE tb_pagamentos (
    id_pagamento INT AUTO_INCREMENT PRIMARY KEY,
    valor DECIMAL(10, 2) NOT NULL,
    data_pagamento DATE NOT NULL
);

-- Tabela 07/13
CREATE TABLE tb_mesas (
    id_mesa INT AUTO_INCREMENT PRIMARY KEY,
    capacidade INT NOT NULL,
    localizacao VARCHAR(255)
);


-- Tabela 08/13
CREATE TABLE tb_menu (
    id_item INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(255) NOT NULL,
    descricao TEXT,
    preco DECIMAL(10, 2) NOT NULL
);

-- Tabela 09/13
CREATE TABLE tb_detalhes_pedido (
    id_detalhe_pedido INT AUTO_INCREMENT PRIMARY KEY,
    id_pedido INT,
    id_item INT,
    quantidade INT NOT NULL,
    preco_unitario DECIMAL(10, 2) NOT NULL,
    FOREIGN KEY (id_pedido) REFERENCES tb_pedidos(id_pedido),
    FOREIGN KEY (id_item) REFERENCES tb_menu(id_item)
);

-- Tabela 10/13
CREATE TABLE tb_cliente_forma_pgto (
    id_cliente INT,
    id_forma_pagamento INT,
    PRIMARY KEY (id_cliente, id_forma_pagamento),
    FOREIGN KEY (id_cliente) REFERENCES tb_clientes(id_cliente),
    FOREIGN KEY (id_forma_pagamento) REFERENCES tb_formas_pagamento(id_forma_pagamento)
);

-- Tabela 11/13
CREATE TABLE tb_funcionario_pedido (
    id_funcionario INT,
    id_pedido INT,
    PRIMARY KEY (id_funcionario, id_pedido),
    FOREIGN KEY (id_funcionario) REFERENCES tb_funcionarios(id_funcionario),
    FOREIGN KEY (id_pedido) REFERENCES tb_pedidos(id_pedido)
);

-- Tabela 12/13
CREATE TABLE tb_pagamento_forma_pgto (
    id_pagamento INT,
    id_forma_pagamento INT,
    PRIMARY KEY (id_pagamento, id_forma_pagamento),
    FOREIGN KEY (id_pagamento) REFERENCES tb_pagamentos(id_pagamento),
    FOREIGN KEY (id_forma_pagamento) REFERENCES tb_formas_pagamento(id_forma_pagamento)
);

-- Tabela 13/13
CREATE TABLE tb_menu_detalhes (
    id_item INT,
    id_detalhe_pedido INT,
    PRIMARY KEY (id_item, id_detalhe_pedido),
    FOREIGN KEY (id_item) REFERENCES tb_menu(id_item),
    FOREIGN KEY (id_detalhe_pedido) REFERENCES tb_detalhes_pedido(id_detalhe_pedido)
);

-- POPULANDO AS TABELAS
-- Clientes
INSERT INTO tb_clientes (nome, tipo_cliente, cpf, cnpj, telefone, email) VALUES
('Ana Paula Silva', 'PF', '123.456.789-00', NULL, '(61) 1234-5678', 'ana.silva@example.com'),
('João Pereira', 'PF', '234.567.890-11', NULL, '(61) 2234-5678', 'joao.pereira@example.com'),
('Maria Oliveira', 'PF', '345.678.901-22', NULL, '(61) 3234-5678', 'maria.oliveira@example.com'),
('Carlos Lima', 'PF', '456.789.012-33', NULL, '(61) 4234-5678', 'carlos.lima@example.com'),
('Renata Souza', 'PF', '567.890.123-44', NULL, '(61) 5234-5678', 'renata.souza@example.com'),
('Ricardo Batista', 'PF', '678.901.234-55', NULL, '(61) 6234-5678', 'ricardo.batista@example.com'),
('Patrícia Araújo', 'PF', '789.012.345-66', NULL, '(61) 7234-5678', 'patricia.araujo@example.com'),
('Paulo Fernandes', 'PF', '890.123.456-77', NULL, '(61) 8234-5678', 'paulo.fernandes@example.com'),
('Vanessa Costa', 'PF', '901.234.567-88', NULL, '(61) 9234-5678', 'vanessa.costa@example.com'),
('Rafael Monteiro', 'PF', '012.345.678-99', NULL, '(61) 0234-5678', 'rafael.monteiro@example.com'),
('Juliana Lima', 'PF', '234.567.890-00', NULL, '(61) 1234-5679', 'juliana.lima@example.com'),
('André Santos', 'PF', '345.678.901-11', NULL, '(61) 2234-5679', 'andre.santos@example.com'),
('Mariana Nunes', 'PF', '456.789.012-22', NULL, '(61) 3234-5679', 'mariana.nunes@example.com'),
('Felipe Almeida', 'PF', '567.890.123-33', NULL, '(61) 4234-5679', 'felipe.almeida@example.com'),
('Beatriz Mendes', 'PF', '678.901.234-44', NULL, '(61) 5234-5679', 'beatriz.mendes@example.com'),
('Fernando Rocha', 'PF', '789.012.345-55', NULL, '(61) 6234-5679', 'fernando.rocha@example.com'),
('Luana Ribeiro', 'PF', '890.123.456-66', NULL, '(61) 7234-5679', 'luana.ribeiro@example.com'),
('Marcelo Farias', 'PF', '901.234.567-77', NULL, '(61) 8234-5679', 'marcelo.farias@example.com'),
('Simone Carvalho', 'PF', '012.345.678-88', NULL, '(61) 9234-5679', 'simone.carvalho@example.com'),
('Rodrigo Borges', 'PF', '123.456.789-99', NULL, '(61) 0234-5679', 'rodrigo.borges@example.com'),
('Empresa ABC Ltda', 'PJ', NULL, '00.123.456/0001-00', '(61) 1111-1111', 'contato@empresaabc.com'),
('Indústria XYZ SA', 'PJ', NULL, '11.234.567/0001-11', '(61) 2222-2222', 'vendas@industriaxyz.com'),
('Comércio QWE Ltda', 'PJ', NULL, '22.345.678/0001-22', '(61) 3333-3333', 'suporte@comercioqwe.com'),
('Serviços LMN Ltda', 'PJ', NULL, '33.456.789/0001-33', '(61) 4444-4444', 'info@servicoslmn.com'),
('Construtora OPQ Ltda', 'PJ', NULL, '44.567.890/0001-44', '(61) 5555-5555', 'admin@construtoraopq.com'),
('Tech JKL SA', 'PJ', NULL, '55.678.901/0001-55', '(61) 6666-6666', 'tech@techjkl.com'),
('Transporte RST Ltda', 'PJ', NULL, '66.789.012/0001-66', '(61) 7777-7777', 'logistica@transporterst.com'),
('Eventos UVW Ltda', 'PJ', NULL, '77.890.123/0001-77', '(61) 8888-8888', 'eventos@eventosuvw.com'),
('Consultoria DEF Ltda', 'PJ', NULL, '88.901.234/0001-88', '(61) 9999-9999', 'consultoria@consultoriadef.com'),
('Educação GHI Ltda', 'PJ', NULL, '99.012.345/0001-99', '(61) 1010-1010', 'ensino@educacaoghi.com'),
('Hotel JKL Ltda', 'PJ', NULL, '10.123.456/0001-10', '(61) 1212-1212', 'reservas@hoteljkl.com'),
('Restaurante MNO Ltda', 'PJ', NULL, '20.234.567/0001-20', '(61) 1313-1313', 'contato@restaurante mno.com'),
('Clínica PQR Ltda', 'PJ', NULL, '30.345.678/0001-30', '(61) 1414-1414', 'atendimento@clinicapqr.com'),
('Editora STU Ltda', 'PJ', NULL, '40.456.789/0001-40', '(61) 1515-1515', 'editorial@editorastu.com'),
('Banco VWX SA', 'PJ', NULL, '50.567.890/0001-50', '(61) 1616-1616', 'financas@bancovwx.com'),
('Seguradora YZ Ltda', 'PJ', NULL, '60.678.901/0001-60', '(61) 1717-1717', 'seguranca@seguradorayz.com');

SELECT * FROM tb_clientes;


-- Funcionários
INSERT INTO tb_funcionarios (nome, data_nascimento, cpf, cargo, telefone, email, salario, data_contratacao) VALUES
('José da Silva', '1980-01-15', '123.456.789-00', 'Gerente', '(61) 1234-5678', 'jose.silva@example.com', 5000.00, '2023-01-01'),
('Maria Santos', '1985-02-20', '234.567.890-11', 'Maître', '(61) 2234-5678', 'maria.santos@example.com', 4000.00, '2023-02-01'),
('Carlos Oliveira', '1990-03-25', '345.678.901-22', 'Garçom', '(61) 3234-5678', 'carlos.oliveira@example.com', 2500.00, '2023-03-01'),
('Ana Costa', '1992-04-10', '456.789.012-33', 'Garçonete', '(61) 4234-5678', 'ana.costa@example.com', 2500.00, '2023-04-01'),
('Paulo Pereira', '1988-05-15', '567.890.123-44', 'Garçom', '(61) 5234-5678', 'paulo.pereira@example.com', 2500.00, '2023-05-01'),
('Fernanda Lima', '1995-06-20', '678.901.234-55', 'Cozinheira', '(61) 6234-5678', 'fernanda.lima@example.com', 3000.00, '2023-06-01'),
('Ricardo Sousa', '1987-07-25', '789.012.345-66', 'Cozinheiro', '(61) 7234-5678', 'ricardo.sousa@example.com', 3000.00, '2023-07-01'),
('Juliana Alves', '1993-08-30', '890.123.456-77', 'Auxiliar de Cozinha', '(61) 8234-5678', 'juliana.alves@example.com', 2000.00, '2023-08-01'),
('Marcos Ribeiro', '1989-09-05', '901.234.567-88', 'Auxiliar de Cozinha', '(61) 9234-5678', 'marcos.ribeiro@example.com', 2000.00, '2023-09-01'),
('Patrícia Moreira', '1991-10-10', '012.345.678-99', 'Recepcionista', '(61) 0234-5678', 'patricia.moreira@example.com', 2200.00, '2023-10-01'),
('Roberto Souza', '1986-11-15', '123.456.789-10', 'Recepcionista', '(61) 1234-6789', 'roberto.souza@example.com', 2200.00, '2023-11-01'),
('Vanessa Martins', '1994-12-20', '234.567.890-20', 'Barman', '(61) 2234-6789', 'vanessa.martins@example.com', 2800.00, '2023-12-01'),
('Lucas Fernandes', '1990-01-25', '345.678.901-30', 'Barman', '(61) 3234-6789', 'lucas.fernandes@example.com', 2800.00, '2024-01-01'),
('Letícia Cardoso', '1996-02-05', '456.789.012-40', 'Auxiliar de Limpeza', '(61) 4234-6789', 'leticia.cardoso@example.com', 1800.00, '2024-02-01'),
('Diego Rocha', '1992-03-10', '567.890.123-50', 'Auxiliar de Limpeza', '(61) 5234-6789', 'diego.rocha@example.com', 1800.00, '2024-03-01'),
('Camila Nascimento', '1985-04-15', '678.901.234-60', 'Sommelier', '(61) 6234-6789', 'camila.nascimento@example.com', 3500.00, '2024-04-01'),
('Pedro Teixeira', '1991-05-20', '789.012.345-70', 'Sommelier', '(61) 7234-6789', 'pedro.teixeira@example.com', 3500.00, '2024-05-01'),
('Laura Braga', '1993-06-25', '890.123.456-80', 'Garçonete', '(61) 8234-6789', 'laura.braga@example.com', 2500.00, '2024-06-01'),
('Fábio Neves', '1988-07-30', '901.234.567-90', 'Garçom', '(61) 9234-6789', 'fabio.neves@example.com', 2500.00, '2024-07-01'),
('Clara Barbosa', '1994-08-05', '012.345.678-11', 'Cozinheira', '(61) 0234-6789', 'clara.barbosa@example.com', 3000.00, '2024-08-01'),
('Mateus Araújo', '1989-09-10', '123.456.789-22', 'Cozinheiro', '(61) 1234-7890', 'mateus.araujo@example.com', 3000.00, '2024-09-01'),
('Bianca Duarte', '1992-10-15', '234.567.890-33', 'Auxiliar de Cozinha', '(61) 2234-7890', 'bianca.duarte@example.com', 2000.00, '2024-10-01'),
('Henrique Campos', '1991-11-20', '345.678.901-44', 'Recepcionista', '(61) 3234-7890', 'henrique.campos@example.com', 2200.00, '2024-11-01'),
('Tatiana Fonseca', '1995-12-25', '456.789.012-55', 'Barman', '(61) 4234-7890', 'tatiana.fonseca@example.com', 2800.00, '2024-12-01'),
('Eduardo Moraes', '1987-01-30', '567.890.123-66', 'Auxiliar de Limpeza', '(61) 5234-7890', 'eduardo.moraes@example.com', 1800.00, '2024-01-01'),
('Lorena Gomes', '1990-02-05', '678.901.234-77', 'Garçonete', '(61) 6234-7890', 'lorena.gomes@example.com', 2500.00, '2024-02-01');

SELECT * FROM tb_funcionarios;

-- Endereço dos funcionários
INSERT INTO tb_endereco_funcionario (id_funcionario, logradouro, numero, complemento, bairro, cidade, estado, cep) VALUES
(1, 'Rua das Acácias', 123, 'Apto 101', 'Asa Norte', 'Brasília', 'DF', '70000-000'),
(2, 'Avenida das Nações', 456, 'Bloco B', 'Asa Sul', 'Brasília', 'DF', '70200-000'),
(3, 'Quadra 203', 789, '', 'Setor Oeste', 'Gama', 'DF', '72420-000'),
(4, 'SQN 108', 321, 'Apto 202', 'Norte', 'Brasília', 'DF', '70740-000'),
(5, 'EQ 12/13', 654, '', 'Centro', 'Taguatinga', 'DF', '72000-000'),
(6, 'Avenida Central', 987, 'Bloco C', 'Noroeste', 'Brasília', 'DF', '70650-000'),
(7, 'Quadra 105', 543, '', 'Asa Norte', 'Brasília', 'DF', '70730-000'),
(8, 'Rua da Paz', 876, 'Casa 3', 'Cruzeiro Velho', 'Brasília', 'DF', '70640-000'),
(9, 'Quadra 301', 210, 'Bloco A', 'Centro', 'Águas Claras', 'DF', '71900-000'),
(10, 'SQSW 304', 432, '', 'Sudoeste', 'Brasília', 'DF', '70297-000'),
(11, 'QI 25', 654, 'Apto 203', 'Guará II', 'Brasília', 'DF', '71000-000'),
(12, 'QN 7', 876, '', 'Ceilândia', 'Brasília', 'DF', '72200-000'),
(13, 'Quadra 502', 123, 'Bloco D', 'Asa Sul', 'Brasília', 'DF', '70350-000'),
(14, 'CLN 116', 456, '', 'Norte', 'Brasília', 'DF', '70780-000'),
(15, 'QN 16', 789, 'Casa 1', 'Riacho Fundo', 'Brasília', 'DF', '71800-000'),
(16, 'Avenida Brasil', 321, 'Bloco E', 'Recanto das Emas', 'Brasília', 'DF', '72600-000'),
(17, 'QRSW 3', 654, '', 'Sudoeste', 'Brasília', 'DF', '70297-030'),
(18, 'EQN 306/307', 987, '', 'Noroeste', 'Brasília', 'DF', '70670-000'),
(19, 'Quadra 104', 543, 'Casa 2', 'Sul', 'Samambaia', 'Brasília', 'DF', '72300-000'),
(20, 'QN 8', 876, 'Apto 101', 'Sul', 'Núcleo Bandeirante', 'Brasília', 'DF', '71700-000'),
(21, 'Rua das Palmeiras', 210, '', 'Asa Norte', 'Brasília', 'DF', '70750-000'),
(22, 'QI 23', 432, 'Bloco F', 'Guará I', 'Brasília', 'DF', '71000-030'),
(23, 'Avenida JK', 654, '', 'Centro', 'Valparaíso de Goiás', 'GO', '72870-000'),
(24, 'Quadra 405', 876, '', 'Asa Sul', 'Brasília', 'DF', '70330-000'),
(25, 'SQN 402', 123, 'Apto 202', 'Norte', 'Brasília', 'DF', '70740-030'),
(26, 'Avenida das Palmeiras', 456, '', 'Centro', 'Planaltina', 'DF', '73300-000');

SELECT * FROM tb_endereco_funcionario;

-- Forma de pagamento
INSERT INTO tb_formas_pagamento (forma_pagamento) VALUES
('Cartão de Crédito'),
('Cartão de Débito'),
('Pix'),
('Dinheiro'),
('Voucher'),
('Vale Refeição');

SELECT * FROM tb_formas_pagamento;

-- Pedidos
INSERT INTO tb_pedidos (data_pedido, status) VALUES
('2022-12-01', 'Concluído'),
('2022-12-01', 'Concluído'),
('2022-12-02', 'Concluído'),
('2022-12-02', 'Concluído'),
('2022-12-03', 'Concluído'),
('2022-12-03', 'Concluído'),
('2022-12-04', 'Concluído'),
('2022-12-04', 'Concluído'),
('2022-12-05', 'Concluído'),
('2022-12-05', 'Concluído'),
('2022-12-06', 'Concluído'),
('2022-12-06', 'Concluído'),
('2022-12-07', 'Concluído'),
('2022-12-07', 'Concluído'),
('2022-12-08', 'Concluído'),
('2022-12-08', 'Concluído'),
('2022-12-09', 'Concluído'),
('2022-12-09', 'Concluído'),
('2022-12-10', 'Concluído'),
('2022-12-10', 'Concluído'),
('2022-12-11', 'Concluído'),
('2022-12-11', 'Concluído'),
('2022-12-12', 'Concluído'),
('2022-12-12', 'Concluído'),
('2022-12-13', 'Concluído'),
('2022-12-13', 'Concluído'),
('2022-12-14', 'Concluído'),
('2022-12-14', 'Concluído'),
('2022-12-15', 'Concluído'),
('2022-12-15', 'Concluído'),
('2022-12-16', 'Concluído'),
('2022-12-16', 'Concluído'),
('2022-12-17', 'Concluído'),
('2022-12-17', 'Concluído'),
('2022-12-18', 'Concluído'),
('2022-12-18', 'Concluído'),
('2022-12-19', 'Concluído'),
('2023-01-01', 'Concluído'),
('2023-01-01', 'Concluído'),
('2023-01-02', 'Concluído'),
('2023-01-02', 'Concluído'),
('2023-01-03', 'Concluído'),
('2023-01-03', 'Concluído'),
('2023-01-04', 'Concluído'),
('2023-01-04', 'Concluído'),
('2023-01-05', 'Concluído'),
('2023-01-05', 'Concluído'),
('2023-01-06', 'Concluído'),
('2023-01-06', 'Concluído'),
('2023-01-07', 'Concluído'),
('2023-01-07', 'Concluído'),
('2023-01-08', 'Concluído'),
('2023-01-08', 'Concluído'),
('2023-01-09', 'Concluído'),
('2023-01-09', 'Concluído'),
('2023-01-10', 'Concluído'),
('2023-01-10', 'Concluído'),
('2023-01-11', 'Concluído'),
('2023-01-11', 'Concluído'),
('2023-01-12', 'Concluído'),
('2023-01-12', 'Concluído'),
('2023-01-13', 'Concluído'),
('2023-01-13', 'Concluído'),
('2023-01-14', 'Concluído'),
('2023-01-14', 'Concluído'),
('2023-01-15', 'Concluído'),
('2023-01-15', 'Concluído'),
('2023-01-16', 'Concluído'),
('2023-01-16', 'Concluído'),
('2023-01-17', 'Concluído'),
('2023-01-17', 'Concluído'),
('2023-01-18', 'Concluído'),
('2023-01-18', 'Concluído'),
('2023-01-19', 'Concluído'),
('2023-01-19', 'Concluído'),
('2023-01-20', 'Concluído'),
('2023-01-20', 'Concluído'),
('2023-01-21', 'Concluído'),
('2023-01-21', 'Concluído'),
('2023-01-22', 'Concluído'),
('2023-02-01', 'Concluído'),
('2023-02-01', 'Concluído'),
('2023-02-02', 'Concluído'),
('2023-02-02', 'Concluído'),
('2023-02-03', 'Concluído'),
('2023-02-03', 'Concluído'),
('2023-02-04', 'Concluído'),
('2023-02-04', 'Concluído'),
('2023-02-05', 'Concluído'),
('2023-02-05', 'Concluído'),
('2023-02-06', 'Concluído'),
('2023-02-06', 'Concluído'),
('2023-02-07', 'Concluído'),
('2023-02-07', 'Concluído'),
('2023-02-08', 'Concluído'),
('2023-02-08', 'Concluído'),
('2023-02-09', 'Concluído'),
('2023-02-09', 'Concluído'),
('2023-02-10', 'Concluído'),
('2023-02-10', 'Concluído'),
('2023-02-11', 'Concluído'),
('2023-02-11', 'Concluído'),
('2023-02-12', 'Concluído'),
('2023-02-12', 'Concluído'),
('2023-02-13', 'Concluído'),
('2023-02-13', 'Concluído'),
('2023-02-14', 'Concluído'),
('2023-02-14', 'Concluído'),
('2023-02-15', 'Concluído'),
('2023-02-15', 'Concluído'),
('2023-02-16', 'Concluído'),
('2023-03-01', 'Concluído'),
('2023-03-02', 'Concluído'),
('2023-03-03', 'Concluído'),
('2023-03-04', 'Concluído'),
('2023-03-05', 'Concluído'),
('2023-03-06', 'Concluído'),
('2023-03-07', 'Concluído'),
('2023-03-08', 'Concluído'),
('2023-03-09', 'Concluído'),
('2023-03-10', 'Concluído'),
('2023-04-01', 'Concluído'),
('2023-04-02', 'Concluído'),
('2023-04-03', 'Concluído'),
('2023-04-04', 'Concluído'),
('2023-04-05', 'Concluído'),
('2023-04-06', 'Concluído'),
('2023-04-07', 'Concluído'),
('2023-04-08', 'Concluído'),
('2023-04-09', 'Concluído'),
('2023-04-10', 'Concluído'),
('2023-05-01', 'Concluído'),
('2023-05-02', 'Concluído'),
('2023-05-03', 'Concluído'),
('2023-05-04', 'Concluído'),
('2023-05-05', 'Concluído'),
('2023-05-06', 'Concluído'),
('2023-05-07', 'Concluído'),
('2023-05-08', 'Concluído'),
('2023-05-09', 'Concluído'),
('2023-05-10', 'Concluído'),
('2023-06-01', 'Concluído'),
('2023-06-02', 'Concluído'),
('2023-06-03', 'Concluído'),
('2023-06-04', 'Concluído'),
('2023-06-05', 'Concluído'),
('2023-06-06', 'Concluído'),
('2023-06-07', 'Concluído'),
('2023-06-08', 'Concluído'),
('2023-06-09', 'Concluído'),
('2023-06-10', 'Concluído'),
('2023-06-11', 'Concluído'),
('2023-06-12', 'Concluído'),
('2023-06-13', 'Concluído'),
('2023-06-14', 'Concluído'),
('2023-07-01', 'Concluído'),
('2023-07-05', 'Concluído'),
('2023-07-10', 'Concluído'),
('2023-07-15', 'Concluído'),
('2023-07-20', 'Concluído'),
('2023-07-25', 'Concluído'),
('2023-07-30', 'Concluído'),
('2023-08-01', 'Concluído'),
('2023-08-05', 'Concluído'),
('2023-08-10', 'Concluído'),
('2023-08-15', 'Concluído'),
('2023-08-20', 'Concluído'),
('2023-08-25', 'Concluído'),
('2023-08-30', 'Concluído'),
('2023-09-01', 'Concluído'),
('2023-09-05', 'Concluído'),
('2023-09-10', 'Concluído'),
('2023-09-15', 'Concluído'),
('2023-09-20', 'Concluído'),
('2023-09-25', 'Concluído'),
('2023-09-30', 'Concluído'),
('2023-10-01', 'Concluído'),
('2023-10-05', 'Concluído'),
('2023-10-10', 'Concluído'),
('2023-10-15', 'Concluído'),
('2023-10-20', 'Concluído'),
('2023-10-25', 'Concluído'),
('2023-10-30', 'Concluído'),
('2023-11-01', 'Concluído'),
('2023-11-05', 'Concluído'),
('2023-11-10', 'Concluído'),
('2023-11-15', 'Concluído'),
('2023-11-20', 'Concluído'),
('2023-11-25', 'Concluído'),
('2023-11-30', 'Concluído'),
('2023-12-01', 'Concluído'),
('2023-12-05', 'Concluído'),
('2024-01-01', 'Concluído'),
('2024-01-02', 'Concluído'),
('2024-01-03', 'Concluído'),
('2024-01-04', 'Concluído'),
('2024-01-05', 'Concluído'),
('2024-01-06', 'Concluído'),
('2024-01-07', 'Concluído'),
('2024-01-08', 'Concluído'),
('2024-01-09', 'Concluído'),
('2024-01-10', 'Concluído'),
('2024-01-11', 'Concluído'),
('2024-01-12', 'Concluído'),
('2024-01-13', 'Concluído'),
('2024-01-14', 'Concluído'),
('2024-01-15', 'Concluído'),
('2024-01-16', 'Concluído'),
('2024-01-17', 'Concluído'),
('2024-01-18', 'Concluído'),
('2024-01-19', 'Concluído'),
('2024-01-20', 'Concluído'),
('2024-02-01', 'Concluído'),
('2024-02-02', 'Concluído'),
('2024-02-03', 'Concluído'),
('2024-02-04', 'Concluído'),
('2024-02-05', 'Concluído'),
('2024-02-06', 'Concluído'),
('2024-02-07', 'Concluído'),
('2024-02-08', 'Concluído'),
('2024-02-09', 'Concluído'),
('2024-02-10', 'Concluído'),
('2024-03-01', 'Concluído'),
('2024-03-02', 'Concluído'),
('2024-03-03', 'Concluído'),
('2024-03-04', 'Concluído'),
('2024-03-05', 'Concluído'),
('2024-03-06', 'Concluído'),
('2024-03-07', 'Concluído'),
('2024-03-08', 'Concluído'),
('2024-03-09', 'Concluído'),
('2024-03-10', 'Concluído'),
('2024-04-01', 'Concluído'),
('2024-04-02', 'Concluído'),
('2024-04-03', 'Concluído'),
('2024-04-04', 'Concluído'),
('2024-04-05', 'Concluído'),
('2024-05-01', 'Concluído'),
('2024-05-02', 'Concluído'),
('2024-05-03', 'Concluído'),
('2024-08-01', 'Concluído'),
('2024-08-05', 'Concluído'),
('2024-08-10', 'Concluído'),
('2024-08-15', 'Concluído'),
('2024-08-20', 'Concluído'),
('2024-08-25', 'Concluído'),
('2024-08-30', 'Concluído'),
('2024-09-01', 'Concluído'),
('2024-09-05', 'Concluído'),
('2024-09-10', 'Concluído'),
('2024-09-15', 'Concluído'),
('2024-09-20', 'Concluído'),
('2024-09-25', 'Concluído'),
('2024-09-30', 'Concluído'),
('2024-10-01', 'Concluído'),
('2024-10-05', 'Concluído'),
('2024-10-10', 'Concluído'),
('2024-10-15', 'Concluído'),
('2024-10-20', 'Concluído'),
('2024-10-25', 'Concluído'),
('2024-10-30', 'Concluído'),
('2024-08-02', 'Concluído'),
('2024-08-06', 'Concluído'),
('2024-08-11', 'Concluído'),
('2024-08-16', 'Concluído'),
('2024-08-21', 'Concluído'),
('2024-08-26', 'Concluído'),
('2024-11-01', 'Concluído'),
('2024-11-02', 'Concluído'),
('2024-11-03', 'Concluído'),
('2024-11-04', 'Concluído'),
('2024-11-05', 'Concluído'),
('2024-11-06', 'Concluído'),
('2024-11-07', 'Concluído'),
('2024-11-08', 'Concluído'),
('2024-11-09', 'Concluído'),
('2024-11-10', 'Concluído'),
('2024-11-11', 'Concluído'),
('2024-11-12', 'Concluído'),
('2024-11-13', 'Concluído'),
('2024-11-14', 'Concluído'),
('2024-11-15', 'Concluído'),
('2024-11-16', 'Concluído'),
('2024-11-17', 'Concluído'),
('2024-11-18', 'Concluído'),
('2024-11-19', 'Concluído'),
('2024-11-20', 'Concluído'),
('2024-11-21', 'Concluído'),
('2024-11-22', 'Concluído'),
('2024-11-23', 'Concluído'),
('2024-11-24', 'Concluído'),
('2024-11-25', 'Concluído'),
('2024-11-26', 'Concluído'),
('2024-11-27', 'Concluído'),
('2024-11-28', 'Concluído'),
('2024-11-29', 'Concluído'),
('2024-11-30', 'Concluído'),
('2024-12-01', 'Concluído'),
('2024-12-02', 'Concluído'),
('2024-12-03', 'Concluído'),
('2024-12-04', 'Concluído'),
('2024-12-05', 'Concluído'),
('2024-12-06', 'Concluído'),
('2024-12-07', 'Concluído'),
('2024-12-08', 'Concluído'),
('2024-12-09', 'Concluído'),
('2024-12-10', 'Concluído'),
('2024-12-11', 'Concluído'),
('2024-12-11', 'Concluído');

SELECT * FROM tb_pedidos;

-- Pagamentos
INSERT INTO tb_pagamentos (valor, data_pagamento) VALUES
(100.50, '2022-12-01'),
(200.75, '2022-12-01'),
(150.00, '2022-12-02'),
(80.00, '2022-12-02'),
(120.25, '2022-12-03'),
(75.00, '2022-12-03'),
(90.50, '2022-12-04'),
(110.75, '2022-12-04'),
(130.00, '2022-12-05'),
(115.00, '2022-12-05'),
(95.25, '2022-12-06'),
(85.00, '2022-12-06'),
(105.50, '2022-12-07'),
(140.75, '2022-12-07'),
(100.00, '2022-12-08'),
(70.00, '2022-12-08'),
(125.25, '2022-12-09'),
(95.00, '2022-12-09'),
(75.50, '2022-12-10'),
(130.75, '2022-12-10'),
(90.00, '2022-12-11'),
(120.00, '2022-12-11'),
(100.50, '2022-12-12'),
(150.75, '2022-12-12'),
(85.00, '2022-12-13'),
(110.00, '2022-12-13'),
(105.25, '2022-12-14'),
(95.00, '2022-12-14'),
(80.50, '2022-12-15'),
(125.75, '2022-12-15'),
(135.00, '2022-12-16'),
(95.00, '2022-12-16'),
(85.25, '2022-12-17'),
(115.00, '2022-12-17'),
(105.50, '2022-12-18'),
(120.75, '2022-12-18'),
(100.00, '2022-12-19'),
(150.75, '2023-01-01'),
(200.00, '2023-01-01'),
(175.25, '2023-01-02'),
(180.50, '2023-01-02'),
(165.00, '2023-01-03'),
(190.75, '2023-01-03'),
(210.00, '2023-01-04'),
(220.50, '2023-01-04'),
(155.00, '2023-01-05'),
(180.25, '2023-01-05'),
(195.00, '2023-01-06'),
(200.75, '2023-01-06'),
(175.00, '2023-01-07'),
(190.50, '2023-01-07'),
(185.25, '2023-01-08'),
(170.00, '2023-01-08'),
(210.75, '2023-01-09'),
(220.00, '2023-01-09'),
(175.25, '2023-01-10'),
(185.50, '2023-01-10'),
(190.00, '2023-01-11'),
(215.75, '2023-01-11'),
(225.00, '2023-01-12'),
(235.50, '2023-01-12'),
(200.25, '2023-01-13'),
(210.00, '2023-01-13'),
(195.75, '2023-01-14'),
(220.50, '2023-01-14'),
(225.00, '2023-01-15'),
(205.75, '2023-01-15'),
(200.00, '2023-01-16'),
(215.25, '2023-01-16'),
(230.50, '2023-01-17'),
(245.00, '2023-01-17'),
(220.75, '2023-01-18'),
(205.00, '2023-01-18'),
(215.25, '2023-01-19'),
(230.50, '2023-01-19'),
(225.00, '2023-01-20'),
(240.75, '2023-01-20'),
(210.00, '2023-01-21'),
(220.50, '2023-01-21'),
(205.25, '2023-01-22'),
(150.50, '2023-02-01'),
(165.75, '2023-02-01'),
(180.00, '2023-02-02'),
(190.25, '2023-02-02'),
(175.50, '2023-02-03'),
(160.75, '2023-02-03'),
(185.00, '2023-02-04'),
(170.25, '2023-02-04'),
(195.50, '2023-02-05'),
(180.75, '2023-02-05'),
(165.00, '2023-02-06'),
(175.25, '2023-02-06'),
(185.50, '2023-02-07'),
(195.75, '2023-02-07'),
(170.00, '2023-02-08'),
(180.25, '2023-02-08'),
(190.50, '2023-02-09'),
(200.75, '2023-02-09'),
(175.00, '2023-02-10'),
(185.25, '2023-02-10'),
(165.50, '2023-02-11'),
(155.75, '2023-02-11'),
(170.00, '2023-02-12'),
(160.25, '2023-02-12'),
(180.50, '2023-02-13'),
(175.75, '2023-02-13'),
(190.00, '2023-02-14'),
(185.25, '2023-02-14'),
(195.50, '2023-02-15'),
(185.75, '2023-02-15'),
(180.00, '2023-02-16'),
(150.00, '2023-03-01'),
(175.00, '2023-03-02'),
(160.00, '2023-03-03'),
(185.00, '2023-03-04'),
(170.00, '2023-03-05'),
(180.00, '2023-03-06'),
(155.00, '2023-03-07'),
(165.00, '2023-03-08'),
(175.00, '2023-03-09'),
(190.00, '2023-03-10'),
(160.00, '2023-04-01'),
(185.00, '2023-04-02'),
(175.00, '2023-04-03'),
(170.00, '2023-04-04'),
(165.00, '2023-04-05'),
(180.00, '2023-04-06'),
(155.00, '2023-04-07'),
(175.00, '2023-04-08'),
(190.00, '2023-04-09'),
(160.00, '2023-04-10'),
(175.00, '2023-05-01'),
(170.00, '2023-05-02'),
(160.00, '2023-05-03'),
(185.00, '2023-05-04'),
(180.00, '2023-05-05'),
(165.00, '2023-05-06'),
(155.00, '2023-05-07'),
(175.00, '2023-05-08'),
(170.00, '2023-05-09'),
(190.00, '2023-05-10'),
(160.00, '2023-06-01'),
(175.00, '2023-06-02'),
(170.00, '2023-06-03'),
(185.00, '2023-06-04'),
(165.00, '2023-06-05'),
(180.00, '2023-06-06'),
(155.00, '2023-06-07'),
(175.00, '2023-06-08'),
(190.00, '2023-06-09'),
(160.00, '2023-06-10'),
(175.00, '2023-06-11'),
(170.00, '2023-06-12'),
(185.00, '2023-06-13'),
(165.00, '2023-06-14'),
(170.00, '2023-07-01'),
(175.50, '2023-07-05'),
(160.25, '2023-07-10'),
(180.75, '2023-07-15'),
(165.50, '2023-07-20'),
(175.00, '2023-07-25'),
(155.75, '2023-07-30'),
(160.00, '2023-08-01'),
(180.25, '2023-08-05'),
(175.50, '2023-08-10'),
(170.00, '2023-08-15'),
(185.75, '2023-08-20'),
(165.25, '2023-08-25'),
(155.50, '2023-08-30'),
(160.00, '2023-09-01'),
(175.25, '2023-09-05'),
(185.50, '2023-09-10'),
(170.75, '2023-09-15'),
(165.00, '2023-09-20'),
(175.50, '2023-09-25'),
(155.25, '2023-09-30'),
(160.00, '2023-10-01'),
(180.50, '2023-10-05'),
(175.75, '2023-10-10'),
(170.00, '2023-10-15'),
(165.50, '2023-10-20'),
(175.25, '2023-10-25'),
(155.50, '2023-10-30'),
(160.00, '2023-11-01'),
(180.75, '2023-11-05'),
(175.50, '2023-11-10'),
(170.25, '2023-11-15'),
(165.00, '2023-11-20'),
(175.50, '2023-11-25'),
(155.75, '2023-11-30'),
(160.00, '2023-12-01'),
(175.25, '2023-12-05'),
(160.50, '2024-01-01'),
(170.75, '2024-01-02'),
(180.00, '2024-01-03'),
(190.25, '2024-01-04'),
(175.50, '2024-01-05'),
(165.75, '2024-01-06'),
(180.00, '2024-01-07'),
(170.25, '2024-01-08'),
(185.50, '2024-01-09'),
(175.75, '2024-01-10'),
(165.00, '2024-01-11'),
(155.25, '2024-01-12'),
(170.50, '2024-01-13'),
(160.75, '2024-01-14'),
(180.00, '2024-01-15'),
(170.25, '2024-01-16'),
(175.50, '2024-01-17'),
(165.75, '2024-01-18'),
(155.00, '2024-01-19'),
(175.25, '2024-01-20'),
(160.00, '2024-02-01'),
(170.25, '2024-02-02'),
(180.50, '2024-02-03'),
(175.75, '2024-02-04'),
(165.00, '2024-02-05'),
(155.25, '2024-02-06'),
(170.50, '2024-02-07'),
(160.75, '2024-02-08'),
(180.00, '2024-02-09'),
(170.25, '2024-02-10'),
(165.50, '2024-03-01'),
(175.75, '2024-03-02'),
(185.00, '2024-03-03'),
(175.25, '2024-03-04'),
(160.00, '2024-03-05'),
(170.25, '2024-03-06'),
(180.50, '2024-03-07'),
(165.75, '2024-03-08'),
(175.00, '2024-03-09'),
(165.25, '2024-03-10'),
(155.50, '2024-04-01'),
(170.75, '2024-04-02'),
(180.00, '2024-04-03'),
(165.25, '2024-04-04'),
(175.50, '2024-04-05'),
(165.75, '2024-04-06'),
(155.00, '2024-04-07'),
(175.25, '2024-04-08'),
(160.50, '2024-04-09'),
(170.75, '2024-04-10'),
(165.00, '2024-05-01'),
(175.25, '2024-05-02'),
(185.50, '2024-05-03'),
(175.75, '2024-05-04'),
(160.00, '2024-05-05'),
(170.25, '2024-05-06'),
(180.50, '2024-05-07'),
(165.75, '2024-05-08'),
(175.00, '2024-05-09'),
(165.25, '2024-05-10'),
(155.50, '2024-06-01'),
(170.75, '2024-06-02'),
(180.00, '2024-06-03'),
(165.25, '2024-06-04'),
(175.50, '2024-06-05'),
(165.75, '2024-06-06'),
(155.00, '2024-06-07'),
(175.25, '2024-06-08'),
(160.50, '2024-06-09'),
(170.75, '2024-06-10'),
(180.00, '2024-06-11'),
(165.25, '2024-06-12'),
(175.50, '2024-06-13'),
(165.75, '2024-06-14'),
(155.00, '2024-06-15'),
(160.00, '2024-08-01'),
(175.25, '2024-08-05'),
(165.50, '2024-08-10'),
(180.75, '2024-08-15'),
(170.00, '2024-08-20'),
(160.25, '2024-08-25'),
(175.50, '2024-08-30'),
(165.75, '2024-08-31'),
(160.00, '2024-09-01'),
(175.25, '2024-09-05'),
(165.50, '2024-09-10'),
(180.75, '2024-09-15'),
(170.00, '2024-09-20'),
(160.25, '2024-09-25'),
(175.50, '2024-09-30'),
(165.75, '2024-10-01'),
(175.00, '2024-10-05'),
(160.25, '2024-10-10'),
(170.50, '2024-10-15'),
(165.75, '2024-10-20'),
(175.00, '2024-10-25'),
(160.25, '2024-10-30'),
(170.50, '2024-10-31'),
(165.00, '2024-11-01'),
(175.25, '2024-11-02'),
(185.50, '2024-11-03'),
(175.75, '2024-11-04'),
(160.00, '2024-11-05'),
(170.25, '2024-11-06'),
(180.50, '2024-11-07'),
(165.75, '2024-11-08'),
(175.00, '2024-11-09'),
(165.25, '2024-11-10'),
(155.50, '2024-11-11'),
(170.75, '2024-11-12'),
(180.00, '2024-11-13'),
(165.25, '2024-11-14'),
(175.50, '2024-11-15'),
(165.75, '2024-11-16'),
(155.00, '2024-11-17'),
(175.25, '2024-11-18'),
(160.50, '2024-11-19'),
(170.75, '2024-11-20'),
(165.00, '2024-11-21'),
(175.25, '2024-11-22'),
(185.50, '2024-11-23'),
(175.75, '2024-11-24'),
(160.00, '2024-11-25'),
(170.25, '2024-11-26'),
(180.50, '2024-11-27'),
(165.75, '2024-11-28'),
(175.00, '2024-11-29'),
(165.25, '2024-11-30'),
(155.50, '2024-12-01'),
(170.75, '2024-12-02'),
(180.00, '2024-12-03'),
(165.25, '2024-12-04'),
(175.50, '2024-12-05'),
(165.75, '2024-12-06'),
(155.00, '2024-12-07'),
(175.25, '2024-12-08'),
(160.50, '2024-12-09'),
(170.75, '2024-12-10'),
(180.00, '2024-12-11');

SELECT * FROM tb_pagamentos;
-- Mesas
INSERT INTO tb_mesas (capacidade, localizacao) VALUES
(4, 'Próximo à Janela'),
(2, 'Centro do Salão'),
(6, 'Área Externa'),
(4, 'Próximo à Cozinha'),
(2, 'Centro do Salão'),
(4, 'Próximo à Entrada'),
(6, 'Área Externa'),
(4, 'Centro do Salão'),
(2, 'Próximo ao Bar'),
(6, 'Área Externa'),
(4, 'Próximo à Janela'),
(2, 'Centro do Salão'),
(4, 'Próximo à Cozinha'),
(6, 'Área Externa'),
(4, 'Próximo à Entrada'),
(2, 'Centro do Salão'),
(4, 'Próximo ao Bar'),
(6, 'Área Externa'),
(4, 'Próximo à Janela'),
(2, 'Centro do Salão'),
(4, 'Próximo à Cozinha'),
(6, 'Área Externa'),
(4, 'Próximo à Entrada'),
(2, 'Centro do Salão'),
(4, 'Próximo ao Bar'),
(6, 'Área Externa'),
(4, 'Próximo à Janela'),
(2, 'Centro do Salão'),
(4, 'Próximo à Cozinha'),
(6, 'Área Externa'),
(4, 'Próximo à Entrada'),
(2, 'Centro do Salão'),
(4, 'Próximo ao Bar'),
(6, 'Área Externa'),
(4, 'Próximo à Janela'),
(2, 'Centro do Salão'),
(4, 'Próximo à Cozinha'),
(6, 'Área Externa');

SELECT * FROM tb_mesas;

-- Menu
INSERT INTO tb_menu (nome, descricao, preco) VALUES
('Pizza Margherita', 'Pizza com molho de tomate, mussarela e manjericão.', 25.00),
('Hambúrguer Clássico', 'Hambúrguer de carne bovina com alface, tomate e queijo.', 18.50),
('Salada Caesar', 'Salada com alface, croutons, parmesão e molho Caesar.', 20.00),
('Sopa de Legumes', 'Sopa feita com uma variedade de legumes frescos.', 15.00),
('Frango à Parmegiana', 'Peito de frango empanado com molho de tomate e queijo.', 30.00),
('Peixe Grelhado', 'Peixe grelhado com legumes ao vapor.', 28.50),
('Macarrão à Bolonhesa', 'Macarrão com molho de carne e tomate.', 22.00),
('Risoto de Cogumelos', 'Risoto cremoso com cogumelos frescos.', 26.50),
('Torta de Maçã', 'Sobremesa clássica de torta de maçã.', 12.00),
('Mousse de Chocolate', 'Mousse de chocolate cremoso.', 10.50),
('Café Expresso', 'Café expresso quente.', 5.00),
('Suco de Laranja', 'Suco de laranja fresco.', 7.00),
('Bife Acebolado', 'Bife grelhado com cebolas caramelizadas.', 29.00),
('Lasanha de Carne', 'Lasanha com camadas de massa, carne moída e molho de tomate.', 32.00),
('Omelete de Queijo', 'Omelete com queijo e ervas frescas.', 16.00),
('Sorvete de Baunilha', 'Sorvete de baunilha com calda de chocolate.', 8.50),
('Camarão à Provençal', 'Camarão grelhado com alho e ervas.', 35.00),
('Pão de Alho', 'Pão de alho assado.', 6.00),
('Batata Frita', 'Porção de batatas fritas crocantes.', 10.00),
('Filé Mignon', 'Filé mignon grelhado com molho de pimenta.', 40.00),
('Salada de Frutas', 'Mix de frutas frescas da estação.', 12.00),
('Sushi Variado', 'Seleção de sushi com diferentes tipos de peixe.', 45.00),
('Wrap de Frango', 'Wrap com frango grelhado, alface e molho.', 18.00),
('Brownie de Chocolate', 'Brownie de chocolate com nozes.', 9.50),
('Panqueca de Morango', 'Panqueca com morangos frescos e chantilly.', 14.00),
('Cerveja Artesanal', 'Cerveja artesanal local.', 12.00),
('Limonada', 'Limonada fresca.', 7.50),
('Costela Assada', 'Costela de porco assada ao molho barbecue.', 38.00),
('Espaguete ao Alho e Óleo', 'Espaguete com alho, azeite e pimenta.', 20.50),
('Salada Caprese', 'Salada com tomate, mussarela de búfala e manjericão.', 22.00),
('Petit Gâteau', 'Bolo de chocolate com sorvete de baunilha.', 13.50),
('Espeto de Carne', 'Espeto de carne com pimentões e cebolas.', 17.00),
('Bolo de Cenoura', 'Bolo de cenoura com cobertura de chocolate.', 10.00),
('Cachorro-Quente', 'Pão com salsicha, molho, queijo e batata palha.', 15.00),
('Caldo Verde', 'Sopa de couve com linguiça e batata.', 18.00),
('Tábua de Frios', 'Seleção de queijos e embutidos.', 34.00),
('Crepe de Queijo e Presunto', 'Crepe recheado com queijo e presunto.', 16.50),
('Tapioca de Coco', 'Tapioca recheada com coco ralado e leite condensado.', 12.50);

SELECT * FROM tb_menu;

-- Detalhe dos pedidos
INSERT INTO tb_detalhes_pedido (id_pedido, id_item, quantidade, preco_unitario) VALUES
(1, 1, 2, 25.00),
(1, 3, 1, 20.00),
(2, 2, 1, 18.50),
(2, 4, 1, 15.00),
(3, 5, 1, 30.00),
(3, 6, 1, 28.50),
(4, 7, 1, 22.00),
(4, 8, 1, 26.50),
(5, 9, 1, 12.00),
(5, 10, 1, 10.50),
(6, 11, 2, 5.00),
(6, 12, 2, 7.00),
(7, 13, 1, 29.00),
(7, 14, 1, 32.00),
(8, 15, 1, 16.00),
(8, 16, 1, 8.50),
(9, 17, 1, 35.00),
(9, 18, 1, 6.00),
(10, 19, 2, 10.00),
(10, 20, 1, 40.00),
(11, 21, 1, 12.00),
(11, 22, 1, 45.00),
(12, 23, 1, 18.00),
(12, 24, 1, 9.50),
(13, 25, 1, 14.00),
(13, 26, 1, 12.00),
(14, 27, 1, 7.50),
(14, 28, 1, 38.00),
(15, 29, 1, 20.50),
(15, 30, 1, 22.00),
(16, 31, 1, 13.50),
(16, 32, 1, 17.00),
(17, 33, 1, 10.00),
(17, 34, 1, 15.00),
(18, 35, 1, 18.00),
(18, 36, 1, 34.00),
(19, 37, 1, 16.50),
(19, 38, 1, 12.50);

SELECT * FROM tb_detalhes_pedido;

-- Cliente e a forma de pagamento
INSERT INTO tb_cliente_forma_pgto (id_cliente, id_forma_pagamento) VALUES
(1, 1),
(1, 2),
(2, 3),
(2, 4),
(3, 1),
(3, 5),
(4, 2),
(4, 6),
(5, 3),
(5, 1),
(6, 4),
(6, 2),
(7, 5),
(7, 3),
(8, 6),
(8, 4),
(9, 1),
(9, 5),
(10, 2),
(10, 6),
(11, 3),
(11, 1),
(12, 4),
(12, 2),
(13, 5),
(13, 3),
(14, 6),
(14, 4),
(15, 1),
(15, 5),
(16, 2),
(16, 6),
(17, 3),
(17, 1),
(18, 4),
(18, 2),
(19, 5),
(19, 3),
(20, 6),
(20, 4),
(21, 1),
(21, 2),
(22, 3),
(22, 4),
(23, 1),
(23, 5),
(24, 2),
(24, 6),
(25, 3),
(25, 1),
(26, 4),
(26, 2),
(27, 5),
(27, 3),
(28, 6),
(28, 4),
(29, 1),
(29, 5),
(30, 2),
(30, 6),
(31, 3),
(31, 1),
(32, 4),
(32, 2),
(33, 5),
(33, 3),
(34, 6),
(34, 4),
(35, 1),
(35, 2);

SELECT * FROM tb_cliente_forma_pgto;

-- Funcionário e pedido
INSERT INTO tb_funcionario_pedido (id_funcionario, id_pedido) VALUES
(1, 1),
(2, 2),
(3, 3),
(4, 4),
(5, 5),
(6, 6),
(7, 7),
(8, 8),
(9, 9),
(10, 10),
(11, 11),
(12, 12),
(13, 13),
(14, 14),
(15, 15),
(16, 16),
(17, 17),
(18, 18),
(19, 19),
(20, 20),
(21, 21),
(22, 22),
(23, 23),
(24, 24),
(25, 25),
(26, 26),
(1, 27),
(2, 28),
(3, 29),
(4, 30),
(5, 31),
(6, 32),
(7, 33),
(8, 34),
(9, 35),
(10, 36),
(11, 37),
(12, 38),
(13, 39),
(14, 40),
(15, 41),
(16, 42),
(17, 43),
(18, 44),
(19, 45),
(20, 46),
(21, 47),
(22, 48),
(23, 49),
(24, 50),
(25, 51),
(26, 52),
(1, 53),
(2, 54),
(3, 55),
(4, 56),
(5, 57),
(6, 58),
(7, 59),
(8, 60),
(9, 61),
(10, 62),
(11, 63),
(12, 64),
(13, 65),
(14, 66),
(15, 67),
(16, 68),
(17, 69),
(18, 70),
(19, 71),
(20, 72),
(21, 73),
(22, 74),
(23, 75),
(24, 76),
(25, 77),
(26, 78),
(1, 79),
(2, 80),
(3, 81),
(4, 82),
(5, 83),
(6, 84),
(7, 85),
(8, 86),
(9, 87),
(10, 88),
(11, 89),
(12, 90),
(13, 91),
(14, 92),
(15, 93),
(16, 94),
(17, 95),
(18, 96),
(19, 97),
(20, 98),
(21, 99),
(22, 100),
(23, 101),
(24, 102),
(25, 103),
(26, 104),
(1, 105),
(2, 106),
(3, 107),
(4, 108),
(5, 109),
(6, 110),
(7, 111),
(8, 112),
(9, 113),
(10, 114),
(11, 115),
(12, 116),
(13, 117),
(14, 118),
(15, 119),
(16, 120),
(17, 121),
(18, 122),
(19, 123),
(20, 124),
(21, 125),
(22, 126),
(23, 127),
(24, 128),
(25, 129),
(26, 130);

SELECT * FROM tb_funcionario_pedido;

-- Pagamento e forma de pagamento
INSERT INTO tb_pagamento_forma_pgto (id_pagamento, id_forma_pagamento) VALUES
(1, 1),
(2, 2),
(3, 3),
(4, 4),
(5, 5),
(6, 6),
(7, 1),
(8, 2),
(9, 3),
(10, 4),
(11, 5),
(12, 6),
(13, 1),
(14, 2),
(15, 3),
(16, 4),
(17, 5),
(18, 6),
(19, 1),
(20, 2),
(21, 3),
(22, 4),
(23, 5),
(24, 6),
(25, 1),
(26, 2),
(27, 3),
(28, 4),
(29, 5),
(30, 6),
(31, 1),
(32, 2),
(33, 3),
(34, 4),
(35, 5),
(36, 6),
(37, 1),
(38, 2),
(39, 3),
(40, 4),
(41, 5),
(42, 6),
(43, 1),
(44, 2),
(45, 3),
(46, 4),
(47, 5),
(48, 6),
(49, 1),
(50, 2),
(51, 3),
(52, 4),
(53, 5),
(54, 6),
(55, 1),
(56, 2),
(57, 3),
(58, 4),
(59, 5),
(60, 6),
(61, 1),
(62, 2),
(63, 3),
(64, 4),
(65, 5),
(66, 6),
(67, 1),
(68, 2),
(69, 3),
(70, 4),
(71, 5),
(72, 6),
(73, 1),
(74, 2),
(75, 3),
(76, 4),
(77, 5),
(78, 6),
(79, 1),
(80, 2),
(81, 3),
(82, 4),
(83, 5),
(84, 6),
(85, 1),
(86, 2),
(87, 3),
(88, 4),
(89, 5),
(90, 6),
(91, 1),
(92, 2),
(93, 3),
(94, 4),
(95, 5),
(96, 6),
(97, 1),
(98, 2),
(99, 3),
(100, 4),
(101, 5),
(102, 6),
(103, 1),
(104, 2),
(105, 3),
(106, 4),
(107, 5),
(108, 6),
(109, 1),
(110, 2),
(111, 3),
(112, 4),
(113, 5),
(114, 6),
(115, 1),
(116, 2),
(117, 3),
(118, 4),
(119, 5),
(120, 6),
(121, 1),
(122, 2),
(123, 3),
(124, 4),
(125, 5),
(126, 6),
(127, 1),
(128, 2),
(129, 3),
(130, 4),
(131, 5),
(132, 6),
(133, 1),
(134, 2),
(135, 3),
(136, 4),
(137, 5),
(138, 6),
(139, 1),
(140, 2),
(141, 3),
(142, 4),
(143, 5),
(144, 6),
(145, 1),
(146, 2),
(147, 3),
(148, 4),
(149, 5),
(150, 6);

SELECT * FROM tb_pagamento_forma_pgto;

-- Detalhes do menu
INSERT INTO tb_menu_detalhes (id_item, id_detalhe_pedido) VALUES
(1, 1),
(1, 2),
(2, 3),
(2, 4),
(3, 5),
(3, 6),
(4, 7),
(4, 8),
(5, 9),
(5, 10),
(6, 11),
(6, 12),
(7, 13),
(7, 14),
(8, 15),
(8, 16),
(9, 17),
(9, 18),
(10, 19),
(10, 20),
(11, 21),
(11, 22),
(12, 23),
(12, 24),
(13, 25),
(13, 26),
(14, 27),
(14, 28),
(15, 29),
(15, 30),
(16, 31),
(16, 32),
(17, 33),
(17, 34),
(18, 35),
(18, 36),
(19, 37),
(19, 38);

SELECT * FROM tb_menu_detalhes;

-- VIEW Clientes e suas formas de pagamento
CREATE VIEW vw_clientes_formas_pagamento AS
SELECT c.id_cliente, c.nome, f.forma_pagamento
FROM tb_clientes c
JOIN tb_cliente_forma_pgto cp ON c.id_cliente = cp.id_cliente
JOIN tb_formas_pagamento f ON cp.id_forma_pagamento = f.id_forma_pagamento;

SELECT * FROM vw_clientes_formas_pagamento; -- Esta view mostra todos os clientes e suas formas de pagamento associadas.

-- View detalhes do pedido
CREATE VIEW vw_detalhes_pedidos AS
SELECT p.id_pedido, c.nome AS cliente, m.nome AS item_menu, dp.quantidade, dp.preco_unitario
FROM tb_pedidos p
JOIN tb_detalhes_pedido dp ON p.id_pedido = dp.id_pedido
JOIN tb_clientes c ON p.id_cliente = c.id_cliente
JOIN tb_menu m ON dp.id_item = m.id_item;

DESC tb_pedidos; -- NO FK
DESC tb_clientes; -- NO FK
DESC tb_detalhes_pedido; -- FK (id_pedido, id_item)
DESC tb_menu; -- NO FK

SELECT * FROM vw_detalhes_pedidos; -- Esta view mostra os detalhes dos pedidos, incluindo os clientes e itens do menu.

-- View pagamentos realizados
CREATE VIEW vw_pagamentos_realizados AS
SELECT pg.id_pagamento, pg.valor, pg.data_pagamento, fp.descricao AS forma_pagamento
FROM tb_pagamentos pg
JOIN tb_pagamento_forma_pgto pfp ON pg.id_pagamento = pfp.id_pagamento
JOIN tb_formas_pagamento fp ON pfp.id_forma_pagamento = fp.id_forma_pagamento;

SELECT * FROM vw_pagamentos_realizados; -- Esta view mostra todos os pagamentos realizados e suas formas de pagamento.

-- View adicionar novo cliente
CREATE VIEW vw_pagamentos_realizados AS
SELECT pg.id_pagamento, pg.valor, pg.data_pagamento, fp.descricao AS forma_pagamento
FROM tb_pagamentos pg
JOIN tb_pagamento_forma_pgto pfp ON pg.id_pagamento = pfp.id_pagamento
JOIN tb_formas_pagamento fp ON pfp.id_forma_pagamento = fp.id_forma_pagamento;

SELECT * FROM vw_pagamentos_realizados; -- Este procedimento adiciona um novo cliente ao banco de dados.

-- Procedimento atualizar endereço do funcionário
DELIMITER $$
CREATE PROCEDURE sp_atualizar_endereco_funcionario (
    IN id_funcionario INT,
    IN novo_endereco VARCHAR(255)
)
BEGIN
    UPDATE tb_endereco_funcionario
    SET endereco = novo_endereco
    WHERE id_funcionario = id_funcionario;
END $$
DELIMITER ;

-- Este procedimento atualiza o endereço de um funcionário específico.

-- Procedimento registrar pagamento
DELIMITER $$
CREATE PROCEDURE sp_registrar_pagamento (
    IN valor DECIMAL(10,2),
    IN data_pagamento DATE,
    IN id_forma_pagamento INT
)
BEGIN
    INSERT INTO tb_pagamentos (valor, data_pagamento) VALUES (valor, data_pagamento);
    SET @id_pagamento = LAST_INSERT_ID();
    INSERT INTO tb_pagamento_forma_pgto (id_pagamento, id_forma_pagamento) VALUES (@id_pagamento, id_forma_pagamento);
END $$
DELIMITER ;

-- Este procedimento registra um novo pagamento e associa uma forma de pagamento a ele.

-- Função para calcular o total de pedidos de um cliente
DELIMITER $$
CREATE FUNCTION fn_total_pedidos_cliente (id_cliente INT)
RETURNS DECIMAL(10,2)
DETERMINISTIC
BEGIN
    DECLARE total DECIMAL(10,2);
    SELECT SUM(dp.preco_unitario * dp.quantidade)
    INTO total
    FROM tb_pedidos p
    JOIN tb_detalhes_pedido dp ON p.id_pedido = dp.id_pedido
    WHERE p.id_cliente = id_cliente;
    RETURN total;
END $$
DELIMITER ;

-- Esta função calcula o total de pedidos de um cliente específico.

-- Função para calcular a média de pagamentos
DELIMITER $$
CREATE FUNCTION fn_media_pagamentos ()
RETURNS DECIMAL(10,2)
DETERMINISTIC
BEGIN
    DECLARE media DECIMAL(10,2);
    SELECT AVG(valor)
    INTO media
    FROM tb_pagamentos;
    RETURN media;
END $$
DELIMITER ;

-- Esta função calcula a média dos valores dos pagamentos realizados.

-- View pedidos e funcionários responsáveis
CREATE VIEW vw_pedidos_funcionarios AS
SELECT p.id_pedido, f.nome AS funcionario
FROM tb_pedidos p
JOIN tb_funcionario_pedido fp ON p.id_pedido = fp.id_pedido
JOIN tb_funcionarios f ON fp.id_funcionario = f.id_funcionario;

SELECT * FROM vw_pedidos_funcionarios; -- Esta view mostra todos os pedidos e os funcionários responsáveis por eles.

-- View cardápio completo
CREATE VIEW vw_cardapio_completo AS
SELECT m.nome, m.descricao, m.preco, md.detalhe, md.valor
FROM tb_menu m
LEFT JOIN tb_menu_detalhes md ON m.id_item = md.id_item;

SELECT * FROM vw_cardapio_completo; -- Esta view mostra o cardápio completo com detalhes dos itens.

-- Procedimento adicionar novo pedido
DELIMITER $$
CREATE PROCEDURE sp_adicionar_pedido (
    IN id_cliente INT,
    IN data_pedido DATE
)
BEGIN
    INSERT INTO tb_pedidos (id_cliente, data_pedido, status) VALUES (id_cliente, data_pedido, 'Pendente');
END $$
DELIMITER ;

-- Este procedimento adiciona um novo pedido para um cliente específico.

-- Procedimento atualizar status do pedido
DELIMITER $$
CREATE PROCEDURE sp_atualizar_status_pedido (
    IN id_pedido INT,
    IN novo_status VARCHAR(255)
)
BEGIN
    UPDATE tb_pedidos
    SET status = novo_status
    WHERE id_pedido = id_pedido;
END $$
DELIMITER ;

-- Este procedimento atualiza o status de um pedido específico.

-- Função para calcular o total de itens vendidos
DELIMITER $$
CREATE FUNCTION fn_total_itens_vendidos ()
RETURNS INT
DETERMINISTIC
BEGIN
    DECLARE total INT;
    SELECT SUM(quantidade)
    INTO total
    FROM tb_detalhes_pedido;
    RETURN total;
END $$
DELIMITER ;

-- Esta função calcula o total de itens vendidos.

-- View clientes e seus pedidos
CREATE VIEW vw_clientes_pedidos AS
SELECT c.nome AS cliente, p.id_pedido, p.data_pedido, p.status
FROM tb_clientes c
JOIN tb_pedidos p ON c.id_cliente = p.id_cliente;

SELECT * FROM vw_clientes_pedidos; -- Esta view mostra todos os clientes e seus pedidos.

-- View pagamentos por data
CREATE VIEW vw_pagamentos_por_data AS
SELECT data_pagamento, COUNT(*) AS total_pagamentos, SUM(valor) AS total_valor
FROM tb_pagamentos
GROUP BY data_pagamento;

SELECT * FROM vw_pagamentos_por_data; -- Esta view mostra o total de pagamentos e o valor total por data.
















