CREATE DATABASE IF NOT EXISTS sistema_aeroportuario; 
USE sistema_aeroportuario; 


CREATE TABLE IF NOT EXISTS aeroporto (
    codigo INT PRIMARY KEY, 
    nome VARCHAR(100) NOT NULL, 
    cidade VARCHAR(100) NOT NULL, 
    pais VARCHAR(60) NOT NULL
); 


CREATE TABLE IF NOT EXISTS aeronave (
    matricula INT PRIMARY KEY, 
    modelo VARCHAR(60) NOT NULL, 
    fabricante VARCHAR(80) NOT NULL, 
    capacidade INT NOT NULL 
); 


CREATE TABLE IF NOT EXISTS voo (
    codigo_voo INT PRIMARY KEY, 
    matricula_aeronave INT,
    codigo_origem INT NOT NULL,  
    codigo_destino INT NOT NULL, 
    horario_partida TIME NOT NULL, 
    horario_chegada TIME NOT NULL, 
    FOREIGN KEY (matricula_aeronave) REFERENCES aeronave(matricula),
    FOREIGN KEY (codigo_origem) REFERENCES aeroporto(codigo),
    FOREIGN KEY (codigo_destino) REFERENCES aeroporto(codigo)
); 


CREATE TABLE IF NOT EXISTS funcionario_tripulacao (
    matricula INT PRIMARY KEY,
    nome VARCHAR(100) NOT NULL, 
    salario DECIMAL(10,2) NOT NULL, 
    data_contrato DATE NOT NULL,
    cargo VARCHAR(30) NOT NULL 
); 



CREATE TABLE IF NOT EXISTS escala_tripulacao (
    codigo_voo INT, 
    matricula_funcionario INT, 
    
    PRIMARY KEY(codigo_voo, matricula_funcionario), 
    FOREIGN KEY (codigo_voo) REFERENCES voo(codigo_voo),
    FOREIGN KEY (matricula_funcionario) REFERENCES funcionario_tripulacao(matricula)
); 


CREATE TABLE IF NOT EXISTS passageiro (
    id_passageiro INT PRIMARY KEY, 
    nome VARCHAR(100) NOT NULL
);


CREATE TABLE IF NOT EXISTS bagagem (
    id_bagagem INT PRIMARY KEY,
    peso DECIMAL(5,2) NOT NULL,
    status_bagagem VARCHAR(30),
    id_passageiro INT,
    
    FOREIGN KEY (id_passageiro) REFERENCES passageiro(id_passageiro)
);


CREATE TABLE IF NOT EXISTS passagem_voo (
    codigo_voo INT,
    id_passageiro INT,
    numero_assento VARCHAR(10) NOT NULL,
    data_compra DATE NOT NULL,
    
    PRIMARY KEY (codigo_voo, id_passageiro),
    FOREIGN KEY (codigo_voo) REFERENCES voo(codigo_voo),
    FOREIGN KEY (id_passageiro) REFERENCES passageiro(id_passageiro)
);