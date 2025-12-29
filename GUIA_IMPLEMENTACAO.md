# 📚 Guia de Implementação - Novo Sistema de Gestão

## 1. 🎯 Visão Geral do Projeto

### O que foi criado:
- ✅ **40 tabelas** de banco de dados normalizadas
- ✅ **Estrutura completa** em SQL Server / MySQL / PostgreSQL
- ✅ **Dados de exemplo** para teste
- ✅ **Índices estratégicos** para performance
- ✅ **Relacionamentos** com integridade referencial

### Baseado em:
- Análise do sistema SIC (sistema legado em Paradox)
- Simplificação das 170 tabelas para 40 tabelas normalizadas
- Mantidas as principais funcionalidades (especialmente estoque)

---

## 2. 🗂️ Estrutura de Pastas Criadas

```
c:\Users\Eroni\Desktop\winsic\
├── ANALISE_BANCOS_DADOS.md                    (análise do sistema antigo)
├── ESTRUTURA_TABELAS_NOVO_SISTEMA.sql         (SQL CREATE TABLE)
├── DICIONARIO_DADOS_E_DIAGRAMA.md             (documentação e diagrama ER)
└── EXEMPLOS_DADOS_INSERCAO.sql                (dados de teste)
```

---

## 3. 🚀 Passos para Implementação

### Passo 1: Escolher a Plataforma de Banco de Dados

| Banco | Vantagens | Desvantagens |
|-------|-----------|--------------|
| **SQL Server 2022+** | Integração Windows, segurança, performance | Licença cara |
| **MySQL 8.0+** | Open source, escalável, popular | Menos recursos para grandes volumes |
| **PostgreSQL 14+** | Robusto, open source, avançado | Requer mais configuração |
| **SQLite** | Simples, sem instalação, teste | Não ideal para múltiplos usuários |

**Recomendação para este projeto:** SQL Server (já que está em Windows)

### Passo 2: Preparar o Ambiente

#### SQL Server:
```powershell
# Instalar SQL Server Express (gratuito até 10GB)
# Download: https://www.microsoft.com/pt-br/sql-server/sql-server-2022

# Instalar SQL Server Management Studio (SSMS)
# Download: https://learn.microsoft.com/pt-br/sql/ssms/

# Criar um novo banco de dados
CREATE DATABASE SIC_NOVO;
USE SIC_NOVO;
```

#### MySQL:
```bash
# Instalar via package manager
sudo apt-get install mysql-server

# Criar banco de dados
mysql -u root -p
CREATE DATABASE sic_novo;
USE sic_novo;
```

#### PostgreSQL:
```bash
# Instalar PostgreSQL
sudo apt-get install postgresql postgresql-contrib

# Criar banco de dados
sudo -u postgres psql
CREATE DATABASE sic_novo;
\c sic_novo;
```

### Passo 3: Executar os Scripts

#### SQL Server:
```sql
-- Abrir SSMS
-- Conectar no servidor local
-- Criar novo database: SIC_NOVO
-- Abrir a file: ESTRUTURA_TABELAS_NOVO_SISTEMA.sql
-- Executar (F5 ou Ctrl+Shift+E)
-- Depois executar: EXEMPLOS_DADOS_INSERCAO.sql
```

#### MySQL/PostgreSQL:
```bash
# Terminal
mysql -u root -p sic_novo < ESTRUTURA_TABELAS_NOVO_SISTEMA.sql
mysql -u root -p sic_novo < EXEMPLOS_DADOS_INSERCAO.sql
```

---

## 4. 📊 Principais Tabelas Explicadas

### 🔝 Estoque (Núcleo do Sistema)

```
tbl_produto
├── Identificação única (código, barras)
├── Preços dinâmicos (custo, tabela, venda)
├── Controle de quantidade
├── BLOB para imagens (até 35MB)
└── Ligações com:
    ├── tbl_categoria_produto
    ├── tbl_unidade_medida
    └── tbl_fornecedor

tbl_estoque_movimento (CRUCIAL)
├── Rastreabilidade 100% de cada mudança
├── Tipos de movimento
├── Quantidade anterior e final (auditoria)
├── Timestamp de quando
└── Quem fez (id_usuario)

tbl_inventario_cabecalho/detalhe
├── Inventário periódico
├── Comparação: quantidade_sistema vs quantidade_fisico
└── Diferenças identificadas
```

