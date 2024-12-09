/*
Aula 13 - STORE PROCEDURE: procedimentos de armazenamento
São consultas avançadas que ficam armazenadas no banco de dados.
Podem modificar os dados.
Vamos chamar com o CALL.
Consegue utulizar o SELECT, UPDATE, DELETE.
*/

-- CRIAÇÃO E SELEÇÃO PARA USO DO BANCO DE DADOS
CREATE DATABASE IF NOT EXISTS db_procedimentos;
USE db_procedimentos;

-- CRIAÇÃO DA TABELA FUNCIONÁRIO
CREATE TABLE IF NOT EXISTS tb_funcionario(
    id_funcionario INT PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(100),
    cargo VARCHAR(100),
    salario_base DECIMAL(10,2),
    bonus DECIMAL(10,2),
    departamento VARCHAR(100),
    data_admissao DATE
);

-- CADASTRO DOS FUNCIONÁRIOS
INSERT INTO tb_funcionario
    (nome, cargo, salario_base, bonus, departamento, data_admissao)
VALUES
    ('Ana Souza', 'Analista', 3500.00, 500.00, 'TI', '2022-03-15'),
    ('Carlos Lima', 'Gerente', 5000.00, 800.00, 'Marketing', '2020-07-01'),
    ('Joana Santos', 'Desenvolvedora', 4000.00, 600.00, 'TI', '2021-11-20'),
    ('Pedro Almeida', 'Coordenador', 4500.00, 700.00, 'RH', '2019-04-10'),
    ('Mariana Oliveira', 'Assistente', 2500.00, 400.00, 'Financeiro', '2023-01-10');

-- VISUALIZAÇÃO DOS FUNCIONÁRIOS CADASTRADOS
SELECT * FROM tb_funcionario;

# EXEMPLO 01- atualizando salário com um aumento
#_____________________________________________________    
DELIMITER $$
CREATE PROCEDURE atualizarSalario(
        id INT,
        aumento DECIMAL(5,2))
BEGIN
    UPDATE tb_funcionario
    SET salario_base = salario_base *(1 + aumento/100)
    WHERE id_funcionario = id;
    SELECT nome, salario_base FROM tb_funcionario
    WHERE id_funcionario = id;
END $$
DELIMITER ;
CALL atualizarSalario(5,100);
#
# EXEMPLO 02- adicionar um novo funcionario
#_____________________________________________________  
DELIMITER $$
CREATE PROCEDURE cadastrarFuncionario(
    c_nome VARCHAR(100),
    c_cargo VARCHAR(100),
    c_salario_base DECIMAL(10,2),
    c_bonus DECIMAL(10,2),
    c_departamento VARCHAR(100),
    c_data_admissao DATE)
BEGIN
    INSERT INTO tb_funcionario(nome,cargo,salario_base,bonus,departamento,data_admissao)
    VALUES (c_nome,c_cargo,c_salario_base,c_bonus,c_departamento,c_data_admissao);
    SELECT * FROM tb_funcionario;
END $$
DELIMITER ;
CALL cadastrarFuncionario('Pedro','Analista',3000,600,'TI','2024-12-06')
#
# EXEMPLO 03- Atualizar o cargo de um funcionário e o seu respectivo bonus.
#_____________________________________________________
DELIMITER $$
CREATE PROCEDURE atualizarCargoBonus (a_id INT,a_cargo VARCHAR(100), a_bonus DEC(10,2))
BEGIN
    UPDATE tb_funcionario
    SET cargo = a_cargo, bonus = a_bonus
    WHERE id_funcionario = a_id;
    SELECT * FROM tb_funcionario;
END $$
DELIMITER ;
CALL atualizarCargoBonus(6,'Gerente',1000);

#
# EXEMPLO 04 - Trocar um funcionario de departamento
#_____________________________________________________
DELIMITER $$
CREATE PROCEDURE transferir(t_id INT, t_departamento VARCHAR(100))
BEGIN
    UPDATE tb_funcionario
    SET departamento = t_departamento
    WHERE id_funcionario = t_id;
    SELECT * FROM tb_funcionario;
END $$
DELIMITER ;
CALL transferir(5,'RH');
#
# EXEMPLO 05 - Deletar os funcionarios antigos (<=2020)
#_____________________________________________________
DELIMITER $$
CREATE PROCEDURE deletar()
BEGIN
    DELETE FROM tb_funcionario WHERE data_admissao <= '2020-12-31';
    SELECT * FROM tb_funcionario;
END $$
DELIMITER ;
CALL deletar();
#
# EXEMPLO 07 -Tabela de Histórico
#_____________________________________________________
CREATE TABLE tb_historico_salario (
    id_historico INT PRIMARY KEY AUTO_INCREMENT,
    salario_antigo DECIMAL(10,2),
    salario_novo DECIMAL(10,2),
    data_alteracao DATE,
    id_funcionario INT,
    FOREIGN KEY (id_funcionario) REFERENCES tb_funcionario(id_funcionario));
DROP PROCEDURE aumentarSalario;
DELIMITER $$
CREATE PROCEDURE aumentarSalario( a_id INT, a_aumento DECIMAL(10,2))
BEGIN
    DECLARE f_salario_antigo DECIMAL(10,2);
    DECLARE f_salario_novo DECIMAL(10,2);
    -- Busca o salário atual do funcionário
    SELECT salario_base INTO f_salario_antigo FROM tb_funcionario
    WHERE id_funcionario = a_id;
    -- calcula novo salário com base no aumento
    SET f_salario_novo = f_salario_antigo * (1 + a_aumento/100);
    -- atualizar o salário do funcionário
    UPDATE tb_funcionario
    SET salario_base = f_salario_novo
    WHERE id_funcionario = a_id;
    -- atualizar a tabela historico
    INSERT INTO tb_historico_salario(id_funcionario, salario_antigo, salario_novo,
        data_alteracao) VALUES
    (a_id,f_salario_antigo, f_salario_novo,curdate());
    SELECT * FROM tb_historico_salario;
END $$
DELIMITER ;
CALL aumentarSalario(1,10);