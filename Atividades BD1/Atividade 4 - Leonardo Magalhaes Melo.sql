-- NOME: Leonardo Magalhaes Melo
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
    salario DECIMAL(10,2) NOT NULL, 
    data_admissao DATE NOT NULL, 
    especialidade VARCHAR(100) NOT NULL, 
    id_unidade INT NOT NULL,
    
    FOREIGN KEY (id_unidade) REFERENCES unidade(id)
);

ALTER TABLE unidade ADD CONSTRAINT fk_unidade_gerente FOREIGN KEY (matricula_funcionario) REFERENCES funcionario(matricula); 

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


ALTER TABLE aluno 
ADD COLUMN situacao_cadastro VARCHAR(20) DEFAULT 'Ativo';

ALTER TABLE plano
    CHANGE COLUMN valor_mensal mensalidade_preco DECIMAL(12,2) NOT NULL,
    CHANGE COLUMN duracao_contratual fidelidade_meses INT NOT NULL,
    CHANGE COLUMN nome titulo_plano VARCHAR(120) NOT NULL;

-- ==========================================================
-- INSERÇÃO DOS DADOS (DML)
-- ==========================================================

INSERT INTO unidade (id, nome, rua, numero, bairro, matricula_funcionario, data_gerencia) VALUES
(1, 'Academia Fit Centro', 'Av. Central', '100', 'Centro', NULL, NULL),
(2, 'Academia Fit Jardins', 'Rua das Flores', '450', 'Jardins', NULL, NULL),
(3, 'Academia Fit Norte', 'Av. Perimetral', '900', 'São José', NULL, NULL),
(4, 'Academia Fit Sul', 'Rua do Comércio', '12', 'Vila Nova', NULL, NULL),
(5, 'Academia Fit Oeste', 'Av. Oeste', '333', 'Pampulha', NULL, NULL),
(6, 'Academia Fit Leste', 'Rua da Bahia', '77', 'Funcionários', NULL, NULL),
(7, 'Academia Fit Praia', 'Av. Beira Mar', '1010', 'Boa Viagem', NULL, NULL),
(8, 'Academia Fit Express', 'Rua Getúlio Vargas', '55', 'Industrial', NULL, NULL),
(9, 'Academia Fit Premium', 'Alameda das Américas', '800', 'Alphaville', NULL, NULL),
(10, 'Academia Fit Club', 'Av. JK', '2020', 'Canaã', NULL, NULL);

INSERT INTO funcionario (matricula, nome, rua, numero, bairro, telefone, salario, data_admissao, especialidade, id_unidade) VALUES
(101, 'Marcos Paulo Silva', 'Rua A', '10', 'Centro', '38-9999-1111', 4500.00, '2020-01-10', 'Musculação', 1),
(102, 'Ana Clara Rocha', 'Rua B', '20', 'Jardins', '38-9999-2222', 3800.00, '2021-03-15', 'Pilates', 2),
(103, 'Ricardo Melo Antunes', 'Rua C', '30', 'São José', '38-9999-3333', 4200.00, '2019-06-20', 'Crossfit', 3),
(104, 'Juliana Costa Souza', 'Rua D', '40', 'Vila Nova', '38-9999-4444', 3200.00, '2022-01-10', 'Dança', 4),
(105, 'Thiago Alencar Lima', 'Rua E', '55', 'Pampulha', '38-9999-5555', 5500.00, '2018-05-01', 'Fisiologia do Exercício', 5),
(106, 'Fernanda Dias Rezende', 'Rua F', '60', 'Funcionários', '38-9999-6666', 3100.00, '2023-02-18', 'Spinning', 6),
(107, 'Lucas Barbosa Fontes', 'Rua G', '70', 'Boa Viagem', '38-9999-7777', 4000.00, '2021-08-01', 'Natação', 7),
(108, 'Camila Mendes Rezende', 'Rua H', '80', 'Industrial', '38-9999-8888', 2900.00, '2023-09-01', 'Musculação', 8),
(109, 'Rodrigo Garcia Malta', 'Rua I', '90', 'Alphaville', '38-9999-9999', 6000.00, '2017-02-12', 'Treinamento Funcional', 9),
(110, 'Amanda Alves Pedrosa', 'Rua J', '100', 'Canaã', '38-9999-0000', 3500.00, '2022-11-15', 'Yoga', 10);

