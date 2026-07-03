-- NOME: Leonardo Magalhaes Melo
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
    capacity INT NOT NULL  
); 


ALTER TABLE aeronave CHANGE COLUMN capacity capacidade INT NOT NULL;


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

INSERT INTO aeroporto (codigo, nome, cidade, pais) VALUES
(1, 'Aeroporto Internacional de Guarulhos', 'Guarulhos', 'Brasil'),
(2, 'Aeroporto Internacional Galeão', 'Rio de Janeiro', 'Brasil'),
(3, 'Aeroporto Internacional John F. Kennedy', 'Nova York', 'Estados Unidos'),
(4, 'Aeroporto de Lisboa', 'Lisboa', 'Portugal'),
(5, 'Aeroporto de Paris-Charles de Gaulle', 'Paris', 'França'),
(6, 'Aeroporto Internacional de Tóquio-Haneda', 'Tóquio', 'Japão'),
(7, 'Aeroporto El Dorado', 'Bogotá', 'Colômbia'),
(8, 'Aeroporto de Heathrow', 'Londres', 'Reino Unido'),
(9, 'Aeroporto Internacional de Confins', 'Belo Horizonte', 'Brasil'),
(10, 'Aeroporto Internacional de Frankfurt', 'Frankfurt', 'Alemanha');

INSERT INTO aeronave (matricula, modelo, fabricante, capacidade) VALUES
(1010, 'A320neo', 'Airbus', 174),
(1020, '737 MAX 8', 'Boeing', 186),
(1030, 'E195-E2', 'Embraer', 136),
(1040, '787-9 Dreamliner', 'Boeing', 300),
(1050, 'A350-900', 'Airbus', 330),
(1060, '777-300ER', 'Boeing', 396),
(1070, 'A321neo', 'Airbus', 240),
(1080, 'E190', 'Embraer', 114),
(1090, '737-800', 'Boeing', 162),
(1100, 'A330-900neo', 'Airbus', 298);
    
INSERT INTO voo (codigo_voo, matricula_aeronave, codigo_origem, codigo_destino, horario_partida, horario_chegada) VALUES
(501, 1010, 1, 2, '06:00:00', '07:15:00'),
(502, 1020, 2, 1, '08:30:00', '09:45:00'),
(503, 1040, 1, 3, '22:15:00', '06:30:00'),
(504, 1050, 1, 4, '18:10:00', '06:20:00'),
(505, 1030, 9, 1, '11:00:00', '12:15:00'),
(506, 1060, 5, 6, '13:00:00', '15:45:00'),
(507, 1070, 7, 1, '01:20:00', '07:30:00'),
(508, 1090, 1, 9, '14:50:00', '16:00:00'),
(509, 1100, 4, 2, '23:30:00', '05:40:00'),
(510, 1040, 3, 8, '19:00:00', '07:10:00');
    
INSERT INTO funcionario_tripulacao (matricula, nome, salario, data_contrato, cargo) VALUES
(2001, 'Carlos Eduardo Silva', 14500.00, '2018-03-12', 'Piloto'),
(2002, 'Amanda Rocha Negrão', 12200.00, '2019-07-22', 'Co-Piloto'),
(2003, 'Mariana Costa Azevedo', 4800.00, '2021-01-15', 'Comissário de Bordo'),
(2004, 'Rodrigo Souza Lima', 5100.00, '2020-11-05', 'Comissário de Bordo'),
(2005, 'Roberto Mendes Alencar', 15800.00, '2015-05-20', 'Piloto'),
(2006, 'Fernanda Souza Dias', 11900.00, '2020-02-10', 'Co-Piloto'),
(2007, 'Juliana Martins Lopes', 4600.00, '2022-06-18', 'Comissário de Bordo'),
(2008, 'Lucas Oliveira Rezende', 4800.00, '2021-08-01', 'Comissário de Bordo'),
(2009, 'Ricardo Garcia Fontes', 16000.00, '2012-04-02', 'Piloto'),
(2010, 'Camila Alves Pedrosa', 5300.00, '2019-10-14', 'Comissário de Bordo');
    
