DROP TABLE IF EXISTS notificacoes;
DROP TABLE IF EXISTS calendario;
DROP TABLE IF EXISTS cronogramas;
DROP TABLE IF EXISTS disciplinas;
DROP TABLE IF EXISTS cursos;
DROP TABLE IF EXISTS estudantes;

-- Entidade: Estudante
CREATE TABLE estudantes (
    id_estudante SERIAL PRIMARY KEY,
    nome VARCHAR(255) NOT NULL,
    email VARCHAR(255) UNIQUE NOT NULL,
    senha_hash VARCHAR(255) NOT NULL, -- Armazenar a senha em hash
    disponibilidade_dias VARCHAR(100) -- Ex: "seg,ter,qua"
);

-- Entidade: Curso (Relaciona-se com Estudante)
CREATE TABLE cursos (
    id_curso SERIAL PRIMARY KEY,
    id_estudante INTEGER NOT NULL,
    nome_curso VARCHAR(255) NOT NULL,
    instituicao VARCHAR(255),
    data_inicio DATE,
    data_fim DATE,
    
    CONSTRAINT fk_estudante
        FOREIGN KEY(id_estudante) 
        REFERENCES estudantes(id_estudante)
        ON DELETE CASCADE -- Se um estudante for deletado, seus cursos também serão.
);

-- Entidade: Disciplina (Relaciona-se com Curso)
CREATE TABLE disciplinas (
    id_disciplina SERIAL PRIMARY KEY,
    id_curso INTEGER NOT NULL,
    nome_disciplina VARCHAR(255) NOT NULL,
    carga_horaria_total INTEGER,
    semestre VARCHAR(50),
    
    CONSTRAINT fk_curso
        FOREIGN KEY(id_curso)
        REFERENCES cursos(id_curso)
        ON DELETE CASCADE -- Se um curso for deletado, suas disciplinas também serão.
);

-- Entidade: Cronograma (Relaciona-se com Disciplina)
CREATE TABLE cronogramas (
    id_cronograma SERIAL PRIMARY KEY,
    id_disciplina INTEGER NOT NULL,
    horas_por_dia NUMERIC(4, 2), -- Ex: 2.5 horas
    progresso INTEGER DEFAULT 0 CHECK (progresso >= 0 AND progresso <= 100),
    data_inicio DATE,
    data_fim DATE,
    
    CONSTRAINT fk_disciplina
        FOREIGN KEY(id_disciplina)
        REFERENCES disciplinas(id_disciplina)
        ON DELETE CASCADE -- Se uma disciplina for deletada, seus cronogramas também serão.
);

-- Entidade: Calendario (Relaciona-se com Cronograma)
CREATE TABLE calendario (
    id_calendario SERIAL PRIMARY KEY,
    id_cronograma INTEGER NOT NULL,
    data DATE NOT NULL,
    horas_estudo NUMERIC(4, 2),
    status VARCHAR(50) DEFAULT 'planejado' CHECK (status IN ('planejado', 'concluído', 'atrasado')),
    
    CONSTRAINT fk_cronograma
        FOREIGN KEY(id_cronograma)
        REFERENCES cronogramas(id_cronograma)
        ON DELETE CASCADE -- Se um cronograma for deletado, seus registros de calendário também serão.
);

-- Entidade: Notificacao (Relaciona-se com Calendario)
CREATE TABLE notificacoes (
    id_notificacao SERIAL PRIMARY KEY,
    id_calendario INTEGER NOT NULL,
    titulo VARCHAR(255) NOT NULL,
    mensagem TEXT,
    data_envio TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP,
    status VARCHAR(50) DEFAULT 'pendente' CHECK (status IN ('pendente', 'enviado', 'lido')),
    
    CONSTRAINT fk_calendario
        FOREIGN KEY(id_calendario)
        REFERENCES calendario(id_calendario)
        ON DELETE CASCADE -- Se um evento de calendário for deletado, suas notificações também serão.
);