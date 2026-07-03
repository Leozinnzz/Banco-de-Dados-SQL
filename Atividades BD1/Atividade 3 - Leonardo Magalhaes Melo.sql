-- NOME: Leonardo Magalhaes Melo
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


ALTER TABLE dispositivo 
ADD COLUMN valor_aquisicao DECIMAL(12,2) DEFAULT 0.00;

ALTER TABLE evento 
    CHANGE COLUMN _data data_registro DATE NOT NULL, 
    CHANGE COLUMN tipo classificacao_evento VARCHAR(50) NOT NULL,
    CHANGE COLUMN prioridade nivel_severidade VARCHAR(20) NOT NULL;

INSERT INTO ambiente (id, nome, localizacao) VALUES
(1, 'Laboratório de Sensores Inteligentes', 'Bloco A - Sala 102'),
(2, 'Oficina de Manufatura Aditiva', 'Bloco B - Galpão 3'),
(3, 'Sala de Testes de Voo de Drones', 'Bloco A - Sala 204'),
(4, 'Arena de Robôs Móveis', 'Bloco C - Subsolo'),
(5, 'Núcleo de Computação e Visão Computacional', 'Bloco B - Sala 105'),
(6, 'Laboratório de Biomecatrônica', 'Bloco D - Sala 12'),
(7, 'Câmara de Simulação Ambiental', 'Bloco C - Sala 201'),
(8, 'Oficina de Robótica Industrial', 'Bloco E - Galpão 1'),
(9, 'Espaço Maker de Prototipagem Rápida', 'Bloco A - Convivência'),
(10, 'Sala de Sistemas Autônomos Subaquáticos', 'Bloco D - Piscina Técnica');

INSERT INTO pesquisador (matricula, nome, titulacao, area_atuacao) VALUES
(1001, 'Dr. Arthur Pendragon Ramos', 'Doutor', 'Visão Computacional e IA'),
(1002, 'Ma. Clara Mendonça Luz', 'Mestre', 'Robótica Móvel Terrestre'),
(1003, 'Dr. Roberto Carlos Peixoto', 'Doutor', 'Cinemática de Manipuladores'),
(1004, 'Eng. Beatriz Fontes Alencar', 'Especialista', 'Sistemas Embarcados e IoT'),
(1005, 'Dr. Henrique Souza Dias', 'Doutor', 'Drones e Veículos Aéreos'),
(1006, 'Dra. Júlia Martins Rezende', 'Doutora', 'Próteses Biomecatrônicas'),
(1007, 'Me. Lucas Oliveira Lima', 'Mestre', 'Navegação Autônoma'),
(1008, 'Eng. Sofia Barbosa Malta', 'Graduada', 'Impressão 3D e Materiais'),
(1009, 'Dr. Fernando Garcia Fontes', 'Doutor', 'Robótica Industrial'),
(1010, 'Ma. Natália Ribeiro Correia', 'Mestre', 'Fusão de Sensores');

INSERT INTO experimento (id, nome, id_ambiente) VALUES
(501, 'Mapeamento SLAM 3D com Lidar', 4),
(502, 'Calibração de Atuadores Pneumáticos', 2),
(503, 'Controle de Estabilidade de Quadricóptero', 3),
(504, 'Reconhecimento de Objetos com Redes YOLO', 5),
(505, 'Teste de Fadiga de Exoesqueleto de Joelho', 6),
(506, 'Navegação Autônoma Evitando Obstáculos', 4),
(507, 'Sincronização de Enxame de Microdrones', 3),
(508, 'Manipulação de Peças Automotivas Intercaladas', 8),
(509, 'Análise de Vedação de ROV Subaquático', 10),
(510, 'Impressão Estrutural de Chassis de Alumínio', 9);