-- Vinculando os gerentes nas unidades 
UPDATE unidade SET matricula_funcionario = 101, data_gerencia = '2020-01-10' WHERE id = 1;
UPDATE unidade SET matricula_funcionario = 102, data_gerencia = '2021-03-15' WHERE id = 2;
UPDATE unidade SET matricula_funcionario = 103, data_gerencia = '2019-06-20' WHERE id = 3;
UPDATE unidade SET matricula_funcionario = 105, data_gerencia = '2018-05-01' WHERE id = 5;
UPDATE unidade SET matricula_funcionario = 109, data_gerencia = '2017-02-12' WHERE id = 9;

INSERT INTO aluno (matricula, nome, data_nascimento, rua, numero, bairro, telefone, data_ingresso, situacao_cadastro) VALUES
(201, 'Carlos Eduardo Santos', '1995-05-20', 'Av. Principal', '12', 'Centro', '38-9888-1111', '2025-01-05', 'Ativo'),
(202, 'Beatriz Cavalcanti', '1998-09-12', 'Rua Torta', '45', 'Jardins', '38-9888-2222', '2025-02-10', 'Ativo'),
(203, 'Daniel Gomes Ferreira', '1990-03-30', 'Av. Minas', '789', 'São José', '38-9888-3333', '2024-06-15', 'Ativo'),
(204, 'Elena Pinheiro', '2002-07-22', 'Rua Direita', '101', 'Vila Nova', '38-9888-4444', '2025-05-01', 'Ativo'),
(205, 'Gabriel Barbosa Almeida', '1993-11-04', 'Rua Nova', '88', 'Pampulha', '38-9888-5555', '2023-01-10', 'Inativo'),
(206, 'Larissa Ramos Antunes', '1997-01-15', 'Av. Sul', '32', 'Funcionários', '38-9888-6666', '2025-03-22', 'Ativo'),
(207, 'Marcos Vinícius Cunha', '2000-08-09', 'Rua da Paz', '404', 'Boa Viagem', '38-9888-7777', '2025-04-12', 'Ativo'),
(208, 'Natália Ribeiro', '1988-12-25', 'Av. Norte', '77', 'Industrial', '38-9888-8888', '2024-10-01', 'Ativo'),
(209, 'Pedro Augusto Malta', '1992-06-18', 'Rua Principal', '9', 'Alphaville', '38-9888-9999', '2025-01-15', 'Ativo'),
(210, 'Sofia Albuquerque', '2004-02-28', 'Av. JK', '100', 'Canaã', '38-9888-0000', '2025-06-01', 'Ativo');

INSERT INTO plano (id, titulo_plano, mensalidade_preco, fidelidade_meses, beneficios) VALUES
(1, 'Mensal Bronze', 99.90, 1, 'Acesso livre à área de musculação da unidade contratada.'),
(2, 'Trimestral Prata', 89.90, 3, 'Acesso livre à musculação + 1 modalidade à escolha.'),
(3, 'Semestral Ouro', 79.90, 6, 'Acesso livre a todas as unidades, musculação e todas as modalidades.'),
(4, 'Anual Black Ouro', 69.90, 12, 'Acesso total, avaliação física mensal gratuita e direito a 1 acompanhante aos fins de semana.'),
(5, 'Plano Corporativo', 59.90, 12, 'Desconto em folha para empresas parceiras na categoria musculação.'),
(6, 'Plano Universitário', 65.00, 6, 'Desconto estudantil para horários de menor fluxo (12h às 16h).'),
(7, 'Plano Master 60+', 55.00, 1, 'Acompanhamento focado em terceira idade e hidroginástica inclusa.'),
(8, 'Plano CrossFit Exclusive', 149.90, 3, 'Acesso ilimitado ao Box de Crossfit oficial da rede.'),
(9, 'Plano VIP Personal', 499.90, 1, 'Acesso total + 3 sessões semanais de personal trainer exclusivo.'),
(10, 'Plano Digital Home', 29.90, 12, 'Acesso a treinos online por aplicativo, sem direito a uso presencial.');

