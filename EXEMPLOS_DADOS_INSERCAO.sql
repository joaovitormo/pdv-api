-- ============================================
-- EXEMPLOS DE DADOS PARA O NOVO SISTEMA
-- Script de inserção de dados de teste
-- ============================================

-- ============================================
-- 1. DADOS DE CONFIGURAÇÃO E USUÁRIOS
-- ============================================

-- Usuários do Sistema
INSERT INTO tbl_usuario (nome_usuario, login, senha_hash, email, ativo)
VALUES 
    ('Administrador', 'admin', 'HASH_SEGURO_AQUI', 'admin@empresa.com', 1),
    ('João Silva', 'joao', 'HASH_SEGURO_AQUI', 'joao@empresa.com', 1),
    ('Maria Santos', 'maria', 'HASH_SEGURO_AQUI', 'maria@empresa.com', 1),
    ('Carlos Oliveira', 'carlos', 'HASH_SEGURO_AQUI', 'carlos@empresa.com', 1);

-- Configurações do Sistema
INSERT INTO tbl_configuracao (chave, valor, descricao, tipo_config)
VALUES 
    ('EMPRESA_NOME', 'Minha Empresa Ltda', 'Nome da empresa', 'STRING'),
    ('EMPRESA_CNPJ', '12.345.678/0001-00', 'CNPJ da empresa', 'STRING'),
    ('EMPRESA_EMAIL', 'empresa@email.com', 'Email principal', 'STRING'),
    ('EMPRESA_TELEFONE', '(11) 3000-0000', 'Telefone principal', 'STRING'),
    ('TAXA_IMPOSTO_PADRAO', '18', 'Taxa de imposto padrão em %', 'NUMERO'),
    ('DIAS_VALIDADE_ORCAMENTO', '30', 'Dias de validade do orçamento', 'NUMERO'),
    ('ESTOQUE_MINIMO_ALERTA', '1', 'Ativar alerta de estoque mínimo', 'BOOLEANO'),
    ('MOEDA_SISTEMA', 'BRL', 'Moeda padrão do sistema', 'STRING');

-- ============================================
-- 2. DADOS BÁSICOS - CIDADES E LOCALIDADES
-- ============================================

INSERT INTO tbl_cidade (nome_cidade, estado, cep_inicio, cep_fim, ativo)
VALUES 
    ('São Paulo', 'SP', '01000000', '05999999', 1),
    ('Rio de Janeiro', 'RJ', '20000000', '28999999', 1),
    ('Belo Horizonte', 'MG', '30000000', '31999999', 1),
    ('Curitiba', 'PR', '80000000', '82999999', 1),
    ('Salvador', 'BA', '40000000', '42999999', 1);

-- ============================================
-- 3. DADOS DE BANCO E FINANCEIRO
-- ============================================

INSERT INTO tbl_banco (codigo_banco, nome_banco, nome_agencia, numero_agencia, numero_conta, digit_conta, saldo_inicial, saldo_atual, ativo)
VALUES 
    (1, 'Banco do Brasil', 'Agência Centro', '0001', '123456', '7', 10000.00, 10000.00, 1),
    (33, 'Itaú Unibanco', 'Agência Zona Leste', '0002', '654321', '8', 5000.00, 5000.00, 1),
    (341, 'Itaú Unibanco', 'Agência Centro', '0003', '999888', '5', 8000.00, 8000.00, 1);

INSERT INTO tbl_forma_pagamento (nome_forma, tipo_pagamento, aceita_parcelamento, ativo)
VALUES 
    ('Dinheiro', 'DINHEIRO', 0, 1),
    ('Cheque', 'CHEQUE', 0, 1),
    ('Boleto', 'BOLETO', 1, 1),
    ('Transferência Bancária', 'TRANSFERENCIA', 0, 1),
    ('Cartão de Crédito', 'CARTAO', 1, 1),
    ('PIX', 'PIX', 0, 1),
    ('Crediário 30 dias', 'PARCELADO', 1, 1);

