
CREATE TABLE acordar (
    id INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    acordar TIMESTAMP
);

CREATE TABLE tipoatividade (
    id INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    descricao VARCHAR(30)
);

CREATE TABLE atividade (
    id INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    descricao VARCHAR(100),
    obs VARCHAR(200),
    id_tipoatividade INTEGER NOT NULL,
    CONSTRAINT fk_atividade_tipo
        FOREIGN KEY (id_tipoatividade)
        REFERENCES tipoatividade(id)
);

CREATE TABLE movimentacaohora (
    id INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    data TIMESTAMP,
    obs VARCHAR(500),
    qtde_horas TIME,
    acordar TIME,
    id_atividade INTEGER NOT NULL,
    CONSTRAINT fk_mov_atividade
        FOREIGN KEY (id_atividade)
        REFERENCES atividade(id)
);

CREATE TABLE intervalotempo (
    id INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    tempoinicial TIMESTAMP,
    tempofinal TIMESTAMP,
    id_movimentacaohora INTEGER NOT NULL,
    CONSTRAINT fk_intervalo_mov
        FOREIGN KEY (id_movimentacaohora)
        REFERENCES movimentacaohora(id)
);

CREATE TABLE corpo (
    id_corpo INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    data TIMESTAMP,
    peso NUMERIC(8,3),
    cintura INTEGER,
    obs VARCHAR(250)
);

CREATE TABLE tarefas (
    id_tarefa INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    data TIMESTAMP,
    obs VARCHAR(250),
    data_finalizado TIMESTAMP,
    opcao CHAR(1)
);