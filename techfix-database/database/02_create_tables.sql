-- ============================================================
-- TECHFIX - CRIAÇÃO DAS TABELAS
-- Arquivo: 02_create_tables.sql
-- Banco: MySQL 8+
-- ============================================================

USE techfix;

-- ============================================================
-- 1. CLIENTES
-- Armazena os dados das pessoas que utilizam os serviços.
-- ============================================================
CREATE TABLE clientes (
    id_cliente INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    email VARCHAR(100) UNIQUE,
    telefone VARCHAR(20),
    cidade VARCHAR(80),
    data_cadastro DATETIME DEFAULT CURRENT_TIMESTAMP
);

-- ============================================================
-- 2. TÉCNICOS
-- Profissionais responsáveis pelo atendimento/manutenção.
-- ============================================================
CREATE TABLE tecnicos (
    id_tecnico INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    especialidade VARCHAR(100),
    email VARCHAR(100) UNIQUE,
    telefone VARCHAR(20),
    ativo BOOLEAN DEFAULT TRUE
);

-- ============================================================
-- 3. EQUIPAMENTOS
-- Cada equipamento pertence a um cliente.
-- Relacionamento: CLIENTES 1:N EQUIPAMENTOS.
-- ============================================================
CREATE TABLE equipamentos (
    id_equipamento INT AUTO_INCREMENT PRIMARY KEY,
    id_cliente INT NOT NULL,
    tipo VARCHAR(50) NOT NULL,
    marca VARCHAR(50) NOT NULL,
    modelo VARCHAR(100) NOT NULL,
    numero_serie VARCHAR(100) UNIQUE,
    data_cadastro DATETIME DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT fk_equipamento_cliente
        FOREIGN KEY (id_cliente)
        REFERENCES clientes(id_cliente)
        ON UPDATE CASCADE
        ON DELETE RESTRICT
);

-- ============================================================
-- 4. SERVIÇOS
-- Catálogo de serviços oferecidos pela assistência.
-- ============================================================
CREATE TABLE servicos (
    id_servico INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    descricao VARCHAR(255),
    preco DECIMAL(10,2) NOT NULL,
    ativo BOOLEAN DEFAULT TRUE,

    CONSTRAINT chk_servico_preco
        CHECK (preco >= 0)
);

-- ============================================================
-- 5. PEÇAS
-- Produtos/peças utilizados nas ordens de serviço.
-- ============================================================
CREATE TABLE pecas (
    id_peca INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    codigo VARCHAR(50) UNIQUE NOT NULL,
    estoque INT NOT NULL DEFAULT 0,
    preco DECIMAL(10,2) NOT NULL,

    CONSTRAINT chk_peca_estoque
        CHECK (estoque >= 0),
    CONSTRAINT chk_peca_preco
        CHECK (preco >= 0)
);

-- ============================================================
-- 6. ORDENS DE SERVIÇO
-- Registra cada atendimento realizado para um equipamento.
-- Um técnico pode atender várias ordens.
-- ============================================================
CREATE TABLE ordens_servico (
    id_ordem INT AUTO_INCREMENT PRIMARY KEY,
    id_equipamento INT NOT NULL,
    id_tecnico INT,
    problema TEXT NOT NULL,
    diagnostico TEXT,
    status ENUM(
        'ABERTA',
        'EM_ANALISE',
        'AGUARDANDO_PECA',
        'EM_MANUTENCAO',
        'CONCLUIDA',
        'CANCELADA'
    ) DEFAULT 'ABERTA',
    data_abertura DATETIME DEFAULT CURRENT_TIMESTAMP,
    data_conclusao DATETIME,

    CONSTRAINT fk_ordem_equipamento
        FOREIGN KEY (id_equipamento)
        REFERENCES equipamentos(id_equipamento)
        ON UPDATE CASCADE
        ON DELETE RESTRICT,

    CONSTRAINT fk_ordem_tecnico
        FOREIGN KEY (id_tecnico)
        REFERENCES tecnicos(id_tecnico)
        ON UPDATE CASCADE
        ON DELETE SET NULL
);

-- ============================================================
-- 7. ORDEM_SERVICO_SERVICOS
-- Tabela associativa do relacionamento N:N entre ordens e serviços.
-- Uma ordem pode possuir vários serviços e um serviço pode aparecer
-- em várias ordens.
-- ============================================================
CREATE TABLE ordem_servico_servicos (
    id_ordem INT NOT NULL,
    id_servico INT NOT NULL,
    quantidade INT NOT NULL DEFAULT 1,
    valor_unitario DECIMAL(10,2) NOT NULL,

    PRIMARY KEY (id_ordem, id_servico),

    CONSTRAINT fk_oss_ordem
        FOREIGN KEY (id_ordem)
        REFERENCES ordens_servico(id_ordem)
        ON UPDATE CASCADE
        ON DELETE CASCADE,

    CONSTRAINT fk_oss_servico
        FOREIGN KEY (id_servico)
        REFERENCES servicos(id_servico)
        ON UPDATE CASCADE
        ON DELETE RESTRICT,

    CONSTRAINT chk_oss_quantidade
        CHECK (quantidade > 0),
    CONSTRAINT chk_oss_valor
        CHECK (valor_unitario >= 0)
);

-- ============================================================
-- 8. ORDEM_SERVICO_PECAS
-- Tabela associativa do relacionamento N:N entre ordens e peças.
-- ============================================================
CREATE TABLE ordem_servico_pecas (
    id_ordem INT NOT NULL,
    id_peca INT NOT NULL,
    quantidade INT NOT NULL DEFAULT 1,
    valor_unitario DECIMAL(10,2) NOT NULL,

    PRIMARY KEY (id_ordem, id_peca),

    CONSTRAINT fk_osp_ordem
        FOREIGN KEY (id_ordem)
        REFERENCES ordens_servico(id_ordem)
        ON UPDATE CASCADE
        ON DELETE CASCADE,

    CONSTRAINT fk_osp_peca
        FOREIGN KEY (id_peca)
        REFERENCES pecas(id_peca)
        ON UPDATE CASCADE
        ON DELETE RESTRICT,

    CONSTRAINT chk_osp_quantidade
        CHECK (quantidade > 0),
    CONSTRAINT chk_osp_valor
        CHECK (valor_unitario >= 0)
);

-- ============================================================
-- 9. PAGAMENTOS
-- Registra pagamentos relacionados às ordens de serviço.
-- Uma ordem pode ter nenhum, um ou vários pagamentos.
-- ============================================================
CREATE TABLE pagamentos (
    id_pagamento INT AUTO_INCREMENT PRIMARY KEY,
    id_ordem INT NOT NULL,
    valor DECIMAL(10,2) NOT NULL,
    forma_pagamento ENUM(
        'PIX',
        'DINHEIRO',
        'CARTAO_CREDITO',
        'CARTAO_DEBITO'
    ) NOT NULL,
    data_pagamento DATETIME DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT fk_pagamento_ordem
        FOREIGN KEY (id_ordem)
        REFERENCES ordens_servico(id_ordem)
        ON UPDATE CASCADE
        ON DELETE RESTRICT,

    CONSTRAINT chk_pagamento_valor
        CHECK (valor > 0)
);
