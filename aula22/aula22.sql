/*
AULA 07
GROUP BY + HAVING e ORDER BY
*/
CREATE DATABASE db_empresa;
USE db_empresa;
CREATE TABLE tb_funcionario (
    id_funcionario INT PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(100) NOT NULL,
    cpf VARCHAR(11) UNIQUE NOT NULL,
    telefone VARCHAR(15),
    email VARCHAR(100) UNIQUE,
    endereco VARCHAR(200),
    data_nascimento DATE,
    genero ENUM('masculino', 'feminino', 'outro'),
    data_admissao DATE NOT NULL,
    carga_horaria INT NOT NULL,
    salario DECIMAL(10, 2) NOT NULL,
    departamento VARCHAR(50),
    cargo VARCHAR(50),
    tipo_contrato ENUM('CLT', 'PJ', 'estagiario') NOT NULL,
    situacao ENUM('ativo', 'inativo') DEFAULT 'ativo'
);
INSERT INTO tb_funcionario
(nome, cpf, telefone, email, endereco, data_nascimento, genero, data_admissao, carga_horaria, salario, departamento, cargo, tipo_contrato, situacao)
VALUES
('Ana Silva', '12345678901', '61999910001', 'ana.silva@email.com', 'Rua A, 100', '1988-03-05', 'feminino', '2022-01-10', 40, 3000.00, 'RH', 'Analista', 'CLT', 'ativo'),
('Carlos Pereira', '23456789012', '61999920002', 'carlos.pereira@email.com', 'Rua B, 200', '1990-07-10', 'masculino', '2021-05-15', 40, 4000.00, 'TI', 'Desenvolvedor', 'CLT', 'ativo'),
('Mariana Costa', '34567890123', '61999930003', 'mariana.costa@email.com', 'Rua C, 300', '1995-08-20', 'feminino', '2023-03-20', 30, 2500.00, 'Financeiro', 'Assistente', 'estagiario', 'ativo'),
('José Alves', '45678901234', '61999940004', 'jose.alves@email.com', 'Rua D, 400', '1985-11-11', 'masculino', '2019-09-25', 40, 4200.00, 'Logística', 'Supervisor', 'CLT', 'ativo'),
('Paula Souza', '56789012345', '61999950005', 'paula.souza@email.com', 'Rua E, 500', '1992-01-15', 'feminino', '2020-06-10', 30, 3100.00, 'Marketing', 'Analista', 'PJ', 'ativo'),
('Bruno Santos', '67890123456', '61999960006', 'bruno.santos@email.com', 'Rua F, 600', '1989-09-30', 'masculino', '2021-02-01', 40, 3800.00, 'TI', 'Consultor', 'CLT', 'ativo'),
('Fernanda Lima', '78901234567', '61999970007', 'fernanda.lima@email.com', 'Rua G, 700', '1993-06-21', 'feminino', '2022-04-01', 20, 1900.00, 'Administração', 'Estagiária', 'estagiario', 'ativo'),
('Rodrigo Nunes', '89012345678', '61999980008', 'rodrigo.nunes@email.com', 'Rua H, 800', '1987-10-15', 'masculino', '2018-08-15', 40, 4600.00, 'Vendas', 'Gerente', 'CLT', 'ativo'),
('Carla Rodrigues', '90123456789', '61999990009', 'carla.rodrigues@email.com', 'Rua I, 900', '1986-05-11', 'feminino', '2020-07-21', 40, 3200.00, 'Compras', 'Supervisora', 'CLT', 'ativo'),
('Felipe Teixeira', '01234567890', '61999910010', 'felipe.teixeira@email.com', 'Rua J, 1000', '1991-02-20', 'masculino', '2017-03-14', 40, 3300.00, 'TI', 'Analista', 'PJ', 'ativo'),
('Julia Almeida', '11234567891', '61999920011', 'julia.almeida@email.com', 'Rua K, 1100', '1990-11-07', 'feminino', '2021-01-20', 20, 2200.00, 'RH', 'Assistente', 'estagiario', 'ativo'),
('Marcelo Carvalho', '22345678902', '61999930012', 'marcelo.carvalho@email.com', 'Rua L, 1200', '1988-12-02', 'masculino', '2019-06-18', 40, 4200.00, 'Financeiro', 'Consultor', 'CLT', 'ativo'),
('Renata Gomes', '33456789013', '61999940013', 'renata.gomes@email.com', 'Rua M, 1300', '1994-03-25', 'feminino', '2023-02-11', 30, 2400.00, 'Vendas', 'Estagiária', 'estagiario', 'ativo'),
('Rafael Oliveira', '44567890124', '61999950014', 'rafael.oliveira@email.com', 'Rua N, 1400', '1983-07-29', 'masculino', '2016-05-05', 40, 5100.00, 'TI', 'Desenvolvedor', 'CLT', 'ativo'),
('Luciana Lopes', '55678901235', '61999960015', 'luciana.lopes@email.com', 'Rua O, 1500', '1996-04-17', 'feminino', '2021-10-10', 40, 3300.00, 'RH', 'Assistente', 'CLT', 'ativo'),
('Thiago Martins', '66789012346', '61999970016', 'thiago.martins@email.com', 'Rua P, 1600', '1991-12-19', 'masculino', '2018-11-20', 40, 4400.00, 'Logística', 'Supervisor', 'CLT', 'ativo'),
('Camila Ferreira', '77890123457', '61999980017', 'camila.ferreira@email.com', 'Rua Q, 1700', '1985-08-10', 'feminino', '2020-03-15', 30, 2500.00, 'Administração', 'Analista', 'PJ', 'ativo'),
('Daniel Souza', '88901234568', '61999990018', 'daniel.souza@email.com', 'Rua R, 1800', '1987-11-01', 'masculino', '2019-09-25', 40, 3700.00, 'Compras', 'Analista', 'CLT', 'ativo'),
('Monica Fonseca', '99012345679', '61999910019', 'monica.fonseca@email.com', 'Rua S, 1900', '1994-06-05', 'feminino', '2022-07-10', 20, 1700.00, 'Marketing', 'Estagiária', 'estagiario', 'ativo'),
('Igor Medeiros', '10123456790', '61999920020', 'igor.medeiros@email.com', 'Rua T, 2000', '1992-09-15', 'masculino', '2018-04-20', 40, 4100.00, 'TI', 'Consultor', 'CLT', 'ativo'),
('Sandra Torres', '12123456791', '61999930021', 'sandra.torres@email.com', 'Rua U, 2100', '1989-02-20', 'feminino', '2020-11-17', 30, 2900.00, 'Financeiro', 'Analista', 'PJ', 'ativo'),
('Lucas Ramos', '22234567892', '61999940022', 'lucas.ramos@email.com', 'Rua V, 2200', '1995-01-28', 'masculino', '2023-01-15', 20, 1500.00, 'Administração', 'Estagiário', 'estagiario', 'ativo'),
('Natalia Moreira', '33345678903', '61999950023', 'natalia.moreira@email.com', 'Rua W, 2300', '1993-05-11', 'feminino', '2021-08-10', 40, 3300.00, 'RH', 'Consultora', 'CLT', 'ativo'),
('Pedro Henrique', '44456789014', '61999960024', 'pedro.henrique@email.com', 'Rua X, 2400', '1984-09-12', 'masculino', '2018-06-18', 40, 5000.00, 'Vendas', 'Supervisor', 'CLT', 'ativo'),
('Claudia Tavares', '55567890125', '61999970025', 'claudia.tavares@email.com', 'Rua Y, 2500', '1987-03-29', 'feminino', '2019-09-01', 30, 2600.00, 'Compras', 'Analista', 'PJ', 'ativo'),
('Ricardo Assis', '66678901236', '61999980026', 'ricardo.assis@email.com', 'Rua Z, 2600', '1990-12-23', 'masculino', '2020-02-20', 40, 4200.00, 'Logística', 'Consultor', 'CLT', 'ativo'),
('Beatriz Araujo', '77789012347', '61999990027', 'beatriz.araujo@email.com', 'Rua AA, 2700', '1986-07-19', 'feminino', '2021-05-15', 30, 3100.00, 'Marketing', 'Analista', 'PJ', 'ativo'),
('Fabio Lima', '88890123458', '61999910028', 'fabio.lima@email.com', 'Rua AB, 2800', '1985-04-11', 'masculino', '2017-09-25', 40, 4600.00, 'TI', 'Supervisor', 'CLT', 'ativo'),
('Carolina Menezes', '99901234569', '61999920029', 'carolina.menezes@email.com', 'Rua AC, 2900', '1991-01-07', 'feminino', '2023-03-14', 20, 2100.00, 'Administração', 'Assistente', 'estagiario', 'ativo'),
('Gustavo Sales', '10234567890', '61999930030', 'gustavo.sales@email.com', 'Rua AD, 3000', '1983-10-29', 'masculino', '2018-11-10', 40, 4800.00, 'Financeiro', 'Gerente', 'CLT', 'ativo');
-- GROUP BY vai agrupar valor iguais
SELECT departamento FROM tb_funcionario
GROUP BY departamento;