-- ============================================
-- 4. DADOS DE FORNECEDORES
-- ============================================

INSERT INTO tbl_fornecedor (nome_fornecedor, cnpj_cpf, contato_principal, email_fornecedor, telefone, celular, endereco, numero_endereco, id_cidade, cep, ativo)
VALUES 
    ('Distribuidora XYZ Ltda', '12.345.678/0001-99', 'João Fornecedor', 'contato@distribuidora.com', '(11) 3030-3030', '(11) 99999-9999', 'Rua Exemplo', '100', 1, '01000000', 1),
    ('Supplier ABC Importadora', '98.765.432/0001-11', 'Maria Importadora', 'vendas@supplier.com', '(21) 2020-2020', '(21) 98888-8888', 'Avenida Principal', '500', 2, '20000000', 1),
    ('Indústria Nacional LTDA', '55.666.777/0001-88', 'Carlos Industrial', 'comercial@industrial.com', '(31) 3100-3100', '(31) 97777-7777', 'Estrada Industrial', '1000', 3, '30000000', 1);

-- ============================================
-- 5. DADOS DE CLIENTES
-- ============================================

INSERT INTO tbl_cliente (nome_cliente, cnpj_cpf, tipo_cliente, email_cliente, telefone, celular, endereco, numero_endereco, bairro, id_cidade, cep, limite_credito, dias_prazo, ativo)
VALUES 
    ('João da Silva', '123.456.789-10', 'PF', 'joao@email.com', '(11) 3000-1111', '(11) 99999-1111', 'Rua A', '100', 'Centro', 1, '01000100', 5000.00, 30, 1),
    ('Maria Santos Comércio', '98.765.432/0001-22', 'PJ', 'comercio@email.com', '(11) 3000-2222', '(11) 99999-2222', 'Rua B', '200', 'Zona Sul', 1, '01000200', 50000.00, 60, 1),
    ('Carlos e Filhos Ltda', '11.222.333/0001-44', 'PJ', 'vendas@carlos.com', '(11) 3000-3333', '(11) 99999-3333', 'Avenida C', '300', 'Zona Norte', 1, '01000300', 100000.00, 90, 1),
    ('Ana Costa', '456.789.123-45', 'PF', 'ana@email.com', '(21) 2000-1111', '(21) 98888-1111', 'Rua D', '400', 'Copacabana', 2, '20000400', 3000.00, 30, 1),
    ('Loja Premium RJ', '77.888.999/0001-55', 'PJ', 'compras@lojapremium.com', '(21) 2000-2222', '(21) 98888-2222', 'Avenida E', '500', 'Centro', 2, '20000500', 150000.00, 120, 1);

INSERT INTO tbl_cliente_contato (id_cliente, nome_contato, email_contato, telefone_contato, cargo)
VALUES 
    (2, 'Pedro Gerente', 'pedro@comercio.com', '(11) 3000-2223', 'Gerente'),
    (3, 'Lucia Compradora', 'lucia@carlos.com', '(11) 3000-3334', 'Compradora'),
    (5, 'Roberto Diretor', 'roberto@lojapremium.com', '(21) 2000-2223', 'Diretor Comercial');

-- ============================================
-- 6. DADOS DE RH - FUNÇÕES
-- ============================================

INSERT INTO tbl_funcao_cbo (codigo_cbo, nome_funcao, descricao_funcao, salario_base, ativo)
VALUES 
    ('2121-05', 'Gerente de Vendas', 'Responsável por equipe de vendas', 5000.00, 1),
    ('1411-15', 'Vendedor', 'Realizará vendas e contato com cliente', 2500.00, 1),
    ('4105-05', 'Operador de Estoque', 'Controle e movimentação de estoque', 2000.00, 1),
    ('3512-15', 'Atendente de Caixa', 'Operação do caixa e atendimento', 1800.00, 1),
    ('2139-55', 'Gerente Administrativo', 'Gestão administrativa geral', 4500.00, 1);

