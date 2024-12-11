/*
PROJETO FINAL
Banco de Dados de um Restaurante apresentado ao Curso de Administrador de Banco de Dados
do Senai SIG-DF sob orientação do Professor Yor Rio Pardo Felix
*/

-- CRIAÇÃO E SELEÇÃO DO BANCO DE DADOS
CREATE DATABASE db_restaurante;
USE db_restaurante;

-- Tabela 01: endereco_cliente
CREATE TABLE tb_endereco_cliente (
    id_end_cliente INT PRIMARY KEY AUTO_INCREMENT,
    logradouto VARCHAR(225),
    numero VARCHAR(20),
    complemento VARCHAR(225),
    bairro VARCHAR(225),
    cidade VARCHAR(225),
    estado VARCHAR(225),
    cep VARCHAR(10)
);

-- Tabela 02: tipo_cliente
CREATE TABLE tb_tipo_cliente (
    id_tipo_cliente INT PRIMARY KEY AUTO_INCREMENT,
    descricao VARCHAR(50),
    tipo_documento VARCHAR(20)
);

-- Tabela 03: cliente
CREATE TABLE tb_cliente (
    id_cliente INT PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(225),
    email VARCHAR(125),
    telefone VARCHAR(20),
    id_tipo_cliente INT,
    documento VARCHAR(14),
    id_end_cliente INT,
    FOREIGN KEY (id_tipo_cliente) REFERENCES tb_tipo_cliente(id_tipo_cliente),
    FOREIGN KEY (id_end_cliente) REFERENCES tb_endereco_cliente(id_end_cliente),
    CONSTRAINT chk_documento CHECK (
        (id_tipo_cliente = 1 AND LENGTH(documento) = 11) OR
        (id_tipo_cliente = 2 AND LENGTH(documento) = 14)
    )
);

-- Tabela 04: funcionarios
CREATE TABLE tb_funcionarios (
    id_funcionario INT PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(255),
    email VARCHAR(255),
    telefone VARCHAR(20),
    funcao VARCHAR(50),
    data_admissao DATE,
    salario DECIMAL(10,2)
);

-- Tabela 05: menu
CREATE TABLE tb_menu (
    id_item INT PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(255),
    descricao TEXT,
    preco DECIMAL(10,2),
    categoria VARCHAR(50)
);

-- Tabela tb_mesas
CREATE TABLE tb_mesas (
    id_mesa INT PRIMARY KEY AUTO_INCREMENT,
    numero INT,
    capacidade INT
);

-- Tabela tb_pedido
CREATE TABLE tb_pedido (
    id_pedido INT PRIMARY KEY AUTO_INCREMENT,
    data DATETIME,
    descricao TEXT,
    id_cliente INT,
    id_mesa INT,
    FOREIGN KEY (id_cliente) REFERENCES tb_cliente(id_cliente),
    FOREIGN KEY (id_mesa) REFERENCES tb_mesas(id_mesa)
);

-- Tabela tb_pagamentos
CREATE TABLE tb_pagamentos (
    id_pagamento INT PRIMARY KEY AUTO_INCREMENT,
    id_pedido INT,
    id_cliente INT,
    valor DECIMAL(10,2),
    data_pagamento DATETIME,
    forma_pagamento VARCHAR(50),
    FOREIGN KEY (id_pedido) REFERENCES tb_pedido(id_pedido),
    FOREIGN KEY (id_cliente) REFERENCES tb_cliente(id_cliente)
);

-- Tabelas especializadas para formas de pagamento
CREATE TABLE tb_pagamento_cartao_credito (
    id_pagamento INT PRIMARY KEY,
    numero_transacao VARCHAR(255),
    bandeira VARCHAR(50),
    FOREIGN KEY (id_pagamento) REFERENCES tb_pagamentos(id_pagamento)
);

CREATE TABLE tb_pagamento_pix (
    id_pagamento INT PRIMARY KEY,
    chave_pix VARCHAR(255),
    FOREIGN KEY (id_pagamento) REFERENCES tb_pagamentos(id_pagamento)
);

CREATE TABLE tb_pagamento_voucher (
    id_pagamento INT PRIMARY KEY,
    numero_voucher VARCHAR(255),
    FOREIGN KEY (id_pagamento) REFERENCES tb_pagamentos(id_pagamento)
);

CREATE TABLE tb_pagamento_cartao_debito (
    id_pagamento INT PRIMARY KEY,
    numero_transacao VARCHAR(255),
    bandeira VARCHAR(50),
    FOREIGN KEY (id_pagamento) REFERENCES tb_pagamentos(id_pagamento)
);

CREATE TABLE tb_pagamento_vale_refeicao (
    id_pagamento INT PRIMARY KEY,
    numero_voucher VARCHAR(255),
    FOREIGN KEY (id_pagamento) REFERENCES tb_pagamentos(id_pagamento)
);

CREATE TABLE tb_pagamento_dinheiro (
    id_pagamento INT PRIMARY KEY,
    FOREIGN KEY (id_pagamento) REFERENCES tb_pagamentos(id_pagamento)
);

-- Tabela tb_fornecedor
CREATE TABLE tb_fornecedor (
    id_fornecedor INT PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(255),
    contato VARCHAR(255),
    telefone VARCHAR(20),
    email VARCHAR(255),
    endereco TEXT,
    cnpj VARCHAR(14) UNIQUE
);

-- Tabela tb_insumos
CREATE TABLE tb_insumos (
    id_insumo INT PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(255),
    descricao TEXT,
    preco DECIMAL(10,2),
    id_fornecedor INT,
    FOREIGN KEY (id_fornecedor) REFERENCES tb_fornecedor(id_fornecedor)
);

-- Tabela tb_pedido_itens
CREATE TABLE tb_pedido_itens (
    id_pedido INT,
    id_item INT,
    quantidade INT,
    FOREIGN KEY (id_pedido) REFERENCES tb_pedido(id_pedido),
    FOREIGN KEY (id_item) REFERENCES tb_menu(id_item),
    PRIMARY KEY (id_pedido, id_item)
);

-- Tabela relacional tb_funcionario_mesa
CREATE TABLE tb_funcionario_mesa (
    id_funcionario INT,
    id_mesa INT,
    PRIMARY KEY (id_funcionario, id_mesa),
    FOREIGN KEY (id_funcionario) REFERENCES tb_funcionarios(id_funcionario),
    FOREIGN KEY (id_mesa) REFERENCES tb_mesas(id_mesa)
);

-- Tabela relacional tb_funcionario_pedido
CREATE TABLE tb_funcionario_pedido (
    id_funcionario INT,
    id_pedido INT,
    PRIMARY KEY (id_funcionario, id_pedido),
    FOREIGN KEY (id_funcionario) REFERENCES tb_funcionarios(id_funcionario),
    FOREIGN KEY (id_pedido) REFERENCES tb_pedido(id_pedido)
);

-- Tabela relacional tb_menu_insumos
CREATE TABLE tb_menu_insumos (
    id_item INT,
    id_insumo INT,
    quantidade DECIMAL(10,2),
    PRIMARY KEY (id_item, id_insumo),
    FOREIGN KEY (id_item) REFERENCES tb_menu(id_item),
    FOREIGN KEY (id_insumo) REFERENCES tb_insumos(id_insumo)
);

-- Tabelas de pedidos de insumos
CREATE TABLE tb_pedidos_insumos (
    id_pedido_insumo INT PRIMARY KEY AUTO_INCREMENT,
    id_fornecedor INT,
    data_pedido DATE,
    data_entrega DATE,
    status VARCHAR(50),
    FOREIGN KEY (id_fornecedor) REFERENCES tb_fornecedor(id_fornecedor)
);

CREATE TABLE tb_pedidos_insumos_detalhes (
    id_pedido_insumo INT,
    id_insumo INT,
    quantidade DECIMAL(10,2),
    PRIMARY KEY (id_pedido_insumo, id_insumo),
    FOREIGN KEY (id_pedido_insumo) REFERENCES tb_pedidos_insumos(id_pedido_insumo),
    FOREIGN KEY (id_insumo) REFERENCES tb_insumos(id_insumo)
);

-- Populando as tabelas
-- Tipos de cliente
INSERT INTO tb_tipo_cliente (descricao, tipo_documento) VALUES
('Pessoa Física', 'CPF'),
('Pessoa Jurídica', 'CNPJ');

-- Endereço dos clientes:
INSERT INTO tb_endereco_cliente (logradouto, numero, complemento, bairro, cidade, estado, cep) VALUES
('Rua A', '123', 'Apto 101', 'Centro', 'São Paulo', 'SP', '01000-000'),
('Rua B', '456', '', 'Jardins', 'Rio de Janeiro', 'RJ', '02000-000'),
('Rua C', '789', 'Bloco B', 'Bela Vista', 'Belo Horizonte', 'MG', '03000-000'),
('Rua D', '321', 'Casa', 'Moema', 'São Paulo', 'SP', '04000-000'),
('Rua E', '654', '', 'Ipanema', 'Rio de Janeiro', 'RJ', '05000-000'),
('Rua F', '987', 'Apto 202', 'Savassi', 'Belo Horizonte', 'MG', '06000-000'),
('Rua G', '159', '', 'Barra da Tijuca', 'Rio de Janeiro', 'RJ', '07000-000'),
('Avenida H', '321', 'Sala 12', 'Centro', 'Curitiba', 'PR', '80000-000'),
('Rua I', '432', 'Casa', 'Liberdade', 'Salvador', 'BA', '40000-000'),
('Rua J', '543', 'Apto 303', 'Boa Viagem', 'Recife', 'PE', '50000-000'),
('Rua K', '654', '', 'Centro', 'Fortaleza', 'CE', '60000-000'),
('Avenida L', '765', 'Bloco C', 'Asa Sul', 'Brasília', 'DF', '70000-000'),
('Rua M', '876', 'Casa', 'Centro', 'Florianópolis', 'SC', '88000-000'),
('Rua N', '987', 'Apto 404', 'Centro', 'Manaus', 'AM', '69000-000'),
('Avenida O', '198', '', 'Centro', 'Belém', 'PA', '66000-000'),
('Rua P', '219', 'Bloco A', 'Centro', 'Natal', 'RN', '59000-000'),
('Rua Q', '432', '', 'Centro', 'João Pessoa', 'PB', '58000-000'),
('Rua R', '543', 'Apto 505', 'Centro', 'Maceió', 'AL', '57000-000'),
('Rua S', '654', '', 'Centro', 'Aracaju', 'SE', '49000-000'),
('Avenida T', '765', 'Sala 34', 'Centro', 'Campo Grande', 'MS', '79000-000'),
('Rua U', '876', 'Casa', 'Centro', 'Cuiabá', 'MT', '78000-000'),
('Rua V', '987', 'Apto 606', 'Centro', 'Porto Velho', 'RO', '76800-000'),
('Avenida W', '198', '', 'Centro', 'Rio Branco', 'AC', '69900-000'),
('Rua X', '219', 'Bloco B', 'Centro', 'Macapá', 'AP', '68900-000'),
('Rua Y', '432', '', 'Centro', 'Palmas', 'TO', '77000-000'),
('Rua Z', '543', 'Apto 707', 'Centro', 'Boa Vista', 'RR', '69300-000'),
('Avenida AA', '654', '', 'Centro', 'São Luís', 'MA', '65000-000'),
('Rua AB', '765', 'Sala 45', 'Centro', 'Teresina', 'PI', '64000-000'),
('Rua AC', '876', 'Casa', 'Centro', 'Vitória', 'ES', '29000-000'),
('Rua AD', '987', 'Apto 808', 'Centro', 'Goiânia', 'GO', '74000-000');

