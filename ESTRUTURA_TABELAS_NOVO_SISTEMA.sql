-- ============================================
-- SISTEMA SIC - ESTRUTURA NOVO BANCO DE DADOS
-- Plataforma: SQL Server / MySQL / PostgreSQL
-- Data: 23 de Dezembro de 2025
-- ============================================

-- ============================================
-- 1. TABELAS DE CONFIGURAÇÃO E SISTEMA
-- ============================================

CREATE TABLE tbl_usuario (
    id_usuario INT PRIMARY KEY IDENTITY(1,1),
    nome_usuario VARCHAR(100) NOT NULL,
    login VARCHAR(50) NOT NULL UNIQUE,
    senha_hash VARCHAR(255) NOT NULL,
    email VARCHAR(100),
    ativo BIT DEFAULT 1,
    data_criacao DATETIME DEFAULT GETDATE(),
    data_atualizacao DATETIME DEFAULT GETDATE()
);

CREATE TABLE tbl_configuracao (
    id_config INT PRIMARY KEY IDENTITY(1,1),
    chave VARCHAR(100) NOT NULL UNIQUE,
    valor VARCHAR(MAX),
    descricao VARCHAR(255),
    tipo_config VARCHAR(50), -- 'STRING', 'NUMERO', 'DATA', 'BOOLEANO'
    data_atualizacao DATETIME DEFAULT GETDATE()
);

CREATE TABLE tbl_log_sistema (
    id_log INT PRIMARY KEY IDENTITY(1,1),
    id_usuario INT,
    tipo_operacao VARCHAR(50), -- INSERT, UPDATE, DELETE, SELECT
    tabela_afetada VARCHAR(100),
    descricao_operacao VARCHAR(MAX),
    ip_usuario VARCHAR(50),
    data_operacao DATETIME DEFAULT GETDATE(),
    FOREIGN KEY (id_usuario) REFERENCES tbl_usuario(id_usuario)
);

-- ============================================
-- 2. TABELAS DE CADASTRO BÁSICO
-- ============================================

CREATE TABLE tbl_cidade (
    id_cidade INT PRIMARY KEY IDENTITY(1,1),
    nome_cidade VARCHAR(100) NOT NULL,
    estado VARCHAR(2) NOT NULL,
    cep_inicio VARCHAR(8),
    cep_fim VARCHAR(8),
    ativo BIT DEFAULT 1
);

CREATE TABLE tbl_banco (
    id_banco INT PRIMARY KEY IDENTITY(1,1),
    codigo_banco INT,
    nome_banco VARCHAR(100) NOT NULL,
    nome_agencia VARCHAR(100),
    numero_agencia VARCHAR(20),
    numero_conta VARCHAR(20),
    digit_conta VARCHAR(5),
    saldo_inicial DECIMAL(12,2) DEFAULT 0,
    saldo_atual DECIMAL(12,2),
    ativo BIT DEFAULT 1,
    data_atualizacao DATETIME DEFAULT GETDATE()
);

CREATE TABLE tbl_fornecedor (
    id_fornecedor INT PRIMARY KEY IDENTITY(1,1),
    nome_fornecedor VARCHAR(150) NOT NULL,
    cnpj_cpf VARCHAR(20) UNIQUE,
    contato_principal VARCHAR(100),
    email_fornecedor VARCHAR(100),
    telefone VARCHAR(20),
    celular VARCHAR(20),
    endereco VARCHAR(255),
    numero_endereco VARCHAR(20),
    complemento VARCHAR(100),
    id_cidade INT,
    cep VARCHAR(8),
    observacoes VARCHAR(MAX),
    data_cadastro DATETIME DEFAULT GETDATE(),
    ativo BIT DEFAULT 1,
    FOREIGN KEY (id_cidade) REFERENCES tbl_cidade(id_cidade)
);