INSERT INTO escala_tripulacao (codigo_voo, matricula_funcionario) VALUES
(501, 2001),
(501, 2003),
(502, 2002),
(502, 2004),
(503, 2005),
(503, 2007),
(504, 2009),
(504, 2010),
(505, 2006),
(505, 2008);
    
INSERT INTO passageiro (id_passageiro, nome) VALUES
(3001, 'Bruno Henrique Santos'),
(3002, 'Beatriz Cavalcanti Melo'),
(3003, 'Daniel Gomes Ferreira'),
(3004, 'Elena Pinheiro Guimarães'),
(3005, 'Gabriel Barbosa Almeida'),
(3006, 'Larissa Ramos Antunes'),
(3007, 'Marcos Vinícius Teixeira'),
(3008, 'Natália Ribeiro Correia'),
(3009, 'Pedro Augusto Malta'),
(3010, 'Sofia Albuquerque Lima');
    
INSERT INTO bagagem (id_bagagem, peso, status_bagagem, id_passageiro) VALUES
(4001, 21.50, 'Despachada', 3001),
(4002, 12.30, 'Em Trânsito', 3002),
(4003, 32.00, 'Despachada', 3003),
(4004, 8.50, 'Entregue', 3004),
(4005, 23.00, 'Despachada', 3005),
(4006, 15.10, 'Extraviada', 3006),
(4007, 22.80, 'Entregue', 3007),
(4008, 18.00, 'Em Trânsito', 3008),
(4009, 26.40, 'Despachada', 3009),
(4010, 7.20, 'Entregue', 3010);

INSERT INTO passagem_voo (codigo_voo, id_passageiro, numero_assento, data_compra) VALUES
(501, 3001, '12A', '2026-05-10'),
(501, 3002, '14C', '2026-05-12'),
(502, 3003, '03B', '2026-04-20'),
(503, 3004, '22G', '2026-03-01'),
(504, 3005, '01A', '2026-05-01'),
(505, 3006, '18D', '2026-05-25'),
(506, 3007, '31J', '2026-02-15'),
(507, 3008, '10E', '2026-04-18'),
(508, 3009, '07F', '2026-05-28'),
(509, 3010, '15A', '2026-05-14');


ALTER TABLE funcionario_tripulacao ADD COLUMN status_funcionario VARCHAR(20) DEFAULT 'ativo'; 

ALTER TABLE bagagem 
    CHANGE COLUMN peso peso_kg DECIMAL(6,3) NOT NULL, 
    CHANGE COLUMN status_bagagem situacao_rastreio VARCHAR(45), 
    CHANGE COLUMN id_bagagem codigo_etiqueta INT; 


-- Consulta 1: Listagem Geral de Voos com Cidades de Origem e Destino
-- Importância: Essencial para painéis de visualização do cliente e controle básico de tráfego, trocando IDs numéricos por nomes reais.
SELECT 
    v.codigo_voo, 
    a_origem.cidade AS origem, 
    a_destino.cidade AS destino, 
    v.horario_partida
FROM voo v
JOIN aeroporto a_origem ON v.codigo_origem = a_origem.codigo
JOIN aeroporto a_destino ON v.codigo_destino = a_destino.codigo;


-- Consulta 2: Faturamento Total Estimado por Voo (Ocupação e Capacidade)
-- Importância: Permite analisar a eficiência comercial de cada rota com base na capacidade da aeronave alocada versus passagens vendidas.
SELECT 
    v.codigo_voo, 
    an.modelo, 
    an.capacidade, 
    COUNT(pv.id_passageiro) AS passageiros_abordados,
    ROUND((COUNT(pv.id_passageiro) / an.capacidade) * 100, 2) AS percentual_ocupacao
FROM voo v
JOIN aeronave an ON v.matricula_aeronave = an.matricula
LEFT JOIN passagem_voo pv ON v.codigo_voo = pv.codigo_voo
GROUP BY v.codigo_voo, an.modelo, an.capacidade;