-- Cadastro dos clientes
INSERT INTO tb_cliente (nome, email, telefone, documento, id_tipo_cliente, id_end_cliente) VALUES
-- Clientes Pessoa Física
('João Silva', 'joao.silva@example.com', '1234567890', '12345678901', 1, 1),
('Maria Souza', 'maria.souza@example.com', '0987654321', '10987654321', 1, 2),
('Carlos Santos', 'carlos.santos@example.com', '1111111111', '11122233344', 1, 3),
('Ana Pereira', 'ana.pereira@example.com', '2222222222', '22233344455', 1, 4),
('Pedro Lima', 'pedro.lima@example.com', '3333333333', '33344455566', 1, 5),
('Paula Dias', 'paula.dias@example.com', '4444444444', '44455566677', 1, 6),
('Ricardo Almeida', 'ricardo.almeida@example.com', '5555555555', '55566677788', 1, 7),
('Fernanda Costa', 'fernanda.costa@example.com', '6666666666', '66677788899', 1, 8),
('Gabriel Rocha', 'gabriel.rocha@example.com', '7777777777', '77788899900', 1, 9),
('Juliana Martins', 'juliana.martins@example.com', '8888888888', '88899900011', 1, 10),
('Bruno Oliveira', 'bruno.oliveira@example.com', '9999999999', '99900011122', 1, 11),
('Tatiana Borges', 'tatiana.borges@example.com', '1010101010', '00011122233', 1, 12),
('Marcos Santos', 'marcos.santos@example.com', '1111111112', '11122233344', 1, 13),
('Larissa Costa', 'larissa.costa@example.com', '1212121212', '22233344455', 1, 14),
('Thiago Mendes', 'thiago.mendes@example.com', '1313131313', '33344455566', 1, 15),
-- Clientes Pessoa Jurídica
('Empresa ABC Ltda.', 'contato@abc.com', '2112345678', '12345678000199', 2, 16),
('Restaurante Delícia', 'contato@delicia.com', '3112345678', '22345678000188', 2, 17),
('Supermercado Extra', 'contato@extra.com', '4112345678', '32345678000177', 2, 18),
('Construtora Beta', 'contato@beta.com', '5112345678', '42345678000166', 2, 19),
('Editora Gama', 'contato@gama.com', '6112345678', '52345678000155', 2, 20),
('Transportadora Delta', 'contato@delta.com', '7112345678', '62345678000144', 2, 21),
('Tecnologia Epsilon', 'contato@epsilon.com', '8112345678', '72345678000133', 2, 22),
('Clínica Zeta', 'contato@zeta.com', '9112345678', '82345678000122', 2, 23),
('Consultoria Eta', 'contato@eta.com', '10112345678', '92345678000111', 2, 24),
('Laboratório Theta', 'contato@theta.com', '11112345678', '02345678000100', 2, 25),
('Papelaria Iota', 'contato@iota.com', '12112345678', '12345678000299', 2, 26),
('Farmácia Kappa', 'contato@kappa.com', '13112345678', '22345678000288', 2, 27),
('Academia Lambda', 'contato@lambda.com', '14112345678', '32345678000277', 2, 28),
('Hotel Mu', 'contato@mu.com', '15112345678', '42345678000266', 2, 29),
('Loja Nu', 'contato@nu.com', '16112345678', '52345678000255', 2, 30);

SELECT * FROM tb_tipo_cliente;
SELECT * FROM tb_endereco_cliente;
SELECT * FROM tb_cliente;

-- Funcionários
INSERT INTO tb_funcionarios (nome, email, telefone, funcao, data_admissao, salario) VALUES
('Carlos Pereira', 'carlos.pereira@example.com', '1111111111', 'Gerente', '2021-01-10', 5000.00),
('Ana Souza', 'ana.souza@example.com', '2222222222', 'Garçom', '2020-02-15', 2000.00),
('João Oliveira', 'joao.oliveira@example.com', '3333333333', 'Garçom', '2019-03-20', 2000.00),
('Maria Silva', 'maria.silva@example.com', '4444444444', 'Cozinheiro', '2018-04-25', 3000.00),
('Pedro Santos', 'pedro.santos@example.com', '5555555555', 'Auxiliar de Cozinha', '2017-05-30', 1500.00),
('Fernanda Almeida', 'fernanda.almeida@example.com', '6666666666', 'Maître', '2016-06-05', 3500.00),
('Lucas Lima', 'lucas.lima@example.com', '7777777777', 'Garçom', '2015-07-10', 2000.00),
('Juliana Costa', 'juliana.costa@example.com', '8888888888', 'Garçom', '2014-08-15', 2000.00),
('Ricardo Mendes', 'ricardo.mendes@example.com', '9999999999', 'Cozinheiro', '2013-09-20', 3000.00),
('Tatiana Rocha', 'tatiana.rocha@example.com', '1010101010', 'Auxiliar de Cozinha', '2012-10-25', 1500.00),
('Bruno Borges', 'bruno.borges@example.com', '1111111112', 'Gerente', '2011-11-30', 5000.00),
('Larissa Barros', 'larissa.barros@example.com', '1212121212', 'Garçom', '2010-12-05', 2000.00),
('Marcos Dias', 'marcos.dias@example.com', '1313131313', 'Garçom', '2009-01-10', 2000.00),
('Gabriela Azevedo', 'gabriela.azevedo@example.com', '1414141414', 'Cozinheiro', '2008-02-15', 3000.00),
('Thiago Carvalho', 'thiago.carvalho@example.com', '1515151515', 'Auxiliar de Cozinha', '2007-03-20', 1500.00),
('Patrícia Gomes', 'patricia.gomes@example.com', '1616161616', 'Maître', '2006-04-25', 3500.00),
('Rodrigo Farias', 'rodrigo.farias@example.com', '1717171717', 'Garçom', '2005-05-30', 2000.00),
('Aline Ferreira', 'aline.ferreira@example.com', '1818181818', 'Garçom', '2004-06-05', 2000.00),
('Marcelo Correia', 'marcelo.correia@example.com', '1919191919', 'Cozinheiro', '2003-07-10', 3000.00),
('Renata Lopes', 'renata.lopes@example.com', '2020202020', 'Auxiliar de Cozinha', '2002-08-15', 1500.00),
('César Ribeiro', 'cesar.ribeiro@example.com', '2121212121', 'Gerente', '2001-09-20', 5000.00),
('Raquel Nascimento', 'raquel.nascimento@example.com', '2222222222', 'Garçom', '2000-10-25', 2000.00),
('Felipe Cardoso', 'felipe.cardoso@example.com', '2323232323', 'Garçom', '1999-11-30', 2000.00),
('Sabrina Martins', 'sabrina.martins@example.com', '2424242424', 'Cozinheiro', '1998-12-05', 3000.00),
('Eduardo Teixeira', 'eduardo.teixeira@example.com', '2525252525', 'Auxiliar de Cozinha', '1997-01-10', 1500.00);

SELECT * FROM tb_funcionarios;

-- Mesas
INSERT INTO tb_mesas (numero, capacidade) VALUES
(1, 4),
(2, 4),
(3, 4),
(4, 4),
(5, 4),
(6, 4),
(7, 4),
(8, 4),
(9, 4),
(10, 4),
(11, 6),
(12, 6),
(13, 6),
(14, 6),
(15, 6),
(16, 6),
(17, 6),
(18, 6),
(19, 6),
(20, 6),
(21, 2),
(22, 2),
(23, 2),
(24, 2),
(25, 2),
(26, 2),
(27, 2),
(28, 2),
(29, 2),
(30, 2),
(31, 8),
(32, 8),
(33, 8),
(34, 8),
(35, 8);

SELECT * FROM tb_mesas;