INSERT INTO dispositivo (id, fabricante, modelo, data_aquisicao, tipo_dispositivo, valor_aquisicao) VALUES
(201, 'Universal Robots', 'UR5e', '2024-03-12', 'Braço Robótico Articulado', 120000.00),
(202, 'RPLIDAR', 'A3M1', '2025-01-15', 'Sensor Lidar 360 Graus', 2500.00),
(203, 'DJI', 'Matrice 300 RTK', '2024-07-22', 'Aeronave Remotamente Pilotada', 85000.00),
(204, 'NVIDIA', 'Jetson Orin Nano', '2025-05-10', 'Placa de Processamento de IA', 4500.00),
(205, 'Clearpath Robotics', 'Jackal UGV', '2023-11-05', 'Veículo Terrestre Autônomo', 150000.00),
(206, 'Intel', 'RealSense D435i', '2024-02-18', 'Câmera de Profundidade', 3800.00),
(207, 'KUKA', 'KR 6 R900', '2023-05-20', 'Robô Industrial Manipulador', 210000.00),
(208, 'Arduino LLC', 'Portenta H7', '2025-08-01', 'Microcontrolador Dual-Core', 900.00),
(209, 'Raspberry Pi Foundation', 'Raspberry Pi 5', '2024-10-14', 'Single Board Computer', 750.00),
(210, 'Tektronix', 'TBS1052B', '2023-04-02', 'Osciloscópio Digital', 5500.00);


INSERT INTO evento (id, data_registro, horario, classificacao_evento, nivel_severidade, id_experimento, id_dispositivo) VALUES
(301, '2026-06-01', '10:15:00', 'Log de Execução', 'Baixa', 501, 202),
(302, '2026-06-01', '10:30:00', 'Aviso de Temperatura', 'Média', 504, 204),
(303, '2026-06-02', '14:22:00', 'Falha de Conexão', 'Alta', 503, 203),
(304, '2026-06-03', '09:00:00', 'Calibração Concluída', 'Baixa', 502, 201),
(305, '2026-06-04', '16:45:00', 'Parada de Emergência', 'Crítica', 508, 207),
(306, '2026-06-05', '11:10:00', 'Log de Execução', 'Baixa', 506, 205),
(307, '2026-06-05', '11:12:00', 'Queda de Tensão', 'Média', 506, 209),
(308, '2026-06-06', '15:30:00', 'Erro de Timeout', 'Alta', 509, 208),
(309, '2026-06-07', '08:20:00', 'Início de Ciclo', 'Baixa', 505, 206),
(310, '2026-06-07', '17:00:00', 'Sobrecarga de Corrente', 'Alta', 510, 210);

INSERT INTO execucao (id, tarefa_realizada, horario_inicio, horario_termino, resultado_obtido, id_dispositivo) VALUES
(401, 'Varredura de Nuvem de Pontos da Sala 204', '2026-06-01 10:00:00', '2026-06-01 10:25:00', 'Sucesso: Mapa gerado com margem de erro de 2cm.', 202),
(402, 'Processamento de Vídeo em Tempo Real', '2026-06-01 10:28:00', '2026-06-01 11:30:00', 'Sucesso parciail: Frame rate caiu devido ao superaquecimento.', 204),
(403, 'Voo Estacionário de Precisão com Ventania', '2026-06-02 14:15:00', '2026-06-02 14:22:00', 'Falha: Ventos excederam limite, gerando corte de link RF.', 203),
(404, 'Movimentação Paletizada em Ciclo Fechado', '2026-06-03 08:50:00', '2026-06-03 09:50:00', 'Sucesso: Repetibilidade de posição mantida em 0.03mm.', 201),
(405, 'Ciclo Contínuo de Soldagem Intermitente', '2026-06-04 16:40:00', '2026-06-04 16:45:00', 'Abortado: Sensor óptico identificou barreira física na arena.', 207),
(406, 'Navegação por Odometria Visual em Labirinto', '2026-06-05 11:00:00', '2026-06-05 11:30:00', 'Sucesso: Destino alcançado em tempo recorde de 3 min.', 205),
(407, 'Leitura Contínua de Extensômetros de Carga', '2026-06-07 08:15:00', '2026-06-07 12:15:00', 'Sucesso: Curva de histerese mapeada perfeitamente.', 206),
(408, 'Envio de Comandos PWM para Drivers H', '2026-06-06 15:25:00', '2026-06-06 15:30:00', 'Falha: Interrupção de hardware travou barramento I2C.', 208),
(409, 'Modelagem de Malha de Altura de Impressão', '2026-06-07 16:45:00', '2026-06-07 17:30:00', 'Sucesso: Camadas niveladas a cada 0.1mm.', 210),
(410, 'Execução de Kernel de IA para Filtro Kalman', '2026-06-05 11:10:00', '2026-06-05 11:45:00', 'Sucesso: Ruído de sinal reduzido em 85%.', 209);