INSERT INTO ficha (id, data_incricao, matricula_aluno, matricula_funcionario) VALUES
(1, '2025-01-06', 201, 101),
(2, '2025-02-11', 202, 101),
(3, '2024-06-16', 203, 103),
(4, '2025-05-02', 204, 108),
(5, '2023-01-11', 205, 108),
(6, '2025-03-23', 206, 101),
(7, '2025-04-13', 207, 101),
(8, '2024-10-02', 208, 103),
(9, '2025-01-16', 209, 101),
(10, '2025-06-02', 210, 108);

INSERT INTO exercicio (nome) VALUES
('Supino Reto com Barra'),
('Agachamento Livre'),
('Puxada Alta na Polia'),
('Rosca Direta BÍceps'),
('TrÍceps Corda'),
('Leg Press 45 Graus'),
('Elevação Lateral Ombro'),
('Cadeira Extensora'),
('Mesa Flexora'),
('Abdominal Supra');

INSERT INTO modalidade (nome) VALUES
('Musculação Tradicional'),
('Pilates Avançado'),
('CrossFit Integrado'),
('Zumba Ritmos'),
('Spinning Indoor'),
('Natação Livre'),
('Hatha Yoga'),
('Hidroginástica Sênior'),
('FitDance'),
('Muay Thai');

INSERT INTO aula (codigo, horario, limite_participante, numero_modalidade) VALUES
(501, '07:00:00', 30, 1),
(502, '08:30:00', 15, 2),
(503, '19:00:00', 25, 3),
(504, '18:00:00', 40, 4),
(505, '06:15:00', 20, 5),
(506, '12:00:00', 12, 6),
(507, '20:15:00', 25, 7),
(508, '09:00:00', 30, 8),
(509, '17:00:00', 35, 9),
(510, '21:00:00', 20, 10);

INSERT INTO avaliacao_fisica (peso, altura, percentual_gordura, massa_muscular, observacoes, matricula_aluno, matricula_funcionario) VALUES
(78.50, 1.75, 16.50, 38, 'Apresenta boa evolução de massa magra.', 201, 101),
(62.10, 1.63, 24.20, 24, 'Foco em redução de gordura e fortalecimento core.', 202, 101),
(95.00, 1.82, 28.00, 41, 'Hipertensão leve controlada. Evitar apneia.', 203, 103),
(55.40, 1.58, 19.10, 22, 'Objetivo de hipertrofia de membros inferiores.', 204, 108),
(88.30, 1.78, 22.40, 39, 'Aluno estagnado devido à baixa frequência.', 205, 108),
(70.20, 1.70, 14.00, 34, 'Excelente condicionamento cardiorrespiratório.', 206, 101),
(82.00, 1.80, 18.50, 37, 'Iniciando treinos de força integrada.', 207, 101),
(68.90, 1.65, 31.00, 25, 'Recomenda-se ajuste nutricional aliado ao treino.', 208, 103),
(102.50, 1.85, 26.10, 45, 'Atleta em transição de ganho de volume bruto.', 209, 101),
(51.00, 1.60, 21.00, 20, 'Foco em postura, flexibilidade e respiração.', 210, 108);

INSERT INTO ficha_exercicio (id_ficha, codigo_exercicio, series, repeticoes, carga, tempo_descanso) VALUES
(1, 1, 4, 10, 60, '00:01:00'),
(1, 4, 3, 12, 15, '00:00:45'),
(2, 2, 4, 12, 40, '00:01:15'),
(3, 2, 5, 5, 100, '00:02:00'),
(4, 8, 3, 15, 30, '00:00:45'),
(5, 3, 4, 10, 50, '00:01:00'),
(6, 6, 4, 10, 120, '00:01:00'),
(7, 1, 3, 12, 50, '00:01:00'),
(8, 9, 3, 12, 25, '00:00:45'),
(9, 10, 4, 25, 0, '00:00:30');

