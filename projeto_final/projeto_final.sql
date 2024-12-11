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
    nome VARCHAR(255),
    cpf VARCHAR(11),
    cnpj VARCHAR(14),
    telefone VARCHAR(20),
    email VARCHAR(255),
    CONSTRAINT chk_cpf_cnpj CHECK (cpf IS NOT NULL OR cnpj IS NOT NULL)
);

-- Tabela de Funcionários
CREATE TABLE tb_funcionarios (
    id_funcionario INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(255) NOT NULL,
    data_nascimento DATE NOT NULL,
    cpf VARCHAR(11) NOT NULL,
    cargo VARCHAR(50),
    telefone VARCHAR(20),
    email VARCHAR(255),
    salario DECIMAL(10, 2),
    data_contratacao DATE
);

-- Tabela de Endereço dos Funcionários
CREATE TABLE tb_endereco_funcionario (
    id_funcionario INT,
    logradouro VARCHAR(255),
    numero INT,
    complemento VARCHAR(255),
    cidade VARCHAR(255),
    estado VARCHAR(2),
    cep VARCHAR(8),
    PRIMARY KEY (id_funcionario),
    FOREIGN KEY (id_funcionario) REFERENCES tb_funcionarios(id_funcionario)
);

-- Tabela de Menu
CREATE TABLE tb_menu (
    id_item INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(255) NOT NULL,
    descricao VARCHAR(255),
    preco DECIMAL(10, 2)
);

-- Tabela de Mesas
CREATE TABLE tb_mesas (
    id_mesa INT AUTO_INCREMENT PRIMARY KEY,
    capacidade INT,
    localizacao VARCHAR(255)
);

-- Tabela de Fornecedores
CREATE TABLE tb_fornecedores (
    id_fornecedor INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(255) NOT NULL,
    cpf VARCHAR(20),
    telefone VARCHAR(20),
    email VARCHAR(255)
);

-- Tabela de Pedidos
CREATE TABLE tb_pedidos (
    id_pedido INT AUTO_INCREMENT PRIMARY KEY,
    id_mesa INT,
    id_funcionario INT,
    data_pedido DATETIME,
    status VARCHAR(50),
    FOREIGN KEY (id_mesa) REFERENCES tb_mesas(id_mesa),
    FOREIGN KEY (id_funcionario) REFERENCES tb_funcionarios(id_funcionario)
);

-- Tabela de Detalhes dos Pedidos
CREATE TABLE tb_detalhes_pedidos (
    id_pedido INT,
    id_item INT,
    quantidade INT,
    preco_unitario DECIMAL(10, 2),
    PRIMARY KEY (id_pedido, id_item),
    FOREIGN KEY (id_pedido) REFERENCES tb_pedidos(id_pedido),
    FOREIGN KEY (id_item) REFERENCES tb_menu(id_item)
);

-- Tabela de Pagamentos
CREATE TABLE tb_pagamentos (
    id_pagamento INT AUTO_INCREMENT PRIMARY KEY,
    id_pedido INT,
    id_cliente INT,
    valor DECIMAL(10, 2),
    data_pagamento DATETIME,
    FOREIGN KEY (id_pedido) REFERENCES tb_pedidos(id_pedido),
    FOREIGN KEY (id_cliente) REFERENCES tb_clientes(id_cliente)
);

-- Tabela de Formas de Pagamento
CREATE TABLE tb_formas_pagamento (
    id_pagamento INT,
    forma_pagamento VARCHAR(50),
    PRIMARY KEY (id_pagamento, forma_pagamento),
    FOREIGN KEY (id_pagamento) REFERENCES tb_pagamentos(id_pagamento)
);

-- Registro dos clientes
INSERT INTO tb_clientes (nome, cpf, cnpj, telefone, email) VALUES
('Carlos Pereira', '12345678900', NULL, '11999999999', 'carlos.pereira@example.com'),
('Ana Souza', NULL, '12345678000100', '11888888888', 'ana.souza@example.com'),
('João Oliveira', '11223344556', NULL, '11777777777', 'joao.oliveira@example.com'),
('Maria Silva', '98765432100', NULL, '11666666666', 'maria.silva@example.com'),
('Pedro Santos', NULL, '22334455000199', '11555555555', 'pedro.santos@example.com'),
('Luiza Costa', '12312312399', NULL, '11444444444', 'luiza.costa@example.com'),
('Marcos Almeida', NULL, '33445566000122', '11333333333', 'marcos.almeida@example.com'),
('Julia Fernandes', '32132132188', NULL, '11222222222', 'julia.fernandes@example.com'),
('Felipe Carvalho', '45645645677', NULL, '11988887777', 'felipe.carvalho@example.com'),
('Carla Mota', NULL, '44556677000133', '11877776666', 'carla.mota@example.com'),
('Gabriel Lima', '65465465466', NULL, '11766665555', 'gabriel.lima@example.com'),
('Isabela Rocha', '78978978955', NULL, '11655554444', 'isabela.rocha@example.com'),
('Ricardo Barros', NULL, '55667788000144', '11544443333', 'ricardo.barros@example.com'),
('Sandra Menezes', '98798798744', NULL, '11433332222', 'sandra.menezes@example.com'),
('Rafael Nunes', '12398712377', NULL, '11322221111', 'rafael.nunes@example.com'),
('Laura Azevedo', NULL, '66778899000155', '11911112222', 'laura.azevedo@example.com'),
('Thiago Borges', '45612345688', NULL, '11899998888', 'thiago.borges@example.com'),
('Patrícia Ramos', '78912378999', NULL, '11788887777', 'patricia.ramos@example.com'),
('Eduardo Moreira', NULL, '77889900000166', '11677776666', 'eduardo.moreira@example.com'),
('Beatriz Campos', '32178932166', NULL, '11566665555', 'beatriz.campos@example.com'),
('André Souza', '98732198755', NULL, '11455554444', 'andre.souza@example.com'),
('Alice Martins', '65498765444', NULL, '11344443333', 'alice.martins@example.com'),
('Leonardo Braga', NULL, '88990011000177', '11233332222', 'leonardo.braga@example.com'),
('Mariana Lopes', '32165432133', NULL, '11922221111', 'mariana.lopes@example.com'),
('Paulo Gonçalves', '78945678988', NULL, '11833334444', 'paulo.goncalves@example.com'),
('Fernanda Pinto', NULL, '99001122000188', '11744445555', 'fernanda.pinto@example.com'),
('Rodrigo Costa', '45678945677', NULL, '11655556666', 'rodrigo.costa@example.com'),
('Bruna Lima', '98712398766', NULL, '11566667777', 'bruna.lima@example.com'),
('Lucas Pereira', NULL, '11223344000199', '11477778888', 'lucas.pereira@example.com'),
('Camila Alves', '32145632155', NULL, '11388889999', 'camila.alves@example.com');