INSERT INTO pesquisador_experimento (matricula_pesquisador, id_experimento) VALUES
(1001, 504),
(1002, 501),
(1002, 506),
(1003, 502),
(1004, 506),
(1005, 503),
(1005, 507),
(1006, 505),
(1009, 508),
(1010, 501);


INSERT INTO dispositivo (id, fabricante, modelo, data_aquisicao, tipo_dispositivo, valor_aquisicao) VALUES
(211, 'Boston Dynamics', 'Spot', '2026-06-25', 'Cão Robô Autônomo', 350000.00);


-- Consulta 1: Relatório de Monitoramento de Falhas e Eventos Críticos
-- Importância: Segurança industrial e operacional. Lista ocorrências graves imediatamente para que a equipe de engenharia verifique avarias de hardware.
SELECT 
    ev.id AS evento_id, 
    ev.data_registro, 
    ev.horario, 
    ev.classificacao_evento, 
    d.modelo AS dispositivo_afetado, 
    exp.nome AS experimento
FROM evento ev
JOIN dispositivo d ON ev.id_dispositivo = d.id
JOIN experimento exp ON ev.id_experimento = exp.id
WHERE ev.nivel_severidade IN ('Alta', 'Crítica')
ORDER BY ev.data_registro DESC, ev.horario DESC;


-- Consulta 2: Cronograma Detalhado de Uso de Ambientes por Experimento
-- Importância: Gestão logística do espaço físico. Evita conflitos de agendamento de cientistas em uma mesma sala ou arena de testes.
SELECT 
    amb.nome AS sala_ambiente, 
    amb.localizacao, 
    exp.nome AS experimento_alocado
FROM experimento exp
JOIN ambiente amb ON exp.id_ambiente = amb.id
ORDER BY amb.nome;


-- Consulta 3: Quantidade de Experimentos Conduzidos por Titulação Acadêmica
-- Importância: Métricas de RH e Capes. Analisa se o volume de produção do laboratório está concentrado em Doutores, Mestres ou Graduandos.
SELECT 
    p.titulacao, 
    COUNT(pe.id_experimento) AS total_participacoes
FROM pesquisador_experimento pe
JOIN pesquisador p ON pe.matricula_pesquisador = p.matricula
GROUP BY p.titulacao
ORDER BY total_participacoes DESC;


-- Consulta 4: Duração Média (em minutos) das Execuções de Tarefas por Dispositivo
-- Importância: Análise de Ciclo e Desempenho (OEE). Mede a eficiência de tempo de máquina ligada e o estresse operacional do equipamento.
SELECT 
    d.id AS id_dispositivo,
    d.modelo, 
    d.tipo_dispositivo,
    COUNT(ex.id) AS total_tarefas,
    ROUND(AVG(TIMESTAMPDIFF(MINUTE, ex.horario_inicio, ex.horario_termino)), 1) AS media_duracao_minutos
FROM execucao ex
JOIN dispositivo d ON ex.id_dispositivo = d.id
GROUP BY d.id, d.modelo, d.tipo_dispositivo;


