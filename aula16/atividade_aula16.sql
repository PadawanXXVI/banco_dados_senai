CREATE DATABASE IF NOT EXISTS db_loja_virtual;
USE db_loja_virtual;

CREATE TABLE tb_produto(
	id_produto INTEGER PRIMARY KEY,
    nome_produto VARCHAR(50),
    descricao_produto VARCHAR(100),
    preco_produto FLOAT
);

CREATE TABLE tb_cliente(
	id_cliente INTEGER PRIMARY KEY,
    nome_cliente VARCHAR(100),
    email_cliente VARCHAR(100),
    cpf_cliente VARCHAR(15)
);

CREATE TABLE tb_pedido(
	id_pedido INTEGER PRIMARY KEY,
    data_pedido DATE
);

ALTER TABLE tb_produto
MODIFY COLUMN descricao_produto VARCHAR(150);

ALTER TABLE tb_cliente
ADD COLUMN endereco_cliente VARCHAR(100) AFTER email_cliente;

ALTER TABLE tb_pedido
ADD COLUMN status_pedido VARCHAR(20);

ALTER TABLE tb_pedido
CHANGE COLUMN data_pedido data_dia_pedido DATE;

ALTER TABLE tb_cliente
DROP COLUMN endereco_cliente;

ALTER TABLE tb_cliente
RENAME TO tb_comprador_final;

ALTER TABLE tb_produto
DROP COLUMN descricao_produto;

DESCRIBE tb_comprador_final;

ALTER TABLE tb_produto
MODIFY COLUMN preco_produto DECIMAL(10,2);

ALTER TABLE tb_pedido
RENAME TO tb_ordem;

ALTER TABLE tb_ordem
ADD COLUMN data_entrega_ordem DATE;

ALTER TABLE tb_comprador_final
CHANGE COLUMN email_cliente contato_email VARCHAR(100);

DROP TABLE tb_produto;