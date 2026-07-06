CREATE DATABASE IF NOT EXISTS bugmakers; 
USE bugmakers;
CREATE TABLE IF NOT EXISTS contrato (
	id_contrato INT PRIMARY KEY,
    tipo VARCHAR(20) NOT NULL, 
    salario DECIMAL(15,2) NOT NULL, 
    cargo VARCHAR(60) NOT NULL, 
    bonificacao DECIMAL(10,2) NOT NULL, 
    data_inicio DATE NOT NULL, 
    data_termino DATE
);

CREATE TABLE IF NOT EXISTS funcionario (
	cpf INT PRIMARY KEY, 
	nome VARCHAR(100) NOT NULL, 
	telefone INT,
	data_nascimento DATE NOT NULL,
	UF VARCHAR(12), 
	cidade VARCHAR(50) NOT NULL,
	bairro VARCHAR(30), 
	rua VARCHAR(30),
	num_casa VARCHAR(15),
    id_contrato INT, 
	CONSTRAINT fk_contrato FOREIGN KEY (id_contrato) REFERENCES contrato(id_contrato)
);

 CREATE TABLE IF NOT EXISTS profissional_saude (
	cpf INT PRIMARY KEY,
	especialidade VARCHAR(20) NOT NULL,
	registro VARCHAR(25) UNIQUE NOT NULL
 );

CREATE TABLE IF NOT EXISTS jogador(
	cpf INT PRIMARY KEY, 
    situacao_atua VARCHAR(20) DEFAULT 'ativo' NOT NULL,
    nickname VARCHAR(100) NOT NULL, 
    funcao VARCHAR(60) NOT NULL,
    horas_treino_semana INT NOT NULL
);

CREATE TABLE IF NOT EXISTS consulta(
	id_consulta INT PRIMARY KEY AUTO_INCREMENT,
	tipo VARCHAR(40) NOT NULL,
	data_consulta DATE NOT NULL,
	horario_consulta TIME NOT NULL,
	observações TEXT NOT NULL,
    id_profissional INT,
    id_jogador INT, 
	CONSTRAINT fk_profissional FOREIGN KEY (id_profissional) REFERENCES profissional_saude(cpf),
	CONSTRAINT fk_jogador FOREIGN KEY (id_jogador) REFERENCES jogador(cpf)
);

CREATE TABLE IF NOT EXISTS checkin_diario (
	id_checkin INT PRIMARY KEY AUTO_INCREMENT, 
	data_registro DATE NOT NULL,
	hora_sono INT NOT NULL,
	nivel_estresse INT NOT NULL, 
	nivel_fadiga INT NOT NULL, 
    id_jogador INT, 
	CONSTRAINT fk_jogador_2 FOREIGN KEY (id_jogador) REFERENCES jogador(cpf)
 );

CREATE TABLE IF NOT EXISTS rotina_academia (
	id_treino INT PRIMARY KEY AUTO_INCREMENT,
	tipo_treino VARCHAR(40) NOT NULL,
	duracao INT NOT NULL,
	custo DECIMAL(6,2) NOT NULL,
    id_jogador INT,
	CONSTRAINT fk_jogador_3 FOREIGN KEY (id_jogador) REFERENCES jogador(cpf)
);

CREATE TABLE IF NOT EXISTS partida (
	id_partida INT PRIMARY KEY AUTO_INCREMENT, 
	tipo_partida VARCHAR(40) NOT NULL, 
	data_partida DATE NOT NULL,
	hora_partida TIME NOT NULL, 
	time_adversario VARCHAR(60),
	gols_tomados INT DEFAULT 0 NOT NULL, 
	overtime VARCHAR(10) NOT NULL,
	resultado VARCHAR (15) NOT NULL,
	gols_contra INT DEFAULT 0 NOT NULL, 
    id_torneio INT,
	CONSTRAINT fk_torneio FOREIGN KEY (id_torneio) REFERENCES torneio(id_torneio)
);


CREATE TABLE IF NOT EXISTS torneio (
	id_torneio INT PRIMARY KEY AUTO_INCREMENT,
	nome VARCHAR(50) NOT NULL, 
	data_inicio DATE NOT NULL,
	data_fim DATE NOT NULL,
	taxa_inscricao DECIMAL(8,2) NOT NULL,
	local_torneio VARCHAR(50) NOT NULL,
	premiacao DECIMAL(15,2) NOT NULL
 );

CREATE TABLE IF NOT EXISTS desempenho_jogador_partida (
	id_desempenho INT PRIMARY KEY AUTO_INCREMENT, 
	gols INT NOT NULL, 
	score INT NOT NULL,
	assistencias INT NOT NULL, 
	chutes_ao_gol INT NOT NULL,
	salvamentos INT DEFAULT 0 NOT NULL,
    id_jogador INT, 
	id_partida INT,
	CONSTRAINT fk_jogador_4 FOREIGN KEY (id_jogador) REFERENCES jogador(cpf),
	CONSTRAINT fk_partida FOREIGN KEY (id_partida) REFERENCES partida(id_partida)
 );

CREATE TABLE IF NOT EXISTS receita (
	id_receita INT PRIMARY KEY AUTO_INCREMENT,
	origem VARCHAR(50) NOT NULL,
	valor_recebido DECIMAL(15,2) NOT NULL, 
	data_recebimento DATE NOT NULL,
	id_torneio INT, 
	CONSTRAINT fk_torneio_2 FOREIGN KEY (id_torneio) REFERENCES torneio(id_torneio)
);

CREATE TABLE IF NOT EXISTS viagem (
	id_viagem INT PRIMARY KEY AUTO_INCREMENT, 
	data_ida DATE NOT NULL,
	data_volta DATE NOT NULL,
	destino VARCHAR(50) NOT NULL,
	status_viagem VARCHAR(20) NOT NULL, 
    id_torneio INT, 
	CONSTRAINT fk_torneio_3 FOREIGN KEY (id_torneio) REFERENCES torneio(id_torneio)
 );

CREATE TABLE IF NOT EXISTS equipamento (
	id_equipamento INT PRIMARY KEY AUTO_INCREMENT,
	tipo VARCHAR(40) NOT NULL,
	modelo VARCHAR(50) NOT NULL,
	marca VARCHAR(45) NOT NULL,
	preco DECIMAL(10,2) NOT NULL,
	descricao TEXT,
	data_compra DATE NOT NULL
 );

CREATE TABLE IF NOT EXISTS transporte_equipamento (
	id_viagem INT,
    id_equipamento INT, 
    PRIMARY KEY(id_viagem, id_equipamento),
	CONSTRAINT fk_viagem FOREIGN KEY (id_viagem) REFERENCES viagem(id_viagem),
	CONSTRAINT fk_equipamento FOREIGN KEY (id_equipamento) REFERENCES equipamento(id_equipamento)
);

CREATE TABLE IF NOT EXISTS transporte (
	id_transporte INT PRIMARY KEY AUTO_INCREMENT,
	tipo VARCHAR(50) NOT NULL,
	preco DECIMAL(10,2) NOT NULL,
	trajeto VARCHAR(40) NOT NULL,
	qtd_passageiros INT NOT NULL,
	status_transporte VARCHAR(20) NOT NULL,
    id_viagem INT,
	CONSTRAINT fk_viagem_2 FOREIGN KEY (id_viagem) REFERENCES viagem(id_viagem)
 );
 
 SHOW TABLES;