CREATE TABLE tbl_feriado (
    id_feriado INT PRIMARY KEY IDENTITY(1,1),
    data_feriado DATE NOT NULL,
    descricao_feriado VARCHAR(100),
    tipo_feriado VARCHAR(50), -- NACIONAL, ESTADUAL, MUNICIPAL, PONTE
    ativo BIT DEFAULT 1
);

-- ============================================
-- 3. TABELAS DE GESTÃO DE CLIENTES
-- ============================================

CREATE TABLE tbl_cliente (
    id_cliente INT PRIMARY KEY IDENTITY(1,1),
    nome_cliente VARCHAR(150) NOT NULL,
    cnpj_cpf VARCHAR(20) UNIQUE,
    inscricao_estadual VARCHAR(20),
    tipo_cliente VARCHAR(20), -- PF, PJ, CONSUMIDOR
    email_cliente VARCHAR(100),
    telefone VARCHAR(20),
    celular VARCHAR(20),
    endereco VARCHAR(255),
    numero_endereco VARCHAR(20),
    complemento VARCHAR(100),
    bairro VARCHAR(100),
    id_cidade INT,
    cep VARCHAR(8),
    limite_credito DECIMAL(12,2) DEFAULT 0,
    dias_prazo INT DEFAULT 0,
    observacoes VARCHAR(MAX),
    data_cadastro DATETIME DEFAULT GETDATE(),
    data_atualizacao DATETIME DEFAULT GETDATE(),
    ativo BIT DEFAULT 1,
    FOREIGN KEY (id_cidade) REFERENCES tbl_cidade(id_cidade)
);

CREATE TABLE tbl_cliente_contato (
    id_contato INT PRIMARY KEY IDENTITY(1,1),
    id_cliente INT NOT NULL,
    nome_contato VARCHAR(100),
    email_contato VARCHAR(100),
    telefone_contato VARCHAR(20),
    celular_contato VARCHAR(20),
    cargo VARCHAR(50),
    FOREIGN KEY (id_cliente) REFERENCES tbl_cliente(id_cliente) ON DELETE CASCADE
);

-- ============================================
-- 4. TABELAS DE RECURSOS HUMANOS
-- ============================================

CREATE TABLE tbl_funcao_cbo (
    id_funcao INT PRIMARY KEY IDENTITY(1,1),
    codigo_cbo VARCHAR(10),
    nome_funcao VARCHAR(100) NOT NULL,
    descricao_funcao VARCHAR(MAX),
    salario_base DECIMAL(12,2),
    ativo BIT DEFAULT 1
);

CREATE TABLE tbl_funcionario (
    id_funcionario INT PRIMARY KEY IDENTITY(1,1),
    nome_funcionario VARCHAR(150) NOT NULL,
    cpf VARCHAR(20) UNIQUE,
    rg VARCHAR(20),
    email_funcionario VARCHAR(100),
    telefone VARCHAR(20),
    celular VARCHAR(20),
    data_nascimento DATE,
    endereco VARCHAR(255),
    numero_endereco VARCHAR(20),
    complemento VARCHAR(100),
    id_cidade INT,
    cep VARCHAR(8),
    id_funcao INT,
    data_admissao DATE,
    data_demissao DATE,
    salario DECIMAL(12,2),
    observacoes VARCHAR(MAX),
    ativo BIT DEFAULT 1,
    FOREIGN KEY (id_funcao) REFERENCES tbl_funcao_cbo(id_funcao),
    FOREIGN KEY (id_cidade) REFERENCES tbl_cidade(id_cidade)
);

-- ============================================
-- 5. TABELAS DE ESTOQUE (MAIS COMPLEXAS)
-- ============================================

CREATE TABLE tbl_setor (
    id_setor INT PRIMARY KEY IDENTITY(1,1),
    nome_setor VARCHAR(100) NOT NULL,
    descricao_setor VARCHAR(255),
    ativo BIT DEFAULT 1
);