-- ============================================
-- 7. DADOS DE RH - FUNCIONÁRIOS
-- ============================================

INSERT INTO tbl_funcionario (nome_funcionario, cpf, rg, email_funcionario, telefone, data_nascimento, endereco, id_cidade, id_funcao, data_admissao, salario, ativo)
VALUES 
    ('João da Silva Vendedor', '111.111.111-11', '1111111', 'joao.vendedor@empresa.com', '(11) 99999-1111', '1985-05-15', 'Rua X', 1, 2, '2020-01-15', 2500.00, 1),
    ('Maria Estoque Silva', '222.222.222-22', '2222222', 'maria.estoque@empresa.com', '(11) 99999-2222', '1990-03-20', 'Rua Y', 1, 3, '2021-06-01', 2000.00, 1),
    ('Carlos Caixa Junior', '333.333.333-33', '3333333', 'carlos.caixa@empresa.com', '(11) 99999-3333', '1995-07-10', 'Rua Z', 1, 4, '2022-01-20', 1800.00, 1),
    ('Ana Gerente Sales', '444.444.444-44', '4444444', 'ana.gerente@empresa.com', '(11) 99999-4444', '1980-12-05', 'Avenida Principal', 1, 1, '2018-03-10', 5000.00, 1);

-- ============================================
-- 8. DADOS DE ESTOQUE - CATEGORIAS E UNIDADES
-- ============================================

INSERT INTO tbl_categoria_produto (nome_categoria, descricao_categoria, ativo)
VALUES 
    ('Eletrônicos', 'Produtos eletrônicos diversos', 1),
    ('Informática', 'Computadores, periféricos e acessórios', 1),
    ('Acessórios', 'Cabos, adaptadores, periféricos', 1),
    ('Peças de Reposição', 'Peças para manutenção e reposição', 1),
    ('Consumíveis', 'Itens consumíveis e descartáveis', 1);

INSERT INTO tbl_unidade_medida (sigla_unidade, descricao_unidade, ativo)
VALUES 
    ('UN', 'Unidade', 1),
    ('KG', 'Quilograma', 1),
    ('L', 'Litro', 1),
    ('M', 'Metro', 1),
    ('CX', 'Caixa', 1),
    ('PC', 'Peça', 1);

-- ============================================
-- 9. DADOS DE ESTOQUE - PRODUTOS (PRINCIPAIS)
-- ============================================