-- Menu
INSERT INTO tb_menu (nome, descricao, preco, categoria) VALUES
-- Entradas
('Salada Caprese', 'Salada com tomate, mussarela de búfala e manjericão', 15.00, 'Entrada'),
('Bruschetta', 'Torrada com tomate, alho e azeite de oliva', 12.00, 'Entrada'),
('Sopa de Cebola', 'Sopa clássica de cebola gratinada', 18.00, 'Entrada'),
('Ceviche', 'Peixe marinado no limão com cebola roxa e coentro', 20.00, 'Entrada'),
('Tábua de Frios', 'Seleção de queijos e embutidos', 25.00, 'Entrada'),
('Carpaccio', 'Fatias finas de carne crua com molho de mostarda', 22.00, 'Entrada'),
('Salada Caesar', 'Salada com alface, frango grelhado, croutons e molho Caesar', 18.00, 'Entrada'),
('Creme de Aspargos', 'Sopa cremosa de aspargos frescos', 20.00, 'Entrada'),
('Gaspacho', 'Sopa fria de tomate, pepino e pimentão', 16.00, 'Entrada'),
('Terrine de Foie Gras', 'Terrine de foie gras com geleia de frutas vermelhas', 30.00, 'Entrada'),
('Bolinhos de Queijo', 'Bolinhos de queijo empanados e fritos', 15.00, 'Entrada'),
('Tartare de Salmão', 'Salmão cru temperado com ervas e especiarias', 25.00, 'Entrada'),
('Salada Grega', 'Salada com tomate, pepino, cebola, azeitonas e queijo feta', 17.00, 'Entrada'),
('Salada de Frutas', 'Seleção de frutas frescas da estação', 12.00, 'Entrada'),
('Rolinhos Primavera', 'Rolinhos de vegetais e carne, fritos e crocantes', 14.00, 'Entrada'),
('Patê de Campagne', 'Patê rústico de fígado de porco', 18.00, 'Entrada'),
('Camarão ao Alho', 'Camarões salteados no alho e azeite', 28.00, 'Entrada'),
('Caldo Verde', 'Sopa de couve com linguiça', 15.00, 'Entrada'),
('Pão de Alho', 'Pão recheado com alho e manteiga', 10.00, 'Entrada'),
('Salada de Quinoa', 'Salada de quinoa com legumes', 18.00, 'Entrada'),
('Sashimi de Atum', 'Fatias finas de atum cru', 25.00, 'Entrada'),
('Cocktail de Camarão', 'Camarões com molho cocktail', 20.00, 'Entrada'),
('Polenta Frita', 'Polenta frita crocante', 12.00, 'Entrada'),
('Foccacia', 'Pão italiano com azeite e alecrim', 10.00, 'Entrada'),
('Salada de Grão de Bico', 'Salada de grão de bico com vegetais frescos', 15.00, 'Entrada'),
-- Bebidas
('Coca-Cola', 'Refrigerante de cola', 5.00, 'Bebida'),
('Suco de Laranja', 'Suco de laranja natural', 7.00, 'Bebida'),
('Água Mineral', 'Água mineral sem gás', 3.00, 'Bebida'),
('Água com Gás', 'Água mineral com gás', 4.00, 'Bebida'),
('Chá Gelado', 'Chá gelado com limão', 6.00, 'Bebida'),
('Cerveja', 'Cerveja Pilsen gelada', 8.00, 'Bebida'),
('Vinho Tinto', 'Taça de vinho tinto', 20.00, 'Bebida'),
('Caipirinha', 'Tradicional caipirinha brasileira', 15.00, 'Bebida'),
('Suco de Abacaxi', 'Suco de abacaxi natural', 7.00, 'Bebida'),
('Suco de Melancia', 'Suco de melancia natural', 7.00, 'Bebida'),
('Suco de Manga', 'Suco de manga natural', 7.00, 'Bebida'),
('Refrigerante Guaraná', 'Refrigerante sabor guaraná', 5.00, 'Bebida'),
('Água de Coco', 'Água de coco natural', 6.00, 'Bebida'),
('Limonada', 'Limonada fresca', 6.00, 'Bebida'),
('Espresso', 'Café espresso', 4.00, 'Bebida'),
('Cappuccino', 'Café com leite vaporizado e espuma', 6.00, 'Bebida'),
-- Aperitivos
('Batata Frita', 'Porção de batatas fritas crocantes', 10.00, 'Aperitivo'),
('Onion Rings', 'Anéis de cebola empanados e fritos', 12.00, 'Aperitivo'),
('Bolinho de Bacalhau', 'Bolinho de bacalhau frito', 18.00, 'Aperitivo'),
('Pastel de Carne', 'Pastel recheado com carne moída', 15.00, 'Aperitivo'),
('Azeitonas', 'Porção de azeitonas verdes temperadas', 8.00, 'Aperitivo'),
('Mix de Nuts', 'Porção de castanhas variadas', 12.00, 'Aperitivo'),
('Coxinha de Frango', 'Coxinha de frango empanada e frita', 10.00, 'Aperitivo'),
('Queijo Coalho', 'Espetinho de queijo coalho grelhado', 12.00, 'Aperitivo'),
('Amendoim', 'Porção de amendoins salgados', 8.00, 'Aperitivo'),
('Mini Kibe', 'Mini kibes fritos', 15.00, 'Aperitivo'),
('Calabresa Acebolada', 'Linguiça calabresa acebolada', 18.00, 'Aperitivo'),
('Camarão Empanado', 'Camarões empanados e fritos', 25.00, 'Aperitivo'),
('Provolone à Milanesa', 'Provolone empanado e frito', 20.00, 'Aperitivo'),
('Esfiha de Carne', 'Esfiha aberta de carne', 10.00, 'Aperitivo'),
-- Pratos Principais
('Pizza Margherita', 'Pizza com molho de tomate, mussarela e manjericão', 30.00, 'Prato Principal'),
('Spaghetti à Carbonara', 'Massa com molho de ovo, queijo, bacon e pimenta preta', 28.00, 'Prato Principal'),
('Bife à Parmegiana', 'Bife empanado com molho de tomate e queijo gratinado', 35.00, 'Prato Principal'),
('Risotto de Cogumelos', 'Risoto cremoso de cogumelos variados', 32.00, 'Prato Principal'),
('Frango Grelhado', 'Filé de frango grelhado com legumes', 25.00, 'Prato Principal'),
('Salmão ao Molho de Maracujá', 'Filé de salmão com molho de maracujá', 40.00, 'Prato Principal'),
('Feijoada', 'Prato típico brasileiro com feijão preto e carnes variadas', 45.00, 'Prato Principal'),
('Filé Mignon', 'Filé mignon grelhado com batatas fritas', 45.00, 'Prato Principal'),
('Lasanha à Bolonhesa', 'Lasanha com molho de carne e queijo gratinado', 35.00, 'Prato Principal'),
('Moqueca de Peixe', 'Moqueca de peixe com leite de coco e dendê', 38.00, 'Prato Principal'),
('Estrogonofe de Frango', 'Estrogonofe de frango com arroz e batata palha', 30.00, 'Prato Principal'),
('Ravióli de Ricota', 'Massa recheada com ricota e espinafre', 28.00, 'Prato Principal'),
('Churrasco', 'Carne assada na brasa com acompanhamentos', 50.00, 'Prato Principal'),
('Peixe Grelhado', 'Filé de peixe grelhado com arroz e salada', 35.00, 'Prato Principal'),
('Hambúrguer Artesanal', 'Hambúrguer com queijo, bacon e molho especial', 25.00, 'Prato Principal'),
-- Sobremesas
('Tiramisu', 'Sobremesa italiana com mascarpone e café', 15.00, 'Sobremesa'),
('Petit Gâteau', 'Bolo de chocolate com recheio cremoso e sorvete de baunilha', 18.00, 'Sobremesa'),
('Pudim de Leite', 'Pudim de leite condensado', 12.00, 'Sobremesa'),
('Mousse de Maracujá', 'Mousse de maracujá', 10.00, 'Sobremesa'),
('Torta de Limão', 'Torta com base crocante e recheio de limão', 14.00, 'Sobremesa'),
('Sorvete', 'Bola de sorvete com opção de sabores variados', 8.00, 'Sobremesa'),
('Cheesecake', 'Torta de queijo com calda de frutas vermelhas', 16.00, 'Sobremesa'),
('Brownie', 'Brownie de chocolate com sorvete', 16.00, 'Sobremesa'),
('Sorvete Sundae', 'Sorvete com calda de chocolate e castanhas', 14.00, 'Sobremesa'),
('Frutas da Estação', 'Seleção de frutas frescas', 12.00, 'Sobremesa'),
('Pavê de Chocolate', 'Camadas de creme e chocolate', 15.00, 'Sobremesa'),
('Rabanada', 'Rabanada tradicional com canela', 10.00, 'Sobremesa'),
('Creme Brulee', 'Sobremesa de creme com crosta de açúcar caramelizado', 18.00, 'Sobremesa'),
('Torta Holandesa', 'Torta de biscoito com recheio cremoso e cobertura de chocolate', 20.00, 'Sobremesa'),
('Profiteroles', 'Carolina recheada com creme e coberta com chocolate', 16.00, 'Sobremesa'),
('Torta de Maçã', 'Torta de maçã com massa crocante', 14.00, 'Sobremesa'),
('Manjar de Coco', 'Manjar de coco com calda de ameixa', 12.00, 'Sobremesa'),
('Bolo de Cenoura', 'Bolo de cenoura com cobertura de chocolate', 10.00, 'Sobremesa'),
('Banana Split', 'Banana com sorvete, chantilly e caldas', 18.00, 'Sobremesa'),
('Pudim de Chocolate', 'Pudim de chocolate com calda de chocolate', 15.00, 'Sobremesa'),
('Gelatina Colorida', 'Gelatina de sabores variados', 8.00, 'Sobremesa'),
('Pão de Ló', 'Pão de ló fofinho com creme de confeiteiro', 12.00, 'Sobremesa'),
('Mousse de Chocolate', 'Mousse de chocolate cremoso', 15.00, 'Sobremesa'),
('Mil Folhas', 'Mil folhas com creme de baunilha', 20.00, 'Sobremesa'),
('Churros', 'Churros recheados com doce de leite', 10.00, 'Sobremesa'),
('Quindim', 'Sobremesa de coco com calda de caramelo', 8.00, 'Sobremesa'),
('Baba de Moça', 'Doce de ovos com calda de coco', 12.00, 'Sobremesa'),
-- Adicionais
('Porção de Arroz', 'Porção de arroz branco', 5.00, 'Adicional'),
('Porção de Farofa', 'Porção de farofa temperada', 6.00, 'Adicional'),
('Porção de Feijão', 'Porção de feijão preto', 5.00, 'Adicional'),
('Porção de Legumes', 'Porção de legumes cozidos', 7.00, 'Adicional'),
('Porção de Salada', 'Porção de salada verde', 8.00, 'Adicional'),
('Molho de Pimenta', 'Porção de molho de pimenta caseiro', 3.00, 'Adicional'),
('Porção de Batata Palha', 'Porção de batata palha', 5.00, 'Adicional');

SELECT * FROM tb_menu;