**Por que é importante:**
- Controle total do estoque
- Rastreabilidade legal/fiscal
- Detecção de furtos ou erros
- Base para reordenação automática

---

### 💰 Financeiro (Fluxo de Caixa)

```
Pedido → Nota_Fiscal → Contas_Receber → Caixa
                            ↓
                      Forma_Pagamento
                            ↓
                      Cheque/Banco
```

**Tabelas principais:**
- `tbl_contas_receber` - Duplicatas e prazo
- `tbl_cheque` - Controle de cheques
- `tbl_caixa` - Fechamento diário
- `tbl_caixa_movimento` - Detalhe de movimentos

---

### 👥 Clientes e Vendas

```
Cliente
├── Tipo: PF ou PJ
├── Limite de crédito
├── Dias de prazo padrão
├── Múltiplos contatos
└── Vinculado a:
    ├── Pedidos
    ├── Orçamentos
    ├── Contas a receber
    └── Atendimentos
```

---

## 5. ✅ Verificações de Integridade

### Antes de usar em produção:

```sql
-- 1. Verificar contagem de registros
SELECT 'tbl_usuario' as Tabela, COUNT(*) as Registros FROM tbl_usuario
UNION ALL
SELECT 'tbl_cliente', COUNT(*) FROM tbl_cliente
UNION ALL
SELECT 'tbl_produto', COUNT(*) FROM tbl_produto
UNION ALL
SELECT 'tbl_pedido_cabecalho', COUNT(*) FROM tbl_pedido_cabecalho
ORDER BY Tabela;

-- 2. Verificar relacionamentos órfãos
-- Pedidos sem cliente
SELECT p.id_pedido, p.numero_pedido
FROM tbl_pedido_cabecalho p
WHERE NOT EXISTS (SELECT 1 FROM tbl_cliente c WHERE c.id_cliente = p.id_cliente);

-- 3. Verificar estoque negativo (nunca deve acontecer!)
SELECT id_produto, estoque_atual
FROM tbl_produto
WHERE estoque_atual < 0;

-- 4. Verificar contas_receber com erro
SELECT id_conta_receber
FROM tbl_contas_receber
WHERE valor_total_devido <> (valor_original + valor_juros - valor_desconto);

-- 5. Verificar duplicatas no caixa
SELECT id_caixa_movimento
FROM tbl_caixa_movimento
GROUP BY id_caixa_movimento, valor_movimento, data_movimento
HAVING COUNT(*) > 1;
```

---

## 6. 🔒 Segurança

### Recomendações importantes:

#### 1. Backup Automático
```sql
-- SQL Server: Configurar backup diário
-- MySQL: Usar mysqldump
mysqldump -u root -p sic_novo > sic_novo_backup_$(date +%Y%m%d).sql
```

#### 2. Usuários do Banco
```sql
-- Criar usuário específico (não usar sa ou root)
-- SQL Server
CREATE LOGIN usuario_sic WITH PASSWORD = 'Senha_Forte_123!';
CREATE USER usuario_sic FOR LOGIN usuario_sic;
GRANT SELECT, INSERT, UPDATE, DELETE ON DATABASE::SIC_NOVO TO usuario_sic;

-- MySQL
CREATE USER 'usuario_sic'@'localhost' IDENTIFIED BY 'Senha_Forte_123!';
GRANT ALL PRIVILEGES ON sic_novo.* TO 'usuario_sic'@'localhost';
FLUSH PRIVILEGES;
```

#### 3. Criptografia
```sql
-- Armazenar senhas hash (NEVER plaintext!)
-- Usar: bcrypt, PBKDF2, ou Argon2

-- Exemplo: Função para hash
-- Em aplicação (C#, Python, etc.):
-- senha_hash = Hash.BCrypt("minha_senha")
```

#### 4. Auditoria
```sql
-- Campo data_atualizacao em todas as tabelas
-- Campo id_usuario em tbl_log_sistema
-- Trigger para rastrear UPDATE/DELETE

CREATE TRIGGER trg_auditoria_produto
ON tbl_produto
AFTER UPDATE, DELETE
AS
BEGIN
    INSERT INTO tbl_log_sistema (
        tipo_operacao, tabela_afetada, descricao_operacao, data_operacao
    )
    SELECT 
        CASE WHEN EXISTS(SELECT 1 FROM inserted) AND EXISTS(SELECT 1 FROM deleted) 
             THEN 'UPDATE'
             WHEN EXISTS(SELECT 1 FROM deleted) THEN 'DELETE'
             ELSE 'INSERT' END,
        'tbl_produto',
        'Modificação em tbl_produto',
        GETDATE();
END;
```