CREATE TABLE tbl_modulo (
    id_modulo INT PRIMARY KEY IDENTITY(1,1),
    nome_modulo VARCHAR(100) NOT NULL,
    descricao_modulo VARCHAR(255),
    ativo BIT DEFAULT 1
);

CREATE TABLE tbl_categoria_produto (
    id_categoria INT PRIMARY KEY IDENTITY(1,1),
    nome_categoria VARCHAR(100) NOT NULL,
    descricao_categoria VARCHAR(255),
    ativo BIT DEFAULT 1
);

CREATE TABLE tbl_unidade_medida (
    id_unidade INT PRIMARY KEY IDENTITY(1,1),
    sigla_unidade VARCHAR(10) NOT NULL UNIQUE,
    descricao_unidade VARCHAR(100),
    ativo BIT DEFAULT 1
);

-- Tabela Principal de Produtos
CREATE TABLE tbl_produto (
    numero_registro INT PRIMARY KEY IDENTITY(1,1),
    numero_controle INT NOT NULL,
    codigo_produto VARCHAR(50) NOT NULL UNIQUE,
    codigo_interno VARCHAR(100),
    nome_produto VARCHAR(255) NOT NULL,
    id_setor INT,
    nome_fabricante VARCHAR(150),
    id_fornecedor INT,
    preco_custo DECIMAL(12,2),
    custo_medio DECIMAL(12,4),
    preco_venda DECIMAL(12,2),
    quantidade_estoque INT DEFAULT 0,
    estoque_minimo INT DEFAULT 0,
    id_unidade_medida INT,
    margem_lucro DECIMAL(8,2), -- Percentual (0-100)
    codigo_moeda VARCHAR(10),
    data_ultimo_reajuste DATE,
    observacoes VARCHAR(MAX),
    nao_sai_tabela BIT DEFAULT 0,
    inativo BIT DEFAULT 0,
    codigo_ipi VARCHAR(20),
    percentual_ipi DECIMAL(8,2) DEFAULT 0,
    codigo_cst VARCHAR(10),
    percentual_icms DECIMAL(8,2) DEFAULT 0,
    base_calculo_icms DECIMAL(6,2) DEFAULT 100,
    peso_bruto DECIMAL(10,3),
    peso_liquido DECIMAL(10,3),
    id_modulo INT,
    local_armazenamento VARCHAR(100),
    quantidade_embalagem INT,
    codigo_elv VARCHAR(50),
    previsao_estoque VARCHAR(MAX),
    data_foto DATETIME,
    data_inclusao DATETIME DEFAULT GETDATE(),
    id_usuario_inclusao INT,
    codigo_ex VARCHAR(50),
    percentual_iva_st DECIMAL(8,2) DEFAULT 0,
    codigo_pfc VARCHAR(50),
    codigo_ipi_cst VARCHAR(10),
    ipi_base_calculo DECIMAL(12,2) DEFAULT 0,
    imagem_produto VARBINARY(MAX), -- Foto/Imagem do produto
    data_atualizacao DATETIME DEFAULT GETDATE(),
    FOREIGN KEY (id_setor) REFERENCES tbl_setor(id_setor),
    FOREIGN KEY (id_fornecedor) REFERENCES tbl_fornecedor(id_fornecedor),
    FOREIGN KEY (id_unidade_medida) REFERENCES tbl_unidade_medida(id_unidade),
    FOREIGN KEY (id_modulo) REFERENCES tbl_modulo(id_modulo),
    FOREIGN KEY (id_usuario_inclusao) REFERENCES tbl_usuario(id_usuario)
);

-- Histórico de Estoque (Rastreabilidade)
CREATE TABLE tbl_estoque_movimento (
    id_movimento INT PRIMARY KEY IDENTITY(1,1),
    id_produto INT NOT NULL,
    tipo_movimento VARCHAR(50), -- ENTRADA, SAIDA, AJUSTE, DEVOLUCAO, INVENTARIO
    quantidade_anterior INT,
    quantidade_movimento INT NOT NULL,
    quantidade_final INT,
    preco_unitario DECIMAL(12,2),
    motivo_movimento VARCHAR(255),
    id_usuario INT,
    data_movimento DATETIME DEFAULT GETDATE(),
    observacao_movimento VARCHAR(MAX),
    FOREIGN KEY (id_produto) REFERENCES tbl_produto(numero_registro),
    FOREIGN KEY (id_usuario) REFERENCES tbl_usuario(id_usuario)
);

