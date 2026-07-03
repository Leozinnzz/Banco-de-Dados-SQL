CREATE DATABASE IF NOT EXISTS bugmakers_league;
USE bugmakers_league; 

CREATE TABLE IF NOT EXISTS contrato(
	id_contrato INT PRIMARY KEY,
	tipo varchar(20) NOT NULL, 
	salario DECIMAL(10,2) NOT NULL,
	cargo varchar(100) NOT NULL, 
	bonificacao DECIMAL(5,2) NOT NULL, 
	data_inicio DATE NOT NULL, 
	data_termino DATE 
);

CREATE TABLE IF NOT EXISTS funcionario(
	cpf INT PRIMARY KEY, 
    nome VARCHAR(100),
    telefone INT, 
    data_nascimento DATE NOT NULL, 
    UF VARCHAR(15), 
    cidade
    bairro
    rua
    num_casa
    fk_contrato
); 