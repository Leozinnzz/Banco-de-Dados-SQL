CREATE DATABASE IF NOT EXISTS gestao_academia; 
USE gestao_academia; 

CREATE TABLE IF NOT EXISTS unidade(
	id INT PRIMARY KEY, 
    nome VARCHAR(100) NOT NULL,
	rua VARCHAR(30) NOT NULL, 
    numero VARCHAR(20) NOT NULL,
    bairro VARCHAR(50) NOT NULL,
    matricula_funcionario INT, 
    data_gerencia DATE
);

CREATE TABLE IF NOT EXISTS funcionario (
	matricula INT PRIMARY KEY, 
    nome VARCHAR(100) NOT NULL, 
    rua VARCHAR(30) NOT NULL, 
    numero VARCHAR(20) NOT NULL,
    bairro VARCHAR(50) NOT NULL,
    telefone VARCHAR(20) NOT NULL, 
    salário DECIMAL(10,2) NOT NULL, 
    data_admissao DATE NOT NULL, 
    especialidade VARCHAR(100) NOT NULL, 
    id_unidade INT NOT NULL,
    
    FOREIGN KEY (id_unidade) REFERENCES unidade(id)
);

ALTER TABLE unidade ADD CONSTRAINT  fk_unidade_gerente FOREIGN KEY (matricula_funcionario) REFERENCES funcionario(matricula); 

CREATE TABLE IF NOT EXISTS aluno (
	matricula INT PRIMARY KEY, 
    nome VARCHAR(100) NOT NULL, 
    data_nascimento DATE NOT NULL, 
    rua VARCHAR(20) NOT NULL,
    numero VARCHAR(20) NOT NULL,
    bairro VARCHAR(50) NOT NULL,
    telefone VARCHAR(20) NOT NULL, 
    data_ingresso DATE
);

CREATE TABLE IF NOT EXISTS plano(
	id INT PRIMARY KEY, 
	nome VARCHAR(100) NOT NULL, 
    valor_mensal DECIMAL(10,2) NOT NULL, 
    duracao_contratual INT NOT NULL, 
    beneficios TEXT
);

CREATE TABLE IF NOT EXISTS ficha(
	id INT PRIMARY KEY, 
    data_incricao DATE NOT NULL, 
    matricula_aluno INT NOT NULL, 
    matricula_funcionario INT NOT NULL, 
    
    FOREIGN KEY (matricula_aluno) REFERENCES aluno(matricula), 
    FOREIGN KEY (matricula_funcionario) REFERENCES funcionario(matricula)
);

CREATE TABLE IF NOT EXISTS exercicio(
	codigo INT PRIMARY KEY AUTO_INCREMENT, 
    nome VARCHAR(100) NOT NULL 
); 

CREATE TABLE IF NOT EXISTS modalidade (
	numero INT PRIMARY KEY AUTO_INCREMENT,
	nome VARCHAR(100) NOT NULL 
); 


CREATE TABLE IF NOT EXISTS aula(
	codigo INT PRIMARY KEY, 
    horario TIME NOT NULL, 
    limite_participante INT DEFAULT 30, 
    numero_modalidade INT NOT NULL, 
    
    FOREIGN KEY (numero_modalidade) REFERENCES modalidade(numero)
 );
 
CREATE TABLE IF NOT EXISTS avaliacao_fisica(
	id INT PRIMARY KEY AUTO_INCREMENT, 
    peso DECIMAL (5,2), 
    altura DECIMAL (5,2),
    percentual_gordura DECIMAL (5,2), 
    massa_muscular INTEGER, 
    observacoes TEXT, 
    
    matricula_aluno INT NOT NULL, 
    matricula_funcionario INT NOT NULL, 
    
    FOREIGN KEY (matricula_aluno) REFERENCES aluno(matricula),
    FOREIGN KEY (matricula_funcionario) REFERENCES funcionario(matricula)
 );
 
CREATE TABLE IF NOT EXISTS ficha_exercicio(
	id_ficha INT, 
    codigo_exercicio INT, 
    series INT NOT NULL, 
    repeticoes INT NOT NULL, 
    carga INT NOT NULL,
    tempo_descanso TIME,
    
    PRIMARY KEY (id_ficha, codigo_exercicio), 
    FOREIGN KEY (id_ficha) REFERENCES ficha(id), 
    FOREIGN KEY (codigo_exercicio) REFERENCES exercicio(codigo)
);
 
 CREATE TABLE IF NOT EXISTS instrutor_modalidade(
	matricula_funcionario INT,  
    numero_modalidade INT, 
    
    PRIMARY KEY (matricula_funcionario, numero_modalidade), 
	FOREIGN KEY (matricula_funcionario) REFERENCES funcionario(matricula), 
    FOREIGN KEY (numero_modalidade) REFERENCES modalidade(numero)
 );
 
 CREATE TABLE IF NOT EXISTS frequencia_aula (
	matricula_aluno INT,
    codigo_aula INT, 
    data_aula DATE NOT NULL, 
    frequencia BOOLEAN NOT NULL,
    
    PRIMARY KEY (matricula_aluno, codigo_aula), 
    FOREIGN KEY (matricula_aluno) REFERENCES aluno(matricula), 
    FOREIGN KEY (codigo_aula) REFERENCES aula(codigo)
 );
 
 CREATE TABLE IF NOT EXISTS historico_plano (
	id_historico INT PRIMARY KEY AUTO_INCREMENT,
	data_inicio DATE NOT NULL, 
    data_fim DATE, 
    
    matricula_aluno INT NOT NULL, 
    id_plano INT NOT NULL, 
    
    FOREIGN KEY (matricula_aluno) REFERENCES aluno(matricula), 
    FOREIGN KEY (id_plano) REFERENCES plano(id)
 );
 

 