-- Inventário Periódico
CREATE TABLE tbl_inventario_cabecalho (
    id_inventario INT PRIMARY KEY IDENTITY(1,1),
    numero_inventario INT NOT NULL UNIQUE,
    data_inventario DATETIME DEFAULT GETDATE(),
    id_usuario INT,
    status_inventario VARCHAR(50), -- ABERTO, EM_PROGRESSO, FINALIZADO
    observacoes_inventario VARCHAR(MAX),
    FOREIGN KEY (id_usuario) REFERENCES tbl_usuario(id_usuario)
);

CREATE TABLE tbl_inventario_detalhe (
    id_inventario_detalhe INT PRIMARY KEY IDENTITY(1,1),
    id_inventario INT NOT NULL,
    id_produto INT NOT NULL,
    quantidade_sistema INT,
    quantidade_fisico INT,
    diferenca INT,
    observacao_item VARCHAR(MAX),
    FOREIGN KEY (id_inventario) REFERENCES tbl_inventario_cabecalho(id_inventario),
    FOREIGN KEY (id_produto) REFERENCES tbl_produto(numero_registro)
);

-- ============================================
-- 6. TABELAS DE VENDAS/PEDIDOS
-- ============================================

CREATE TABLE tbl_serie_pedido (
    id_serie INT PRIMARY KEY IDENTITY(1,1),
    numero_serie VARCHAR(10) NOT NULL UNIQUE,
    descricao_serie VARCHAR(100),
    proximo_numero INT DEFAULT 1,
    ativo BIT DEFAULT 1
);

CREATE TABLE tbl_pedido_cabecalho (
    id_pedido INT PRIMARY KEY IDENTITY(1,1),
    numero_pedido VARCHAR(50) NOT NULL UNIQUE,
    id_serie INT,
    id_cliente INT NOT NULL,
    data_pedido DATETIME DEFAULT GETDATE(),
    data_entrega_prevista DATE,
    id_usuario_vendedor INT,
    tipo_pedido VARCHAR(50), -- VENDA, ORCAMENTO, DEVOLUCAO
    status_pedido VARCHAR(50), -- ABERTO, CONFIRMADO, FATURADO, ENTREGUE, CANCELADO
    condicao_pagamento VARCHAR(50), -- A_VISTA, PARCELADO, CONSIGNACAO
    quantidade_parcelas INT,
    desconto_pedido DECIMAL(12,2) DEFAULT 0,
    desconto_percentual DECIMAL(6,2) DEFAULT 0,
    frete_valor DECIMAL(12,2) DEFAULT 0,
    valor_total DECIMAL(12,2),
    observacoes_pedido VARCHAR(MAX),
    data_cancelamento DATE,
    motivo_cancelamento VARCHAR(MAX),
    FOREIGN KEY (id_cliente) REFERENCES tbl_cliente(id_cliente),
    FOREIGN KEY (id_usuario_vendedor) REFERENCES tbl_usuario(id_usuario),
    FOREIGN KEY (id_serie) REFERENCES tbl_serie_pedido(id_serie)
);

CREATE TABLE tbl_pedido_detalhe (
    id_detalhe_pedido INT PRIMARY KEY IDENTITY(1,1),
    id_pedido INT NOT NULL,
    id_produto INT NOT NULL,
    quantidade_pedida INT NOT NULL,
    quantidade_entregue INT DEFAULT 0,
    preco_unitario DECIMAL(12,2) NOT NULL,
    desconto_item DECIMAL(12,2) DEFAULT 0,
    desconto_percentual_item DECIMAL(6,2) DEFAULT 0,
    subtotal DECIMAL(12,2),
    observacao_item VARCHAR(MAX),
    FOREIGN KEY (id_pedido) REFERENCES tbl_pedido_cabecalho(id_pedido) ON DELETE CASCADE,
    FOREIGN KEY (id_produto) REFERENCES tbl_produto(numero_registro)
);

