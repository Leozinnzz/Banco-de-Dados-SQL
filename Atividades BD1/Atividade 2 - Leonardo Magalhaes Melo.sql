-- NOME: Leonardo Magalhaes Melo
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


INSERT INTO campeonato (id_campeonato, nome, temporada, regulamento, data_inicio, data_termino) VALUES
(1, 'Série A Profissional', 2026, 'Pontos Corridos', '2026-04-12', '2026-12-06'),
(2, 'Copa dos Campeões', 2026, 'Mata-Mata', '2026-03-10', '2026-11-25'),
(3, 'Taça Regional Ouro', 2026, 'Fases de Grupos', '2026-01-15', '2026-04-05'),
(4, 'Série B de Acesso', 2026, 'Pontos Corridos', '2026-04-19', '2026-11-29'),
(5, 'Supercopa Interestadual', 2026, 'Jogo Único', '2026-02-20', '2026-02-20'),
(6, 'Liga de Desenvolvimento Sub-20', 2026, 'Mata-Mata', '2026-05-01', '2026-09-15'),
(7, 'Copa do Interior', 2026, 'Fases de Grupos', '2026-07-01', '2026-10-30'),
(8, 'Torneio de Verão', 2026, 'Pontos Corridos', '2026-01-05', '2026-01-25'),
(9, 'Série A Profissional', 2025, 'Pontos Corridos', '2025-04-15', '2025-12-07'),
(10, 'Copa dos Campeões', 2025, 'Mata-Mata', '2025-03-11', '2025-11-26');


INSERT INTO clube (codigo, nome, cidade, estadio_principal, presidente) VALUES
(10, 'Atlético Esportivo', 'São Paulo', 'Arena Progresso', 'Marcos Aurélio Antunes'),
(20, 'União Futebol Clube', 'Rio de Janeiro', 'Estádio do Mar', 'Beatriz Dornelles'),
(30, 'Real Belo Horizonte', 'Belo Horizonte', 'Estádio das Alterosas', 'Geraldo Magela Rezende'),
(40, 'Sport Club Porto Alegre', 'Porto Alegre', 'Arena Sul', 'Cláudio Humberto Praxedes'),
(50, 'Nacional de Curitiba', 'Curitiba', 'Ecoville Stadium', 'Ricardo Linhares Silva'),
(60, 'Associação Salvador', 'Salvador', 'Ninho da Águia', 'Antônio de Pádua Neto'),
(70, 'Goiás Central Club', 'Goiânia', 'Serra Verde', 'Washington Luiz Faria'),
(80, 'Sport Recife Unido', 'Recife', 'Ilha Costeira', 'Luciana Cavalcanti Costa'),
(90, 'Fortaleza Central', 'Fortaleza', 'Arena das Dunas do Norte', 'Marcelo Paz Júnior'),
(100, 'Brasília FC', 'Brasília', 'Estádio Alvorada', 'Augusto Heleno Melo');


INSERT INTO jogadores (id, nome, nacionalidade, data_nascimento, posicao_principal) VALUES
(501, 'Gabriel Barbosa Lima', 'Brasileiro', '1996-08-30', 'Atacante'),
(502, 'Giorgian De Arrascaeta', 'Uruguaio', '1994-06-01', 'Meio-Campo'),
(503, 'Rodrigo Nestor Alencar', 'Brasileiro', '2000-08-09', 'Meio-Campo'),
(504, 'Jonathan Matias Calleri', 'Argentino', '1993-09-23', 'Atacante'),
(505, 'Pedro Geromel Fontes', 'Brasileiro', '1985-09-21', 'Zagueiro'),
(506, 'Weverton Pereira Silva', 'Brasileiro', '1987-12-13', 'Goleiro'),
(507, 'Gustavo Gómez Portillo', 'Paraguaio', '1993-05-06', 'Zagueiro'),
(508, 'Alan Patrick Rodrigues', 'Brasileiro', '1991-05-13', 'Meio-Campo'),
(509, 'Hulk Givanildo Souza', 'Brasileiro', '1986-07-25', 'Atacante'),
(510, 'Jhon Arias Andrade', 'Colombiano', '1997-09-21', 'Atacante');