INSERT INTO instrutor_modalidade (matricula_funcionario, numero_modalidade) VALUES
(101, 1),
(102, 2),
(103, 3),
(104, 4),
(105, 1),
(106, 5),
(107, 6),
(108, 1),
(109, 1),
(110, 7);

INSERT INTO frequencia_aula (matricula_aluno, codigo_aula, data_aula, frequencia) VALUES
(201, 501, '2026-06-20', 1),
(202, 502, '2026-06-20', 1),
(203, 503, '2026-06-21', 1),
(204, 504, '2026-06-21', 0),
(205, 501, '2026-06-22', 0),
(206, 505, '2026-06-22', 1),
(207, 501, '2026-06-23', 1),
(208, 503, '2026-06-23', 1),
(209, 501, '2026-06-24', 1),
(210, 507, '2026-06-24', 1);

INSERT INTO historico_plano (data_inicio, data_fim, matricula_aluno, id_plano) VALUES
('2025-01-05', NULL, 201, 3),
('2025-02-10', NULL, 202, 1),
('2024-06-15', '2024-12-15', 203, 2),
('2024-12-16', NULL, 203, 4),
('2025-05-01', NULL, 204, 6),
('2023-01-10', '2024-01-10', 205, 4),
('2025-03-22', NULL, 206, 3),
('2025-04-12', NULL, 207, 4),
('2024-10-01', NULL, 208, 2),
('2025-01-15', NULL, 209, 9);


-- Consulta 1: Faturamento Mensal Recorrente Estimado por Tipo de Plano Ativo
-- Importância: Finanças e Negócios. Permite prever o fluxo de caixa mensal fixo baseado na quantidade de alunos vinculados a cada plano.
SELECT 
    p.titulo_plano, 
    COUNT(hp.id_historico) AS planos_ativos,
    SUM(p.mensalidade_preco) AS faturamento_estimado_recorrente
FROM historico_plano hp
JOIN plano p ON hp.id_plano = p.id
WHERE hp.data_fim IS NULL
GROUP BY p.id, p.titulo_plano
ORDER BY faturamento_estimado_recorrente DESC;


-- Consulta 2: Relatório de Ocupação Média de Alunos por Modalidade de Aula
-- Importância: Gestão de Infraestrutura. Revela quais modalidades estão lotadas ou ociosas para remanejamento de horários e salas.
SELECT 
    m.nome AS modalidade, 
    COUNT(fa.matricula_aluno) AS total_presencas_registradas,
    ROUND(AVG(au.limite_participante), 0) AS capacidade_media_salas
FROM frequencia_aula fa
JOIN aula au ON fa.codigo_aula = au.codigo
JOIN modalidade m ON au.numero_modalidade = m.numero
WHERE fa.frequencia = 1
GROUP BY m.numero, m.nome;


-- Consulta 3: Ranking de Custos de Folha de Pagamento por Unidade Operacional
-- Importância: Auditoria Financeira. Apresenta o custo bruto mensal de salários que cada unidade da academia custa para o grupo corporativo.
SELECT 
    u.id AS codigo_unidade, 
    u.nome AS unidade, 
    COUNT(f.matricula) AS total_colaboradores,
    SUM(f.salario) AS despesa_salarial_total -- Ajustado para 'salario' sem acento
FROM funcionario f
JOIN unidade u ON f.id_unidade = u.id
GROUP BY u.id, u.nome
ORDER BY despesa_salarial_total DESC;


-- Consulta 4: Alunos em Situação de Risco à Saúde (Percentual de Gordura Elevado > 25%)
-- Importância: Retenção e Suporte Técnico. Permite que coordenadores filtrem alunos que necessitam de intervenção pedagógica/física urgente dos instrutores.
SELECT 
    a.nome AS aluno, 
    a.telefone, 
    af.percentual_gordura, 
    af.observacoes
