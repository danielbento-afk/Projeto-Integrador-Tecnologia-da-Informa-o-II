-- ### OPERAÇÕES DE INSERÇÃO (INSERT) ###

-- 1. Cadastrar um novo estudante
INSERT INTO estudantes (nome, email, senha_hash, disponibilidade_dias)
VALUES ('Maria Oliveira', 'maria.oliveira@email.com', 'hash_da_senha_123', 'seg,ter,qui,sex');

-- 2. Cadastrar um curso para a Maria (id_estudante = 1)
INSERT INTO cursos (id_estudante, nome_curso, instituicao, data_inicio)
VALUES (1, 'Sistemas de Informação', 'Universidade Federal', '2025-08-01');

-- 3. Cadastrar disciplinas para o curso (id_curso = 1)
INSERT INTO disciplinas (id_curso, nome_disciplina, carga_horaria_total, semestre)
VALUES (1, 'Banco de Dados', 80, '3º Semestre');
INSERT INTO disciplinas (id_curso, nome_disciplina, carga_horaria_total, semestre)
VALUES (1, 'Programação Web', 60, '3º Semestre');

-- 4. Criar um cronograma para a disciplina 'Banco de Dados' (id_disciplina = 1)
INSERT INTO cronogramas (id_disciplina, horas_por_dia, data_inicio, data_fim)
VALUES (1, 2.5, '2025-10-20', '2025-12-10');

-- 5. Adicionar um evento de estudo no calendário para esse cronograma (id_cronograma = 1)
INSERT INTO calendario (id_cronograma, data, horas_estudo, status)
VALUES (1, '2025-10-21', 2.5, 'planejado');

-- 6. Adicionar uma notificação para este evento de calendário (id_calendario = 1)
INSERT INTO notificacoes (id_calendario, titulo, mensagem)
VALUES (1, 'Lembrete de Estudo', 'Sua sessão de Banco de Dados começa em 30 minutos.');


-- ### OPERAÇÕES DE CONSULTA (SELECT) ###

-- Consultar todas as disciplinas de um estudante específico (Maria, id = 1)
-- Isso exige navegar por todas as tabelas que conectamos
SELECT 
    e.nome AS estudante,
    c.nome_curso,
    d.nome_disciplina
FROM 
    estudantes e
JOIN 
    cursos c ON e.id_estudante = c.id_estudante
JOIN 
    disciplinas d ON c.id_curso = d.id_curso
WHERE 
    e.id_estudante = 1;

-- Consultar todos os eventos de calendário "planejados" para um cronograma (id = 1)
SELECT data, horas_estudo
FROM calendario
WHERE id_cronograma = 1 AND status = 'planejado';


-- ### OPERAÇÕES DE ATUALIZAÇÃO (UPDATE) ###

-- Marcar um evento de calendário como 'concluído' e atualizar o progresso do cronograma
UPDATE calendario
SET status = 'concluído'
WHERE id_calendario = 1;

UPDATE cronogramas
SET progresso = 10 -- (Ex: 10% concluído)
WHERE id_cronograma = 1;


-- ### OPERAÇÕES DE REMOÇÃO (DELETE) ###

-- Remover um curso (id = 1).
-- Devido ao "ON DELETE CASCADE", isso irá remover:
--   - O curso 1
--   - As disciplinas 1 e 2 (ligadas ao curso 1)
--   - O cronograma 1 (ligado à disciplina 1)
--   - O calendário 1 (ligado ao cronograma 1)
--   - A notificação 1 (ligada ao calendário 1)
DELETE FROM cursos WHERE id_curso = 1;