-- ============================================
-- 7. TABELAS DE ORÇAMENTO
-- ============================================

CREATE TABLE tbl_orcamento_cabecalho (
    id_orcamento INT PRIMARY KEY IDENTITY(1,1),
    numero_orcamento VARCHAR(50) NOT NULL UNIQUE,
    id_cliente INT NOT NULL,
    data_orcamento DATETIME DEFAULT GETDATE(),
    data_validade_orcamento DATE,
    id_usuario_vendedor INT,
    status_orcamento VARCHAR(50), -- ABERTO, ENVIADO, APROVADO, REJEITADO, CONVERTIDO, EXPIRADO
    desconto_orcamento DECIMAL(12,2) DEFAULT 0,
    desconto_percentual DECIMAL(6,2) DEFAULT 0,
    frete_valor DECIMAL(12,2) DEFAULT 0,
    valor_total DECIMAL(12,2),
    observacoes_orcamento VARCHAR(MAX),
    FOREIGN KEY (id_cliente) REFERENCES tbl_cliente(id_cliente),
    FOREIGN KEY (id_usuario_vendedor) REFERENCES tbl_usuario(id_usuario)
);

CREATE TABLE tbl_orcamento_detalhe (
    id_detalhe_orcamento INT PRIMARY KEY IDENTITY(1,1),
    id_orcamento INT NOT NULL,
    id_produto INT NOT NULL,
    quantidade_orcada INT NOT NULL,
    preco_unitario DECIMAL(12,2) NOT NULL,
    desconto_item DECIMAL(12,2) DEFAULT 0,
    desconto_percentual_item DECIMAL(6,2) DEFAULT 0,
    subtotal DECIMAL(12,2),
    observacao_item VARCHAR(MAX),
    FOREIGN KEY (id_orcamento) REFERENCES tbl_orcamento_cabecalho(id_orcamento) ON DELETE CASCADE,
    FOREIGN KEY (id_produto) REFERENCES tbl_produto(numero_registro)
);

-- ============================================
-- 8. TABELAS FINANCEIRAS
-- ============================================

CREATE TABLE tbl_forma_pagamento (
    id_forma_pagamento INT PRIMARY KEY IDENTITY(1,1),
    nome_forma VARCHAR(100) NOT NULL,
    tipo_pagamento VARCHAR(50), -- DINHEIRO, CHEQUE, BOLETO, TRANSFERENCIA, CARTAO, PIX
    aceita_parcelamento BIT DEFAULT 1,
    ativo BIT DEFAULT 1
);

CREATE TABLE tbl_contas_receber (
    id_conta_receber INT PRIMARY KEY IDENTITY(1,1),
    numero_documento VARCHAR(50) NOT NULL UNIQUE,
    id_cliente INT NOT NULL,
    id_pedido INT,
    id_forma_pagamento INT,
    valor_original DECIMAL(12,2) NOT NULL,
    valor_pago DECIMAL(12,2) DEFAULT 0,
    valor_juros DECIMAL(12,2) DEFAULT 0,
    valor_desconto DECIMAL(12,2) DEFAULT 0,
    valor_total_devido DECIMAL(12,2),
    data_emissao DATE DEFAULT GETDATE(),
    data_vencimento DATE NOT NULL,
    data_pagamento DATE,
    dias_atraso INT DEFAULT 0,
    status_pagamento VARCHAR(50), -- ABERTO, PARCIALMENTE_PAGO, PAGO, CANCELADO, VENCIDO
    observacoes VARCHAR(MAX),
    FOREIGN KEY (id_cliente) REFERENCES tbl_cliente(id_cliente),
    FOREIGN KEY (id_pedido) REFERENCES tbl_pedido_cabecalho(id_pedido),
    FOREIGN KEY (id_forma_pagamento) REFERENCES tbl_forma_pagamento(id_forma_pagamento)
);