INSERT INTO tbl_produto (
    codigo_interno, codigo_barras, nome_produto, descricao_produto,
    id_categoria, id_unidade, id_fornecedor, preco_custo, preco_tabela, preco_venda,
    margem_lucro, quantidade_minima, quantidade_maxima, estoque_atual, ativo
) VALUES 
    ('PROD-001', '7891234567890', 'Monitor LED 24"', 
     'Monitor LED Full HD 1920x1080, painel IPS, 60Hz', 
     2, 1, 1, 450.00, 750.00, 699.90, 55.0, 5, 20, 12, 1),
    
    ('PROD-002', '7891234567891', 'Teclado Mecânico RGB', 
     'Teclado mecânico com iluminação RGB, switches mecânicos Cherry MX', 
     2, 1, 2, 150.00, 299.00, 279.90, 86.6, 10, 30, 25, 1),
    
    ('PROD-003', '7891234567892', 'Mouse Wireless Logitech', 
     'Mouse sem fio com receptor USB, duração de bateria de 12 meses', 
     2, 1, 1, 45.00, 99.00, 89.90, 99.8, 15, 50, 45, 1),
    
    ('PROD-004', '7891234567893', 'Cabo HDMI 2.0 5M', 
     'Cabo HDMI 2.0 com 5 metros, suporta 4K@60Hz', 
     3, 1, 2, 15.00, 39.90, 35.90, 139.3, 20, 100, 89, 1),
    
    ('PROD-005', '7891234567894', 'Hub USB 3.0 7 Portas', 
     'Hub USB 3.0 com 7 portas, alimentação externa, velocidade até 5Gbps', 
     3, 1, 1, 35.00, 79.90, 74.90, 114.0, 8, 25, 18, 1),
    
    ('PROD-006', '7891234567895', 'SSD 240GB Kingston', 
     'SSD 240GB SATA III, leitura até 550 MB/s, escrita até 350 MB/s', 
     2, 1, 3, 120.00, 249.00, 229.90, 91.6, 5, 15, 8, 1),
    
    ('PROD-007', '7891234567896', 'Memória RAM DDR4 8GB', 
     'Memória RAM DDR4 8GB 2666MHz, compatível com a maioria das plataformas', 
     2, 1, 2, 60.00, 129.90, 119.90, 99.8, 10, 40, 32, 1),
    
    ('PROD-008', '7891234567897', 'Fonte 500W Bronze', 
     'Fonte de alimentação 500W certificação 80+ Bronze, ventilador 120mm', 
     2, 1, 1, 180.00, 349.00, 329.90, 83.3, 3, 12, 7, 1),
    
    ('PROD-009', '7891234567898', 'Pasta Térmica 5g', 
     'Pasta térmica para processador, condutividade térmica 3.0 W/mK', 
     4, 1, 2, 8.00, 19.90, 17.90, 123.8, 30, 150, 95, 1),
    
    ('PROD-010', '7891234567899', 'Webcam Full HD 1080p', 
     'Webcam Full HD com microfone integrado, sensor CMOS 2MP', 
     3, 1, 1, 55.00, 139.90, 129.90, 136.2, 8, 20, 14, 1);

-- ============================================
-- 10. SÉRIE DE PEDIDOS
-- ============================================

INSERT INTO tbl_serie_pedido (numero_serie, descricao_serie, proximo_numero, ativo)
VALUES 
    ('PED', 'Série de Pedidos Padrão', 1001, 1),
    ('ORC', 'Série de Orçamentos', 1, 1);

-- ============================================
-- 11. EXEMPLOS DE PEDIDOS (VENDAS)
-- ============================================

INSERT INTO tbl_pedido_cabecalho (
    numero_pedido, id_serie, id_cliente, data_pedido, id_usuario_vendedor,
    tipo_pedido, status_pedido, condicao_pagamento, quantidade_parcelas,
    desconto_pedido, frete_valor, valor_total
) VALUES 
    ('PED-001', 1, 1, '2025-12-10', 1, 'VENDA', 'CONFIRMADO', 'A_VISTA', 1, 0.00, 0.00, 2099.70),
    ('PED-002', 1, 2, '2025-12-11', 2, 'VENDA', 'ABERTO', 'PARCELADO', 3, 200.00, 50.00, 5349.70),
    ('PED-003', 1, 3, '2025-12-12', 1, 'VENDA', 'FATURADO', 'PARCELADO', 2, 0.00, 0.00, 6499.60);

INSERT INTO tbl_pedido_detalhe (
    id_pedido, id_produto, quantidade_pedida, preco_unitario, desconto_item, subtotal
) VALUES 
    (1, 1, 2, 699.90, 0.00, 1399.80),
    (1, 3, 1, 89.90, 0.00, 89.90),
    (1, 5, 1, 74.90, 0.00, 74.90),
    
    (2, 2, 3, 279.90, 50.00, 789.70),
    (2, 6, 2, 229.90, 0.00, 459.80),
    (2, 7, 4, 119.90, 0.00, 479.60),
    (2, 10, 2, 129.90, 0.00, 259.80),
    
    (3, 4, 10, 35.90, 0.00, 359.00),
    (3, 8, 3, 329.90, 0.00, 989.70),
    (3, 9, 15, 17.90, 0.00, 268.50),
    (3, 10, 5, 129.90, 0.00, 649.50);