-- Consulta 5: Listagem de Pesquisadores Alocados por Experimento (Equipes)
-- Importância: Visibilidade gerencial. Permite ao diretor do laboratório ver quem são os integrantes responsáveis e líderes por projeto científico.
SELECT 
    exp.nome AS experimento, 
    p.nome AS pesquisador, 
    p.area_atuacao
FROM pesquisador_experimento pe
JOIN experimento exp ON pe.id_experimento = exp.id
JOIN pesquisador p ON pe.matricula_pesquisador = p.matricula
ORDER BY exp.nome;


-- Consulta 6: Auditoria de Eficiência e Falhas nos Textos de Resultados das Execuções
-- Importância: Controle de Qualidade. Filtra quais execuções retornaram mensagens explícitas de erro/falha nos logs para manutenção corretiva imediata.
SELECT 
    ex.id AS cod_execucao, 
    d.modelo AS equipamento, 
    ex.tarefa_realizada, 
    ex.resultado_obtido
FROM execucao ex
JOIN dispositivo d ON ex.id_dispositivo = d.id
WHERE ex.resultado_obtido LIKE '%Falha%' OR ex.resultado_obtido LIKE '%Abortado%';


-- Consulta 7: Inventário de Dispositivos por Fabricante e Antiguidade
-- Importância: Gerenciamento de Ativos e ciclo de obsolescência de TI. Identifica quais parceiros fornecem mais maquinário e aponta equipamentos antigos que perderão a garantia.
SELECT 
    fabricante, 
    COUNT(*) AS total_itens, 
    MIN(data_aquisicao) AS item_mais_antigo,
    MAX(data_aquisicao) AS item_mais_recente
FROM dispositivo
GROUP BY manufacturer; 
ALTER TABLE dispositivo CHANGE COLUMN manufacturer fabricante VARCHAR(100) NOT NULL; 


SELECT 
    fabricante, 
    COUNT(*) AS total_itens, 
    MIN(data_aquisicao) AS item_mais_antigo,
    MAX(data_aquisicao) AS item_mais_recente
FROM dispositivo
GROUP BY fabricante
ORDER BY total_itens DESC;


-- Consulta 8: Mapeamento de Frequência de Ocorrências por Tipo de Dispositivo
-- Importância: Confiabilidade de Hardware (MTBF). Indica qual categoria de hardware (sensores, placas de IA ou braços mecânicos) gera mais alertas no sistema.
SELECT 
    d.tipo_dispositivo, 
    COUNT(ev.id) AS quantidade_alertas_gerados
FROM evento ev
JOIN dispositivo d ON ev.id_dispositivo = d.id
GROUP BY d.tipo_dispositivo
ORDER BY quantidade_alertas_gerados DESC;


-- Consulta 9: Identificação de Pesquisadores Altamente Multitarefas (Mais de 1 Projeto)
-- Importância: Equilíbrio de carga horária científica. Monitora gargalos pessoais de docentes e engenheiros para evitar sobrecarga de trabalho.
SELECT 
    p.nome, 
    p.area_atuacao, 
    COUNT(pe.id_experimento) AS total_projetos_ativos
FROM pesquisador_experimento pe
JOIN pesquisador p ON pe.matricula_pesquisador = p.matricula
GROUP BY p.matricula, p.nome, p.area_atuacao
HAVING total_projetos_ativos > 1;


-- Consulta 10: Relação Geral de Dispositivos Nunca Utilizados em Execuções Cadastradas
-- Importância: Redução de desperdício financeiro. Localiza maquinários caros ociosos (Exemplo: O robô Spot inserido no ID 211 aparecerá aqui).
SELECT 
    d.id, 
    d.fabricante, 
    d.modelo, 
    d.tipo_dispositivo
FROM dispositivo d
LEFT JOIN execucao ex ON d.id = ex.id_dispositivo
WHERE ex.id IS NULL;