-- Pedidos
INSERT INTO tb_pedido (data, descricao, id_cliente, id_mesa) VALUES
-- Pedidos de 2021 e 2022
('2021-01-05', 'Pedido 1', 1, 1),
('2021-01-12', 'Pedido 2', 2, 2),
('2021-02-03', 'Pedido 3', 3, 3),
('2021-02-20', 'Pedido 4', 4, 4),
('2021-03-15', 'Pedido 5', 5, 5),
('2021-04-10', 'Pedido 6', 6, 6),
('2021-04-22', 'Pedido 7', 7, 7),
('2021-05-05', 'Pedido 8', 8, 8),
('2021-06-01', 'Pedido 9', 9, 9),
('2021-06-14', 'Pedido 10', 10, 10),
('2021-07-08', 'Pedido 11', 11, 11),
('2021-07-22', 'Pedido 12', 12, 12),
('2021-08-05', 'Pedido 13', 13, 13),
('2021-08-19', 'Pedido 14', 14, 14),
('2021-09-01', 'Pedido 15', 15, 15),
('2021-09-15', 'Pedido 16', 16, 16),
('2021-10-03', 'Pedido 17', 17, 17),
('2021-10-20', 'Pedido 18', 18, 18),
('2021-11-01', 'Pedido 19', 19, 19),
('2021-11-18', 'Pedido 20', 20, 20),
('2021-12-02', 'Pedido 21', 21, 21),
('2021-12-15', 'Pedido 22', 22, 22),
('2022-01-05', 'Pedido 23', 23, 23),
('2022-01-22', 'Pedido 24', 24, 24),
('2022-02-10', 'Pedido 25', 25, 25),
('2022-02-25', 'Pedido 26', 26, 26),
('2022-03-08', 'Pedido 27', 27, 27),
('2022-03-22', 'Pedido 28', 28, 28),
('2022-04-03', 'Pedido 29', 29, 29),
('2022-04-20', 'Pedido 30', 30, 30),
('2022-05-01', 'Pedido 31', 1, 1),
('2022-05-15', 'Pedido 32', 2, 2),
('2022-06-01', 'Pedido 33', 3, 3),
('2022-06-18', 'Pedido 34', 4, 4),
('2022-07-01', 'Pedido 35', 5, 5),
('2022-07-14', 'Pedido 36', 6, 6),
('2022-08-05', 'Pedido 37', 7, 7),
('2022-08-20', 'Pedido 38', 8, 8),
('2022-09-02', 'Pedido 39', 9, 9),
('2022-09-19', 'Pedido 40', 10, 10),
('2022-10-01', 'Pedido 41', 11, 11),
('2022-10-18', 'Pedido 42', 12, 12),
('2022-11-03', 'Pedido 43', 13, 13),
('2022-11-20', 'Pedido 44', 14, 14),
('2022-12-02', 'Pedido 45', 15, 15),
('2022-12-15', 'Pedido 46', 16, 16),
('2023-01-05', 'Pedido 47', 17, 17),
('2023-01-22', 'Pedido 48', 18, 18),
-- Pedidos de 2023 e 2024
('2023-02-10', 'Pedido 49', 19, 19),
('2023-02-25', 'Pedido 50', 20, 20),
('2023-03-08', 'Pedido 51', 21, 21),
('2023-03-22', 'Pedido 52', 22, 22),
('2023-04-03', 'Pedido 53', 23, 23),
('2023-04-20', 'Pedido 54', 24, 24),
('2023-05-01', 'Pedido 55', 25, 25),
('2023-05-15', 'Pedido 56', 26, 26),
('2023-06-01', 'Pedido 57', 27, 27),
('2023-06-18', 'Pedido 58', 28, 28),
('2023-07-01', 'Pedido 59', 29, 29),
('2023-07-14', 'Pedido 60', 30, 30),
('2023-08-05', 'Pedido 61', 1, 1),
('2023-08-20', 'Pedido 62', 2, 2),
('2023-09-02', 'Pedido 63', 3, 3),
('2023-09-19', 'Pedido 64', 4, 4),
('2023-10-01', 'Pedido 65', 5, 5),
('2023-10-18', 'Pedido 66', 6, 6),
('2023-11-03', 'Pedido 67', 7, 7),
('2023-11-20', 'Pedido 68', 8, 8),
('2023-12-02', 'Pedido 69', 9, 9),
('2023-12-15', 'Pedido 70', 10, 10),
('2024-01-05', 'Pedido 71', 11, 11),
('2024-01-22', 'Pedido 72', 12, 12),
('2024-02-10', 'Pedido 73', 13, 13),
('2024-02-25', 'Pedido 74', 14, 14),
('2024-03-08', 'Pedido 75', 15, 15),
('2024-03-22', 'Pedido 76', 16, 16),
('2024-04-03', 'Pedido 77', 17, 17),
('2024-04-20', 'Pedido 78', 18, 18),
('2024-05-01', 'Pedido 79', 19, 19),
('2024-05-15', 'Pedido 80', 20, 20),
('2024-06-01', 'Pedido 81', 21, 21),
('2024-06-18', 'Pedido 82', 22, 22),
('2024-07-01', 'Pedido 83', 23, 23),
('2024-07-14', 'Pedido 84', 24, 24),
('2024-08-05', 'Pedido 85', 25, 25),
('2024-08-20', 'Pedido 86', 26, 26),
('2024-09-02', 'Pedido 87', 27, 27),
('2024-09-19', 'Pedido 88', 28, 28),
('2024-10-01', 'Pedido 89', 29, 29),
('2024-10-18', 'Pedido 90', 30, 30),
('2024-11-03', 'Pedido 91', 1, 1),
('2024-11-20', 'Pedido 92', 2, 2),
('2024-12-02', 'Pedido 93', 3, 3),
('2024-12-15', 'Pedido 94', 4, 4),
('2024-12-30', 'Pedido 95', 5, 5),
('2021-11-05', 'Pedido 96', 6, 6),
('2021-12-10', 'Pedido 97', 7, 7),
('2021-12-25', 'Pedido 98', 8, 8),
('2021-11-25', 'Pedido 99', 9, 9),
('2021-12-01', 'Pedido 100', 10, 10),
('2021-12-15', 'Pedido 101', 11, 11),
('2021-12-20', 'Pedido 102', 12, 12),
('2022-01-05', 'Pedido 103', 13, 13),
('2022-01-15', 'Pedido 104', 14, 14),
('2022-01-25', 'Pedido 105', 15, 15),
('2022-02-01', 'Pedido 106', 16, 16),
('2022-02-15', 'Pedido 107', 17, 17),
('2022-02-28', 'Pedido 108', 18, 18),
('2022-03-05', 'Pedido 109', 19, 19),
('2022-03-10', 'Pedido 110', 20, 20),
('2022-03-22', 'Pedido 111', 21, 21),
('2022-04-01', 'Pedido 112', 22, 22),
('2022-04-10', 'Pedido 113', 23, 23),
('2022-04-20', 'Pedido 114', 24, 24),
('2022-05-01', 'Pedido 115', 25, 25),
('2022-05-10', 'Pedido 116', 26, 26),
('2022-05-20', 'Pedido 117', 27, 27),
('2022-06-01', 'Pedido 118', 28, 28),
('2022-06-10', 'Pedido 119', 29, 29),
('2022-06-20', 'Pedido 120', 30, 30),
('2022-07-01', 'Pedido 121', 1, 1),
('2022-07-10', 'Pedido 122', 2, 2),
('2022-07-20', 'Pedido 123', 3, 3),
('2022-08-01', 'Pedido 124', 4, 4),
('2022-08-10', 'Pedido 125', 5, 5),
('2022-08-20', 'Pedido 126', 6, 6),
('2022-09-01', 'Pedido 127', 7, 7),
('2022-09-10', 'Pedido 128', 8, 8),
('2022-09-20', 'Pedido 129', 9, 9),
('2022-10-01', 'Pedido 130', 10, 10),
('2022-10-10', 'Pedido 131', 11, 11),
('2022-10-20', 'Pedido 132', 12, 12),
('2022-11-01', 'Pedido 133', 13, 13),
('2022-11-10', 'Pedido 134', 14, 14),
('2022-11-20', 'Pedido 135', 15, 15),
('2022-12-01', 'Pedido 136', 16, 16),
('2022-12-10', 'Pedido 137', 17, 17),
('2022-12-20', 'Pedido 138', 18, 18),
('2023-01-01', 'Pedido 139', 19, 19),
('2023-01-10', 'Pedido 140', 20, 20),
('2023-01-20', 'Pedido 141', 21, 21),
('2023-02-01', 'Pedido 142', 22, 22),
('2023-02-10', 'Pedido 143', 23, 23),
('2023-02-20', 'Pedido 144', 24, 24),
('2023-03-01', 'Pedido 145', 25, 25),
('2023-03-10', 'Pedido 146', 26, 26),
('2023-03-20', 'Pedido 147', 27, 27),
('2023-04-01', 'Pedido 148', 28, 28),
('2023-04-10', 'Pedido 149', 29, 29),
('2023-04-20', 'Pedido 150', 30, 30),
('2023-05-01', 'Pedido 151', 1, 1),
('2023-05-10', 'Pedido 152', 2, 2),
('2023-05-20', 'Pedido 153', 3, 3),
('2023-06-01', 'Pedido 154', 4, 4),
('2023-06-10', 'Pedido 155', 5, 5),
('2023-06-20', 'Pedido 156', 6, 6),
('2023-07-01', 'Pedido 157', 7, 7),
('2023-07-10', 'Pedido 158', 8, 8),
('2023-07-20', 'Pedido 159', 9, 9),
('2023-08-01', 'Pedido 160', 10, 10),
('2022-01-15', 'Pedido 161', 11, 11),
('2022-02-01', 'Pedido 162', 12, 12),
('2022-02-15', 'Pedido 163', 13, 13),
('2022-03-01', 'Pedido 164', 14, 14),
('2022-03-15', 'Pedido 165', 15, 15),
('2022-04-01', 'Pedido 166', 16, 16),
('2022-04-15', 'Pedido 167', 17, 17),
('2022-05-01', 'Pedido 168', 18, 18),
('2022-05-15', 'Pedido 169', 19, 19),
('2022-06-01', 'Pedido 170', 20, 20),
('2022-06-15', 'Pedido 171', 21, 21),
('2022-07-01', 'Pedido 172', 22, 22),
('2022-07-15', 'Pedido 173', 23, 23),
('2022-08-01', 'Pedido 174', 24, 24),
('2022-08-15', 'Pedido 175', 25, 25),
('2022-09-01', 'Pedido 176', 26, 26),
('2022-09-15', 'Pedido 177', 27, 27),
('2022-10-01', 'Pedido 178', 28, 28),
('2022-10-15', 'Pedido 179', 29, 29),
('2022-11-01', 'Pedido 180', 30, 30),
('2022-11-15', 'Pedido 181', 1, 1),
('2022-12-01', 'Pedido 182', 2, 2),
('2022-12-15', 'Pedido 183', 3, 3),
('2023-01-01', 'Pedido 184', 4, 4),
('2023-01-15', 'Pedido 185', 5, 5),
('2023-02-01', 'Pedido 186', 6, 6),
('2023-02-15', 'Pedido 187', 7, 7),
('2023-03-01', 'Pedido 188', 8, 8),
('2023-03-15', 'Pedido 189', 9, 9),
('2023-04-01', 'Pedido 190', 10, 10),
('2023-04-15', 'Pedido 191', 11, 11),
('2023-05-01', 'Pedido 192', 12, 12),
('2023-05-15', 'Pedido 193', 13, 13),
('2023-06-01', 'Pedido 194', 14, 14),
('2023-06-15', 'Pedido 195', 15, 15),
('2023-07-01', 'Pedido 196', 16, 16),
('2023-07-15', 'Pedido 197', 17, 17),
('2023-08-01', 'Pedido 198', 18, 18),
('2023-08-15', 'Pedido 199', 19, 19),
('2023-09-01', 'Pedido 200', 20, 20),
('2023-09-15', 'Pedido 201', 21, 21),
('2023-10-01', 'Pedido 202', 22, 22),
('2023-10-15', 'Pedido 203', 23, 23),
('2023-11-01', 'Pedido 204', 24, 24),
('2023-11-15', 'Pedido 205', 25, 25),
('2023-12-01', 'Pedido 206', 26, 26),
('2023-12-15', 'Pedido 207', 27, 27),
('2024-01-01', 'Pedido 208', 28, 28),
('2024-01-15', 'Pedido 209', 29, 29),
('2024-02-01', 'Pedido 210', 30, 30),
('2022-02-10', 'Pedido 211', 1, 1),
('2022-02-25', 'Pedido 212', 2, 2),
('2022-03-08', 'Pedido 213', 3, 3),
('2022-03-22', 'Pedido 214', 4, 4),
('2022-04-03', 'Pedido 215', 5, 5),
('2022-04-20', 'Pedido 216', 6, 6),
('2022-05-01', 'Pedido 217', 7, 7),
('2022-05-15', 'Pedido 218', 8, 8),
('2022-06-01', 'Pedido 219', 9, 9),
('2022-06-18', 'Pedido 220', 10, 10),
('2022-07-01', 'Pedido 221', 11, 11),
('2022-07-14', 'Pedido 222', 12, 12),
('2022-08-05', 'Pedido 223', 13, 13),
('2022-08-20', 'Pedido 224', 14, 14),
('2022-09-02', 'Pedido 225', 15, 15),
('2022-09-19', 'Pedido 226', 16, 16),
('2022-10-01', 'Pedido 227', 17, 17),
('2022-10-18', 'Pedido 228', 18, 18),
('2022-11-03', 'Pedido 229', 19, 19),
('2022-11-20', 'Pedido 230', 20, 20),
('2022-12-02', 'Pedido 231', 21, 21),
('2022-12-15', 'Pedido 232', 22, 22),
('2023-01-05', 'Pedido 233', 23, 23),
('2023-01-22', 'Pedido 234', 24, 24),
('2023-02-10', 'Pedido 235', 25, 25),
('2023-02-25', 'Pedido 236', 26, 26),
('2023-03-08', 'Pedido 237', 27, 27),
('2023-03-22', 'Pedido 238', 28, 28),
('2023-04-03', 'Pedido 239', 29, 29),
('2023-04-20', 'Pedido 240', 30, 30),
('2023-05-01', 'Pedido 241', 1, 1),
('2023-05-15', 'Pedido 242', 2, 2),
('2023-06-01', 'Pedido 243', 3, 3),
('2023-06-18', 'Pedido 244', 4, 4),
('2023-07-01', 'Pedido 245', 5, 5),
('2023-07-14', 'Pedido 246', 6, 6),
('2023-08-05', 'Pedido 247', 7, 7),
('2023-08-20', 'Pedido 248', 8, 8),
('2023-09-02', 'Pedido 249', 9, 9),
('2023-09-19', 'Pedido 250', 10, 10),
('2023-10-01', 'Pedido 251', 11, 11),
('2023-10-18', 'Pedido 252', 12, 12),
('2023-11-03', 'Pedido 253', 13, 13),
('2023-11-20', 'Pedido 254', 14, 14),
('2023-12-02', 'Pedido 255', 15, 15),
('2023-12-15', 'Pedido 256', 16, 16),
('2024-01-05', 'Pedido 257', 17, 17),
('2024-01-22', 'Pedido 258', 18, 18),
('2024-02-10', 'Pedido 259', 19, 19),
('2024-02-25', 'Pedido 260', 20, 20),
('2022-01-05', 'Pedido 261', 21, 21),
('2022-01-22', 'Pedido 262', 22, 22),
('2022-02-10', 'Pedido 263', 23, 23),
('2022-02-25', 'Pedido 264', 24, 24),
('2022-03-08', 'Pedido 265', 25, 25),
('2022-03-22', 'Pedido 266', 26, 26),
('2022-04-03', 'Pedido 267', 27, 27),
('2022-04-20', 'Pedido 268', 28, 28),
('2022-05-01', 'Pedido 269', 29, 29),
('2022-05-15', 'Pedido 270', 30, 30),
('2022-06-01', 'Pedido 271', 1, 1),
('2022-06-18', 'Pedido 272', 2, 2),
('2022-07-01', 'Pedido 273', 3, 3),
('2022-07-14', 'Pedido 274', 4, 4),
('2022-08-05', 'Pedido 275', 5, 5),
('2022-08-20', 'Pedido 276', 6, 6),
('2022-09-02', 'Pedido 277', 7, 7),
('2022-09-19', 'Pedido 278', 8, 8),
('2022-10-01', 'Pedido 279', 9, 9),
('2022-10-18', 'Pedido 280', 10, 10),
('2022-11-03', 'Pedido 281', 11, 11),
('2022-11-20', 'Pedido 282', 12, 12),
('2022-12-02', 'Pedido 283', 13, 13),
('2022-12-15', 'Pedido 284', 14, 14),
('2023-01-05', 'Pedido 285', 15, 15),
('2023-01-22', 'Pedido 286', 16, 16),
('2023-02-10', 'Pedido 287', 17, 17),
('2023-02-25', 'Pedido 288', 18, 18),
('2023-03-08', 'Pedido 289', 19, 19),
('2023-03-22', 'Pedido 290', 20, 20),
('2023-04-03', 'Pedido 291', 21, 21),
('2023-04-20', 'Pedido 292', 22, 22),
('2023-05-01', 'Pedido 293', 23, 23),
('2023-05-15', 'Pedido 294', 24, 24),
('2023-06-01', 'Pedido 295', 25, 25),
('2023-06-18', 'Pedido 296', 26, 26),
('2023-07-01', 'Pedido 297', 27, 27),
('2023-07-14', 'Pedido 298', 28, 28),
('2023-08-05', 'Pedido 299', 29, 29),
('2023-08-20', 'Pedido 300', 30, 30),
('2023-09-02', 'Pedido 301', 1, 1),
('2021-02-20', 'Pedido 302', 2, 2),
('2021-03-15', 'Pedido 303', 3, 3),
('2021-04-05', 'Pedido 304', 4, 4),
('2021-05-10', 'Pedido 305', 5, 5),
('2021-06-25', 'Pedido 306', 6, 6),
('2021-07-12', 'Pedido 307', 7, 7),
('2021-08-19', 'Pedido 308', 8, 8),
('2021-09-25', 'Pedido 309', 9, 9),
('2021-10-30', 'Pedido 310', 10, 10),
('2021-11-15', 'Pedido 311', 11, 11),
('2021-12-05', 'Pedido 312', 12, 12),
('2022-01-14', 'Pedido 313', 13, 13),
('2022-02-28', 'Pedido 314', 14, 14),
('2022-03-22', 'Pedido 315', 15, 15),
('2022-04-18', 'Pedido 316', 16, 16),
('2022-05-10', 'Pedido 317', 17, 17),
('2022-06-27', 'Pedido 318', 18, 18),
('2022-07-14', 'Pedido 319', 19, 19),
('2022-08-21', 'Pedido 320', 20, 20),
('2022-09-15', 'Pedido 321', 21, 21),
('2022-10-05', 'Pedido 322', 22, 22),
('2022-11-19', 'Pedido 323', 23, 23),
('2022-12-25', 'Pedido 324', 24, 24),
('2023-01-18', 'Pedido 325', 25, 25),
('2023-02-12', 'Pedido 326', 26, 26),
('2023-03-22', 'Pedido 327', 27, 27),
('2023-04-28', 'Pedido 328', 28, 28),
('2023-05-13', 'Pedido 329', 29, 29),
('2023-06-05', 'Pedido 330', 30, 30),
('2023-07-25', 'Pedido 331', 1, 1),
('2023-08-15', 'Pedido 332', 2, 2),
('2023-09-10', 'Pedido 333', 3, 3),
('2023-10-25', 'Pedido 334', 4, 4),
('2023-11-18', 'Pedido 335', 5, 5),
('2023-12-05', 'Pedido 336', 6, 6),
('2024-01-20', 'Pedido 337', 7, 7),
('2024-02-10', 'Pedido 338', 8, 8),
('2024-03-18', 'Pedido 339', 9, 9),
('2024-04-05', 'Pedido 340', 10, 10),
('2024-05-25', 'Pedido 341', 11, 11),
('2024-06-12', 'Pedido 342', 12, 12),
('2024-07-19', 'Pedido 343', 13, 13),
('2024-08-10', 'Pedido 344', 14, 14),
('2024-09-15', 'Pedido 345', 15, 15),
('2024-10-05', 'Pedido 346', 16, 16),
('2024-11-25', 'Pedido 347', 17, 17),
('2024-12-12', 'Pedido 348', 18, 18),
('2024-12-29', 'Pedido 349', 19, 19),
('2021-11-05', 'Pedido 350', 20, 20),
('2021-12-10', 'Pedido 351', 21, 21);