-- ============================================
-- 12. EXEMPLOS DE ORÇAMENTOS
-- ============================================

INSERT INTO tbl_orcamento_cabecalho (
    numero_orcamento, id_cliente, data_orcamento, data_validade_orcamento,
    id_usuario_vendedor, status_orcamento, valor_total
) VALUES 
    ('ORC-001', 4, '2025-12-10', '2026-01-10', 1, 'ENVIADO', 1499.70),
    ('ORC-002', 5, '2025-12-11', '2026-01-11', 2, 'ABERTO', 8999.70);

INSERT INTO tbl_orcamento_detalhe (
    id_orcamento, id_produto, quantidade_orcada, preco_unitario, subtotal
) VALUES 
    (1, 1, 1, 699.90, 699.90),
    (1, 2, 1, 279.90, 279.90),
    (1, 3, 2, 89.90, 179.90),
    
    (2, 1, 2, 699.90, 1399.80),
    (2, 6, 5, 229.90, 1149.50),
    (2, 7, 8, 119.90, 959.20),
    (2, 8, 2, 329.90, 659.80),
    (2, 10, 10, 129.90, 1299.00),
    (2, 4, 20, 35.90, 718.00),
    (2, 5, 5, 74.90, 374.40);

-- ============================================
-- 13. MOVIMENTO DE ESTOQUE (RASTREABILIDADE)
-- ============================================

INSERT INTO tbl_estoque_movimento (
    id_produto, tipo_movimento, quantidade_anterior, quantidade_movimento,
    quantidade_final, preco_unitario, motivo_movimento, id_usuario
) VALUES 
    (1, 'ENTRADA', 0, 20, 20, 450.00, 'Compra Fornecedor XYZ', 1),
    (1, 'SAIDA', 20, 2, 18, 699.90, 'Pedido PED-001', 2),
    (2, 'ENTRADA', 0, 50, 50, 150.00, 'Compra Fornecedor ABC', 1),
    (2, 'SAIDA', 50, 3, 47, 279.90, 'Pedido PED-002', 2),
    (3, 'ENTRADA', 0, 100, 100, 45.00, 'Compra Fornecedor XYZ', 1),
    (3, 'SAIDA', 100, 3, 97, 89.90, 'Pedidos diversos', 2),
    (4, 'ENTRADA', 0, 200, 200, 15.00, 'Compra Fornecedor ABC', 1),
    (4, 'SAIDA', 200, 30, 170, 35.90, 'Pedidos diversos', 2),
    (5, 'ENTRADA', 0, 50, 50, 35.00, 'Compra Fornecedor XYZ', 1),
    (5, 'SAIDA', 50, 6, 44, 74.90, 'Pedidos diversos', 2);

-- ============================================
-- 14. CONTAS A RECEBER
-- ============================================

INSERT INTO tbl_contas_receber (
    numero_documento, id_cliente, id_pedido, id_forma_pagamento,
    valor_original, valor_pago, valor_total_devido,
    data_emissao, data_vencimento, status_pagamento
) VALUES 
    ('DOC-001', 1, 1, 6, 2099.70, 2099.70, 2099.70, '2025-12-10', '2025-12-10', 'PAGO'),
    ('DOC-002-01', 2, 2, 5, 1783.23, 0.00, 1783.23, '2025-12-11', '2026-01-10', 'ABERTO'),
    ('DOC-002-02', 2, 2, 5, 1783.24, 0.00, 1783.24, '2025-12-11', '2026-02-10', 'ABERTO'),
    ('DOC-002-03', 2, 2, 5, 1783.23, 0.00, 1783.23, '2025-12-11', '2026-03-10', 'ABERTO'),
    ('DOC-003-01', 3, 3, 5, 3249.80, 0.00, 3249.80, '2025-12-12', '2026-01-11', 'ABERTO'),
    ('DOC-003-02', 3, 3, 5, 3249.80, 0.00, 3249.80, '2025-12-12', '2026-02-11', 'ABERTO');

