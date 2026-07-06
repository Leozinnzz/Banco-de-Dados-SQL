CREATE DATABASE IF NOT EXISTS sistema_inventario; 
USE sistema_inventario; 

CREATE TABLE IF NOT EXISTS jogador(
	id_jogador INT PRIMARY KEY AUTO_INCREMENT, 
    nickname VARCHAR(100) NOT NULL, 
    nivel INT DEFAULT 1, 
    moedas INT DEFAULT 0
);

CREATE TABLE IF NOT EXISTS item(
	id_item INT PRIMARY KEY AUTO_INCREMENT, 
    nome VARCHAR(100) NOT NULL, 
    descricao TEXT, 
    preco_base DECIMAL (15,2) NOT NULL
);

CREATE TABLE IF NOT EXISTS arma(
	id_item INT PRIMARY KEY, 
	dano_ataque INT NOT NULL, 
    durabilidade INT DEFAULT 100,
    
	CONSTRAINT fk_arma 
    FOREIGN KEY (id_item) REFERENCES item(id_item)
);

CREATE TABLE IF NOT EXISTS consumivel(
	id_item INT PRIMARY KEY, 
    bonus_vida INT, 
    tempo_efeito TIME,
    
    CONSTRAINT fk_consumivel FOREIGN KEY (id_item) REFERENCES item(id_item)
);

CREATE TABLE IF NOT EXISTS inventario (
	id_jogador INT,
    id_item INT, 
    quantidade INT NOT NULL,  
    data_aquisicao DATE NOT NULL, 
    
    PRIMARY KEY (id_jogador, id_item),
    CONSTRAINT fk_jogador FOREIGN KEY (id_jogador) REFERENCES jogador(id_jogador), 
    CONSTRAINT fk_item FOREIGN KEY (id_item) REFERENCES item(id_item)
);

CREATE TABLE IF NOT EXISTS conquista(
	id INT PRIMARY KEY AUTO_INCREMENT, 
    nome VARCHAR(100) NOT NULL, 
    quantidade_xp INT NOT NULL
);

CREATE TABLE IF NOT EXISTS conquista_jogador(
	id_jogador INT,
    id_conquista INT,
    data_hora DATETIME NOT NULL,
    
    PRIMARY KEY(id_jogador, id_conquista),
    CONSTRAINT fk_jogador_1 FOREIGN KEY (id_jogador) REFERENCES jogador(id_jogador), 
    CONSTRAINT fk_conquista FOREIGN KEY (id_conquista) REFERENCES conquista(id)
);

INSERT INTO jogador(nickname, nivel, moedas) VALUES 
	('Valkyrie_Br', 15, 450),
	('SpeedRunner', 42, 1200);
    
INSERT INTO item(nome, descricao, preco_base) VALUES
	('Espada Noturna', 'Forjada nas sombras', 350.00),
	('Poção de Mana', 'Restaura energia mágica', 50.00);
    
INSERT INTO arma(id_item, dano_ataque, durabilidade) VALUES
	(1, 75, 120);
    
INSERT INTO consumivel(id_item, bonus_vida, tempo_efeito) VALUES
	(2, 0, '00:05:00');
    
INSERT INTO inventario (id_jogador, id_item, quantidade, data_aquisicao) VALUES
	(1, 1, 1, '2026-07-01'),
	(2, 2, 10, '2026-07-02'); 
    
INSERT INTO conquista (nome, quantidade_xp) VALUES 
	('Primeiros Passos', 100);
    
INSERT INTO conquista_jogador(id_jogador, id_conquista,  data_hora) VALUES
	(1, 1, '2026-07-01 14:30:00');





    
	
