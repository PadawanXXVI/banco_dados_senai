CREATE DATABASE IF NOT EXISTS db_hospital;
USE db_hospital;

CREATE TABLE IF NOT EXISTS tb_paciente(
	id_paciente INT PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(100) NOT NULL,
    data_nascimento DATE NOT NULL,
    cidade VARCHAR(100) NOT NULL,
    telefone VARCHAR(100) NOT NULL,
    email VARCHAR(100) NOT NULL,
    cpf VARCHAR(100),
    tipo_convenio VARCHAR(100) NOT NULL,
    sexo ENUM('M', 'F') NOT NULL,
    estado_civil VARCHAR(100) NOT NULL
);

INSERT INTO tb_paciente
	(nome, data_nascimento, cidade, telefone, email, cpf, tipo_convenio, sexo, estado_civil)
VALUES
	('Ana Silva', '1985-05-12', 'Brasília', '(61) 91234-5678', 'ana.silva@email.com','12345678901', 'Plano Ouro', 'F', 'Casado(a)'),
	('Carlos Santos', '1979-08-22', 'Goiânia', '(62) 99876-5432', 'carlos.santos@email.com', '23456789012', 'Particular', 'M', 'Solteiro(a)'),
	('Beatriz Lima', '1992-03-15', 'Goiânia', '(71) 91111-2222', 'beatriz.lima@email.com', '34567890123', 'Plano Prata', 'F', 'Solteiro(a)'),
	('Daniel Souza', '1990-11-30', 'Rio de Janeiro', '(21) 93333-4444', 'daniel.souza@email.com', '45678901234', 'Plano Ouro', 'M', 'Divorciado(a)'),
	('Elaine Costa', '2000-01-01', 'São Paulo', '(11) 95555-6666', 'elaine.costa@email.com', '56789012345', 'Plano Bronze', 'F', 'Casado(a)'),
	('Fernando Alves', '1987-07-25', 'Brasília', '(85) 97777-8888', 'fernando.alves@email.com', '67890123456', 'Particular', 'M', 'Solteiro(a)'),
	('Gisele Pereira', '1995-12-05', 'Brasília', '(92) 99999-0000', 'gisele.pereira@email.com', '78901234567', 'Plano Prata', 'F', 'Solteiro(a)'),
	('Hugo Nunes', '1983-03-22', 'Goiânia', '(81) 91212-3456', 'hugo.nunes@email.com', '89012345678', 'Plano Ouro', 'M', 'Casado(a)'),
	('Ingrid Rocha', '1998-10-17', 'Brasília', '(84) 93456-7890', 'ingrid.rocha@email.com', '90123456789', 'Particular', 'F', 'Solteiro(a)'),
	('João Mendes', '1975-04-09', 'Goiânia', '(91) 99888-7777', 'joao.mendes@email.com', '01234567890', 'Plano Ouro', 'M', 'Divorciado(a)'),
	('Kátia Gomes', '1990-06-06', 'Brasília', '(41) 94444-1234', 'katia.gomes@email.com', '11122233344', 'Plano Bronze', 'F', 'Casado(a)'),
	('Lucas Tavares', '1994-07-23', 'Rio de Janeiro', '(51) 97766-5544', 'lucas.tavares@email.com', '22233344455', 'Plano Prata', 'M', 'Solteiro(a)'),
	('Mariana Lacerda', '1989-12-12', 'Rio de Janeiro', '(31) 91122-3344', 'mariana.lacerda@email.com', '33344455566', 'Plano Ouro', 'F', 'Viúvo(a)'),
	('Nicolas Dias', '1991-09-01', 'Brasília', '(19) 94455-6677', 'nicolas.dias@email.com', '44455566677', 'Particular', 'M', 'Casado(a)'),
	('Olívia Souza', '1985-02-15', 'Goiânia', '(79) 97788-8899', 'olivia.souza@email.com', '55566677788', 'Plano Bronze', 'F', 'Solteiro(a)'),
	('Paulo Andrade', '1996-11-11', 'Goiânia', '(48) 91100-2233', 'paulo.andrade@email.com', '66677788899', 'Plano Prata', 'M', 'Divorciado(a)'),
	('Quênia Martins', '1993-08-08', 'São Paulo', '(83) 93234-5566', 'quenia.martins@email.com', '77788899900', 'Plano Ouro', 'F', 'Casado(a)'),
	('Rodrigo Lima', '1986-03-03', 'Brasília', '(82) 96567-7890', 'rodrigo.lima@email.com', '88899900011', 'Particular', 'M', 'Solteiro(a)'),
	('Sabrina Castro', '1984-12-20', 'São Paulo', '(67) 92211-3344', 'sabrina.castro@email.com', '99900011122', 'Plano Bronze', 'F', 'Solteiro(a)'),
	('Thiago Ferreira', '1978-01-05', 'São Paulo', '(65) 94455-6677', 'thiago.ferreira@email.com', '00011122233', 'Plano Ouro', 'M', 'Casado(a)');

-- 1. Liste quantidade de pacientes em cada cidade.
SELECT cidade, COUNT(nome) FROM tb_paciente
GROUP BY cidade;

-- 2. Mostre as cidades que possuem mais de 4 pacientes cadastrados.
SELECT cidade, COUNT(nome) FROM tb_paciente
GROUP BY cidade
HAVING COUNT(NOME) > 4;

-- 3. Agrupe os pacientes por tipo de convênio e exiba a quantidade em cada grupo.
SELECT tipo_convenio, COUNT(*) AS `Pacientes por convênio` FROM tb_paciente
GROUP BY tipo_convenio;