-- Registro dos funcionários
INSERT INTO tb_funcionarios (nome, data_nascimento, cpf, cargo, telefone, email, salario, data_contratacao) VALUES
('Mariana Lima', '1985-06-15', '12345678900', 'Gerente', '11987654321', 'mariana.lima@example.com', 5000.00, '2022-01-15'),
('Ricardo Santos', '1987-05-20', '22345678900', 'Maître', '11976543210', 'ricardo.santos@example.com', 4000.00, '2022-02-20'),
('Fernanda Alves', '1990-04-10', '32345678900', 'Garçom', '11965432109', 'fernanda.alves@example.com', 2000.00, '2022-03-10'),
('Júlio César', '1991-03-15', '42345678900', 'Garçom', '11954321098', 'julio.cesar@example.com', 2000.00, '2022-04-11'),
('Beatriz Gomes', '1989-02-25', '52345678900', 'Garçom', '11943210987', 'beatriz.gomes@example.com', 2000.00, '2022-05-12'),
('Lucas Souza', '1988-01-30', '62345678900', 'Cozinheiro', '11932109876', 'lucas.souza@example.com', 3000.00, '2022-06-13'),
('Marta Oliveira', '1986-07-22', '72345678900', 'Cozinheiro', '11921098765', 'marta.oliveira@example.com', 3000.00, '2022-07-14'),
('Pedro Henrique', '1992-09-18', '82345678900', 'Auxiliar de Cozinha', '11910987654', 'pedro.henrique@example.com', 1500.00, '2022-08-15'),
('Carla Mota', '1993-11-05', '92345678900', 'Auxiliar de Cozinha', '11909876543', 'carla.mota@example.com', 1500.00, '2022-09-16'),
('Rafael Silva', '1994-10-10', '10345678900', 'Bartender', '11908765432', 'rafael.silva@example.com', 2500.00, '2022-10-17'),
('Ana Paula', '1995-08-20', '11345678900', 'Bartender', '11907654321', 'ana.paula@example.com', 2500.00, '2022-11-18'),
('Jorge Santos', '1987-06-12', '12345678000', 'Caixa', '11906543210', 'jorge.santos@example.com', 2000.00, '2022-12-19'),
('Sofia Pereira', '1990-05-08', '13345678900', 'Caixa', '11905432109', 'sofia.pereira@example.com', 2000.00, '2023-01-20'),
('Felipe Rocha', '1991-03-25', '14345678900', 'Garçom', '11904321098', 'felipe.rocha@example.com', 2000.00, '2023-02-21'),
('Viviane Martins', '1989-02-14', '15345678900', 'Garçom', '11903210987', 'viviane.martins@example.com', 2000.00, '2023-03-22'),
('Thiago Borges', '1993-12-09', '16345678900', 'Garçom', '11902109876', 'thiago.borges@example.com', 2000.00, '2023-04-23'),
('Larissa Lima', '1988-11-11', '17345678900', 'Cozinheiro', '11901098765', 'larissa.lima@example.com', 3000.00, '2023-05-24'),
('Diego Oliveira', '1992-10-17', '18345678900', 'Cozinheiro', '11900987654', 'diego.oliveira@example.com', 3000.00, '2023-06-25'),
('Patrícia Rodrigues', '1994-09-22', '19345678900', 'Auxiliar de Cozinha', '11900876543', 'patricia.rodrigues@example.com', 1500.00, '2023-07-26'),
('Rodrigo Costa', '1995-08-18', '20345678900', 'Auxiliar de Cozinha', '11900765432', 'rodrigo.costa@example.com', 1500.00, '2023-08-27'),
('Camila Alves', '1996-07-15', '21345678900', 'Bartender', '11900654321', 'camila.alves@example.com', 2500.00, '2023-09-28'),
('Eduardo Moreira', '1997-06-12', '22345678900', 'Bartender', '11900543210', 'eduardo.moreira@example.com', 2500.00, '2023-10-29'),
('Alice Martins', '1988-05-17', '23345678900', 'Caixa', '11900432109', 'alice.martins@example.com', 2000.00, '2023-11-30'),
('Marcelo Nunes', '1991-04-22', '24345678900', 'Caixa', '11900321098', 'marcelo.nunes@example.com', 2000.00, '2023-12-01'),
('Fernanda Pinto', '1992-03-19', '25345678900', 'Garçom', '11900210987', 'fernanda.pinto@example.com', 2000.00, '2024-01-02');

-- Registro dos endereços dos funcionários
INSERT INTO tb_endereco_funcionario (id_funcionario, logradouro, numero, complemento, cidade, estado, cep) VALUES
(1, 'Rua A', 123, 'Apto 1', 'São Paulo', 'SP', '12345678'),
(2, 'Rua B', 456, 'Casa', 'Rio de Janeiro', 'RJ', '23456789'),
(3, 'Rua C', 789, 'Cobertura', 'Belo Horizonte', 'MG', '34567890'),
(4, 'Avenida D', 101, 'Bloco 2', 'Curitiba', 'PR', '45678901'),
(5, 'Travessa E', 202, 'Fundos', 'Porto Alegre', 'RS', '56789012'),
(6, 'Praça F', 303, '', 'Fortaleza', 'CE', '67890123'),
(7, 'Alameda G', 404, 'Cobertura', 'Salvador', 'BA', '78901234'),
(8, 'Rua H', 505, 'Apto 5', 'Florianópolis', 'SC', '89012345'),
(9, 'Avenida I', 606, 'Casa', 'Manaus', 'AM', '90123456'),
(10, 'Travessa J', 707, 'Bloco 1', 'Goiânia', 'GO', '01234567'),
(11, 'Praça K', 808, 'Fundos', 'Belém', 'PA', '12345078'),
(12, 'Alameda L', 909, '', 'Campo Grande', 'MS', '23456189'),
(13, 'Rua M', 1010, 'Apto 10', 'São Luís', 'MA', '34567290'),
(14, 'Avenida N', 1111, 'Bloco 3', 'Natal', 'RN', '45678301'),
(15, 'Travessa O', 1212, 'Cobertura', 'João Pessoa', 'PB', '56789412'),
(16, 'Praça P', 1313, 'Fundos', 'Maceió', 'AL', '67890523'),
(17, 'Alameda Q', 1414, 'Apto 14', 'Aracaju', 'SE', '78901634'),
(18, 'Rua R', 1515, 'Casa', 'Boa Vista', 'RR', '89012745'),
(19, 'Avenida S', 1616, 'Bloco 2', 'Palmas', 'TO', '90123856'),
(20, 'Travessa T', 1717, 'Fundos', 'Teresina', 'PI', '01234967'),
(21, 'Praça U', 1818, '', 'Macapá', 'AP', '12345078'),
(22, 'Alameda V', 1919, 'Apto 19', 'Rio Branco', 'AC', '23456189'),
(23, 'Rua W', 2020, 'Casa', 'Vitória', 'ES', '34567290'),
(24, 'Avenida X', 2121, 'Bloco 1', 'Porto Velho', 'RO', '45678301'),
(25, 'Travessa Y', 2222, 'Cobertura', 'Recife', 'PE', '56789412');

