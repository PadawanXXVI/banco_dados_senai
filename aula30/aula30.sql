/*
Aula 10 - VIEW - VISÃO/EXIBIÇÃOPTIMIZE
É uma tabela virtual baseada no resultado de uma consulta SQL.
Sempre mostra os dados atualizados!
Permite simplificar consultas que são feitas diariamente.
*/

-- COMANDOR PARA CRIAR UMA VIEW
CREATE VIEW nome_da_view AS 
SELECT coluna1, coluna2 FROM tabela
WHERE condição;

-- CONSULTAR UMA VIEW
SELECT * FROM nome_da_view;

-- ATUALIZAR UMA VIEW
REPLACE VIEW nome_da_view;

-- EXCLUIR
DROP VIEW nome_da_view;

-- CRIANDO E SELECIONANDO PARA USO O BANCO DE DADOS
CREATE DATABASE IF NOT EXISTS db_view;
USE db_view;

-- CRIAÇÃO DA TABELA CLIENTE
create table tb_cliente(
    id_cliente int PRIMARY KEY AUTO_INCREMENT,
    nome varchar(120),
    telefone varchar(30),
    status_cliente enum('ativo','inativo'),
    data_nascimento date,
    sexo enum('Masculino','Feminino'),
    email varchar(100)
);

-- CADASTRO DE CLIENTES
INSERT INTO tb_cliente (nome, telefone, status_cliente, data_nascimento, sexo, email) VALUES
('João Silva', '61999999999', 'ativo', '1990-03-15', 'Masculino', 'joao.silva@email.com'),
('Maria Oliveira', '61988888888', 'ativo', '1985-07-21', 'Feminino', 'maria.oliveira@email.com'),
('Carlos Souza', '61977777777', 'inativo', '1978-11-12', 'Masculino', 'carlos.souza@email.com'),
('Ana Santos', '61966666666', 'ativo', '1995-05-03', 'Feminino', 'ana.santos@email.com'),
('Pedro Lima', '61955555555', 'ativo', '1992-09-10', 'Masculino', 'pedro.lima@email.com'),
('Carla Mendes', '61944444444', 'inativo', '2000-01-20', 'Feminino', 'carla.mendes@email.com'),
('Roberto Nunes', '61933333333', 'ativo', '1988-02-25', 'Masculino', 'roberto.nunes@email.com'),
('Fernanda Costa', '61922222222', 'ativo', '1999-06-15', 'Feminino', 'fernanda.costa@email.com'),
('Ricardo Gomes', '61911111111', 'inativo', '1983-12-05', 'Masculino', 'ricardo.gomes@email.com'),
('Luciana Melo', '61912312312', 'ativo', '1997-04-18', 'Feminino', 'luciana.melo@email.com'),
('Marcos Dias', '61932132132', 'inativo', '1980-08-30', 'Masculino', 'marcos.dias@email.com'),
('Patrícia Alves', '61998798798', 'ativo', '1994-03-09', 'Feminino', 'patricia.alves@email.com'),
('Gustavo Moreira', '61965465465', 'ativo', '1991-10-22', 'Masculino', 'gustavo.moreira@email.com'),
('Juliana Rocha', '61978978978', 'inativo', '1986-01-13', 'Feminino', 'juliana.rocha@email.com'),
('Thiago Pereira', '61914725836', 'ativo', '1993-11-29', 'Masculino', 'thiago.pereira@email.com'),
('Sabrina Ribeiro', '61936925814', 'ativo', '2001-12-17', 'Feminino', 'sabrina.ribeiro@email.com'),
('André Martins', '61985236974', 'inativo', '1987-07-04', 'Masculino', 'andre.martins@email.com'),
('Isabela Monteiro', '61974185296', 'ativo', '1996-02-07', 'Feminino', 'isabela.monteiro@email.com'),
('Leandro Batista', '61996325874', 'ativo', '1982-06-19', 'Masculino', 'leandro.batista@email.com'),
('Rafaela Farias', '61985214796', 'inativo', '1990-09-14', 'Feminino', 'rafaela.farias@email.com');

-- CRIANDO A PRIMEIRA VIEW
CREATE VIEW vw_cliente_telefone AS
SELECT nome, telefone FROM tb_cliente;

-- VISUALIZANDO A VIEW
SELECT * FROM vw_cliente_telefone;

-- CRIANDO UMA NOVA VIEW PARA VISUALIZAR OS CLIENTE ATIVOS
CREATE VIEW vw_clientes_ativos AS
SELECT nome, email, telefone FROM tb_cliente
WHERE status_cliente = 'ativo'
ORDER BY nome;

-- VISUALIZAR
SELECT * FROM vw_clientes_ativos;

-- ALTERAR UMA VIEW
ALTER VIEW vw_cliente_ativo AS
SELECT nome, email, status_cliente FROM tb_cliente -- retirando a coluna telefone e colocando a coluna de status
WHERE status_cliente = 'ativo'
ORDER BY nome;

-- VERIFICAR A ESTRUTURA DA VIEW CRIADA
SHOW CREATE VIEW vw_clientes_ativos;

-- VERIFICAR OS ANIVERSARIANTES DO MÊS
CREATE VIEW vw_niver_mes AS
SELECT nome, DAY(data_nascimento) FROM tb_cliente
WHERE MONTH(data_nascimento) = MONTH(curdate());

-- VISUALIZAR
SELECT * FROM vw_niver_mes;

-- Mudando o idioma
SET lc_time_names = 'pt_BR';

-- MOSTRAR O DIA E O MÊS NA MESMA COLUNA
ALTER VIEW vw_niver_mes AS
SELECT nome, CONCAT(DAY(data_nascimento),' de ',  MONTHNAME(data_nascimento)) AS `Aniversariante do mês` FROM tb_cliente
WHERE MONTH (data_nascimento) = MONTH(curdate());

ALTER VIEW vw_niver_mes AS
SELECT CONCAT('Parabéns, ', nome), CONCAT(DAY(data_nascimento),' de ',  MONTHNAME(data_nascimento)) AS `Aniversariante do mês` FROM tb_cliente
WHERE MONTH (data_nascimento) = MONTH(curdate());

-- VISUALIZANDO TODAS AS VIEWS CRIADAS
SHOW FULL TABLES WHERE table_type = 'VIEW';

-- RENOMEAR O NOME DA VIEW
/*
É necessário criar uma nova view a partir da antiga
*/
CREATE VIEW vw_cliente AS SELECT * FROM vw_clientes_ativos; -- criou a cópia

-- APAGAR UMA VIEW
DROP VIEW vw_idade;

-- VISUALIZAR A NOVA VIEW
SELECT * FROM vw_cliente; -- aqui não é possível visualizar, porque a view de oriogem foi excluída

SHOW CREATE VIEW vw_cliente;

-- MOSTRAR A IDADE DOS CLIENTES CADASTRADOS
SELECT nome, CONCAT('Você tem ', timestampdiff(YEAR, data_nascimento, current_date), ' anos') AS `Idade` FROM tb_cliente
GROUP BY idade;

SELECT * FROM vw_idade;