-- 4. Exiba o número de pacientes por estado civil, ordenando pela maior quantidade.
SELECT estado_civil, COUNT(*) AS `QTDE Paciente` FROM tb_paciente
GROUP BY estado_civil
ORDER BY COUNT(*) DESC;

-- 5. Exiba o número de pacientes do sexo masculino ordenado pelo tipo de convêncio.
SELECT tipo_convenio, COUNT(*) AS `Quantidade Masculino` FROM tb_paciente
WHERE sexo = 'M'
GROUP BY tipo_convenio;

-- 6. Liste todos os pacientes ordenados por nome em ordem alfabética.
SELECT nome FROM tb_paciente
ORDER BY nome; -- caso uma única coluna, precisa colocar em ordem alfabética.

-- 7. Liste os pacientes pela data de nascimento, do mais novo para o mais velho.
SELECT nome, data_nascimento FROM tb_paciente
ORDER BY data_nascimento DESC;

-- 8. Exiba os pacientes ordenados pelo estado civil em ordem decrescente.
SELECT nome, estado_civil FROM tb_paciente
ORDER BY estado_civil DESC;

-- 9. Mostre os pacientes organizados primeiro por tipo de convênio e depois por cidade.
SELECT nome, tipo_convenio, cidade FROM tb_paciente
ORDER BY tipo_convenio, cidade;

-- 10. Exiba os pacientes com CPF ordenado em ordem crescente.
SELECT nome, cpf FROM tb_paciente
ORDER BY LEFT (cpf,4);

-- 11. Quantas cidades distintas têm pacientes cadastrados?
SELECT COUNT(DISTINCT cidade)  FROM tb_paciente;

-- 12. Liste os diferentes tipos de convênios disponíveis.
SELECT DISTINCT tipo_convenio FROM tb_paciente;

-- 13. Exiba os estados civis únicos cadastrados na tabela.
SELECT DISTINCT estado_civil FROM tb_paciente;

-- 14. Qual é a menor data de nascimento entre os pacientes?
SELECT MIN(data_nascimento) FROM tb_paciente;

-- 15. Exiba os pacientes que são do sexo feminino e solteiro(a).
SELECT nome, estado_civil FROM tb_paciente
WHERE sexo = 'f' AND estado_civil LIKE 'solt%';

-- 16. Liste os pacientes cujo tipo de convênio seja "Plano Ouro" ou "Plano Prata" e traga os pacientes em ordem alfabetica.
SELECT nome, tipo_convenio FROM tb_paciente
WHERE tipo_convenio IN ('Plano Ouro', 'Plano Prata')
ORDER BY nome; -- como a primeira coluna foi a coluna nome, o resultado já é em ordem alfabética

-- 17. Mostre os pacientes em ordem alfabetica que são do sexo masculino, não casados.
SELECT nome, sexo, estado_civil FROM tb_paciente
WHERE NOT estado_civil LIKE 'cas%' AND sexo = 'm';

-- 18. Liste os pacientes que não possuem telefone cadastrado começando com "(61)".
SELECT nome, telefone FROM tb_paciente
WHERE NOT telefone LIKE '(61)%'
ORDER BY telefone;

-- 19. Exiba os pacientes que são de cidades diferentes de "Brasília" e têm convênio "Particular".
SELECT nome, cidade, tipo_convenio FROM tb_paciente
WHERE NOT cidade = 'Brasília' AND tipo_convenio = 'Particular';

-- 20. Liste os pacientes que nasceram antes de 1990.
SELECT nome, data_nascimento FROM tb_paciente
WHERE data_nascimento < '1990-01-01'
ORDER BY data_nascimento DESC; -- para facilitar a visualização

-- 21. Qual é a maior data de nascimento entre os pacientes?
SELECT MAX(data_nascimento) FROM tb_paciente;

-- 22. Exiba os pacientes que nasceram entre 1985 e 1995.
SELECT nome, data_nascimento FROM tb_paciente
WHERE data_nascimento BETWEEN '1985-01-01' AND '1995-12-31'
ORDER BY data_nascimento; -- para facilitar a visualização

-- 23. Quantos pacientes estão cadastrados na tabela?
SELECT COUNT(nome) FROM tb_paciente;

-- 24. Qual é a menor e a maior data de nascimento dos pacientes?
SELECT MIN(data_nascimento) AS `Paciente mais idoso`, MAX(data_nascimento) AS `Paciente mais novo` FROM tb_paciente;

-- 25. Quantos pacientes estão associados a cada tipo de convênio?
SELECT tipo_convenio, COUNT(*) AS `Total de pacientes` FROM tb_paciente
GROUP BY tipo_convenio
ORDER BY COUNT(*) DESC; -- para facilitar a visualização

-- 26. Adicione uma coluna chamada "profissao" do tipo VARCHAR com tamanho 100 à tabela "tb_paciente" depois da coluna cpf.
ALTER TABLE tb_paciente
ADD COLUMN profissao VARCHAR(100) AFTER cpf;

-- 27. Renomeie a coluna "tipo_convenio" para "plano_saude".
ALTER TABLE tb_paciente
CHANGE tipo_convenio plano_saude VARCHAR(100) NOT NULL;

-- 28. Exclua a coluna "estado_civil" da tabela "tb_paciente".
ALTER TABLE tb_paciente
DROP COLUMN estado_civil;

-- 29. Adicione uma restrição para que o campo "cpf" não aceite valores nulos.
DESC tb_paciente; -- visualizar a coluna sem a restrição

ALTER TABLE tb_paciente
MODIFY cpf VARCHAR(100) NOT NULL;

-- 30. Renomeie a tabela "tb_paciente" para "tb_cliente".
RENAME TABLE tb_paciente TO tb_cliente;
