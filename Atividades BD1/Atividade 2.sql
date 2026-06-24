CREATE DATABASE IF NOT EXISTS Campeonato_futebol; 
USE Campeonato_futebol; 

CREATE TABLE IF NOT EXISTS campeonato(
	id_campeonato INT PRIMARY KEY,
	nome VARCHAR(100) NOT NULL, 
    temporada INT NOT NULL, 
	regulamento VARCHAR(50) NOT NULL, 
    data_inicio DATE NOT NULL, 
    data_termino DATE NOT NULL
);

CREATE TABLE IF NOT EXISTS clube (
	codigo INT PRIMARY KEY, 
    nome VARCHAR(100) NOT NULL, 
    cidade VARCHAR(100) NOT NULL, 
    estadio_principal VARCHAR(100) NOT NULL, 
    presidente VARCHAR(100) UNIQUE NOT NULL
);


CREATE TABLE IF NOT EXISTS jogadores (
	id INT PRIMARY KEY, 
    nome VARCHAR(100) NOT NULL, 
    nacionalidade VARCHAR(100) NOT NULL, 
    data_nascimento DATE NOT NULL, 
    posicao_principal VARCHAR(50) NOT NULL
);

CREATE TABLE IF NOT EXISTS contrato (
	id INT  PRIMARY KEY AUTO_INCREMENT,
    id_jogador INT NOT NULL, 
    id_clube INT NOT NULL, 
	data_inicio DATE NOT NULL, 
    data_termino DATE, 
    salario DECIMAL(10,2) NOT NULL, 
    situacao_contratual VARCHAR(30) NOT NULL,
    
    FOREIGN KEY (id_jogador) REFERENCES jogadores(id), 
    FOREIGN KEY (id_clube) REFERENCES clube(codigo)
);


CREATE TABLE IF NOT EXISTS historico_tranferencia (
	id INT PRIMARY KEY, 
    id_jogador INT,
    clube_origem_id INT NOT NULL, 
    clube_destino_id INT NOT NULL,
    temporada INT NOT NULL,
    
    FOREIGN KEY (id_jogador) REFERENCES jogadores(id), 
    FOREIGN KEY (clube_origem_id) REFERENCES clube(codigo), 
    FOREIGN KEY (clube_destino_id) REFERENCES clube(codigo), 
    
    CONSTRAINT jogador_temporada UNIQUE (id_jogador, temporada)
);

CREATE TABLE IF NOT EXISTS arbitro (
	id INT PRIMARY KEY AUTO_INCREMENT, 
	nome VARCHAR(100) NOT NULL
);

CREATE TABLE IF NOT EXISTS partida (
	id INT PRIMARY KEY AUTO_INCREMENT,
	id_campeonato INT NOT NULL,
	data_partida DATE NOT NULL, 
    horario TIME NOT NULL, 
    estadio VARCHAR(100) NOT NULL, 
    equipe_mandante_id INT NOT NULL, 
    equipe_visitante_id INT NOT NULL, 
	id_arbitro INT NOT NULL,
    
    FOREIGN KEY (id_campeonato) REFERENCES campeonato(id_campeonato), 
    FOREIGN KEY (equipe_mandante_id) REFERENCES clube(codigo),
    FOREIGN KEY (equipe_visitante_id) REFERENCES clube(codigo),
    FOREIGN KEY (id_arbitro) REFERENCES arbitro(id)
);

CREATE TABLE IF NOT EXISTS evento (
	id INT PRIMARY KEY AUTO_INCREMENT, 
    id_partida INT NOT NULL, 
    id_jogador INT NOT NULL, 
    tipo_evento VARCHAR(50) NOT NULL, 
    minuto INT NOT NULL, 
    observacoes TEXT, 
    
    FOREIGN KEY (id_partida) REFERENCES partida(id), 
    FOREIGN KEY (id_jogador) REFERENCES jogadores(id)
);

CREATE TABLE IF NOT EXISTS clube_campeonato (
	clube_id INT NOT NULL, 
    id_campeonato INT NOT NULL, 
    pontuacao INT DEFAULT 0, 
    vitorias INT DEFAULT 0, 
    empates INT DEFAULT 0,
    derrotas INT DEFAULT 0,
    gols_marcados INT DEFAULT 0, 
    gols_sofridos INT DEFAULT 0, 
    
    FOREIGN KEY (clube_id) REFERENCES clube(codigo),
    FOREIGN KEY (id_campeonato) REFERENCES campeonato(id_campeonato),
    PRIMARY KEY (clube_id, id_campeonato)
);

CREATE TABLE IF NOT EXISTS plano_socio (
	id INT PRIMARY KEY AUTO_INCREMENT, 
    nome_plano VARCHAR(100) NOT NULL, 
    mensalidade DECIMAL(10,2) NOT NULL, 
    beneficios TEXT
);

CREATE TABLE IF NOT EXISTS torcedor(
	id INT PRIMARY KEY AUTO_INCREMENT, 
    nome VARCHAR(100) NOT NULL, 
    cpf VARCHAR(100) NOT NULL, 
    id_plano_socio INT, 
    situacao_socio VARCHAR(20) DEFAULT 'Inativo', 
    
    FOREIGN KEY (id_plano_socio) REFERENCES plano_socio(id)
);

CREATE TABLE IF NOT EXISTS  ingresso(
	id INT PRIMARY KEY AUTO_INCREMENT, 
    id_partida INT NOT NULL,
    id_torcedor INT NOT NULL,
    data_venda DATE NOT NULL,
    preco DECIMAL(10,2) NOT NULL, 
    setor_estadio VARCHAR(50) NOT NULL,
    
    FOREIGN KEY (id_partida) REFERENCES partida(id), 
    FOREIGN KEY (id_torcedor) REFERENCES torcedor(id)
);