---

## 7. 🔧 Triggers Recomendadas

### Trigger 1: Atualizar saldo ao receber
```sql
CREATE TRIGGER trg_atualizar_saldo_contas_receber
ON tbl_contas_receber
AFTER UPDATE
AS
BEGIN
    -- Se status_pagamento mudou para 'PAGO'
    -- Atualizar saldo de banco
    UPDATE tbl_banco
    SET saldo_atual = saldo_atual + i.valor_pago
    FROM inserted i
    WHERE EXISTS (
        SELECT 1 FROM inserted
        WHERE status_pagamento = 'PAGO'
    );
END;
```

### Trigger 2: Controlar estoque em vendas
```sql
CREATE TRIGGER trg_reduzir_estoque_pedido
ON tbl_pedido_detalhe
AFTER INSERT
AS
BEGIN
    -- Reduzir estoque ao confirmar pedido
    UPDATE tbl_produto
    SET estoque_atual = estoque_atual - i.quantidade_pedida
    FROM inserted i
    WHERE tbl_produto.id_produto = i.id_produto;
    
    -- Registrar movimento
    INSERT INTO tbl_estoque_movimento (
        id_produto, tipo_movimento, quantidade_movimento,
        motivo_movimento, id_usuario
    )
    SELECT 
        id_produto, 'SAIDA', quantidade_pedida,
        CONCAT('Pedido ', (SELECT numero_pedido FROM tbl_pedido_cabecalho 
                          WHERE id_pedido = i.id_pedido)),
        1
    FROM inserted i;
END;
```

### Trigger 3: Alertas de estoque mínimo
```sql
CREATE TRIGGER trg_alerta_estoque_minimo
ON tbl_estoque_movimento
AFTER INSERT
AS
BEGIN
    -- Se estoque_atual < quantidade_minima
    -- Inserir aviso em log
    INSERT INTO tbl_log_sistema (
        tipo_operacao, tabela_afetada, descricao_operacao
    )
    SELECT 
        'ALERTA',
        'tbl_produto',
        CONCAT('ATENÇÃO: Produto ', p.nome_produto, 
               ' está com estoque (', p.estoque_atual, 
               ') abaixo do mínimo (', p.quantidade_minima, ')')
    FROM tbl_produto p
    WHERE p.estoque_atual < p.quantidade_minima;
END;
```

---

## 8. 📈 Views Úteis

### View 1: Dashboard de Vendas
```sql
CREATE VIEW vw_dashboard_vendas AS
SELECT 
    COUNT(DISTINCT p.id_pedido) as total_pedidos,
    SUM(p.valor_total) as valor_total_vendas,
    COUNT(DISTINCT p.id_cliente) as clientes_unicos,
    AVG(p.valor_total) as ticket_medio,
    CAST(GETDATE() AS DATE) as data_relatorio
FROM tbl_pedido_cabecalho p
WHERE MONTH(p.data_pedido) = MONTH(GETDATE())
AND YEAR(p.data_pedido) = YEAR(GETDATE());
```

### View 2: Estoque Crítico
```sql
CREATE VIEW vw_estoque_critico AS
SELECT 
    p.id_produto,
    p.codigo_interno,
    p.nome_produto,
    p.estoque_atual,
    p.quantidade_minima,
    cp.nome_categoria,
    (p.quantidade_minima - p.estoque_atual) as quantidade_faltante,
    (p.quantidade_minima - p.estoque_atual) * p.preco_custo as valor_faltante
FROM tbl_produto p
JOIN tbl_categoria_produto cp ON p.id_categoria = cp.id_categoria
WHERE p.estoque_atual < p.quantidade_minima
AND p.ativo = 1
ORDER BY valor_faltante DESC;
```