CREATE TABLE tbl_cheque (
    id_cheque INT PRIMARY KEY IDENTITY(1,1),
    numero_cheque VARCHAR(20) NOT NULL,
    id_banco INT NOT NULL,
    valor_cheque DECIMAL(12,2),
    data_emissao DATE,
    data_vencimento DATE,
    emitente_cheque VARCHAR(150),
    cpf_cnpj_emitente VARCHAR(20),
    id_cliente INT,
    status_cheque VARCHAR(50), -- RECEBIDO, DEPOSITADO, COMPENSADO, DEVOLVIDO, CANCELADO
    motivo_devolucao VARCHAR(255),
    observacoes_cheque VARCHAR(MAX),
    FOREIGN KEY (id_banco) REFERENCES tbl_banco(id_banco),
    FOREIGN KEY (id_cliente) REFERENCES tbl_cliente(id_cliente)
);

CREATE TABLE tbl_caixa (
    id_caixa INT PRIMARY KEY IDENTITY(1,1),
    data_caixa DATE NOT NULL,
    id_usuario_caixa INT NOT NULL,
    saldo_abertura DECIMAL(12,2),
    saldo_fechamento DECIMAL(12,2),
    status_caixa VARCHAR(50), -- ABERTO, FECHADO, REABERTURA
    observacoes_caixa VARCHAR(MAX),
    FOREIGN KEY (id_usuario_caixa) REFERENCES tbl_usuario(id_usuario)
);

CREATE TABLE tbl_caixa_movimento (
    id_movimento_caixa INT PRIMARY KEY IDENTITY(1,1),
    id_caixa INT NOT NULL,
    tipo_movimento VARCHAR(50), -- ENTRADA, SAIDA, TRANSFERENCIA, DEVOLUCAO
    valor_movimento DECIMAL(12,2),
    descricao_movimento VARCHAR(255),
    id_forma_pagamento INT,
    numero_documento VARCHAR(50),
    data_movimento DATETIME DEFAULT GETDATE(),
    id_usuario_operador INT,
    FOREIGN KEY (id_caixa) REFERENCES tbl_caixa(id_caixa),
    FOREIGN KEY (id_forma_pagamento) REFERENCES tbl_forma_pagamento(id_forma_pagamento),
    FOREIGN KEY (id_usuario_operador) REFERENCES tbl_usuario(id_usuario)
);

-- ============================================
-- 9. TABELAS DE ATENDIMENTO
-- ============================================

CREATE TABLE tbl_atendimento (
    id_atendimento INT PRIMARY KEY IDENTITY(1,1),
    numero_atendimento VARCHAR(50) NOT NULL UNIQUE,
    id_cliente INT NOT NULL,
    id_usuario_atendente INT NOT NULL,
    data_atendimento DATETIME DEFAULT GETDATE(),
    tipo_atendimento VARCHAR(50), -- CONSULTA, RECLAMACAO, SUGESTAO, DUVIDA, SUPORTE
    assunto_atendimento VARCHAR(255),
    descricao_atendimento VARCHAR(MAX),
    prioridade VARCHAR(50), -- BAIXA, MEDIA, ALTA, CRITICA
    status_atendimento VARCHAR(50), -- ABERTO, EM_ANDAMENTO, RESOLVIDO, FECHADO, REABERTURA
    data_resolucao DATE,
    observacoes_atendimento VARCHAR(MAX),
    FOREIGN KEY (id_cliente) REFERENCES tbl_cliente(id_cliente),
    FOREIGN KEY (id_usuario_atendente) REFERENCES tbl_usuario(id_usuario)
);

