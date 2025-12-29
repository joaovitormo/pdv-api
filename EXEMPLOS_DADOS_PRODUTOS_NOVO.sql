-- ============================================
-- EXEMPLOS DE DADOS - TABELA DE PRODUTOS (NOVO FORMATO)
-- Estrutura baseada no JSON do Paradox
-- ============================================

-- Primeiro, inserir dados de suporte
INSERT INTO tbl_setor (nome_setor, descricao_setor, ativo)
VALUES 
    ('Eletrônicos', 'Produtos eletrônicos em geral', 1),
    ('Hidráulica', 'Produtos hidráulicos e canos', 1),
    ('Elétrica', 'Produtos elétricos e instalação', 1),
    ('Construção', 'Materiais de construção', 1),
    ('Comercial', 'Artigos comerciais diversos', 1);

INSERT INTO tbl_modulo (nome_modulo, descricao_modulo, ativo)
VALUES 
    ('Vendas', 'Módulo de vendas', 1),
    ('Estoque', 'Controle de estoque', 1),
    ('Financeiro', 'Gestão financeira', 1);

INSERT INTO tbl_unidade_medida (sigla_unidade, descricao_unidade, ativo)
VALUES 
    ('UN', 'Unidade', 1),
    ('KG', 'Quilograma', 1),
    ('L', 'Litro', 1),
    ('M', 'Metro', 1),
    ('CX', 'Caixa', 1),
    ('PC', 'Peça', 1),
    ('DZ', 'Dúzia', 1);

INSERT INTO tbl_fornecedor (nome_fornecedor, cnpj_cpf, contato_principal, email_fornecedor, telefone, id_cidade, ativo)
VALUES 
    ('Distribuidora Nacional', '12.345.678/0001-99', 'João Fornecedor', 'contato@dist.com', '(11) 3030-3030', 1, 1),
    ('Importadora Internacional', '98.765.432/0001-11', 'Maria Silva', 'vendas@import.com', '(11) 3020-2020', 1, 1);

-- ============================================
-- INSERÇÃO DE PRODUTOS COM ESTRUTURA COMPLETA
-- Convertido do JSON Paradox com nomes amigáveis
-- ============================================

