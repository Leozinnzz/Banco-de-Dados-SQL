CREATE DATABASE IF NOT EXISTS hospital; 
USE hospital;

CREATE TABLE IF NOT EXISTS paciente(
	id_paciente INT PRIMARY KEY NOT NULL,
    nome VARCHAR(100) NOT NULL, 
    rua VARCHAR(50) NOT NULL,
    bairro VARCHAR(30) NOT NULL,
    numero VARCHAR(20) NOT NULL,  
    telefone VARCHAR(30) NOT NULL
);

CREATE TABLE IF NOT EXISTS medico(
	crm INT PRIMARY KEY NOT NULL, 
    nome VARCHAR(100) NOT NULL, 
	rua VARCHAR(50) NOT NULL,
    bairro VARCHAR(30) NOT NULL,
    numero VARCHAR(20) NOT NULL,
    telefone VARCHAR(30) NOT NULL, 
    especialidade VARCHAR(50) NOT NULL
);

CREATE TABLE IF NOT EXISTS convenio(
	codigo INT PRIMARY KEY NOT NULL, 
    nome VARCHAR(100) NOT NULL
);

CREATE TABLE IF NOT EXISTS consulta(
	codigo INT PRIMARY KEY NOT NULL, 
    data_consulta DATE NOT NULL, 
    horario TIME NOT NULL,  
    porcent DECIMAL (5,2) NOT NULL, 
    
    id_paciente INT NOT NULL,
    id_convenio INT NOT NULL,
    id_medico INT NOT NULL,
    
    FOREIGN KEY (id_paciente) REFERENCES paciente(id_paciente), 
    FOREIGN KEY (id_convenio) REFERENCES convenio(codigo), 
    FOREIGN KEY (id_medico) REFERENCES medico(crm)
); 



CREATE TABLE IF NOT EXISTS possuir(
	cod_convenio INT NOT NULL, 
    cod_paciente INT NOT NULL, 
    
	tipo VARCHAR(15) NOT NULL, 
    vencimento DATE NOT NULL,
	FOREIGN KEY (cod_paciente) REFERENCES paciente(id_paciente), 
	FOREIGN KEY (cod_convenio) REFERENCES convenio(codigo),
    PRIMARY KEY (cod_convenio, cod_paciente)
);

CREATE TABLE IF NOT EXISTS atende(
	cod_convenio INT NOT NULL, 
	id_medico INT NOT NULL, 
	FOREIGN KEY (cod_convenio) REFERENCES convenio(codigo),
    FOREIGN KEY (id_medico) REFERENCES medico(crm),
    PRIMARY KEY (cod_convenio, id_medico)
);

INSERT INTO paciente VALUES 
	(12, "Leonardo", "Leocadio", "Bom Jesus", "105", "3898832899"),
	(15, "Joao", "RUA B", "Bom Jesus", "108", "548855855885"),
	(16, "Pedro", "RUA C", "Bom Jesus", "112", "3654885858");
CREATE DATABASE IF NOT EXISTS hospital; 
USE hospital;

CREATE TABLE IF NOT EXISTS paciente(
	id_paciente INT PRIMARY KEY NOT NULL,
    nome VARCHAR(100) NOT NULL, 
    rua VARCHAR(50) NOT NULL,
    bairro VARCHAR(30) NOT NULL,
    numero VARCHAR(20) NOT NULL,  
    telefone VARCHAR(30) NOT NULL
);

CREATE TABLE IF NOT EXISTS consulta(
	codigo INT PRIMARY KEY NOT NULL, 
    data_consulta DATE NOT NULL, 
    horario TIME NOT NULL,  
    porcent DECIMAL (5,2) NOT NULL, 
    
    id_paciente INT NOT NULL,
    id_convenio INT NOT NULL,
    id_medico INT NOT NULL,
    
    FOREIGN KEY (id_paciente) REFERENCES paciente(id_paciente), 
    FOREIGN KEY (id_convenio) REFERENCES convenio(codigo), 
    FOREIGN KEY (id_medico) REFERENCES medico(crm)
); 

CREATE TABLE IF NOT EXISTS medico(
	crm INT PRIMARY KEY NOT NULL, 
    nome VARCHAR(100) NOT NULL, 
	rua VARCHAR(50) NOT NULL,
    bairro VARCHAR(30) NOT NULL,
    numero VARCHAR(20) NOT NULL,
    telefone VARCHAR(30) NOT NULL, 
    especialidade VARCHAR(50) NOT NULL
);

CREATE TABLE IF NOT EXISTS convenio(
	codigo INT PRIMARY KEY NOT NULL, 
    nome VARCHAR(100) NOT NULL
);

CREATE TABLE IF NOT EXISTS possuir(
	cod_convenio INT NOT NULL, 
    cod_paciente INT NOT NULL, 
    
	tipo VARCHAR(15) NOT NULL, 
    vencimento DATE NOT NULL,
	FOREIGN KEY (cod_paciente) REFERENCES paciente(id_paciente), 
	FOREIGN KEY (cod_convenio) REFERENCES convenio(codigo),
    PRIMARY KEY (cod_convenio, cod_paciente)
);

CREATE TABLE IF NOT EXISTS atende(
	cod_convenio INT NOT NULL, 
	id_medico INT NOT NULL, 
	FOREIGN KEY (cod_convenio) REFERENCES convenio(codigo),
    FOREIGN KEY (id_medico) REFERENCES medico(crm),
    PRIMARY KEY (cod_convenio, id_medico)
);


INSERT INTO paciente VALUES 
	(12, "Leonardo", "Leocadio", "Bom Jesus", "105", "3898832899"),
	(15, "Joao", "RUA B", "Bom Jesus", "108", "548855855885"),
	(16, "Pedro", "RUA C", "Bom Jesus", "112", "3654885858");
    
INSERT INTO medico VALUES 
	(156, "Aurelio", "Rua D", "Jose miguel", "109", "98827282", "Neurocirugiao"); 
    
INSERT INTO convenio VALUES
	(1, 'Unimed'),
	(2, 'Bradesco Saude'),
	(3, 'SulAmerica');
    
INSERT INTO consulta VALUES
	(101, '2026-06-10', '08:30:00', 80.00, 12, 1, 156),
	(102, '2026-06-11', '09:15:00', 70.00, 15, 2, 156),
	(103, '2026-06-12', '14:00:00', 90.00, 16, 3, 156);