SELECT * FROM tb_pedido;

-- Fornecedores
INSERT INTO tb_fornecedor (nome, contato, telefone, email, cnpj) VALUES
('Fornecedor A', 'contatoA@example.com', '1111111111', 'a@example.com', '12345678000100'),
('Fornecedor B', 'contatoB@example.com', '2222222222', 'b@example.com', '22345678000100'),
('Fornecedor C', 'contatoC@example.com', '3333333333', 'c@example.com', '32345678000100'),
('Fornecedor D', 'contatoD@example.com', '4444444444', 'd@example.com', '42345678000100'),
('Fornecedor E', 'contatoE@example.com', '5555555555', 'e@example.com', '52345678000100'),
('Fornecedor F', 'contatoF@example.com', '6666666666', 'f@example.com', '62345678000100'),
('Fornecedor G', 'contatoG@example.com', '7777777777', 'g@example.com', '72345678000100'),
('Fornecedor H', 'contatoH@example.com', '8888888888', 'h@example.com', '82345678000100'),
('Fornecedor I', 'contatoI@example.com', '9999999999', 'i@example.com', '92345678000100'),
('Fornecedor J', 'contatoJ@example.com', '1010101010', 'j@example.com', '02345678000100'),
('Fornecedor K', 'contatoK@example.com', '1111111112', 'k@example.com', '12345678000200'),
('Fornecedor L', 'contatoL@example.com', '1212121212', 'l@example.com', '22345678000200'),
('Fornecedor M', 'contatoM@example.com', '1313131313', 'm@example.com', '32345678000200'),
('Fornecedor N', 'contatoN@example.com', '1414141414', 'n@example.com', '42345678000200'),
('Fornecedor O', 'contatoO@example.com', '1515151515', 'o@example.com', '52345678000200'),
('Fornecedor P', 'contatoP@example.com', '1616161616', 'p@example.com', '62345678000200'),
('Fornecedor Q', 'contatoQ@example.com', '1717171717', 'q@example.com', '72345678000200'),
('Fornecedor R', 'contatoR@example.com', '1818181818', 'r@example.com', '82345678000200'),
('Fornecedor S', 'contatoS@example.com', '1919191919', 's@example.com', '92345678000200'),
('Fornecedor T', 'contatoT@example.com', '2020202020', 't@example.com', '02345678000200'),
('Fornecedor U', 'contatoU@example.com', '2121212121', 'u@example.com', '12345678000300'),
('Fornecedor V', 'contatoV@example.com', '2222222222', 'v@example.com', '22345678000300'),
('Fornecedor W', 'contatoW@example.com', '2323232323', 'w@example.com', '32345678000300'),
('Fornecedor X', 'contatoX@example.com', '2424242424', 'x@example.com', '42345678000300'),
('Fornecedor Y', 'contatoY@example.com', '2525252525', 'y@example.com', '52345678000300');

SELECT * FROM tb_fornecedor;

-- Insumos
INSERT INTO tb_insumos (nome, descricao, preco, id_fornecedor) VALUES
('Tomate', 'Tomate fresco', 3.00, 1),
('Alface', 'Alface fresca', 2.00, 2),
('Queijo Mussarela', 'Queijo mussarela fatiado', 15.00, 3),
('Farinha de Trigo', 'Farinha de trigo para panificação', 4.50, 4),
('Azeite de Oliva', 'Azeite de oliva extra virgem', 20.00, 5),
('Carne Moída', 'Carne moída bovina', 25.00, 6),
('Peito de Frango', 'Peito de frango desossado', 12.00, 7),
('Bacalhau', 'Bacalhau dessalgado', 50.00, 8),
('Camarão', 'Camarão fresco', 45.00, 9),
('Arroz', 'Arroz branco', 5.00, 10),
('Feijão', 'Feijão preto', 6.00, 11),
('Farinha de Mandioca', 'Farinha de mandioca', 3.50, 12),
('Pão de Forma', 'Pão de forma integral', 7.00, 13),
('Presunto', 'Presunto fatiado', 10.00, 14),
('Calabresa', 'Linguiça calabresa defumada', 15.00, 15),
('Bacon', 'Bacon em cubos', 20.00, 16),
('Ovo', 'Ovo caipira', 0.50, 17),
('Leite', 'Leite integral', 4.00, 18),
('Creme de Leite', 'Creme de leite fresco', 5.50, 19),
('Chocolate', 'Chocolate meio amargo', 10.00, 20),
('Frutas Frescas', 'Seleção de frutas frescas', 8.00, 21),
('Ervilha', 'Ervilha fresca', 3.00, 22),
('Cenoura', 'Cenoura fresca', 2.50, 23),
('Batata', 'Batata inglesa', 2.80, 24),
('Pimentão', 'Pimentão verde', 3.20, 25),
('Coca-Cola', 'Refrigerante de cola', 2.00, 1),
('Guaraná', 'Refrigerante sabor guaraná', 2.00, 1),
('Suco de Laranja', 'Suco de laranja natural', 3.00, 2),
('Suco de Abacaxi', 'Suco de abacaxi natural', 3.00, 2),
('Suco de Manga', 'Suco de manga natural', 3.00, 2),
('Água Mineral', 'Água mineral sem gás', 1.50, 3),
('Água com Gás', 'Água mineral com gás', 2.00, 3),
('Cerveja Pilsen', 'Cerveja Pilsen', 5.00, 4),
('Vinho Tinto', 'Vinho tinto seco', 20.00, 5),
('Chá Gelado', 'Chá gelado com limão', 2.50, 2),
('Água de Coco', 'Água de coco natural', 3.00, 6),
('Café', 'Grãos de café torrado', 15.00, 7),
('Leite Integral', 'Leite integral', 4.00, 18),
('Creme de Leite', 'Creme de leite fresco', 5.50, 19),
('Achocolatado', 'Achocolatado em pó', 10.00, 8),
('Café Solúvel', 'Café instantâneo', 8.00, 7),
('Gelo', 'Gelo em cubos', 1.00, 9),
('Limão', 'Limão fresco', 2.00, 10),
('Hortelã', 'Folhas de hortelã fresca', 1.50, 11),
('Maracujá', 'Maracujá fresco', 3.00, 12),
('Açúcar', 'Açúcar refinado', 2.50, 13),
('Canela', 'Canela em pó', 3.00, 14),
('Mel', 'Mel natural', 12.00, 15),
('Rum', 'Rum branco', 25.00, 16),
('Vodka', 'Vodka destilada', 30.00, 17);

SELECT * FROM tb_insumos;

INSERT INTO tb_pedidos_insumos (id_fornecedor, data_pedido, data_entrega, status) VALUES
(1, '2024-12-01', '2024-12-03', 'Entregue'),
(2, '2024-12-05', '2024-12-07', 'Pendente'),
(3, '2024-12-10', '2024-12-12', 'Pendente'),
(4, '2024-12-15', '2024-12-17', 'Pendente'),
(5, '2024-12-20', '2024-12-22', 'Pendente'),
-- Janeiro de 2024
(1, '2024-01-05', '2024-01-07', 'Entregue'),
(2, '2024-01-15', '2024-01-17', 'Entregue'),
-- Fevereiro de 2024
(3, '2024-02-03', '2024-02-05', 'Entregue'),
(4, '2024-02-18', '2024-02-20', 'Entregue'),
-- Março de 2024
(5, '2024-03-02', '2024-03-04', 'Entregue'),
(6, '2024-03-20', '2024-03-22', 'Entregue'),
-- Abril de 2024
(7, '2024-04-05', '2024-04-07', 'Entregue'),
(8, '2024-04-18', '2024-04-20', 'Entregue'),
-- Maio de 2024
(9, '2024-05-03', '2024-05-05', 'Entregue'),
(10, '2024-05-22', '2024-05-24', 'Entregue'),
-- Junho de 2024
(11, '2024-06-05', '2024-06-07', 'Entregue'),
(12, '2024-06-19', '2024-06-21', 'Entregue'),
-- Julho de 2024
(13, '2024-07-03', '2024-07-05', 'Entregue'),
(14, '2024-07-21', '2024-07-23', 'Entregue'),
-- Agosto de 2024
(15, '2024-08-04', '2024-08-06', 'Entregue'),
(16, '2024-08-18', '2024-08-20', 'Entregue'),
-- Setembro de 2024
(17, '2024-09-03', '2024-09-05', 'Entregue'),
(18, '2024-09-25', '2024-09-27', 'Entregue'),
-- Outubro de 2024
(19, '2024-10-05', '2024-10-07', 'Entregue'),
(20, '2024-10-20', '2024-10-22', 'Entregue'),
-- Novembro de 2024
(21, '2024-11-05', '2024-11-07', 'Entregue'),
(22, '2024-11-18', '2024-11-20', 'Entregue');

SELECT * FROM tb_pedidos_insumos;

