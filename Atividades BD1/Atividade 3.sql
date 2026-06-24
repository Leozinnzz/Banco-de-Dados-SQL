CREATE DATABASE IF NOT EXISTS laboratorio_robotica;
USE laboratorio_robotica;

CREATE TABLE IF NOT EXISTS ambiente (
	id INT PRIMARY KEY, 
    nome VARCHAR(100) NOT NULL, 
    localizacao VARCHAR(100) NOT NULL
); 

CREATE TABLE IF NOT EXISTS pesquisador (
	matricula INT PRIMARY KEY, 
    nome VARCHAR(100), 
    titulacao VARCHAR(50),
    area_atuacao VARCHAR(60)
); 

CREATE TABLE IF NOT EXISTS experimento(
	id INT PRIMARY KEY, 
    nome VARCHAR(100) NOT NULL, 
    id_ambiente INT NOT NULL, 
    
    FOREIGN KEY (id_ambiente) REFERENCES ambiente(id)
);

CREATE TABLE IF NOT EXISTS dispositivo(
	id INT PRIMARY KEY, 
    fabricante VARCHAR(100) NOT NULL,
    modelo VARCHAR(70) NOT NULL, 
    data_aquisicao DATE NOT NULL, 
    tipo_dispositivo VARCHAR(40) NOT NULL
);

CREATE TABLE IF NOT EXISTS evento(
	id INT PRIMARY KEY, 
    _data DATE NOT NULL, 
    horario TIME NOT NULL, 
    tipo VARCHAR(30) NOT NULL, 
    prioridade VARCHAR(25) NOT NULL, 
    id_experimento INT NOT NULL, 
    id_dispositivo INT NOT NULL, 
    
	FOREIGN KEY (id_experimento) REFERENCES experimento(id),
	FOREIGN KEY (id_dispositivo) REFERENCES dispositivo(id)
);

CREATE TABLE IF NOT EXISTS execucao(
	id INT PRIMARY KEY, 
    tarefa_realizada VARCHAR(100) NOT NULL, 
    horario_inicio DATETIME NOT NULL, 
    horario_termino DATETIME NOT NULL, 
    resultado_obtido TEXT, 
    id_dispositivo INT NOT NULL, 
    
    FOREIGN KEY (id_dispositivo) REFERENCES dispositivo(id)
);

CREATE TABLE IF NOT EXISTS pesquisador_experimento(
	matricula_pesquisador INT, 
	id_experimento INT, 
    PRIMARY KEY (matricula_pesquisador, id_experimento),
    
    FOREIGN KEY (matricula_pesquisador) REFERENCES pesquisador(matricula), 
    FOREIGN KEY (id_experimento) REFERENCES experimento(id)
);