CREATE TABLE tbl_atendimento_followup (
    id_followup INT PRIMARY KEY IDENTITY(1,1),
    id_atendimento INT NOT NULL,
    id_usuario INT,
    data_followup DATETIME DEFAULT GETDATE(),
    descricao_followup VARCHAR(MAX),
    status_seguimento VARCHAR(50),
    FOREIGN KEY (id_atendimento) REFERENCES tbl_atendimento(id_atendimento) ON DELETE CASCADE,
    FOREIGN KEY (id_usuario) REFERENCES tbl_usuario(id_usuario)
);

-- ============================================
-- 10. TABELAS DE AGENDAMENTO
-- ============================================

CREATE TABLE tbl_agendamento (
    id_agendamento INT PRIMARY KEY IDENTITY(1,1),
    id_cliente INT,
    id_funcionario INT,
    id_usuario_responsavel INT,
    data_agendamento DATETIME NOT NULL,
    data_conclusao DATETIME,
    tipo_servico VARCHAR(100),
    status_agendamento VARCHAR(50), -- AGENDADO, REALIZADO, CANCELADO, REMANEJADO
    observacoes_agendamento VARCHAR(MAX),
    FOREIGN KEY (id_cliente) REFERENCES tbl_cliente(id_cliente),
    FOREIGN KEY (id_funcionario) REFERENCES tbl_funcionario(id_funcionario),
    FOREIGN KEY (id_usuario_responsavel) REFERENCES tbl_usuario(id_usuario)
);

-- ============================================
-- 11. TABELAS DE COMISSÃO E VENDEDOR
-- ============================================

CREATE TABLE tbl_vendedor (
    id_vendedor INT PRIMARY KEY IDENTITY(1,1),
    nome_vendedor VARCHAR(150) NOT NULL,
    id_funcionario INT,
    percentual_comissao DECIMAL(6,2) DEFAULT 0,
    meta_vendas DECIMAL(12,2) DEFAULT 0,
    data_inicio DATE,
    data_fim DATE,
    ativo BIT DEFAULT 1,
    FOREIGN KEY (id_funcionario) REFERENCES tbl_funcionario(id_funcionario)
);

CREATE TABLE tbl_comissao (
    id_comissao INT PRIMARY KEY IDENTITY(1,1),
    id_vendedor INT NOT NULL,
    periodo_mes INT,
    periodo_ano INT,
    quantidade_vendas INT,
    valor_total_vendas DECIMAL(12,2),
    percentual_comissao DECIMAL(6,2),
    valor_comissao DECIMAL(12,2),
    observacoes_comissao VARCHAR(MAX),
    data_calculo DATETIME DEFAULT GETDATE(),
    FOREIGN KEY (id_vendedor) REFERENCES tbl_vendedor(id_vendedor)
);

-- ============================================
-- 12. TABELAS DE DOCUMENTOS FISCAIS
-- ============================================

CREATE TABLE tbl_nota_fiscal_serie (
    id_nf_serie INT PRIMARY KEY IDENTITY(1,1),
    numero_serie VARCHAR(10) NOT NULL UNIQUE,
    tipo_nf VARCHAR(50), -- SAIDA, ENTRADA, DEVOLUCAO
    proximo_numero INT DEFAULT 1,
    data_inicio DATE,
    data_fim DATE,
    ativo BIT DEFAULT 1
);

CREATE TABLE tbl_nota_fiscal (
    id_nota_fiscal INT PRIMARY KEY IDENTITY(1,1),
    numero_nf VARCHAR(50) NOT NULL UNIQUE,
    id_nf_serie INT,
    numero_chave_acesso VARCHAR(50),
    id_cliente INT NOT NULL,
    id_pedido INT,
    data_emissao DATE DEFAULT GETDATE(),
    data_saida DATE,
    tipo_nf VARCHAR(50), -- SAIDA, ENTRADA, DEVOLUCAO, CANCELADA
    status_nf VARCHAR(50), -- RASCUNHO, EMITIDA, CANCELADA, SUBSTITUIDA
    valor_nf DECIMAL(12,2),
    observacoes_nf VARCHAR(MAX),
    FOREIGN KEY (id_nf_serie) REFERENCES tbl_nota_fiscal_serie(id_nf_serie),
    FOREIGN KEY (id_cliente) REFERENCES tbl_cliente(id_cliente),
    FOREIGN KEY (id_pedido) REFERENCES tbl_pedido_cabecalho(id_pedido)
);