-- Registro dos itens do menu
INSERT INTO tb_menu (nome, descricao, preco) VALUES
-- Bebidas
('Água Mineral', 'Água mineral sem gás', 2.50),
('Refrigerante', 'Refrigerante de cola', 4.00),
('Suco de Laranja', 'Suco natural de laranja', 6.00),
('Cerveja', 'Cerveja lager 350ml', 8.00),
('Vinho Tinto', 'Vinho tinto seco, taça', 12.00),

-- Entradas
('Salada Caesar', 'Salada com alface, croutons, queijo parmesão e molho Caesar', 15.00),
('Bruschetta', 'Bruschetta de tomate com manjericão', 12.00),
('Sopa de Cebola', 'Sopa de cebola gratinada', 18.00),
('Carpaccio', 'Carpaccio de carne com rúcula e parmesão', 20.00),
('Mini Coxinhas', 'Porção de mini coxinhas', 10.00),

-- Pratos Principais
('Pizza Margherita', 'Pizza com molho de tomate, mussarela e manjericão', 30.00),
('Spaghetti Carbonara', 'Massa com molho de ovos, queijo parmesão e bacon', 40.00),
('Filé à Parmegiana', 'Filé de frango à milanesa com molho de tomate e queijo', 45.00),
('Feijoada', 'Feijoada completa com arroz, farofa e couve', 50.00),
('Risoto de Camarão', 'Risoto de camarão com queijo parmesão', 55.00),

-- Adicionais
('Batata Frita', 'Porção de batata frita', 8.00),
('Arroz Branco', 'Porção de arroz branco', 5.00),
('Farofa', 'Porção de farofa', 6.00),
('Salada Verde', 'Salada de folhas verdes', 10.00),
('Molho de Pimenta', 'Molho de pimenta artesanal', 3.00),

-- Sobremesas
('Pudim de Leite', 'Pudim de leite condensado', 8.00),
('Sorvete', 'Sorvete de creme, porção', 7.00),
('Torta de Limão', 'Torta de limão com merengue', 10.00),
('Mousse de Chocolate', 'Mousse de chocolate meio amargo', 9.00),
('Creme Brulee', 'Creme brulee com crosta de açúcar queimado', 12.00),

-- Bebidas (continuação)
('Suco de Abacaxi', 'Suco natural de abacaxi', 6.00),
('Suco de Manga', 'Suco natural de manga', 6.00),
('Refrigerante de Laranja', 'Refrigerante sabor laranja', 4.00),
('Cerveja Artesanal', 'Cerveja artesanal 350ml', 10.00),
('Caipirinha', 'Caipirinha tradicional de limão', 15.00),

-- Entradas (continuação)
('Guacamole com Tortilhas', 'Guacamole com tortilhas de milho', 20.00),
('Pastel de Camarão', 'Pastel de camarão com catupiry', 15.00),
('Bolinho de Bacalhau', 'Porção de bolinhos de bacalhau', 18.00),
('Empanadas', 'Empanadas argentinas de carne', 12.00),
('Mini Quiches', 'Mini quiches de queijo e espinafre', 14.00),

-- Pratos Principais (continuação)
('Lasanha Bolonhesa', 'Lasanha à bolonhesa gratinada', 35.00),
('Frango Grelhado', 'Frango grelhado com legumes', 28.00),
('Bife Ancho', 'Bife ancho grelhado com batatas rústicas', 50.00),
('Paella', 'Paella de frutos do mar', 65.00),
('Salmão ao Molho de Maracujá', 'Salmão grelhado ao molho de maracujá', 60.00),

-- Adicionais (continuação)
('Legumes Grelhados', 'Porção de legumes grelhados', 12.00),
('Purê de Batata', 'Porção de purê de batata', 8.00),
('Vinagrete', 'Porção de vinagrete', 5.00),
('Polenta Frita', 'Porção de polenta frita', 10.00),
('Couve Refogada', 'Porção de couve refogada', 6.00);

INSERT INTO tb_menu (nome, descricao, preco) VALUES
-- Bebidas
('Água com Gás', 'Água mineral com gás', 3.00),
('Refrigerante Diet', 'Refrigerante de cola diet', 4.00),
('Suco de Uva', 'Suco natural de uva', 7.00),
('Cerveja Escura', 'Cerveja escura 350ml', 9.00),
('Vinho Branco', 'Vinho branco seco, taça', 12.00),

-- Entradas
('Salada Caprese', 'Salada com tomate, mussarela de búfala e manjericão', 15.00),
('Bolinho de Queijo', 'Porção de bolinhos de queijo', 10.00),
('Sopa de Abóbora', 'Sopa cremosa de abóbora', 18.00),
('Tartar de Salmão', 'Tartar de salmão com abacate', 20.00),
('Anéis de Lula', 'Anéis de lula empanados', 18.00),

-- Pratos Principais
('Pizza Calabresa', 'Pizza com calabresa e cebola', 35.00),
('Fettuccine Alfredo', 'Fettuccine com molho Alfredo', 38.00),
('Peixe à Belle Meunière', 'Filé de peixe ao molho de alcaparras', 42.00),
('Galinhada', 'Galinhada com arroz e pequi', 45.00),
('Risoto de Funghi', 'Risoto de funghi seco com parmesão', 48.00),

-- Adicionais
('Onion Rings', 'Porção de onion rings', 12.00),
('Arroz à Grega', 'Porção de arroz à grega', 7.00),
('Bacon', 'Porção de bacon', 8.00),
('Salada de Tomate', 'Salada de tomate com cebola', 9.00),
('Molho Barbecue', 'Molho barbecue caseiro', 4.00),