SELECT tipo_contrato, COUNT(tipo_contrato) AS `Quantidade Funcionários` 
FROM tb_funcionario
GROUP BY tipo_contrato;

SELECT nome,tipo_contrato FROM tb_funcionario
WHERE tipo_contrato ='pj';

SELECT genero, COUNT(genero) FROM tb_funcionario
GROUP BY genero;

/* Usando o HAVING, vai funionar como um filtro para o GROUP BY,
parecido com o WHERE, mas o HAVING só vai funcionar com o GROUP
BY
*/
SELECT departamento,COUNT(departamento) FROM tb_funcionario
GROUP BY departamento

-- Usar o HAVING para filtrar o resultado do GROUP BY
HAVING COUNT(departamento) > 3;

SELECT cargo, COUNT(cargo), GROUP_CONCAT(nome SEPARATOR ', ')FROM tb_funcionario
GROUP BY cargo
HAVING COUNT(cargo) >5;

-- Utilizando ORDER BY/ordenar
SELECT * FROM tb_funcionario
ORDER BY nome ASC; -- ASC/Ascending/ascendente/"aumentado" 
SELECT * FROM tb_funcionario
ORDER BY nome DESC; -- DESC/Descending/descendente/"diminuindo"

SELECT nome, departamento FROM tb_funcionario
ORDER BY departamento, nome;

SELECT * FROM tb_funcionario
ORDER BY 3;

-- vamos ordenar pela posição dos campos, RIGTH ou LEFT
SELECT nome, cpf FROM tb_funcionario
ORDER BY LEFT(cpf,4)