-- ============================================
-- 13. TABELAS DE TRANSPORTE
-- ============================================

CREATE TABLE tbl_transportadora (
    id_transportadora INT PRIMARY KEY IDENTITY(1,1),
    nome_transportadora VARCHAR(150) NOT NULL,
    cnpj_cpf VARCHAR(20) UNIQUE,
    telefone VARCHAR(20),
    celular VARCHAR(20),
    email_transportadora VARCHAR(100),
    endereco VARCHAR(255),
    id_cidade INT,
    observacoes VARCHAR(MAX),
    ativo BIT DEFAULT 1,
    FOREIGN KEY (id_cidade) REFERENCES tbl_cidade(id_cidade)
);

CREATE TABLE tbl_vale_transporte (
    id_vale INT PRIMARY KEY IDENTITY(1,1),
    id_funcionario INT NOT NULL,
    id_transportadora INT,
    data_vale DATE DEFAULT GETDATE(),
    valor_vale DECIMAL(12,2),
    observacoes_vale VARCHAR(MAX),
    FOREIGN KEY (id_funcionario) REFERENCES tbl_funcionario(id_funcionario),
    FOREIGN KEY (id_transportadora) REFERENCES tbl_transportadora(id_transportadora)
);

-- ============================================
-- ÍNDICES PARA PERFORMANCE
-- ============================================

CREATE INDEX idx_cliente_cnpj ON tbl_cliente(cnpj_cpf);
CREATE INDEX idx_cliente_nome ON tbl_cliente(nome_cliente);
CREATE INDEX idx_produto_codigo ON tbl_produto(codigo_produto);
CREATE INDEX idx_produto_interno ON tbl_produto(codigo_interno);
CREATE INDEX idx_produto_setor ON tbl_produto(id_setor);
CREATE INDEX idx_pedido_cliente ON tbl_pedido_cabecalho(id_cliente);
CREATE INDEX idx_pedido_data ON tbl_pedido_cabecalho(data_pedido);
CREATE INDEX idx_pedido_numero ON tbl_pedido_cabecalho(numero_pedido);
CREATE INDEX idx_contas_receber_cliente ON tbl_contas_receber(id_cliente);
CREATE INDEX idx_contas_receber_vencimento ON tbl_contas_receber(data_vencimento);
CREATE INDEX idx_contas_receber_status ON tbl_contas_receber(status_pagamento);
CREATE INDEX idx_estoque_movimento_produto ON tbl_estoque_movimento(id_produto);
CREATE INDEX idx_estoque_movimento_data ON tbl_estoque_movimento(data_movimento);
CREATE INDEX idx_atendimento_cliente ON tbl_atendimento(id_cliente);
CREATE INDEX idx_atendimento_data ON tbl_atendimento(data_atendimento);
CREATE INDEX idx_orcamento_cliente ON tbl_orcamento_cabecalho(id_cliente);
CREATE INDEX idx_orcamento_data ON tbl_orcamento_cabecalho(data_orcamento);
CREATE INDEX idx_log_usuario ON tbl_log_sistema(id_usuario);
CREATE INDEX idx_log_data ON tbl_log_sistema(data_operacao);
CREATE INDEX idx_cheque_banco ON tbl_cheque(id_banco);
CREATE INDEX idx_cheque_status ON tbl_cheque(status_cheque);

-- ============================================
-- FIM DA ESTRUTURA
-- ============================================