-- Sobremesas
('Cheesecake', 'Cheesecake com calda de frutas vermelhas', 12.00),
('Petit Gâteau', 'Petit gâteau com sorvete de creme', 14.00),
('Tiramisu', 'Tiramisu tradicional', 11.00),
('Brownie', 'Brownie de chocolate com nozes', 10.00),
('Profiteroles', 'Profiteroles recheados com creme de baunilha', 13.00),

-- Bebidas (continuação)
('Suco de Morango', 'Suco natural de morango', 7.00),
('Suco de Acerola', 'Suco natural de acerola', 6.00),
('Refrigerante de Guaraná', 'Refrigerante sabor guaraná', 4.00),
('Cerveja de Trigo', 'Cerveja de trigo 350ml', 11.00),
('Margarita', 'Margarita clássica', 18.00),

-- Entradas (continuação)
('Camarão Empanado', 'Camarão empanado com molho tártaro', 25.00),
('Azeitonas Empanadas', 'Porção de azeitonas empanadas', 10.00),
('Fondue de Queijo', 'Fondue de queijo com pão', 22.00),
('Ceviche', 'Ceviche de peixe branco', 20.00),
('Canapés', 'Canapés variados', 15.00),

-- Pratos Principais (continuação)
('Linguini ao Pesto', 'Linguini com molho pesto', 35.00),
('Costela no Bafo', 'Costela no bafo com mandioca', 50.00),
('Polenta com Ragu', 'Polenta cremosa com ragu de carne', 40.00),
('Moqueca', 'Moqueca de peixe com arroz e farofa', 55.00),
('Nhoque ao Sugo', 'Nhoque de batata com molho sugo', 30.00),

-- Adicionais (continuação)
('Queijo Coalho', 'Porção de queijo coalho grelhado', 10.00),
('Feijão Tropeiro', 'Porção de feijão tropeiro', 8.00),
('Farofa', 'Porção de farofa', 7.00),
('Maionese', 'Porção de maionese', 5.00),
('Molho de Iogurte', 'Molho de iogurte com ervas', 4.00);

INSERT INTO tb_menu (nome, descricao, preco) VALUES
-- Bebidas
('Chá Gelado', 'Chá gelado de limão', 5.00),
('Limonada', 'Limonada suíça', 6.00),
('Café Expresso', 'Café expresso curto', 4.00),
('Chá Verde', 'Chá verde natural', 5.00),
('Smoothie de Morango', 'Smoothie de morango com banana', 8.00),

-- Entradas
('Caprese Skewers', 'Espetinhos caprese com tomate, queijo e manjericão', 12.00),
('Spring Rolls', 'Rolinho primavera com molho agridoce', 10.00),
('Pães de Queijo', 'Porção de pães de queijo', 8.00),
('Salada Grega', 'Salada com tomate, pepino, azeitonas e queijo feta', 15.00),
('Batata Recheada', 'Batata assada recheada com cheddar e bacon', 18.00),

-- Pratos Principais
('Frango à Cubana', 'Frango à cubana com arroz, batata palha e banana frita', 38.00),
('Strogonoff de Carne', 'Strogonoff de carne com arroz e batata palha', 42.00),
('Picadinho', 'Picadinho de carne com arroz e feijão', 35.00),
('Picanha na Chapa', 'Picanha na chapa com farofa e vinagrete', 55.00),
('Escondidinho de Carne Seca', 'Escondidinho de carne seca com purê de mandioca', 40.00),

-- Adicionais
('Palmito Grelhado', 'Porção de palmito grelhado', 12.00),
('Cuscuz Paulista', 'Porção de cuscuz paulista', 8.00),
('Salpicão', 'Porção de salpicão de frango', 10.00),
('Tomates Confitados', 'Porção de tomates confitados', 9.00),
('Brócolis Refogado', 'Porção de brócolis refogado', 7.00),

-- Sobremesas
('Bolo de Cenoura', 'Bolo de cenoura com cobertura de chocolate', 9.00),
('Pavê de Chocolate', 'Pavê de chocolate com biscoito', 11.00),
('Manjar de Coco', 'Manjar de coco com calda de ameixa', 10.00),
('Gelatina Colorida', 'Gelatina colorida em camadas', 7.00),
('Merengue de Morango', 'Merengue de morango com chantilly', 12.00),

-- Bebidas (continuação)
('Suco de Melancia', 'Suco natural de melancia', 6.00),
('Suco Detox', 'Suco detox com couve, limão e gengibre', 7.00),
('Refrigerante de Limão', 'Refrigerante sabor limão', 4.00),
('Cerveja Pilsen', 'Cerveja pilsen 350ml', 8.00),
('Espumante', 'Espumante seco, taça', 15.00),

-- Entradas (continuação)
('Dadinho de Tapioca', 'Dadinho de tapioca com geleia de pimenta', 14.00),
('Ostras Frescas', 'Ostras frescas com limão', 25.00),
('Ceviche de Polvo', 'Ceviche de polvo com coentro', 22.00),
('Torresmo', 'Porção de torresmo crocante', 10.00),
('Patê de Atum', 'Patê de atum com torradinhas', 12.00),

-- Pratos Principais (continuação)
('Baião de Dois', 'Baião de dois com carne seca e feijão verde', 40.00),
('Cozido', 'Cozido de carne com legumes e pirão', 45.00),
('Moela ao Molho', 'Moela ao molho com arroz e purê', 30.00),
('Rabada', 'Rabada com agrião e polenta', 42.00),
('Bacalhau à Gomes de Sá', 'Bacalhau à Gomes de Sá com batatas e azeitonas', 60.00),

-- Adicionais (continuação)
('Batata Rústica', 'Porção de batata rústica', 8.00),
('Tabule', 'Porção de tabule', 7.00),
('Chips de Batata Doce', 'Porção de chips de batata doce', 6.00),
('Molho de Mostarda', 'Molho de mostarda e mel', 3.00),
('Molho Chimichurri', 'Molho chimichurri', 4.00);

INSERT INTO tb_menu (nome, descricao, preco) VALUES
-- Bebidas
('Suco de Abacate', 'Suco natural de abacate', 6.00),
('Água de Coco', 'Água de coco natural', 7.00),
('Chá Mate', 'Chá mate gelado', 4.00),
('Smoothie de Abacaxi', 'Smoothie de abacaxi com hortelã', 8.00),
('Frapê de Cappuccino', 'Frapê gelado de cappuccino', 9.00),