INSERT INTO contrato (id, id_jogador, id_clube, data_inicio, data_termino, salario, situacao_contratual) VALUES
(1, 501, 10, '2024-01-01', '2027-12-31', 450000.00, 'Ativo'),
(2, 502, 10, '2023-05-10', '2026-12-31', 500000.00, 'Ativo'),
(3, 503, 20, '2022-01-15', '2026-01-15', 180000.00, 'Ativo'),
(4, 504, 20, '2023-08-01', '2027-07-31', 350000.00, 'Ativo'),
(5, 505, 30, '2020-03-01', '2026-12-31', 120000.00, 'Em Fim de Contrato'),
(6, 506, 40, '2021-06-01', '2028-06-01', 300000.00, 'Ativo'),
(7, 507, 40, '2022-02-15', '2027-02-15', 400000.00, 'Ativo'),
(8, 508, 50, '2024-03-20', '2026-12-31', 250000.00, 'Ativo'),
(9, 509, 30, '2021-02-10', '2026-12-31', 600000.00, 'Ativo'),
(10, 510, 60, '2023-01-10', '2027-12-31', 220000.00, 'Ativo');


INSERT INTO historico_tranferencia (id, id_jogador, clube_origem_id, clube_destino_id, temporada) VALUES
(1, 501, 20, 10, 2024),
(2, 504, 50, 20, 2023),
(3, 507, 60, 40, 2022),
(4, 508, 10, 50, 2024),
(5, 502, 30, 10, 2023),
(6, 503, 70, 20, 2022),
(7, 509, 100, 30, 2021),
(8, 510, 90, 60, 2023),
(9, 505, 40, 30, 2020),
(10, 506, 80, 40, 2021);


INSERT INTO arbitro (id, nome) VALUES
(1, 'Anderson Daronco Silva'),
(2, 'Wilton Pereira Sampaio'),
(3, 'Raphael Claus'),
(4, 'Edina Alves Batista'),
(5, 'Flávio Rodrigues de Souza'),
(6, 'Ramon Abatti Abel'),
(7, 'Braulio da Silva Machado'),
(8, 'Paulo César Zanovelli'),
(9, 'Bruno Arleu de Araújo'),
(10, 'Rodrigo José Pereira');


INSERT INTO partida (id, id_campeonato, data_partida, horario, estadio, equipe_mandante_id, equipe_visitante_id, id_arbitro) VALUES
(1, 1, '2026-05-10', '16:00:00', 'Arena Progresso', 10, 20, 1),
(2, 1, '2026-05-11', '18:30:00', 'Estádio das Alterosas', 30, 40, 2),
(3, 1, '2026-05-17', '16:00:00', 'Estádio do Mar', 20, 30, 3),
(4, 1, '2026-05-18', '20:00:00', 'Arena Sul', 40, 10, 4),
(5, 2, '2026-06-03', '21:45:00', 'Ecoville Stadium', 50, 60, 5),
(6, 2, '2026-06-04', '21:45:00', 'Serra Verde', 70, 80, 6),
(7, 3, '2026-02-15', '19:00:00', 'Ilha Costeira', 80, 90, 7),
(8, 3, '2026-02-22', '16:00:00', 'Arena das Dunas do Norte', 90, 100, 8),
(9, 1, '2026-06-10', '17:00:00', 'Ninho da Águia', 60, 70, 9),
(10, 1, '2026-06-11', '11:00:00', 'Estádio Alvorada', 100, 50, 10);


