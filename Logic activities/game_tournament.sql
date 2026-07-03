CREATE DATABASE IF NOT EXISTS game_tournament; 
Use game_tournament; 

CREATE TABLE IF NOT EXISTS jogador(
	id_jogador INT PRIMARY KEY AUTO_INCREMENT, 
    nickname VARCHAR(100) NOT NULL, 
    pais VARCHAR(50) NOT NULL
); 

CREATE TABLE IF NOT EXISTS partida(
	id_partida INT PRIMARY KEY AUTO_INCREMENT, 
    data_partida DATE NOT NULL, 
    duracao TIME
);

CREATE TABLE IF NOT EXISTS desempenho (
	id_jogador INT, 
    id_partida INT, 
    pontos INT DEFAULT 0, 
    PRIMARY KEY(id_jogador, id_partida),
    FOREIGN KEY (id_jogador) REFERENCES jogador(id_jogador),
    FOREIGN KEY (id_partida) REFERENCES partida(id_partida)
);


INSERT INTO jogador (nickname, pais) VALUES 
	('Gamer_Neo', 'Brasil'),
    ('Shadow_Boss', 'Portugal'), 
    ('Pixel_Queen', 'Brasil');
    
INSERT INTO partida (data_partida, duracao) VALUES 
	('2026-07-02','00:45:00'),
	('2026-07-03', '01:15:00');

INSERT INTO desempenho (id_jogador, id_partida, pontos) VALUES 
	(1, 1, 150),
	(2, 1, 120),
    -- partida 2
    (1, 2, 210), 
    (2, 2, 90), 
    (3, 2, 300);
    
UPDATE desempenho SET pontos = 110 WHERE id_partida = 2 AND id_jogador = 2;

DELETE FROM desempenho WHERE id_jogador = 2;
DELETE FROM jogador WHERE id_jogador = 2;

SELECT nickname, pais FROM jogador ORDER BY nickname;
SELECT COUNT(id_partida) FROM partida;

SELECT * FROM jogador INNER JOIN desempenho ON jogador.id_jogador = desempenho.id_jogador;

SELECT jogador.nickname, COUNT(desempenho.id_partida) AS total_partidas FROM jogador JOIN desempenho ON jogador.id_jogador = desempenho.id_jogador GROUP BY jogador.nickname
ORDER BY total_partidas DESC;