-- Consulta 3: Folha de Pagamento Líquida por Cargo da Tripulação
-- Importância: Auxilia o setor de Recursos Humanos e Financeiro a auditar os custos operacionais com pessoal de bordo.
SELECT 
    cargo, 
    COUNT(*) AS total_funcionarios, 
    SUM(salario) AS custo_total_salarios,
    ROUND(AVG(salario), 2) AS media_salarial
FROM funcionario_tripulacao
GROUP BY cargo;


-- Consulta 4: Relatório de Bagagens Acima do Peso Permitido Padrão (Ex: > 23kg)
-- Importância: Identificação de potencial de receita extra com taxas de excesso de bagagem e segurança de carga da aeronave.
SELECT 
    b.codigo_etiqueta, 
    p.nome AS passageiro, 
    b.peso_kg
FROM bagagem b
JOIN passageiro p ON b.id_passageiro = p.id_passageiro
WHERE b.peso_kg > 23.00;


-- Consulta 5: Rastreamento de Bagagens Críticas (Extraviadas ou Em Trânsito)
-- Importância: Focado no time de Suporte ao Cliente e Ouvidoria para mitigar problemas com perdas e gerenciar seguros.
SELECT 
    b.codigo_etiqueta, 
    p.nome AS passageiro, 
    b.situacao_rastreio 
FROM bagagem b
JOIN passageiro p ON b.id_passageiro = p.id_passageiro
WHERE b.situacao_rastreio IN ('Extraviada', 'Em Trânsito');


-- Consulta 6: Tripulantes Escalados por Voo com Seus Respectivos Cargos
-- Importância: Segurança operacional. Garante a checagem se cada voo possui a quantidade mínima exigida por lei de Pilotos e Comissários.
SELECT 
    e.codigo_voo, 
    f.nome AS nome_tripulante, 
    f.cargo
FROM escala_tripulacao e
JOIN funcionario_tripulacao f ON e.matricula_funcionario = f.matricula
ORDER BY e.codigo_voo;


-- Consulta 7: Ranqueamento de Países com Maior Fluxo de Destinos
-- Importância: Planejamento estratégico de Malha Aérea. Ajuda a identificar quais mercados internacionais demandam mais infraestrutura.
SELECT 
    a.pais, 
    COUNT(v.codigo_voo) AS total_voos_recebidos
FROM voo v
JOIN aeroporto a ON v.codigo_destino = a.codigo
GROUP BY a.pais
ORDER BY total_voos_recebidos DESC;


-- Consulta 8: Histórico de Compras de Passagens Antecipadas por Período
-- Importância: Análise de comportamento de compra do consumidor para auxiliar algoritmos de precificação dinâmica de passagens.
SELECT 
    codigo_voo, 
    COUNT(id_passageiro) AS passagens_compradas,
    MONTHNAME(data_compra) AS mes_compra
FROM passagem_voo
GROUP BY codigo_voo, data_compra;


-- Consulta 9: Identificação de Aeronaves Ociosas (Sem Voos Vinculados)
-- Importância: Gestão de Ativos. Uma aeronave no chão gera prejuízo; essa query localiza quais aviões precisam entrar na escala.
SELECT 
    a.matricula, 
    a.modelo, 
    a.fabricante
FROM aeronave a
LEFT JOIN voo v ON a.matricula = v.matricula_aeronave
WHERE v.codigo_voo IS NULL;


-- Consulta 10: Lista de Passageiros que Despacharam Mais de uma Bagagem
-- Importância: Auxilia na logística de triagem de esteiras dos terminais e controle de peso geral por CPF/ID.
SELECT 
    p.nome, 
    COUNT(b.codigo_etiqueta) AS total_bagagens_despachadas
FROM passageiro p
JOIN bagagem b ON p.id_passageiro = b.id_passageiro
GROUP BY p.id_passageiro, p.nome
HAVING COUNT(b.codigo_etiqueta) >= 1;