INSERT INTO tbl_produto (
    numero_controle, codigo_produto, codigo_interno, nome_produto, 
    id_setor, nome_fabricante, id_fornecedor, preco_custo, custo_medio, 
    preco_venda, quantidade_estoque, estoque_minimo, id_unidade_medida,
    margem_lucro, codigo_moeda, data_ultimo_reajuste, observacoes,
    nao_sai_tabela, inativo, codigo_ipi, percentual_ipi, codigo_cst,
    percentual_icms, base_calculo_icms, peso_bruto, peso_liquido,
    id_modulo, local_armazenamento, quantidade_embalagem, codigo_elv,
    previsao_estoque, data_foto, data_inclusao, id_usuario_inclusao,
    codigo_ex, percentual_iva_st, codigo_pfc, codigo_ipi_cst, ipi_base_calculo
)
VALUES 
    -- Produto 1: Tê de esgoto 100x Krona
    (
        4,                              -- numero_controle
        '000004',                       -- codigo_produto
        '',                             -- codigo_interno (vazio no original)
        'Tê esgoto 100x krona',         -- nome_produto
        2,                              -- id_setor (Hidráulica)
        '',                             -- nome_fabricante
        1,                              -- id_fornecedor
        5.50,                           -- preco_custo
        5.22903225806452,               -- custo_medio
        11.00,                          -- preco_venda
        22,                             -- quantidade_estoque
        2,                              -- estoque_minimo
        1,                              -- id_unidade_medida (UN)
        100.0,                          -- margem_lucro (%)
        'BRL',                          -- codigo_moeda
        '2017-12-10',                   -- data_ultimo_reajuste
        '',                             -- observacoes
        0,                              -- nao_sai_tabela (False = 0)
        0,                              -- inativo (False = 0)
        '',                             -- codigo_ipi
        0.0,                            -- percentual_ipi
        '',                             -- codigo_cst
        0.0,                            -- percentual_icms
        100.0,                          -- base_calculo_icms
        0.0,                            -- peso_bruto
        0.0,                            -- peso_liquido
        2,                              -- id_modulo (Estoque)
        '',                             -- local_armazenamento
        40,                             -- quantidade_embalagem
        '',                             -- codigo_elv
        '',                             -- previsao_estoque
        '2014-08-30 17:43:18',          -- data_foto
        '2014-08-30 17:38:32',          -- data_inclusao
        1,                              -- id_usuario_inclusao
        '',                             -- codigo_ex
        0.0,                            -- percentual_iva_st
        '',                             -- codigo_pfc
        '',                             -- codigo_ipi_cst
        0.0                             -- ipi_base_calculo
    ),
    
    -- Produto 2: Exemplo adicional - Monitor LED
    (
        1,                              -- numero_controle
        '000001',                       -- codigo_produto
        'MONITOR-24',                   -- codigo_interno
        'Monitor LED 24" Full HD',      -- nome_produto
        1,                              -- id_setor (Eletrônicos)
        'LG',                           -- nome_fabricante
        1,                              -- id_fornecedor
        450.00,                         -- preco_custo
        450.00,                         -- custo_medio
        699.90,                         -- preco_venda
        12,                             -- quantidade_estoque
        5,                              -- estoque_minimo
        1,                              -- id_unidade_medida (UN)
        55.5,                           -- margem_lucro (%)
        'BRL',                          -- codigo_moeda
        '2024-12-20',                   -- data_ultimo_reajuste
        'Produtos importados em estoque',  -- observacoes
        0,                              -- nao_sai_tabela
        0,                              -- inativo
        '',                             -- codigo_ipi
        0.0,                            -- percentual_ipi
        '0000',                         -- codigo_cst
        18.0,                           -- percentual_icms
        100.0,                          -- base_calculo_icms
        5.5,                            -- peso_bruto
        5.0,                            -- peso_liquido
        2,                              -- id_modulo
        'Prateleira A-01',              -- local_armazenamento
        1,                              -- quantidade_embalagem
        '',                             -- codigo_elv
        '',                             -- previsao_estoque
        '2024-12-20 10:30:00',          -- data_foto
        '2024-01-15 09:00:00',          -- data_inclusao
        1,                              -- id_usuario_inclusao
        '',                             -- codigo_ex
        0.0,                            -- percentual_iva_st
        '',                             -- codigo_pfc
        '',                             -- codigo_ipi_cst
        0.0                             -- ipi_base_calculo
    ),
    
    -- Produto 3: Teclado Mecânico
    (
        2,                              -- numero_controle
        '000002',                       -- codigo_produto
        'TECLADO-RGB',                  -- codigo_interno
        'Teclado Mecânico RGB Premium', -- nome_produto
        1,                              -- id_setor (Eletrônicos)
        'Corsair',                      -- nome_fabricante
        2,                              -- id_fornecedor
        150.00,                         -- preco_custo
        155.00,                         -- custo_medio
        279.90,                         -- preco_venda
        25,                             -- quantidade_estoque
        10,                             -- estoque_minimo
        1,                              -- id_unidade_medida (UN)
        86.6,                           -- margem_lucro (%)
        'BRL',                          -- codigo_moeda
        '2024-11-30',                   -- data_ultimo_reajuste
        '',                             -- observacoes
        0,                              -- nao_sai_tabela
        0,                              -- inativo
        '',                             -- codigo_ipi
        0.0,                            -- percentual_ipi
        '0000',                         -- codigo_cst
        18.0,                           -- percentual_icms
        100.0,                          -- base_calculo_icms
        1.2,                            -- peso_bruto
        1.0,                            -- peso_liquido
        2,                              -- id_modulo
        'Prateleira B-02',              -- local_armazenamento
        1,                              -- quantidade_embalagem
        '',                             -- codigo_elv
        '',                             -- previsao_estoque
        NULL,                           -- data_foto
        '2024-03-10 11:20:00',          -- data_inclusao
        1,                              -- id_usuario_inclusao
        '',                             -- codigo_ex
        0.0,                            -- percentual_iva_st
        '',                             -- codigo_pfc
        '',                             -- codigo_ipi_cst
        0.0                             -- ipi_base_calculo
    ),
    
    -- Produto 4: Cabo HDMI
    (
        3,                              -- numero_controle
        '000003',                       -- codigo_produto
        'CABO-HDMI-5M',                 -- codigo_interno
        'Cabo HDMI 2.0 5M',             -- nome_produto
        1,                              -- id_setor (Eletrônicos)
        'Genérico',                     -- nome_fabricante
        1,                              -- id_fornecedor
        15.00,                          -- preco_custo
        15.50,                          -- custo_medio
        35.90,                          -- preco_venda
        89,                             -- quantidade_estoque
        20,                             -- estoque_minimo
        1,                              -- id_unidade_medida (UN)
        139.3,                          -- margem_lucro (%)
        'BRL',                          -- codigo_moeda
        '2024-09-15',                   -- data_ultimo_reajuste
        'Estoque alto - produto em promoção',  -- observacoes
        0,                              -- nao_sai_tabela
        0,                              -- inativo
        '',                             -- codigo_ipi
        0.0,                            -- percentual_ipi
        '0000',                         -- codigo_cst
        18.0,                           -- percentual_icms
        100.0,                          -- base_calculo_icms
        0.3,                            -- peso_bruto
        0.25,                           -- peso_liquido
        2,                              -- id_modulo
        'Prateleira C-03',              -- local_armazenamento
        10,                             -- quantidade_embalagem (caixa com 10)
        '',                             -- codigo_elv
        '',                             -- previsao_estoque
        NULL,                           -- data_foto
        '2024-02-20 14:45:00',          -- data_inclusao
        1,                              -- id_usuario_inclusao
        '',                             -- codigo_ex
        0.0,                            -- percentual_iva_st
        '',                             -- codigo_pfc
        '',                             -- codigo_ipi_cst
        0.0                             -- ipi_base_calculo
    );

-- ============================================
-- VALIDAÇÕES E CONSULTAS DE TESTE
-- ============================================

-- Verificar dados inseridos
SELECT 
    numero_registro,
    numero_controle,
    codigo_produto,
    nome_produto,
    preco_custo,
    preco_venda,
    quantidade_estoque,
    margem_lucro
FROM tbl_produto
ORDER BY numero_registro;

-- Produtos com quantidade abaixo do mínimo
SELECT 
    numero_registro,
    nome_produto,
    quantidade_estoque,
    estoque_minimo
FROM tbl_produto
WHERE quantidade_estoque <= estoque_minimo
ORDER BY quantidade_estoque;

-- Produtos por setor
SELECT 
    s.nome_setor,
    COUNT(p.numero_registro) as total_produtos,
    SUM(p.quantidade_estoque) as total_quantidade,
    AVG(p.preco_venda) as preco_medio_venda
FROM tbl_produto p
JOIN tbl_setor s ON p.id_setor = s.id_setor
GROUP BY s.nome_setor
ORDER BY total_produtos DESC;

-- Valor total em estoque por produto
SELECT 
    nome_produto,
    quantidade_estoque,
    preco_custo,
    (quantidade_estoque * preco_custo) as valor_total_estoque
FROM tbl_produto
WHERE quantidade_estoque > 0
ORDER BY valor_total_estoque DESC;