-- ============================================
-- 15. CHEQUES RECEBIDOS
-- ============================================

INSERT INTO tbl_cheque (
    numero_cheque, id_banco, valor_cheque, data_emissao, data_vencimento,
    emitente_cheque, id_cliente, status_cheque
) VALUES 
    ('000001', 1, 500.00, '2025-12-10', '2026-01-10', 'João da Silva', 1, 'RECEBIDO'),
    ('000002', 2, 1000.00, '2025-12-11', '2026-02-11', 'Maria Santos', 2, 'DEPOSITADO');

-- ============================================
-- 16. CAIXA DIÁRIO
-- ============================================

INSERT INTO tbl_caixa (
    data_caixa, id_usuario_caixa, saldo_abertura, saldo_fechamento, status_caixa
) VALUES 
    ('2025-12-10', 3, 500.00, 2599.70, 'FECHADO'),
    ('2025-12-11', 3, 2599.70, 2599.70, 'ABERTO');

INSERT INTO tbl_caixa_movimento (
    id_caixa, tipo_movimento, valor_movimento, descricao_movimento,
    id_forma_pagamento, numero_documento, id_usuario_operador
) VALUES 
    (1, 'ENTRADA', 2099.70, 'Recebimento PED-001', 6, 'DOC-001', 3),
    (2, 'ENTRADA', 1000.00, 'Depósito Cheque', 2, '000002', 3);

-- ============================================
-- 17. VENDEDORES E COMISSÕES
-- ============================================

INSERT INTO tbl_vendedor (nome_vendedor, id_funcionario, percentual_comissao, meta_vendas, data_inicio, ativo)
VALUES 
    ('João da Silva Vendedor', 1, 5.0, 10000.00, '2020-01-15', 1),
    ('Vendedor Tempos Parciais', NULL, 10.0, 5000.00, '2024-01-01', 1);

INSERT INTO tbl_comissao (
    id_vendedor, periodo_mes, periodo_ano, quantidade_vendas, valor_total_vendas,
    percentual_comissao, valor_comissao
) VALUES 
    (1, 12, 2025, 3, 8449.30, 5.0, 422.46),
    (2, 12, 2025, 1, 2099.70, 10.0, 209.97);

-- ============================================
-- 18. ATENDIMENTOS AO CLIENTE
-- ============================================

INSERT INTO tbl_atendimento (
    numero_atendimento, id_cliente, id_usuario_atendente, data_atendimento,
    tipo_atendimento, assunto_atendimento, descricao_atendimento,
    prioridade, status_atendimento
) VALUES 
    ('ATD-001', 1, 2, '2025-12-10', 'CONSULTA', 'Dúvida sobre produto', 
     'Cliente gostaria de saber se temos monitor em stock', 'MEDIA', 'RESOLVIDO'),
    ('ATD-002', 2, 2, '2025-12-11', 'DUVIDA', 'Prazo de entrega', 
     'Cliente questionou o prazo de entrega do pedido PED-002', 'ALTA', 'EM_ANDAMENTO'),
    ('ATD-003', 4, 2, '2025-12-12', 'RECLAMACAO', 'Produto defeituoso', 
     'Webcam recebida não liga. Solicitado envio de nova unidade.', 'CRITICA', 'ABERTO');

-- ============================================
-- 19. AGENDAMENTOS
-- ============================================

INSERT INTO tbl_agendamento (
    id_cliente, id_funcionario, id_usuario_responsavel, data_agendamento,
    tipo_servico, status_agendamento
) VALUES 
    (1, 4, 1, '2025-12-20 10:00:00', 'Instalação de monitores', 'AGENDADO'),
    (2, 4, 1, '2025-12-21 14:00:00', 'Suporte técnico', 'AGENDADO');