FROM avaliacao_fisica af
JOIN aluno a ON af.matricula_aluno = a.matricula
WHERE af.percentual_gordura > 25.00;


-- Consulta 5: Produtividade de Professores (Fichas Ativas Montadas por Instrutor)
-- Importância: Avaliação de desempenho de RH. Mede o volume de trabalho técnico entregue por cada professor de musculação da rede.
SELECT 
    f.nome AS professor, 
    f.especialidade, 
    COUNT(fi.id) AS fichas_de_treino_criadas
FROM ficha fi
JOIN funcionario f ON fi.matricula_funcionario = f.matricula
GROUP BY f.matricula, f.nome, f.especialidade
ORDER BY fichas_de_treino_criadas DESC;


-- Consulta 6: Exercícios Mais Utilizados nas Fichas Atuais dos Clientes
-- Importância: Logística de Equipamentos. Identifica quais exercícios são campeões de prescrição para guiar a compra ou manutenção preventiva de máquinas/anilhas.
SELECT 
    e.nome AS nome_exercicio, 
    COUNT(fe.id_ficha) AS quantidade_vezes_prescrito
FROM ficha_exercicio fe
JOIN exercicio e ON fe.codigo_exercicio = e.codigo
GROUP BY e.codigo, e.nome
ORDER BY quantidade_vezes_prescrito DESC;


-- Consulta 7: Relação de Gerentes de Unidade Atuais e seu Tempo de Liderança
-- Importância: Organograma Institucional. Facilita o controle administrativo sobre quem responde legalmente por cada filial e desde quando.
SELECT 
    u.nome AS unidade, 
    f.nome AS nome_gerente, 
    u.data_gerencia,
    TIMESTAMPDIFF(YEAR, u.data_gerencia, '2026-06-25') AS anos_na_gerencia
FROM unidade u
JOIN funcionario f ON u.matricula_funcionario = f.matricula;


-- Consulta 8: Taxa de Inadimplência ou Evasão (Alunos Inativos com Contratos Expirados)
-- Importância: Marketing e CRM. Fornece uma listagem limpa de clientes perdidos para campanhas de remarketing de e-mail e ofertas de retorno.
SELECT 
    matricula, 
    nome, 
    telefone, 
    data_ingresso 
FROM aluno 
WHERE situacao_cadastro = 'Inativo';


-- Consulta 9: Distribuição Etária dos Alunos Matriculados para Segmentação de Campanhas
-- Importância: Inteligência de Marketing. Descobre a faixa etária predominante dos clientes para ajustar as músicas das unidades, redes sociais e identidade visual.
SELECT 
    CASE 
        WHEN TIMESTAMPDIFF(YEAR, data_nascimento, '2026-06-25') < 20 THEN 'Sub-20'
        WHEN TIMESTAMPDIFF(YEAR, data_nascimento, '2026-06-25') BETWEEN 20 AND 35 THEN '20 a 35 anos'
        WHEN TIMESTAMPDIFF(YEAR, data_nascimento, '2026-06-25') BETWEEN 36 AND 50 THEN '36 a 50 anos'
        ELSE 'Acima de 50 anos'
    END AS faixa_etaria,
    COUNT(*) AS total_alunos
FROM aluno
GROUP BY faixa_etaria;


-- Consulta 10: Relação de Alunos que Apresentaram Faltas nas Aulas Agendadas
-- Importância: Qualidade do Serviço e Logística. Identifica gargalos onde pessoas agendam vagas e não comparecem, ocupando a vez de terceiros na esteira ou estúdio.
SELECT 
    a.nome AS nome_aluno, 
    m.nome AS modalidade_aula, 
    fa.data_aula
FROM frequencia_aula fa
JOIN aluno a ON fa.matricula_aluno = a.matricula
JOIN aula au ON fa.codigo_aula = au.codigo
JOIN modalidade m ON au.numero_modalidade = m.numero
WHERE fa.frequencia = 0;