INSERT INTO evento (id, id_partida, id_jogador, tipo_evento, minuto, observacoes) VALUES
(1, 1, 501, 'Gol', 23, 'Gol de finalização de pé esquerdo dentro da área.'),
(2, 1, 503, 'Cartão Amarelo', 41, 'Falta tática para interromper contra-ataque.'),
(3, 2, 509, 'Gol', 75, 'Cobrança de falta de longa distância.'),
(4, 2, 505, 'Cartão Vermelho', 89, 'Segunda advertência após entrada violenta.'),
(5, 3, 504, 'Gol', 12, 'Gol de cabeça após cruzamento lateral.'),
(6, 4, 507, 'Cartão Amarelo', 55, 'Reclamação acintosa contra a arbitragem.'),
(7, 5, 510, 'Gol', 88, 'Gol decisivo nos minutos finais em contra-ataque.'),
(8, 7, 508, 'Substituição', 60, 'Saiu lesionado para entrada do reserva.'),
(9, 9, 510, 'Gol', 4, 'Chute rasteiro de fora da área.'),
(10, 10, 508, 'Gol', 62, 'Gol de pênalti convertido com tranquilidade.');


INSERT INTO clube_campeonato (clube_id, id_campeonato, pontuacao, vitorias, empates, derrotas, gols_marcados, gols_sofridos) VALUES
(10, 1, 4, 1, 1, 0, 2, 1),
(20, 1, 1, 0, 1, 1, 1, 2),
(30, 1, 3, 1, 0, 1, 1, 1),
(40, 1, 3, 1, 0, 1, 1, 1),
(50, 2, 0, 0, 0, 1, 0, 1),
(60, 2, 3, 1, 0, 0, 1, 0),
(70, 2, 1, 0, 1, 0, 1, 1),
(80, 2, 1, 0, 1, 0, 1, 1),
(90, 3, 4, 1, 1, 0, 3, 1),
(100, 3, 1, 0, 1, 1, 1, 3);


INSERT INTO plano_socio (id, nome_plano, mensalidade, beneficios) VALUES
(1, 'Sócio Arquibancada Bronze', 39.90, 'Acesso prioritário a ingressos do setor norte/sul'),
(2, 'Sócio Cadeira Prata', 89.90, 'Desconto de 50% em qualquer setor e rede de parceiros'),
(3, 'Sócio VIP Ouro', 199.90, 'Entrada franca nas cadeiras VIP, buffet incluso e camisa oficial anual'),
(4, 'Sócio Corporativo Platina', 999.90, 'Camarote exclusivo com direito a 4 acompanhantes por partida'),
(5, 'Sócio Contribuinte Mirim', 19.90, 'Plano infantil para menores de 12 anos, direito a entrar em campo'),
(6, 'Sócio Regional Interior', 29.90, 'Focado em torcedores de fora da capital, descontos em pay-per-view'),
(7, 'Sócio Universitário', 34.90, 'Desconto especial estudantil mediante comprovação de matrícula'),
(8, 'Sócio Master 60+', 45.00, 'Atendimento e assentos preferenciais em dias de jogos comerciais'),
(9, 'Sócio Diamante Vitalício', 5000.00, 'Pagamento único com acesso vitalício à tribuna de honra'),
(10, 'Sócio Digital Fan', 9.90, 'Sem direito a ingressos, focado em conteúdos digitais e votações');


INSERT INTO torcedor (id, nome, cpf, id_plano_socio, situacao_socio) VALUES
(1, 'Leonardo Medeiros Silva', '111.222.333-44', 3, 'Ativo'),
(2, 'Camila Rodrigues Rocha', '222.333.444-55', 1, 'Ativo'),
(3, 'Felipe Santana Antunes', '333.444.555-66', 2, 'Ativo'),
(4, 'Juliana Fontes Garcia', '444.555.666-77', NULL, 'Inativo'),
(5, 'Thiago Alencar Malta', '555.666.777-88', 4, 'Ativo'),
(6, 'Renata Souza Rezende', '666.777.888-99', 1, 'Inativo'),
(7, 'Mateus Barbosa Lima', '777.888.999-00', 7, 'Ativo'),
(8, 'Amanda Mendes Alencar', '888.999.000-11', NULL, 'Inativo'),
(9, 'Ricardo Dias Oliveira', '999.000.111-22', 2, 'Ativo'),
(10, 'Patrícia Albuquerque', '000.111.222-33', 3, 'Ativo');