-- ============================================
-- 20. FERIADOS
-- ============================================

INSERT INTO tbl_feriado (data_feriado, descricao_feriado, tipo_feriado, ativo)
VALUES 
    ('2025-01-01', 'Confraternização Universal', 'NACIONAL', 1),
    ('2025-02-03', 'Segunda de Carnaval', 'NACIONAL', 1),
    ('2025-02-04', 'Carnaval', 'NACIONAL', 1),
    ('2025-04-21', 'Tiradentes', 'NACIONAL', 1),
    ('2025-05-01', 'Dia do Trabalho', 'NACIONAL', 1),
    ('2025-09-07', 'Independência do Brasil', 'NACIONAL', 1),
    ('2025-10-12', 'Nossa Senhora Aparecida', 'NACIONAL', 1),
    ('2025-11-02', 'Finados', 'NACIONAL', 1),
    ('2025-11-20', 'Consciência Negra', 'NACIONAL', 1),
    ('2025-12-25', 'Natal', 'NACIONAL', 1);

-- ============================================
-- FIM DOS DADOS DE EXEMPLO
-- ============================================

PRINT 'Dados de exemplo inseridos com sucesso!'
PRINT 'Total de registros:'
PRINT 'Usuários: 4'
PRINT 'Clientes: 5'
PRINT 'Produtos: 10'
PRINT 'Pedidos: 3'
PRINT 'Contas a Receber: 6'
PRINT 'Movimentos de Estoque: 10'
PRINT 'Atendimentos: 3'

-- ============================================
-- CONSULTAS ÚTEIS DE VERIFICAÇÃO
-- ============================================

-- Verificar estoque atual
SELECT 
    p.codigo_interno,
    p.nome_produto,
    p.estoque_atual,
    p.quantidade_minima,
    p.quantidade_maxima,
    p.preco_venda,
    (p.estoque_atual * p.preco_venda) as valor_total_estoque
FROM tbl_produto p
WHERE p.ativo = 1
ORDER BY p.nome_produto;

-- Produtos com baixo estoque (abaixo do mínimo)
SELECT 
    p.codigo_interno,
    p.nome_produto,
    p.estoque_atual,
    p.quantidade_minima,
    (p.quantidade_minima - p.estoque_atual) as quantidade_faltante
FROM tbl_produto p
WHERE p.estoque_atual < p.quantidade_minima
AND p.ativo = 1;

-- Total de vendas por cliente
SELECT 
    c.nome_cliente,
    COUNT(p.id_pedido) as quantidade_pedidos,
    SUM(p.valor_total) as valor_total_vendas
FROM tbl_cliente c
LEFT JOIN tbl_pedido_cabecalho p ON c.id_cliente = p.id_cliente
WHERE c.ativo = 1
GROUP BY c.id_cliente, c.nome_cliente
ORDER BY valor_total_vendas DESC;

-- Contas vencidas
SELECT 
    cr.numero_documento,
    c.nome_cliente,
    cr.valor_total_devido,
    cr.data_vencimento,
    DATEDIFF(DAY, cr.data_vencimento, GETDATE()) as dias_atraso
FROM tbl_contas_receber cr
JOIN tbl_cliente c ON cr.id_cliente = c.id_cliente
WHERE cr.status_pagamento IN ('ABERTO', 'VENCIDO')
AND cr.data_vencimento < GETDATE()
ORDER BY dias_atraso DESC;

-- Desempenho de vendedores (comissões)
SELECT 
    v.nome_vendedor,
    c.periodo_mes,
    c.periodo_ano,
    c.quantidade_vendas,
    c.valor_total_vendas,
    c.valor_comissao
FROM tbl_vendedor v
LEFT JOIN tbl_comissao c ON v.id_vendedor = c.id_vendedor
WHERE v.ativo = 1
ORDER BY c.valor_comissao DESC;