### View 3: Contas Vencidas
```sql
CREATE VIEW vw_contas_vencidas AS
SELECT 
    cr.numero_documento,
    c.nome_cliente,
    cr.valor_total_devido,
    cr.data_vencimento,
    DATEDIFF(DAY, cr.data_vencimento, GETDATE()) as dias_atraso,
    cr.dias_atraso * (cr.valor_total_devido * 0.01) as juros_estimado
FROM tbl_contas_receber cr
JOIN tbl_cliente c ON cr.id_cliente = c.id_cliente
WHERE cr.status_pagamento IN ('ABERTO', 'VENCIDO')
AND cr.data_vencimento < GETDATE()
ORDER BY dias_atraso DESC;
```

---

## 9. 🔄 Migração do Sistema Antigo

### Estratégia de migração (Paradox → SQL):

#### Fase 1: Preparação
```
1. Backup completo do sistema antigo
2. Análise estrutural (já feita!)
3. Criar mapa de conversão de tipos
```

#### Fase 2: Extração
```
1. Exportar Paradox → CSV ou Access
2. Validar dados
3. Corrigir inconsistências
```

#### Fase 3: Transformação
```
1. Mapear campos antigos → novos
2. Consolidar tabelas duplicadas
3. Validar relacionamentos
```

#### Fase 4: Carga
```
1. Inserir dados no novo banco
2. Verificar integridade
3. Validar totais
```

#### Fase 5: Teste
```
1. Testes de funcionalidade
2. Performance check
3. Teste de usuários finais
```

---

## 10. 📋 Checklist de Implementação

- [ ] Banco de dados criado e acessível
- [ ] Todas as 40 tabelas criadas
- [ ] Índices criados (20 índices)
- [ ] Dados de exemplo inseridos
- [ ] Triggers configurados
- [ ] Views criadas
- [ ] Backup automático configurado
- [ ] Usuários e permissões definidos
- [ ] Testes de integridade executados
- [ ] Documentação atualizada
- [ ] Treinamento de usuários
- [ ] Go-live do sistema

---

## 11. 📞 Suporte e Documentação

### Documentos criados:
1. `ANALISE_BANCOS_DADOS.md` - Análise do sistema antigo
2. `ESTRUTURA_TABELAS_NOVO_SISTEMA.sql` - DDL completo
3. `DICIONARIO_DADOS_E_DIAGRAMA.md` - Diagrama ER e descrições
4. `EXEMPLOS_DADOS_INSERCAO.sql` - Dados de teste
5. Este arquivo - Guia de implementação

### Contatos técnicos:
- Documentação SQL: Microsoft SQL Docs
- MySQL: dev.mysql.com
- PostgreSQL: postgresql.org

---

## 12. 💡 Dicas de Performance

### Índices
```sql
-- Já criados para as principais consultas
-- Considerar adicionar índices em:
-- - Campos de busca frequente
-- - Campos de JOINs
-- - Campos ORDER BY

-- Exemplo:
CREATE INDEX idx_produto_nome ON tbl_produto(nome_produto);
CREATE INDEX idx_pedido_cliente_data ON tbl_pedido_cabecalho(id_cliente, data_pedido);
```

### Particionamento (para grandes volumes)
```sql
-- Se estoque_movimento crescer muito:
-- Particionar por ano/mês
-- Arquivar dados antigos

ALTER TABLE tbl_estoque_movimento
ADD CONSTRAINT pk_est_mov_mes 
CHECK (MONTH(data_movimento) BETWEEN 1 AND 12);
```

### Limpeza de dados
```sql
-- Remover logs antigos (> 1 ano)
DELETE FROM tbl_log_sistema
WHERE data_operacao < DATEADD(YEAR, -1, GETDATE());

-- Arquivar pedidos fechados (> 2 anos)
-- (Implementar com cuidado!)
```

---

## 13. 🎓 Próximos Passos

### Depois da implementação do banco:

1. **Backend (API)**
   - C#/ASP.NET Core
   - Node.js/Express
   - Python/FastAPI

2. **Frontend**
   - Windows Forms / WPF (desktop)
   - Web (React, Angular, Vue)
   - Mobile (Android, iOS)

3. **Relatórios**
   - SSRS (SQL Server Reporting Services)
   - Crystal Reports
   - Power BI

4. **Integração**
   - NF-e (Nota Fiscal Eletrônica)
   - Sintegra (Integração Fiscal)
   - ERP externo

---

*Documento de implementação - Dezembro 2025*
*Baseado na análise do sistema SIC*