INSERT INTO ingresso (id, id_partida, id_torcedor, data_venda, preco, setor_estadio) VALUES
(1, 1, 1, '2026-05-05', 0.00, 'Cadeira VIP Ouro'),
(2, 1, 2, '2026-05-06', 39.90, 'Arquibancada Norte'),
(3, 1, 3, '2026-05-05', 45.00, 'Cadeira Central Prata'),
(4, 2, 5, '2026-05-07', 0.00, 'Camarote Platina'),
(5, 3, 7, '2026-05-12', 35.00, 'Arquibancada Leste'),
(6, 3, 9, '2026-05-14', 50.00, 'Cadeira Descoberta'),
(7, 4, 1, '2026-05-13', 0.00, 'Cadeira VIP Ouro'),
(8, 5, 2, '2026-05-28', 25.00, 'Arquibancada Sul'),
(9, 6, 10, '2026-05-30', 0.00, 'Cadeira VIP Ouro'),
(10, 7, 4, '2026-02-10', 80.00, 'Cadeira Central Prata');

ALTER TABLE jogadores 
	CHANGE COLUMN nacionalidade pais_origem VARCHAR(60) NOT NULL,
    CHANGE COLUMN posicao_principal posicao_tatica VARCHAR(40) NOT NULL,
    CHANGE COLUMN nome nome_completo VARCHAR(120) NOT NULL;
    
SELECT 
    cl.nome AS clube, 
    cc.pontuacao, 
    cc.vitorias, 
    cc.empates, 
    cc.derrotas, 
    (cc.gols_marcados - cc.gols_sofridos) AS saldo_gols
FROM clube_campeonato cc
JOIN clube cl ON cc.clube_id = cl.codigo
WHERE cc.id_campeonato = 1
ORDER BY cc.pontuacao DESC, cc.vitorias DESC, saldo_gols DESC;

-- Consulta 2: Média Salarial dos Jogadores Ativos por Posição Operacional
-- Importância: Usado pelo departamento financeiro e de scouts (olheiros) para equilibrar o teto salarial e entender o custo de reposição por posição.
SELECT 
    j.posicao_tatica, 
    COUNT(j.id) AS total_jogadores,
    ROUND(AVG(c.salario), 2) AS media_salarial
FROM contrato c
JOIN jogadores j ON c.id_jogador = j.id
WHERE c.situacao_contratual = 'Ativo'
GROUP BY j.posicao_tatica;


-- Consulta 3: Artilharia do Campeonato (Ranking de Gols por Jogador)
-- Importância: Avaliação de desempenho individual. Crucial para premiações de melhor do ano e valorização de mercado do atleta.
SELECT 
    j.nome_completo, 
    cl.nome AS clube_atual, 
    COUNT(ev.id) AS total_gols
FROM evento ev
JOIN jogadores j ON ev.id_jogador = j.id
JOIN contrato con ON j.id = con.id_jogador
JOIN clube cl ON con.id_clube = cl.codigo
WHERE ev.tipo_evento = 'Gol' AND con.situacao_contratual = 'Ativo'
GROUP BY j.id, j.nome_completo, cl.nome
ORDER BY total_gols DESC;


-- Consulta 4: Relatório Estatístico de Arrecadação por Partida (Bilheteria)
-- Importância: Gestão de Estádios e Financeiro. Ajuda a mensurar o lucro bruto de bilheteria e quais jogos geram maior engajamento financeiro.
SELECT 
    p.id AS partida_id, 
    p.data_partida, 
    cm.nome AS mandante, 
    cv.nome AS visitante, 
    SUM(i.preco) AS arrecadacao_total,
    COUNT(i.id) AS ingressos_vendidos
