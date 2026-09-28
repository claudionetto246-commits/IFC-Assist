-- =========================================================
-- IFC ASSIST - SQL FINAL PARA INFINITYFREE
-- =========================================================
-- Importe este arquivo pelo phpMyAdmin no banco escolhido.
-- O arquivo NÃO usa "USE ifc_assist", pois o InfinityFree
-- pode fornecer um nome de banco diferente.
--
-- Administrador inicial:
-- Senha: password
-- =========================================================

CREATE TABLE administradores (
    id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    email VARCHAR(150) NOT NULL UNIQUE,
    senha VARCHAR(255) NOT NULL,
    criado_em TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE categorias (
    id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(100) NOT NULL UNIQUE
);

CREATE TABLE conteudos (
    id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    categoria_id INT UNSIGNED NOT NULL,
    titulo VARCHAR(180) NOT NULL,
    resposta TEXT NOT NULL,
    palavras_chave VARCHAR(255),
    ativo TINYINT(1) NOT NULL DEFAULT 1,
    criado_em TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    atualizado_em TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    CONSTRAINT fk_conteudo_categoria FOREIGN KEY (categoria_id) REFERENCES categorias(id)
);

INSERT INTO categorias (nome) VALUES
('Salas e Setores'),
('Transporte'),
('Eventos'),
('SIGAA');

-- O administrador não é criado neste SQL público.
-- Crie a conta no ambiente de implantação usando um hash bcrypt.

INSERT INTO conteudos (categoria_id, titulo, resposta, palavras_chave) VALUES
(1, 'Onde encontro informações sobre salas e setores?', 'Consulte a identificação das salas no campus ou procure a recepção/coordenação para confirmar o local correto.', 'sala, salas, setor, setores, localização, onde fica'),
(2, 'Onde encontro informações sobre transporte?', 'Os horários e pontos de transporte devem ser confirmados nos canais oficiais ou com a coordenação do campus.', 'ônibus, transporte, horário, ponto, saída'),
(3, 'Como saber quais eventos estão acontecendo?', 'Consulte os canais oficiais do IFC Campus Fraiburgo e os avisos divulgados pela instituição.', 'evento, eventos, palestra, atividade'),
(4, 'Como acessar o SIGAA?', 'Acesse o endereço oficial do SIGAA do IFC e entre com suas credenciais institucionais. Em caso de dificuldade, procure o setor responsável.', 'sigaa, acesso, login, senha, sistema acadêmico');


INSERT INTO categorias (nome) VALUES
('Biblioteca'),
('Secretaria'),
('Financeiro'),
('Matrícula'),
('Laboratórios')
ON DUPLICATE KEY UPDATE nome = VALUES(nome);


-- Conteúdos com perguntas, respostas e palavras-chave
INSERT INTO conteudos 
(categoria_id, titulo, resposta, palavras_chave) 
VALUES

(
(SELECT id FROM categorias WHERE nome = 'Biblioteca'),
'Qual o horário de funcionamento da biblioteca?',
'A biblioteca funciona de segunda a sexta, das 7h30 às 22h, e aos sábados das 8h às 12h.',
'horario, biblioteca, funcionamento, abre, fecha'
),

(
(SELECT id FROM categorias WHERE nome = 'Secretaria'),
'Como solicitar uma declaração de matrícula?',
'A declaração de matrícula pode ser solicitada pelo portal do aluno, na aba Documentos, ou presencialmente na secretaria.',
'declaracao, matricula, secretaria, documento, documentos'
),

(
(SELECT id FROM categorias WHERE nome = 'Financeiro'),
'Como emitir a segunda via do boleto da mensalidade?',
'A segunda via do boleto fica disponível no portal financeiro, na aba Boletos, em até 2 dias úteis após o vencimento.',
'boleto, mensalidade, financeiro, segunda, via, pagamento'
),

(
(SELECT id FROM categorias WHERE nome = 'Matrícula'),
'Quais os prazos para trancamento de matrícula?',
'O trancamento de matrícula pode ser solicitado até o último dia útil do mês anterior ao início do semestre letivo.',
'trancamento, matricula, prazo, cancelar, semestre'
),

(
(SELECT id FROM categorias WHERE nome = 'Laboratórios'),
'Como reservar um laboratório de informática?',
'A reserva de laboratórios é feita com o coordenador do curso, com no mínimo 48 horas de antecedência.',
'laboratorio, reservar, informatica, agendar, sala'
);


INSERT INTO conteudos 
(categoria_id, titulo, resposta, palavras_chave)
VALUES

-- =====================================================
-- SALAS E SETORES
-- =====================================================

(
(SELECT id FROM categorias WHERE nome='Salas e Setores'),
'Onde fica a sala de aula?',
'As salas de aula ficam identificadas nos blocos do campus. Consulte a placa da sala ou a coordenação do curso.',
'sala, salas, aula, bloco, localização, onde fica'
),

(
(SELECT id FROM categorias WHERE nome='Salas e Setores'),
'Onde fica a secretaria?',
'A secretaria fica no setor administrativo do campus. Procure a recepção para confirmar o local.',
'secretaria, setor, administrativo, localização, atendimento'
),

(
(SELECT id FROM categorias WHERE nome='Salas e Setores'),
'Onde encontro a coordenação do curso?',
'A coordenação do curso fica nos setores administrativos do campus. Consulte a recepção para encontrar o responsável.',
'coordenação, curso, coordenador, setor, sala'
),

(
(SELECT id FROM categorias WHERE nome='Salas e Setores'),
'Onde fica o laboratório de informática?',
'Os laboratórios ficam nos blocos indicados pelo campus. Consulte a identificação das salas.',
'laboratório, informática, sala, computador, bloco'
),

(
(SELECT id FROM categorias WHERE nome='Salas e Setores'),
'Como encontro um setor do campus?',
'Consulte as placas de identificação ou peça ajuda na recepção do campus.',
'setor, localização, campus, encontrar, informação'
),


-- =====================================================
-- TRANSPORTE
-- =====================================================

(
(SELECT id FROM categorias WHERE nome='Transporte'),
'Qual o horário do transporte?',
'Os horários do transporte devem ser consultados nos canais oficiais do campus.',
'transporte, ônibus, horário, saída, chegada'
),

(
(SELECT id FROM categorias WHERE nome='Transporte'),
'Onde fica o ponto de ônibus?',
'Os pontos de ônibus podem ser consultados com a instituição ou responsáveis pelo transporte.',
'ônibus, ponto, transporte, local'
),

(
(SELECT id FROM categorias WHERE nome='Transporte'),
'Quem pode utilizar o transporte?',
'O transporte é destinado aos estudantes conforme as regras da instituição.',
'aluno, estudante, transporte, ônibus'
),

(
(SELECT id FROM categorias WHERE nome='Transporte'),
'O transporte funciona todos os dias?',
'A disponibilidade do transporte depende do calendário e horários definidos pelo campus.',
'funciona, dias, transporte, calendário'
),

(
(SELECT id FROM categorias WHERE nome='Transporte'),
'Como saber mudanças no transporte?',
'As alterações são divulgadas pelos canais oficiais do campus.',
'mudança, aviso, transporte, comunicado'
),


-- =====================================================
-- EVENTOS
-- =====================================================

(
(SELECT id FROM categorias WHERE nome='Eventos'),
'Onde vejo os eventos do IFC?',
'Os eventos são divulgados nos canais oficiais do IFC e avisos do campus.',
'evento, eventos, divulgação, aviso'
),

(
(SELECT id FROM categorias WHERE nome='Eventos'),
'Como participar de um evento?',
'Verifique as informações do evento e faça a inscrição quando necessário.',
'participar, inscrição, evento'
),

(
(SELECT id FROM categorias WHERE nome='Eventos'),
'Como saber a data de um evento?',
'As datas dos eventos são informadas nos comunicados oficiais.',
'data, evento, calendário'
),

(
(SELECT id FROM categorias WHERE nome='Eventos'),
'Existem palestras no campus?',
'Sim. As palestras são divulgadas conforme a programação da instituição.',
'palestra, evento, atividade'
),

(
(SELECT id FROM categorias WHERE nome='Eventos'),
'Onde encontro o calendário de eventos?',
'O calendário pode ser consultado nos canais oficiais do campus.',
'calendário, eventos, datas'
),


-- =====================================================
-- SIGAA
-- =====================================================

(
(SELECT id FROM categorias WHERE nome='SIGAA'),
'Como acessar o SIGAA?',
'Acesse o SIGAA utilizando seu usuário e senha institucional.',
'sigaa, acesso, login, sistema'
),

(
(SELECT id FROM categorias WHERE nome='SIGAA'),
'Esqueci minha senha do SIGAA.',
'Utilize a opção de recuperação de senha ou procure o suporte responsável.',
'senha, recuperar, sigaa'
),

(
(SELECT id FROM categorias WHERE nome='SIGAA'),
'Como ver minhas notas no SIGAA?',
'Acesse o SIGAA e consulte a área acadêmica para visualizar suas notas.',
'nota, notas, sigaa, acadêmico'
),

(
(SELECT id FROM categorias WHERE nome='SIGAA'),
'Como consultar disciplinas no SIGAA?',
'No SIGAA é possível consultar suas disciplinas e informações acadêmicas.',
'disciplina, matéria, sigaa'
),

(
(SELECT id FROM categorias WHERE nome='SIGAA'),
'Como acessar documentos no SIGAA?',
'Os documentos podem ser encontrados na área acadêmica do SIGAA.',
'documento, declaração, sigaa'
);