-- Entradas
('Tartare de Atum', 'Tartare de atum com abacate', 22.00),
('Croquete de Carne', 'Croquete de carne com molho de mostarda', 12.00),
('Asinha de Frango', 'Asinha de frango com molho barbecue', 18.00),
('Salada de Frutas', 'Salada de frutas frescas', 14.00),
('Patê de Frango', 'Patê de frango com ervas e torradas', 10.00),

-- Pratos Principais
('Tilápia Grelhada', 'Tilápia grelhada com legumes', 38.00),
('Ragu de Cordeiro', 'Ragu de cordeiro com purê de batata', 45.00),
('Penne à Putanesca', 'Penne com molho putanesca', 35.00),
('Empadão Goiano', 'Empadão goiano com frango e pequi', 30.00),
('Camarão na Moranga', 'Camarão na moranga com arroz branco', 55.00),

-- Adicionais
('Farofa de Banana', 'Porção de farofa de banana', 8.00),
('Vinagrete de Manga', 'Porção de vinagrete de manga', 7.00),
('Couve Crocante', 'Porção de couve crocante', 6.00),
('Molho Rosé', 'Molho rosé caseiro', 4.00),
('Purê de Cenoura', 'Porção de purê de cenoura', 5.00),

-- Sobremesas
('Banoffee', 'Torta banoffee', 12.00),
('Cocada', 'Cocada cremosa', 8.00),
('Gelato', 'Gelato artesanal, porção', 10.00),
('Rabanada', 'Rabanada com calda de vinho', 7.00),
('Pudim de Tapioca', 'Pudim de tapioca com calda de coco', 11.00),

-- Bebidas (continuação)
('Suco de Caju', 'Suco natural de caju', 6.00),
('Smoothie de Manga', 'Smoothie de manga e laranja', 8.00),
('Refrigerante de Limão Siciliano', 'Refrigerante sabor limão siciliano', 5.00),
('Cerveja Red Ale', 'Cerveja Red Ale 350ml', 9.00),
('Piña Colada', 'Piña Colada clássica', 12.00),

-- Entradas (continuação)
('Tábua de Frios', 'Tábua de frios variados', 25.00),
('Linguiça Artesanal', 'Linguiça artesanal com farofa', 20.00),
('Quibe Frito', 'Porção de quibe frito', 15.00),
('Caldo Verde', 'Caldo verde com couve e linguiça', 18.00),
('Croquete de Bacalhau', 'Porção de croquetes de bacalhau', 20.00),

-- Pratos Principais (continuação)
('Strogonoff de Frango', 'Strogonoff de frango com arroz e batata palha', 35.00),
('Tilápia ao Molho de Alcaparras', 'Tilápia grelhada ao molho de alcaparras', 42.00),
('Esfiha', 'Esfiha de carne ou queijo', 10.00),
('Carne de Sol', 'Carne de sol com mandioca', 38.00),
('Pizza de Pepperoni', 'Pizza com pepperoni e mussarela', 32.00),

-- Adicionais (continuação)
('Batata Rústica', 'Porção de batata rústica', 8.00),
('Tabule', 'Porção de tabule', 7.00),
('Chips de Batata Doce', 'Porção de chips de batata doce', 6.00),
('Molho de Mostarda', 'Molho de mostarda e mel', 3.00),
('Molho Chimichurri', 'Molho chimichurri', 4.00);

-- Registro das mesas
INSERT INTO tb_mesas (capacidade, localizacao) VALUES
(4, 'Sala Principal'),
(2, 'Varanda'),
(6, 'Sala VIP'),
(4, 'Sala Principal'),
(4, 'Sala Principal'),
(4, 'Sala Principal'),
(6, 'Sala VIP'),
(2, 'Varanda'),
(6, 'Sala VIP'),
(4, 'Sala Principal'),
(2, 'Varanda'),
(6, 'Sala VIP'),
(4, 'Sala Principal'),
(4, 'Sala Principal'),
(4, 'Sala Principal'),
(6, 'Sala VIP'),
(2, 'Varanda'),
(6, 'Sala VIP'),
(4, 'Sala Principal'),
(2, 'Varanda'),
(6, 'Sala VIP'),
(4, 'Sala Principal'),
(4, 'Sala Principal'),
(4, 'Sala Principal'),
(6, 'Sala VIP'),
(2, 'Varanda'),
(6, 'Sala VIP'),
(4, 'Sala Principal'),
(2, 'Varanda'),
(6, 'Sala VIP'),
(4, 'Sala Principal'),
(4, 'Sala Principal'),
(4, 'Sala Principal'),
(6, 'Sala VIP'),
(2, 'Varanda');

-- Registro dos fornecedores
INSERT INTO tb_fornecedores (nome, cnpj, telefone, email) VALUES
('Fornecedor A', '11111111000101', '1133334444', 'fornecedora@example.com'),
('Fornecedor B', '22222222000202', '1144445555', 'fornecedorb@example.com'),
('Fornecedor C', '33333333000303', '1155556666', 'fornecedorc@example.com'),
('Fornecedor D', '44444444000404', '1166667777', 'fornecedord@example.com'),
('Fornecedor E', '55555555000505', '1177778888', 'fornecedore@example.com'),
('Fornecedor F', '66666666000606', '1188889999', 'fornecedorf@example.com'),
('Fornecedor G', '77777777000707', '1199990000', 'fornecedorg@example.com'),
('Fornecedor H', '88888888000808', '1100001111', 'fornecedorh@example.com'),
('Fornecedor I', '99999999000909', '1122223333', 'fornecedori@example.com'),
('Fornecedor J', '10101010101010', '1133334444', 'fornecedorj@example.com'),
('Fornecedor K', '11111111111111', '1144445555', 'fornecedork@example.com'),
('Fornecedor L', '12121212121212', '1155556666', 'fornecedorl@example.com'),
('Fornecedor M', '13131313131313', '1166667777', 'fornecedorm@example.com'),
('Fornecedor N', '14141414141414', '1177778888', 'fornecedorn@example.com'),
('Fornecedor O', '15151515151515', '1188889999', 'fornecedoro@example.com'),
('Fornecedor P', '16161616161616', '1199990000', 'fornecedorp@example.com'),
('Fornecedor Q', '17171717171717', '1100001111', 'fornecedorq@example.com'),
('Fornecedor R', '18181818181818', '1111112222', 'fornecedorr@example.com');