INSERT INTO tb_pedidos_insumos_detalhes (id_pedido_insumo, id_insumo, quantidade) VALUES
-- Detalhes dos Pedidos de Janeiro
(1, 1, 40),  -- 40 kg de Tomate
(1, 2, 30),  -- 30 kg de Alface
(2, 3, 60),  -- 60 kg de Queijo Mussarela
(2, 4, 50),  -- 50 kg de Farinha de Trigo
-- Detalhes dos Pedidos de Fevereiro
(3, 5, 20),  -- 20 litros de Azeite de Oliva
(3, 6, 70),  -- 70 kg de Carne Moída
(4, 7, 50),  -- 50 kg de Peito de Frango
(4, 8, 40),  -- 40 kg de Bacalhau
-- Detalhes dos Pedidos de Março
(5, 9, 50),  -- 50 kg de Camarão
(5, 10, 100), -- 100 kg de Arroz
(6, 11, 80),  -- 80 kg de Feijão
(6, 12, 60),  -- 60 kg de Farinha de Mandioca
-- Detalhes dos Pedidos de Abril
(7, 13, 70),  -- 70 kg de Pão de Forma
(7, 14, 90),  -- 90 kg de Presunto
(8, 15, 80),  -- 80 kg de Calabresa
(8, 16, 60),  -- 60 kg de Bacon
-- Detalhes dos Pedidos de Maio
(9, 17, 100), -- 100 unidades de Ovo
(9, 18, 200), -- 200 litros de Leite
(10, 19, 150), -- 150 litros de Creme de Leite
(10, 20, 120), -- 120 kg de Chocolate
-- Detalhes dos Pedidos de Junho
(11, 21, 50),  -- 50 kg de Frutas Frescas
(11, 22, 30),  -- 30 kg de Ervilha
(12, 23, 60),  -- 60 kg de Cenoura
(12, 24, 80),  -- 80 kg de Batata
-- Detalhes dos Pedidos de Julho
(13, 25, 40),  -- 40 kg de Pimentão
(13, 1, 100),  -- 100 kg de Tomate
(14, 2, 80),  -- 80 kg de Alface
(14, 3, 150), -- 150 kg de Queijo Mussarela
-- Detalhes dos Pedidos de Agosto
(15, 4, 120), -- 120 kg de Farinha de Trigo
(15, 5, 60),  -- 60 litros de Azeite de Oliva
(16, 6, 90),  -- 90 kg de Carne Moída
(16, 7, 70),  -- 70 kg de Peito de Frango
-- Detalhes dos Pedidos de Setembro
(17, 8, 80),  -- 80 kg de Bacalhau
(17, 9, 90),  -- 90 kg de Camarão
(18, 10, 200), -- 200 kg de Arroz
(18, 11, 100), -- 100 kg de Feijão
-- Detalhes dos Pedidos de Outubro
(19, 12, 70),  -- 70 kg de Farinha de Mandioca
(19, 13, 80),  -- 80 unidades de Pão de Forma
(20, 14, 150), -- 150 kg de Presunto
(20, 15, 120), -- 120 kg de Calabresa
-- Detalhes dos Pedidos de Novembro
(21, 16, 100), -- 100 kg de Bacon
(21, 17, 200), -- 200 unidades de Ovo
(22, 18, 250), -- 250 litros de Leite
(22, 19, 200), -- 200 litros de Creme de Leite
-- Detalhes dos Pedidos de Dezembro
(23, 1, 50),  -- 50 kg de Tomate
(23, 2, 30),  -- 30 kg de Alface
(24, 3, 100),  -- 100 kg de Queijo Mussarela
(24, 4, 50),  -- 50 kg de Farinha de Trigo
(25, 5, 20),  -- 20 litros de Azeite de Oliva
(25, 6, 70),  -- 70 kg de Carne Moída
(26, 7, 50),  -- 50 kg de Peito de Frango
(26, 8, 40),  -- 40 kg de Bacalhau
(27, 9, 50),  -- 50 kg de Camarão
(27, 10, 100);  -- 100 kg de Arroz

SELECT * FROM tb_pedidos_insumos_detalhes;

INSERT INTO tb_menu_insumos (id_item, id_insumo, quantidade) VALUES
-- Pizza Margherita (id_item = 1)
(1, 1, 0.5),   -- 0.5 kg de Tomate
(1, 3, 0.2),   -- 0.2 kg de Queijo Mussarela
(1, 5, 0.05),  -- 0.05 litros de Azeite de Oliva
-- Spaghetti à Carbonara (id_item = 2)
(2, 4, 0.2),   -- 0.2 kg de Farinha de Trigo
(2, 16, 0.1),  -- 0.1 kg de Bacon
(2, 17, 2),    -- 2 unidades de Ovo
-- Salada Caprese (id_item = 3)
(3, 1, 0.2),   -- 0.2 kg de Tomate
(3, 3, 0.1),   -- 0.1 kg de Queijo Mussarela
(3, 5, 0.05),  -- 0.05 litros de Azeite de Oliva
-- Bife à Parmegiana (id_item = 4)
(4, 6, 0.25),  -- 0.25 kg de Carne Moída
(4, 3, 0.15),  -- 0.15 kg de Queijo Mussarela
(4, 1, 0.3),   -- 0.3 kg de Tomate
-- Risotto de Cogumelos (id_item = 5)
(5, 4, 0.2),   -- 0.2 kg de Farinha de Trigo
(5, 22, 0.15), -- 0.15 kg de Ervilha
(5, 21, 0.2),  -- 0.2 kg de Frutas Frescas
-- Feijoada (id_item = 6)
(6, 11, 0.5),  -- 0.5 kg de Feijão Preto
(6, 15, 0.2),  -- 0.2 kg de Calabresa
(6, 16, 0.1),  -- 0.1 kg de Bacon
-- Frango Grelhado (id_item = 7)
(7, 7, 0.25),  -- 0.25 kg de Peito de Frango
(7, 2, 0.1),   -- 0.1 kg de Alface
(7, 24, 0.2),  -- 0.2 kg de Batata
-- Salada Caesar (id_item = 8)
(8, 2, 0.2),   -- 0.2 kg de Alface
(8, 3, 0.1),   -- 0.1 kg de Queijo Mussarela
(8, 5, 0.05),  -- 0.05 litros de Azeite de Oliva
-- Ceviche (id_item = 9)
(9, 9, 0.3),   -- 0.3 kg de Camarão
(9, 11, 0.05), -- 0.05 kg de Feijão
(9, 2, 0.1),   -- 0.1 kg de Alface
-- Sopa de Cebola (id_item = 10)
(10, 12, 0.3), -- 0.3 kg de Farinha de Mandioca
(10, 5, 0.05), -- 0.05 litros de Azeite de Oliva
(10, 2, 0.1);  -- 0.1 kg de Alface

SELECT * FROM tb_menu_insumos;