FROM ingresso i
JOIN partida p ON i.id_partida = p.id
JOIN clube cm ON p.equipe_mandante_id = cm.codigo
JOIN clube cv ON p.equipe_visitante_id = cv.codigo
GROUP BY p.id, p.data_partida, cm.nome, cv.nome;


-- Consulta 5: Relação de Jogadores com Contrato Próximo do Fim (Menos de 6 meses / Status Informativo)
-- Importância: Alerta estratégico para a diretoria. Evita que o clube perca atletas de graça (sem custos de transferência) para equipes rivais.
SELECT 
    j.nome_completo, 
    cl.nome AS clube, 
    c.data_termino, 
    c.salario,
    c.situacao_contratual
FROM contrato c
JOIN jogadores j ON c.id_jogador = j.id
JOIN clube cl ON c.id_clube = cl.codigo
WHERE c.situacao_contratual = 'Em Fim de Contrato';


-- Consulta 6: Histórico de Escalação e Atuação de Árbitros
-- Importância: Controle de Governança e Compliance. Usado pela Comissão de Arbitragem para analisar quais juízes apitam mais clássicos e evitar repetições excessivas.
SELECT 
    a.nome AS nome_arbitro, 
    COUNT(p.id) AS total_partidas_apitadas
FROM partida p
JOIN arbitro a ON p.id_arbitro = a.id
GROUP BY a.id, a.nome
ORDER BY total_partidas_apitadas DESC;


-- Consulta 7: Engajamento de Torcedores por Plano de Sócio Ativo
-- Importância: Direcionamento do setor de Marketing. Indica quais categorias de planos geram mais receita recorrente e fidelização de público.
SELECT 
    ps.nome_plano, 
    COUNT(t.id) AS total_socios_ativos, 
    SUM(ps.mensalidade) AS receita_mensal_estimada
FROM torcedor t
JOIN plano_socio ps ON t.id_plano_socio = ps.id
WHERE t.situacao_socio = 'Ativo'
GROUP BY ps.id, ps.nome_plano
ORDER BY total_socios_ativos DESC;


-- Consulta 8: Análise de Disciplina - Ranking de Cartões Vermelhos por Clube
-- Importância: Análise disciplinar e Fair Play. Comissão técnica e direção usam estes dados para punir internamente indisciplinas que prejudicam o time em campo.
SELECT 
    cl.nome AS clube, 
    COUNT(ev.id) AS total_cartoes_vermelhos
FROM evento ev
JOIN jogadores j ON ev.id_jogador = j.id
JOIN contrato con ON j.id = con.id_jogador
JOIN clube cl ON con.id_clube = cl.codigo
WHERE ev.tipo_evento = 'Cartão Vermelho' AND con.situacao_contratual = 'Ativo'
GROUP BY cl.codigo, cl.nome
ORDER BY total_cartoes_vermelhos DESC;


-- Consulta 9: Fluxo de Origem e Destino de Transferências por Temporada
-- Importância: Inteligência de Mercado. Identifica quais clubes estão atuando como "vendedores" ou "compradores" na janela de transferências do ano.
SELECT 
    ht.temporada, 
    j.nome_completo, 
    c_origem.nome AS clube_origem, 
    c_destino.nome AS clube_destino
FROM historico_tranferencia ht
JOIN jogadores j ON ht.id_jogador = j.id
JOIN clube c_origem ON ht.clube_origem_id = c_origem.codigo
JOIN clube c_destino ON ht.clube_destino_id = c_destino.codigo
ORDER BY ht.temporada DESC;


-- Consulta 10: Faturamento Médio por Categoria de Setor do Estádio
-- Importância: Precificação Inteligente de Ingressos (Ticketing). Apoia decisões de aumento ou redução de preços de acordo com a demanda física de cada setor.
SELECT 
    setor_estadio, 
    COUNT(id) AS ingressos_comprados, 
    ROUND(AVG(preco), 2) AS preco_medio_pago
FROM ingresso
GROUP BY setor_estadio
ORDER BY preco_medio_pago DESC;