-- Registro dos pedidos
INSERT INTO tb_pedidos (id_cliente, id_funcionario, id_mesa, data_pedido, status) VALUES
(1, 1, 1, '2022-01-05 12:00:00', 'Finalizado'),
(2, 2, 2, '2022-01-10 13:30:00', 'Finalizado'),
(3, 3, 3, '2022-01-15 14:15:00', 'Finalizado'),
(4, 4, 4, '2022-01-20 15:00:00', 'Finalizado'),
(5, 5, 5, '2022-01-25 12:30:00', 'Finalizado'),
(6, 6, 6, '2022-02-01 13:00:00', 'Finalizado'),
(7, 7, 7, '2022-02-05 14:30:00', 'Finalizado'),
(8, 8, 8, '2022-02-10 15:15:00', 'Finalizado'),
(9, 9, 9, '2022-02-15 12:00:00', 'Finalizado'),
(10, 10, 10, '2022-02-20 13:30:00', 'Finalizado'),
(11, 11, 11, '2022-02-25 14:15:00', 'Finalizado'),
(12, 12, 12, '2022-03-01 15:00:00', 'Finalizado'),
(13, 13, 13, '2022-03-05 12:30:00', 'Finalizado'),
(14, 14, 14, '2022-03-10 13:00:00', 'Finalizado'),
(15, 15, 15, '2022-03-15 14:30:00', 'Finalizado'),
(16, 16, 16, '2022-03-20 15:15:00', 'Finalizado'),
(17, 17, 17, '2022-03-25 12:00:00', 'Finalizado'),
(18, 18, 18, '2022-04-01 13:30:00', 'Finalizado'),
(19, 19, 19, '2022-04-05 14:15:00', 'Finalizado'),
(20, 20, 20, '2022-04-10 15:00:00', 'Finalizado'),
(21, 21, 21, '2022-04-15 12:30:00', 'Finalizado'),
(22, 22, 22, '2022-04-20 13:00:00', 'Finalizado'),
(23, 23, 23, '2022-04-25 14:30:00', 'Finalizado'),
(24, 24, 24, '2022-05-01 15:15:00', 'Finalizado'),
(25, 25, 25, '2022-05-05 12:00:00', 'Finalizado'),
(1, 1, 1, '2022-05-10 13:30:00', 'Finalizado'),
(2, 2, 2, '2022-05-15 14:15:00', 'Finalizado'),
(3, 3, 3, '2022-05-20 15:00:00', 'Finalizado'),
(4, 4, 4, '2022-05-25 12:30:00', 'Finalizado'),
(5, 5, 5, '2022-06-01 13:00:00', 'Finalizado'),
(6, 6, 6, '2022-06-05 14:30:00', 'Finalizado'),
(7, 7, 7, '2022-06-10 15:15:00', 'Finalizado'),
(8, 8, 8, '2022-06-15 12:00:00', 'Finalizado'),
(9, 9, 9, '2022-06-20 13:30:00', 'Finalizado'),
(10, 10, 10, '2022-06-25 14:15:00', 'Finalizado'),
(11, 11, 11, '2022-07-01 15:00:00', 'Finalizado'),
(12, 12, 12, '2022-07-05 12:30:00', 'Finalizado'),
(13, 13, 13, '2022-07-10 13:00:00', 'Finalizado'),
(14, 14, 14, '2022-07-15 14:30:00', 'Finalizado'),
(15, 15, 15, '2022-07-20 15:15:00', 'Finalizado'),
(16, 16, 16, '2022-07-25 12:00:00', 'Finalizado'),
(17, 17, 17, '2022-08-01 13:30:00', 'Finalizado'),
(18, 18, 18, '2022-08-05 14:15:00', 'Finalizado'),
(19, 19, 19, '2022-08-10 15:00:00', 'Finalizado'),
(20, 20, 20, '2022-08-15 12:30:00', 'Finalizado'),
(21, 21, 21, '2022-08-20 13:00:00', 'Finalizado'),
(22, 22, 22, '2022-08-25 14:30:00', 'Finalizado'),
(23, 23, 23, '2022-09-01 15:15:00', 'Finalizado'),
(24, 24, 24, '2022-09-05 12:00:00', 'Finalizado'),
(25, 25, 25, '2022-09-10 13:30:00', 'Finalizado'),
(1, 1, 1, '2023-01-05 12:00:00', 'Finalizado'),
(2, 2, 2, '2023-01-10 13:30:00', 'Finalizado'),
(3, 3, 3, '2023-01-15 14:15:00', 'Finalizado'),
(4, 4, 4, '2023-01-20 15:00:00', 'Finalizado'),
(5, 5, 5, '2023-01-25 12:30:00', 'Finalizado'),
(6, 6, 6, '2023-02-01 13:00:00', 'Finalizado'),
(7, 7, 7, '2023-02-05 14:30:00', 'Finalizado'),
(8, 8, 8, '2023-02-10 15:15:00', 'Finalizado'),
(9, 9, 9, '2023-02-15 12:00:00', 'Finalizado'),
(10, 10, 10, '2023-02-20 13:30:00', 'Finalizado'),
(11, 11, 11, '2023-02-25 14:15:00', 'Finalizado'),
(12, 12, 12, '2023-03-01 15:00:00', 'Finalizado'),
(13, 13, 13, '2023-03-05 12:30:00', 'Finalizado'),
(14, 14, 14, '2023-03-10 13:00:00', 'Finalizado'),
(15, 15, 15, '2023-03-15 14:30:00', 'Finalizado'),
(16, 16, 16, '2023-03-20 15:15:00', 'Finalizado'),
(17, 17, 17, '2023-03-25 12:00:00', 'Finalizado'),
(18, 18, 18, '2023-04-01 13:30:00', 'Finalizado'),
(19, 19, 19, '2023-04-05 14:15:00', 'Finalizado'),
(20, 20, 20, '2023-04-10 15:00:00', 'Finalizado'),
(21, 21, 21, '2023-04-15 12:30:00', 'Finalizado'),
(22, 22, 22, '2023-04-20 13:00:00', 'Finalizado'),
(23, 23, 23, '2023-04-25 14:30:00', 'Finalizado'),
(24, 24, 24, '2023-05-01 15:15:00', 'Finalizado'),
(25, 25, 25, '2023-05-05 12:00:00', 'Finalizado'),
(1, 1, 1, '2023-05-10 13:30:00', 'Finalizado'),
(2, 2, 2, '2023-05-15 14:15:00', 'Finalizado'),
(3, 3, 3, '2023-05-20 15:00:00', 'Finalizado'),
(4, 4, 4, '2023-05-25 12:30:00', 'Finalizado'),
(5, 5, 5, '2023-06-01 13:00:00', 'Finalizado'),
(6, 6, 6, '2023-06-05 14:30:00', 'Finalizado'),
(7, 7, 7, '2023-06-10 15:15:00', 'Finalizado'),
(8, 8, 8, '2023-06-15 12:00:00', 'Finalizado'),
(9, 9, 9, '2023-06-20 13:30:00', 'Finalizado'),
(10, 10, 10, '2023-06-25 14:15:00', 'Finalizado'),
(11, 11, 11, '2023-07-01 15:00:00', 'Finalizado'),
(12, 12, 12, '2023-07-05 12:30:00', 'Finalizado'),
(13, 13, 13, '2023-07-10 13:00:00', 'Finalizado'),
(14, 14, 14, '2023-07-15 14:30:00', 'Finalizado'),
(15, 15, 15, '2023-07-20 15:15:00', 'Finalizado'),
(16, 16, 16, '2023-07-25 12:00:00', 'Finalizado'),
(17, 17, 17, '2023-08-01 13:30:00', 'Finalizado'),
(18, 18, 18, '2023-08-05 14:15:00', 'Finalizado'),
(19, 19, 19, '2023-08-10 15:00:00', 'Finalizado'),
(20, 20, 20, '2023-08-15 12:30:00', 'Finalizado'),
(21, 21, 21, '2023-08-20 13:00:00', 'Finalizado'),
(22, 22, 22, '2023-08-25 14:30:00', 'Finalizado'),
(23, 23, 23, '2023-09-01 15:15:00', 'Finalizado'),
(24, 24, 24, '2023-09-05 12:00:00', 'Finalizado'),
(25, 25, 25, '2023-09-10 13:30:00', 'Finalizado'),
(1, 1, 1, '2023-09-15 14:15:00', 'Finalizado'),
(2, 2, 2, '2023-09-20 15:00:00', 'Finalizado'),
(3, 3, 3, '2023-09-25 12:30:00', 'Finalizado'),
(4, 4, 4, '2023-10-01 13:00:00', 'Finalizado'),
(5, 5, 5, '2023-10-05 14:30:00', 'Finalizado'),
(6, 6, 6, '2023-10-10 15:15:00', 'Finalizado'),
(7, 7, 7, '2023-10-15 12:00:00', 'Finalizado'),
(8, 8, 8, '2023-10-20 13:30:00', 'Finalizado'),
(9, 9, 9, '2023-10-25 14:15:00', 'Finalizado'),
(10, 10, 10, '2023-11-01 15:00:00', 'Finalizado'),
(1, 1, 1, '2024-01-03 12:00:00', 'Finalizado'),
(2, 2, 2, '2024-01-07 13:30:00', 'Finalizado'),
(3, 3, 3, '2024-01-10 14:15:00', 'Finalizado'),
(4, 4, 4, '2024-01-13 15:00:00', 'Finalizado'),
(5, 5, 5, '2024-01-16 12:30:00', 'Finalizado'),
(6, 6, 6, '2024-01-19 13:00:00', 'Finalizado'),
(7, 7, 7, '2024-01-22 14:30:00', 'Finalizado'),
(8, 8, 8, '2024-01-25 15:15:00', 'Finalizado'),
(9, 9, 9, '2024-01-28 12:00:00', 'Finalizado'),
(10, 10, 10, '2024-02-01 13:30:00', 'Finalizado'),
(11, 11, 11, '2024-02-04 14:15:00', 'Finalizado'),
(12, 12, 12, '2024-02-07 15:00:00', 'Finalizado'),
(13, 13, 13, '2024-02-10 12:30:00', 'Finalizado'),
(14, 14, 14, '2024-02-13 13:00:00', 'Finalizado'),
(15, 15, 15, '2024-02-16 14:30:00', 'Finalizado'),
(16, 16, 16, '2024-02-19 15:15:00', 'Finalizado'),
(17, 17, 17, '2024-02-22 12:00:00', 'Finalizado'),
(18, 18, 18, '2024-02-25 13:30:00', 'Finalizado'),
(19, 19, 19, '2024-02-28 14:15:00', 'Finalizado'),
(20, 20, 20, '2024-03-02 15:00:00', 'Finalizado'),
(21, 21, 21, '2024-03-05 12:30:00', 'Finalizado'),
(22, 22, 22, '2024-03-08 13:00:00', 'Finalizado'),
(23, 23, 23, '2024-03-11 14:30:00', 'Finalizado'),
(24, 24, 24, '2024-03-14 15:15:00', 'Finalizado'),
(25, 25, 25, '2024-03-17 12:00:00', 'Finalizado'),
(1, 1, 1, '2024-03-20 13:30:00', 'Finalizado'),
(2, 2, 2, '2024-03-23 14:15:00', 'Finalizado'),
(3, 3, 3, '2024-03-26 15:00:00', 'Finalizado'),
(4, 4, 4, '2024-03-29 12:30:00', 'Finalizado'),
(5, 5, 5, '2024-04-01 13:00:00', 'Finalizado'),
(6, 6, 6, '2024-04-04 14:30:00', 'Finalizado'),
(7, 7, 7, '2024-04-07 15:15:00', 'Finalizado'),
(8, 8, 8, '2024-04-10 12:00:00', 'Finalizado'),
(9, 9, 9, '2024-04-13 13:30:00', 'Finalizado'),
(10, 10, 10, '2024-04-16 14:15:00', 'Finalizado'),
(11, 11, 11, '2024-04-19 15:00:00', 'Finalizado'),
(12, 12, 12, '2024-04-22 12:30:00', 'Finalizado'),
(13, 13, 13, '2024-04-25 13:00:00', 'Finalizado'),
(14, 14, 14, '2024-04-28 14:30:00', 'Finalizado'),
(16, 1, 16, '2024-04-17 14:15:00', 'Finalizado'),
(17, 2, 17, '2024-05-18 15:00:00', 'Finalizado'),
(18, 3, 18, '2024-06-19 12:30:00', 'Finalizado'),
(19, 4, 19, '2024-07-20 13:00:00', 'Finalizado'),
(20, 5, 20, '2024-08-21 14:30:00', 'Finalizado'),
(21, 6, 21, '2024-09-22 15:15:00', 'Finalizado'),
(22, 7, 22, '2024-10-23 12:00:00', 'Finalizado'),
(23, 8, 23, '2024-11-24 13:30:00', 'Finalizado'),
(24, 9, 24, '2024-12-25 14:15:00', 'Finalizado'),
(25, 10, 25, '2024-01-01 15:00:00', 'Finalizado'),
(1, 11, 1, '2024-02-02 12:30:00', 'Finalizado'),
(2, 12, 2, '2024-03-03 13:00:00', 'Finalizado'),
(3, 13, 3, '2024-04-04 14:30:00', 'Finalizado'),
(4, 14, 4, '2024-05-05 15:15:00', 'Finalizado'),
(5, 15, 5, '2024-06-06 12:00:00', 'Finalizado'),
(6, 16, 6, '2024-07-07 13:30:00', 'Finalizado'),
(7, 17, 7, '2024-08-08 14:15:00', 'Finalizado'),
(8, 18, 8, '2024-09-09 15:00:00', 'Finalizado'),
(9, 19, 9, '2024-10-10 12:30:00', 'Finalizado'),
(10, 20, 10, '2024-11-11 13:00:00', 'Finalizado'),
(11, 21, 11, '2024-12-12 14:30:00', 'Finalizado'),
(12, 22, 12, '2024-01-13 15:15:00', 'Finalizado'),
(13, 23, 13, '2024-02-14 12:00:00', 'Finalizado'),
(14, 24, 14, '2024-03-15 13:30:00', 'Finalizado'),
(15, 25, 15, '2024-04-16 14:15:00', 'Finalizado'),
(16, 1, 16, '2024-05-17 15:00:00', 'Finalizado'),
(17, 2, 17, '2024-06-18 12:30:00', 'Finalizado'),
(18, 3, 18, '2024-07-19 13:00:00', 'Finalizado'),
(19, 4, 19, '2024-08-20 14:30:00', 'Finalizado'),
(20, 5, 20, '2024-09-21 15:15:00', 'Finalizado'),
(21, 6, 21, '2024-10-22 12:00:00', 'Finalizado'),
(22, 7, 22, '2024-11-23 13:30:00', 'Finalizado'),
(23, 8, 23, '2024-12-24 14:15:00', 'Finalizado'),
(24, 9, 24, '2024-01-25 15:00:00', 'Finalizado'),
(25, 10, 25, '2024-02-01 12:30:00', 'Finalizado'),
(1, 11, 1, '2024-03-02 13:00:00', 'Finalizado'),
(2, 12, 2, '2024-04-03 14:30:00', 'Finalizado'),
(3, 13, 3, '2024-05-04 15:15:00', 'Finalizado'),
(4, 14, 4, '2024-06-05 12:00:00', 'Finalizado'),
(5, 15, 5, '2024-07-06 13:30:00', 'Finalizado'),
(6, 16, 6, '2024-08-07 14:15:00', 'Finalizado'),
(7, 17, 7, '2024-09-08 15:00:00', 'Finalizado'),
(8, 18, 8, '2024-10-09 12:30:00', 'Finalizado'),
(9, 19, 9, '2024-11-10 13:00:00', 'Finalizado'),
(10, 20, 10, '2024-12-11 14:30:00', 'Finalizado'),
(16, 1, 16, '2024-04-17 14:15:00', 'Finalizado'),
(17, 2, 17, '2024-05-18 15:00:00', 'Finalizado'),
(18, 3, 18, '2024-06-19 12:30:00', 'Finalizado'),
(19, 4, 19, '2024-07-20 13:00:00', 'Finalizado'),
(20, 5, 20, '2024-08-21 14:30:00', 'Finalizado'),
(21, 6, 21, '2024-09-22 15:15:00', 'Finalizado'),
(22, 7, 22, '2024-10-23 12:00:00', 'Finalizado'),
(23, 8, 23, '2024-11-24 13:30:00', 'Finalizado'),
(24, 9, 24, '2024-12-25 14:15:00', 'Finalizado'),
(25, 10, 25, '2024-01-01 15:00:00', 'Finalizado'),
(1, 11, 1, '2024-02-02 12:30:00', 'Finalizado'),
(2, 12, 2, '2024-03-03 13:00:00', 'Finalizado'),
(3, 13, 3, '2024-04-04 14:30:00', 'Finalizado'),
(4, 14, 4, '2024-05-05 15:15:00', 'Finalizado'),
(5, 15, 5, '2024-06-06 12:00:00', 'Finalizado'),
(6, 16, 6, '2024-07-07 13:30:00', 'Finalizado'),
(7, 17, 7, '2024-08-08 14:15:00', 'Finalizado'),
(8, 18, 8, '2024-09-09 15:00:00', 'Finalizado'),
(9, 19, 9, '2024-10-10 12:30:00', 'Finalizado'),
(10, 20, 10, '2024-11-11 13:00:00', 'Finalizado'),
(11, 21, 11, '2024-12-12 14:30:00', 'Finalizado'),
(12, 22, 12, '2024-01-13 15:15:00', 'Finalizado'),
(13, 23, 13, '2024-02-14 12:00:00', 'Finalizado'),
(14, 24, 14, '2024-03-15 13:30:00', 'Finalizado'),
(15, 25, 15, '2024-04-16 14:15:00', 'Finalizado'),
(16, 1, 16, '2024-05-17 15:00:00', 'Finalizado'),
(17, 2, 17, '2024-06-18 12:30:00', 'Finalizado'),
(18, 3, 18, '2024-07-19 13:00:00', 'Finalizado'),
(19, 4, 19, '2024-08-20 14:30:00', 'Finalizado'),
(20, 5, 20, '2024-09-21 15:15:00', 'Finalizado'),
(21, 6, 21, '2024-10-22 12:00:00', 'Finalizado'),
(22, 7, 22, '2024-11-23 13:30:00', 'Finalizado'),
(23, 8, 23, '2024-12-24 14:15:00', 'Finalizado'),
(24, 9, 24, '2024-01-25 15:00:00', 'Finalizado'),
(25, 10, 25, '2024-02-01 12:30:00', 'Finalizado'),
(1, 11, 1, '2024-03-02 13:00:00', 'Finalizado'),
(2, 12, 2, '2024-04-03 14:30:00', 'Finalizado'),
(3, 13, 3, '2024-05-04 15:15:00', 'Finalizado'),
(4, 14, 4, '2024-06-05 12:00:00', 'Finalizado'),
(5, 15, 5, '2024-07-06 13:30:00', 'Finalizado'),
(6, 16, 6, '2024-08-07 14:15:00', 'Finalizado'),
(7, 17, 7, '2024-09-08 15:00:00', 'Finalizado'),
(8, 18, 8, '2024-10-09 12:30:00', 'Finalizado'),
(9, 19, 9, '2024-11-10 13:00:00', 'Finalizado'),
(10, 20, 10, '2024-12-11 14:30:00', 'Finalizado');