INSERT INTO tb_pagamentos (id_pedido, id_cliente, valor, data_pagamento, forma_pagamento) VALUES
(1, 1, 120.00, '2021-01-05 12:30:00', 'Cartão de Crédito'),
(2, 2, 90.00, '2021-01-12 13:00:00', 'PIX'),
(3, 3, 150.00, '2021-02-03 14:00:00', 'Voucher'),
(4, 4, 80.00, '2021-02-20 15:00:00', 'Cartão de Débito'),
(5, 5, 200.00, '2021-03-15 12:00:00', 'Vale-Refeição'),
(6, 6, 110.00, '2021-04-10 13:00:00', 'Dinheiro'),
(7, 7, 130.00, '2021-04-22 12:30:00', 'Cartão de Crédito'),
(8, 8, 140.00, '2021-05-05 14:30:00', 'PIX'),
(9, 9, 90.00, '2021-06-01 12:45:00', 'Voucher'),
(10, 10, 160.00, '2021-06-14 13:15:00', 'Cartão de Débito'),
(11, 11, 190.00, '2021-07-08 14:00:00', 'Vale-Refeição'),
(12, 12, 100.00, '2021-07-22 15:30:00', 'Dinheiro'),
(13, 13, 120.00, '2021-08-05 13:00:00', 'Cartão de Crédito'),
(14, 14, 140.00, '2021-08-19 14:30:00', 'PIX'),
(15, 15, 180.00, '2021-09-01 12:45:00', 'Voucher'),
(16, 16, 170.00, '2021-09-15 13:15:00', 'Cartão de Débito'),
(17, 17, 150.00, '2021-10-03 14:00:00', 'Vale-Refeição'),
(18, 18, 130.00, '2021-10-20 15:30:00', 'Dinheiro'),
(19, 19, 140.00, '2021-11-01 13:00:00', 'Cartão de Crédito'),
(20, 20, 160.00, '2021-11-18 14:30:00', 'PIX'),
(21, 21, 120.00, '2021-12-02 12:30:00', 'Voucher'),
(22, 22, 100.00, '2021-12-15 13:15:00', 'Cartão de Débito'),
(23, 23, 130.00, '2022-01-05 14:00:00', 'Vale-Refeição'),
(24, 24, 150.00, '2022-01-22 15:30:00', 'Dinheiro'),
(25, 25, 170.00, '2022-02-10 12:45:00', 'Cartão de Crédito'),
(26, 26, 190.00, '2022-02-25 13:15:00', 'PIX'),
(27, 27, 140.00, '2022-03-08 14:00:00', 'Voucher'),
(28, 28, 120.00, '2022-03-22 15:30:00', 'Cartão de Débito'),
(29, 29, 150.00, '2022-04-03 12:30:00', 'Vale-Refeição'),
(30, 30, 160.00, '2022-04-20 13:00:00', 'Dinheiro'),
(31, 1, 120.00, '2022-05-01 12:30:00', 'Cartão de Crédito'),
(32, 2, 90.00, '2022-05-15 13:00:00', 'PIX'),
(33, 3, 150.00, '2022-06-01 14:00:00', 'Voucher'),
(34, 4, 80.00, '2022-06-18 15:00:00', 'Cartão de Débito'),
(35, 5, 200.00, '2022-07-01 12:00:00', 'Vale-Refeição'),
(36, 6, 110.00, '2022-07-14 13:00:00', 'Dinheiro'),
(37, 7, 130.00, '2022-08-05 12:30:00', 'Cartão de Crédito'),
(38, 8, 140.00, '2022-08-20 14:30:00', 'PIX'),
(39, 9, 90.00, '2022-09-02 12:45:00', 'Voucher'),
(40, 10, 160.00, '2022-09-19 13:15:00', 'Cartão de Débito'),
(41, 11, 190.00, '2022-10-01 14:00:00', 'Vale-Refeição'),
(42, 12, 100.00, '2022-10-18 15:30:00', 'Dinheiro'),
(43, 13, 120.00, '2022-11-03 13:00:00', 'Cartão de Crédito'),
(44, 14, 140.00, '2022-11-20 14:30:00', 'PIX'),
(45, 15, 180.00, '2022-12-02 12:45:00', 'Voucher'),
(46, 16, 170.00, '2022-12-15 13:15:00', 'Cartão de Débito'),
(47, 17, 150.00, '2023-01-05 14:00:00', 'Vale-Refeição'),
(48, 18, 130.00, '2023-01-22 15:30:00', 'Dinheiro'),
(49, 19, 140.00, '2023-02-10 13:00:00', 'Cartão de Crédito'),
(50, 20, 160.00, '2023-02-25 14:30:00', 'PIX'),
(51, 21, 120.00, '2023-03-08 12:30:00', 'Voucher'),
(52, 22, 100.00, '2023-03-22 13:15:00', 'Cartão de Débito'),
(53, 23, 130.00, '2023-04-03 14:00:00', 'Vale-Refeição'),
(54, 24, 150.00, '2023-04-20 15:30:00', 'Dinheiro'),
(55, 25, 170.00, '2023-05-01 12:45:00', 'Cartão de Crédito'),
(56, 26, 190.00, '2023-05-15 13:15:00', 'PIX'),
(57, 27, 140.00, '2023-06-01 14:00:00', 'Voucher'),
(58, 28, 120.00, '2023-06-18 15:30:00', 'Cartão de Débito'),
(59, 29, 150.00, '2023-07-01 12:30:00', 'Vale-Refeição'),
(60, 30, 160.00, '2023-07-14 13:00:00', 'Dinheiro'),
(81, 21, 140.00, '2024-06-01 12:30:00', 'Cartão de Crédito'),
(82, 22, 90.00, '2024-06-18 13:00:00', 'PIX'),
(83, 23, 150.00, '2024-07-01 14:00:00', 'Voucher'),
(84, 24, 80.00, '2024-07-14 15:00:00', 'Cartão de Débito'),
(85, 25, 200.00, '2024-08-05 12:00:00', 'Vale-Refeição'),
(86, 26, 110.00, '2024-08-20 13:00:00', 'Dinheiro'),
(87, 27, 130.00, '2024-09-02 12:30:00', 'Cartão de Crédito'),
(88, 28, 140.00, '2024-09-19 14:30:00', 'PIX'),
(89, 29, 90.00, '2024-10-01 12:45:00', 'Voucher'),
(90, 30, 160.00, '2024-10-18 13:15:00', 'Cartão de Débito'),
(91, 1, 190.00, '2024-11-03 14:00:00', 'Vale-Refeição'),
(92, 2, 100.00, '2024-11-20 15:30:00', 'Dinheiro'),
(93, 3, 120.00, '2024-12-02 13:00:00', 'Cartão de Crédito'),
(94, 4, 140.00, '2024-12-15 14:30:00', 'PIX'),
(95, 5, 180.00, '2024-12-30 12:45:00', 'Voucher'),
(96, 6, 170.00, '2021-11-05 13:15:00', 'Cartão de Débito'),
(97, 7, 150.00, '2021-12-10 14:00:00', 'Vale-Refeição'),
(98, 8, 130.00, '2021-12-25 15:30:00', 'Dinheiro'),
(99, 9, 140.00, '2021-11-25 13:00:00', 'Cartão de Crédito'),
(100, 10, 160.00, '2021-12-01 14:30:00', 'PIX'),
(101, 11, 120.00, '2021-12-15 12:30:00', 'Voucher'),
(102, 12, 100.00, '2021-12-20 13:15:00', 'Cartão de Débito'),
(103, 13, 130.00, '2022-01-05 14:00:00', 'Vale-Refeição'),
(104, 14, 150.00, '2022-01-15 15:30:00', 'Dinheiro'),
(105, 15, 170.00, '2022-01-25 12:45:00', 'Cartão de Crédito'),
(106, 16, 190.00, '2022-02-01 13:15:00', 'PIX'),
(107, 17, 140.00, '2022-02-15 14:00:00', 'Voucher'),
(108, 18, 120.00, '2022-02-28 15:30:00', 'Cartão de Débito'),
(109, 19, 150.00, '2022-03-05 12:30:00', 'Vale-Refeição'),
(110, 20, 130.00, '2022-03-10 12:30:00', 'Cartão de Crédito'),
(111, 21, 140.00, '2022-03-22 13:00:00', 'PIX'),
(112, 22, 150.00, '2022-04-01 14:00:00', 'Voucher'),
(113, 23, 80.00, '2022-04-10 15:00:00', 'Cartão de Débito'),
(114, 24, 200.00, '2022-04-20 12:00:00', 'Vale-Refeição'),
(115, 25, 110.00, '2022-05-01 13:00:00', 'Dinheiro'),
(116, 26, 130.00, '2022-05-10 12:30:00', 'Cartão de Crédito'),
(117, 27, 140.00, '2022-05-20 14:30:00', 'PIX'),
(118, 28, 90.00, '2022-06-01 12:45:00', 'Voucher'),
(119, 29, 160.00, '2022-06-10 13:15:00', 'Cartão de Débito'),
(120, 30, 190.00, '2022-06-20 14:00:00', 'Vale-Refeição'),
(121, 1, 100.00, '2022-07-01 15:30:00', 'Dinheiro'),
(122, 2, 120.00, '2022-07-10 13:00:00', 'Cartão de Crédito'),
(123, 3, 140.00, '2022-07-20 14:30:00', 'PIX'),
(124, 4, 180.00, '2022-08-01 12:45:00', 'Voucher'),
(125, 5, 170.00, '2022-08-10 13:15:00', 'Cartão de Débito'),
(126, 6, 150.00, '2022-08-20 14:00:00', 'Vale-Refeição'),
(127, 7, 130.00, '2022-09-01 15:30:00', 'Dinheiro'),
(128, 8, 140.00, '2022-09-10 13:00:00', 'Cartão de Crédito'),
(129, 9, 160.00, '2022-09-20 14:30:00', 'PIX'),
(130, 10, 120.00, '2022-10-01 12:30:00', 'Voucher'),
(131, 11, 100.00, '2022-10-10 13:15:00', 'Cartão de Débito'),
(132, 12, 130.00, '2022-10-20 14:00:00', 'Vale-Refeição'),
(133, 13, 150.00, '2022-11-01 15:30:00', 'Dinheiro'),
(134, 14, 170.00, '2022-11-10 12:45:00', 'Cartão de Crédito'),
(135, 15, 190.00, '2022-11-20 13:15:00', 'PIX'),
(136, 16, 140.00, '2022-12-01 14:00:00', 'Voucher'),
(137, 17, 120.00, '2022-12-10 15:30:00', 'Cartão de Débito'),
(138, 18, 150.00, '2022-12-20 12:30:00', 'Vale-Refeição'),
(139, 19, 160.00, '2023-01-01 13:00:00', 'Dinheiro'),
(140, 20, 140.00, '2023-01-10 14:30:00', 'Cartão de Crédito'),
(141, 21, 90.00, '2023-01-20 12:45:00', 'PIX'),
(142, 22, 150.00, '2023-02-01 13:15:00', 'Voucher'),
(143, 23, 80.00, '2023-02-10 14:00:00', 'Cartão de Débito'),
(144, 24, 200.00, '2023-02-20 15:30:00', 'Vale-Refeição'),
(145, 25, 110.00, '2023-03-01 13:00:00', 'Dinheiro'),
(146, 26, 130.00, '2023-03-10 12:30:00', 'Cartão de Crédito'),
(147, 27, 140.00, '2023-03-20 14:30:00', 'PIX'),
(148, 28, 90.00, '2023-04-01 12:45:00', 'Voucher'),
(149, 29, 160.00, '2023-04-10 13:15:00', 'Cartão de Débito'),
(150, 30, 120.00, '2023-04-20 12:30:00', 'Cartão de Crédito'),
(151, 1, 90.00, '2023-05-01 13:00:00', 'PIX'),
(152, 2, 150.00, '2023-05-10 14:00:00', 'Voucher'),
(153, 3, 80.00, '2023-05-20 15:00:00', 'Cartão de Débito'),
(154, 4, 200.00, '2023-06-01 12:00:00', 'Vale-Refeição'),
(155, 5, 110.00, '2023-06-10 13:00:00', 'Dinheiro'),
(156, 6, 130.00, '2023-06-20 12:30:00', 'Cartão de Crédito'),
(157, 7, 140.00, '2023-07-01 14:30:00', 'PIX'),
(158, 8, 90.00, '2023-07-10 12:45:00', 'Voucher'),
(159, 9, 160.00, '2023-07-20 13:15:00', 'Cartão de Débito'),
(160, 10, 190.00, '2023-08-01 14:00:00', 'Vale-Refeição'),
(161, 11, 100.00, '2022-01-15 15:30:00', 'Dinheiro'),
(162, 12, 120.00, '2022-02-01 13:00:00', 'Cartão de Crédito'),
(163, 13, 140.00, '2022-02-15 14:30:00', 'PIX'),
(164, 14, 180.00, '2022-03-01 12:45:00', 'Voucher'),
(165, 15, 170.00, '2022-03-15 13:15:00', 'Cartão de Débito'),
(166, 16, 150.00, '2022-04-01 14:00:00', 'Vale-Refeição'),
(167, 17, 130.00, '2022-04-15 15:30:00', 'Dinheiro'),
(168, 18, 140.00, '2022-05-01 13:00:00', 'Cartão de Crédito'),
(169, 19, 160.00, '2022-05-15 14:30:00', 'PIX'),
(170, 20, 120.00, '2022-06-01 12:30:00', 'Voucher'),
(171, 21, 100.00, '2022-06-15 13:15:00', 'Cartão de Débito'),
(172, 22, 130.00, '2022-07-01 14:00:00', 'Vale-Refeição'),
(173, 23, 150.00, '2022-07-15 15:30:00', 'Dinheiro'),
(174, 24, 170.00, '2022-08-01 12:45:00', 'Cartão de Crédito'),
(175, 25, 190.00, '2022-08-15 13:15:00', 'PIX'),
(176, 26, 140.00, '2022-09-01 14:00:00', 'Voucher'),
(177, 27, 120.00, '2022-09-15 15:30:00', 'Cartão de Débito'),
(178, 28, 150.00, '2022-10-01 12:30:00', 'Vale-Refeição'),
(179, 29, 160.00, '2022-10-15 13:00:00', 'Dinheiro'),
(180, 30, 140.00, '2022-11-01 14:30:00', 'Cartão de Crédito'),
(181, 1, 90.00, '2022-11-15 12:45:00', 'PIX'),
(182, 2, 150.00, '2022-12-01 13:15:00', 'Voucher'),
(183, 3, 80.00, '2022-12-15 14:00:00', 'Cartão de Débito'),
(184, 4, 200.00, '2023-01-01 15:30:00', 'Vale-Refeição'),
(185, 5, 110.00, '2023-01-15 13:00:00', 'Dinheiro'),
(186, 6, 130.00, '2023-02-01 12:30:00', 'Cartão de Crédito'),
(187, 7, 140.00, '2023-02-15 14:30:00', 'PIX'),
(188, 8, 90.00, '2023-03-01 12:45:00', 'Voucher'),
(189, 9, 160.00, '2023-03-15 13:15:00', 'Cartão de Débito'),
(190, 10, 190.00, '2023-04-01 14:00:00', 'Vale-Refeição'),
(191, 11, 100.00, '2023-04-15 15:30:00', 'Dinheiro'),
(192, 12, 120.00, '2023-05-01 13:00:00', 'Cartão de Crédito'),
(193, 13, 140.00, '2023-05-15 14:30:00', 'PIX'),
(194, 14, 180.00, '2023-06-01 12:45:00', 'Voucher'),
(195, 15, 170.00, '2023-06-15 13:15:00', 'Cartão de Débito'),
(196, 16, 150.00, '2023-07-01 14:00:00', 'Vale-Refeição'),
(197, 17, 130.00, '2023-07-15 15:30:00', 'Dinheiro'),
(198, 18, 140.00, '2023-08-01 13:00:00', 'Cartão de Crédito'),
(199, 19, 160.00, '2023-08-15 14:30:00', 'PIX'),
(200, 20, 140.00, '2023-09-01 12:30:00', 'Cartão de Crédito'),
(201, 21, 90.00, '2023-09-15 13:00:00', 'PIX'),
(202, 22, 150.00, '2023-10-01 14:00:00', 'Voucher'),
(203, 23, 80.00, '2023-10-15 15:00:00', 'Cartão de Débito'),
(204, 24, 200.00, '2023-11-01 12:00:00', 'Vale-Refeição'),
(205, 25, 110.00, '2023-11-15 13:00:00', 'Dinheiro'),
(206, 26, 130.00, '2023-12-01 12:30:00', 'Cartão de Crédito'),
(207, 27, 140.00, '2023-12-15 14:30:00', 'PIX'),
(208, 28, 90.00, '2024-01-01 12:45:00', 'Voucher'),
(209, 29, 160.00, '2024-01-15 13:15:00', 'Cartão de Débito'),
(210, 30, 190.00, '2024-02-01 14:00:00', 'Vale-Refeição'),
(211, 1, 100.00, '2022-02-10 15:30:00', 'Dinheiro'),
(212, 2, 120.00, '2022-02-25 13:00:00', 'Cartão de Crédito'),
(213, 3, 140.00, '2022-03-08 14:30:00', 'PIX'),
(214, 4, 180.00, '2022-03-22 12:45:00', 'Voucher'),
(215, 5, 170.00, '2022-04-03 13:15:00', 'Cartão de Débito'),
(216, 6, 150.00, '2022-04-20 14:00:00', 'Vale-Refeição'),
(217, 7, 130.00, '2022-05-01 15:30:00', 'Dinheiro'),
(218, 8, 140.00, '2022-05-15 13:00:00', 'Cartão de Crédito'),
(219, 9, 160.00, '2022-06-01 14:30:00', 'PIX'),
(220, 10, 120.00, '2022-06-18 12:30:00', 'Voucher'),
(221, 11, 100.00, '2022-07-01 13:15:00', 'Cartão de Débito'),
(222, 12, 130.00, '2022-07-14 14:00:00', 'Vale-Refeição'),
(223, 13, 150.00, '2022-08-05 15:30:00', 'Dinheiro'),
(224, 14, 170.00, '2022-08-20 12:45:00', 'Cartão de Crédito'),
(225, 15, 190.00, '2022-09-02 13:15:00', 'PIX'),
(226, 16, 140.00, '2022-09-19 14:00:00', 'Voucher'),
(227, 17, 120.00, '2022-10-01 15:30:00', 'Cartão de Débito'),
(228, 18, 150.00, '2022-10-18 12:30:00', 'Vale-Refeição'),
(229, 19, 160.00, '2022-11-03 13:00:00', 'Dinheiro'),
(230, 20, 140.00, '2022-11-20 14:30:00', 'Cartão de Crédito'),
(231, 21, 90.00, '2022-12-02 12:45:00', 'PIX'),
(232, 22, 150.00, '2022-12-15 13:15:00', 'Voucher'),
(233, 23, 80.00, '2023-01-05 14:00:00', 'Cartão de Débito'),
(234, 24, 200.00, '2023-01-22 15:30:00', 'Vale-Refeição'),
(235, 25, 110.00, '2023-02-10 12:45:00', 'Dinheiro'),
(236, 26, 130.00, '2023-02-25 13:15:00', 'Cartão de Crédito'),
(237, 27, 140.00, '2023-03-08 14:00:00', 'PIX'),
(238, 28, 90.00, '2023-03-22 15:30:00', 'Voucher'),
(239, 29, 160.00, '2023-04-03 12:30:00', 'Cartão de Débito'),
(240, 30, 160.00, '2023-04-20 13:00:00', 'Dinheiro'),
(241, 1, 120.00, '2023-05-01 12:30:00', 'Cartão de Crédito'),
(242, 2, 90.00, '2023-05-15 13:00:00', 'PIX'),
(243, 3, 150.00, '2023-06-01 14:00:00', 'Voucher'),
(244, 4, 80.00, '2023-06-18 15:00:00', 'Cartão de Débito'),
(245, 5, 200.00, '2023-07-01 12:00:00', 'Vale-Refeição'),
(246, 6, 110.00, '2023-07-14 13:00:00', 'Dinheiro'),
(247, 7, 130.00, '2023-08-05 12:30:00', 'Cartão de Crédito'),
(248, 8, 140.00, '2023-08-20 14:30:00', 'PIX'),
(249, 9, 90.00, '2023-09-02 12:45:00', 'Voucher'),
(250, 10, 160.00, '2023-09-19 13:15:00', 'Cartão de Débito'),
(251, 11, 190.00, '2023-10-01 14:00:00', 'Vale-Refeição'),
(252, 12, 100.00, '2023-10-18 15:30:00', 'Dinheiro'),
(253, 13, 120.00, '2023-11-03 13:00:00', 'Cartão de Crédito'),
(254, 14, 140.00, '2023-11-20 14:30:00', 'PIX'),
(255, 15, 180.00, '2023-12-02 12:45:00', 'Voucher'),
(256, 16, 170.00, '2023-12-15 13:15:00', 'Cartão de Débito'),
(257, 17, 150.00, '2024-01-05 14:00:00', 'Vale-Refeição'),
(258, 18, 130.00, '2024-01-22 15:30:00', 'Dinheiro'),
(259, 19, 140.00, '2024-02-10 13:00:00', 'Cartão de Crédito'),
(260, 20, 160.00, '2024-02-25 14:30:00', 'PIX'),
(261, 21, 120.00, '2022-01-05 12:30:00', 'Voucher'),
(262, 22, 100.00, '2022-01-22 13:15:00', 'Cartão de Débito'),
(263, 23, 130.00, '2022-02-10 14:00:00', 'Vale-Refeição'),
(264, 24, 150.00, '2022-02-25 15:30:00', 'Dinheiro'),
(265, 25, 170.00, '2022-03-08 12:45:00', 'Cartão de Crédito'),
(266, 26, 190.00, '2022-03-22 13:15:00', 'PIX'),
(267, 27, 140.00, '2022-04-03 14:00:00', 'Voucher'),
(268, 28, 120.00, '2022-04-20 15:30:00', 'Cartão de Débito'),
(269, 29, 150.00, '2022-05-01 12:30:00', 'Vale-Refeição'),
(270, 30, 160.00, '2022-05-15 13:00:00', 'Dinheiro'),
(271, 1, 140.00, '2022-06-01 14:30:00', 'Cartão de Crédito'),
(272, 2, 90.00, '2022-06-18 12:45:00', 'PIX'),
(273, 3, 150.00, '2022-07-01 13:15:00', 'Voucher'),
(274, 4, 80.00, '2022-07-14 14:00:00', 'Cartão de Débito'),
(275, 5, 200.00, '2022-08-05 15:30:00', 'Vale-Refeição'),
(276, 6, 110.00, '2022-08-20 13:00:00', 'Dinheiro'),
(277, 7, 130.00, '2022-09-02 12:30:00', 'Cartão de Crédito'),
(278, 8, 140.00, '2022-09-19 14:30:00', 'PIX'),
(279, 9, 90.00, '2022-10-01 12:45:00', 'Voucher'),
(280, 10, 160.00, '2022-10-18 13:15:00', 'Cartão de Débito'),
(281, 11, 190.00, '2022-11-03 14:00:00', 'Vale-Refeição'),
(282, 12, 100.00, '2022-11-20 15:30:00', 'Dinheiro'),
(283, 13, 120.00, '2022-12-02 13:00:00', 'Cartão de Crédito'),
(284, 14, 140.00, '2022-12-15 14:30:00', 'PIX'),
(285, 15, 180.00, '2023-01-05 12:45:00', 'Voucher'),
(286, 16, 170.00, '2023-01-22 13:15:00', 'Cartão de Débito'),
(287, 17, 150.00, '2023-02-10 14:00:00', 'Vale-Refeição'),
(288, 18, 130.00, '2023-02-25 15:30:00', 'Dinheiro'),
(289, 19, 140.00, '2023-03-08 13:00:00', 'Cartão de Crédito'),
(290, 20, 160.00, '2023-03-22 14:30:00', 'PIX'),
(291, 21, 120.00, '2023-04-03 12:30:00', 'Voucher'),
(292, 22, 100.00, '2023-04-20 13:15:00', 'Cartão de Débito'),
(293, 23, 130.00, '2023-05-01 14:00:00', 'Vale-Refeição'),
(294, 24, 150.00, '2023-05-15 15:30:00', 'Dinheiro'),
(295, 25, 170.00, '2023-06-01 12:45:00', 'Cartão de Crédito'),
(296, 26, 190.00, '2023-06-18 13:15:00', 'PIX'),
(297, 27, 140.00, '2023-07-01 14:00:00', 'Voucher'),
(298, 28, 120.00, '2023-07-14 15:30:00', 'Cartão de Débito'),
(299, 29, 150.00, '2023-08-05 12:30:00', 'Vale-Refeição'),
(300, 30, 130.00, '2023-08-20 14:00:00', 'Dinheiro'),
(301, 1, 110.00, '2023-09-02 13:00:00', 'Cartão de Crédito'),
(302, 2, 100.00, '2021-02-20 13:30:00', 'PIX'),
(303, 3, 120.00, '2021-03-15 14:00:00', 'Voucher'),
(304, 4, 90.00, '2021-04-05 14:30:00', 'Cartão de Débito'),
(305, 5, 160.00, '2021-05-10 15:00:00', 'Vale-Refeição'),
(306, 6, 170.00, '2021-06-25 15:30:00', 'Dinheiro'),
(307, 7, 180.00, '2021-07-12 13:00:00', 'Cartão de Crédito'),
(308, 8, 110.00, '2021-08-19 13:30:00', 'PIX'),
(309, 9, 130.00, '2021-09-25 14:00:00', 'Voucher'),
(310, 10, 140.00, '2021-10-30 14:30:00', 'Cartão de Débito'),
(311, 11, 150.00, '2021-11-15 15:00:00', 'Vale-Refeição'),
(312, 12, 160.00, '2021-12-05 15:30:00', 'Dinheiro'),
(313, 13, 170.00, '2022-01-14 13:00:00', 'Cartão de Crédito'),
(314, 14, 180.00, '2022-02-28 13:30:00', 'PIX'),
(315, 15, 190.00, '2022-03-22 14:00:00', 'Voucher'),
(316, 16, 200.00, '2022-04-18 14:30:00', 'Cartão de Débito'),
(317, 17, 210.00, '2022-05-10 15:00:00', 'Vale-Refeição'),
(318, 18, 220.00, '2022-06-27 15:30:00', 'Dinheiro'),
(319, 19, 230.00, '2022-07-14 13:00:00', 'Cartão de Crédito'),
(320, 20, 240.00, '2022-08-21 13:30:00', 'PIX'),
(321, 21, 250.00, '2022-09-15 14:00:00', 'Voucher'),
(322, 22, 260.00, '2022-10-05 14:30:00', 'Cartão de Débito'),
(323, 23, 270.00, '2022-11-19 15:00:00', 'Vale-Refeição'),
(324, 24, 280.00, '2022-12-25 15:30:00', 'Dinheiro'),
(325, 25, 290.00, '2023-01-18 13:00:00', 'Cartão de Crédito'),
(326, 26, 300.00, '2023-02-12 13:30:00', 'PIX'),
(327, 27, 310.00, '2023-03-22 14:00:00', 'Voucher'),
(328, 28, 320.00, '2023-04-28 14:30:00', 'Cartão de Débito'),
(329, 29, 330.00, '2023-05-13 15:00:00', 'Vale-Refeição'),
(330, 30, 340.00, '2023-06-05 15:30:00', 'Dinheiro'),
(331, 1, 350.00, '2023-07-25 13:00:00', 'Cartão de Crédito'),
(332, 2, 360.00, '2023-08-15 13:30:00', 'PIX'),
(333, 3, 370.00, '2023-09-10 14:00:00', 'Voucher'),
(334, 4, 380.00, '2023-10-25 14:30:00', 'Cartão de Débito'),
(335, 5, 390.00, '2023-11-18 15:00:00', 'Vale-Refeição'),
(336, 6, 400.00, '2023-12-05 15:30:00', 'Dinheiro'),
(337, 7, 410.00, '2024-01-20 13:00:00', 'Cartão de Crédito'),
(338, 8, 420.00, '2024-02-10 13:30:00', 'PIX'),
(339, 9, 430.00, '2024-03-18 14:00:00', 'Voucher'),
(340, 10, 440.00, '2024-04-05 14:30:00', 'Cartão de Débito'),
(341, 11, 450.00, '2024-05-25 15:00:00', 'Vale-Refeição'),
(342, 12, 460.00, '2024-06-12 15:30:00', 'Dinheiro'),
(343, 13, 470.00, '2024-07-19 13:00:00', 'Cartão de Crédito'),
(344, 14, 480.00, '2024-08-10 13:30:00', 'PIX'),
(345, 15, 490.00, '2024-09-15 14:00:00', 'Voucher'),
(346, 16, 500.00, '2024-10-05 14:30:00', 'Cartão de Débito'),
(347, 17, 510.00, '2024-11-25 15:00:00', 'Vale-Refeição'),
(348, 18, 520.00, '2024-12-12 15:30:00', 'Dinheiro'),
(349, 19, 530.00, '2024-12-29 13:00:00', 'Cartão de Crédito'),
(350, 20, 540.00, '2021-11-05 13:30:00', 'PIX'),
(351, 21, 550.00, '2021-12-10 14:00:00', 'Voucher');

SELECT * FROM tb_pagamentos;
