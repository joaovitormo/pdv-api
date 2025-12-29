# 🔗 MAPA COMPLETO DE RELACIONAMENTOS

## 🎯 Todos os Foreign Keys do Sistema

```
MÓDULO DE CONFIGURAÇÃO
═══════════════════════════════════════════════════════════════

tbl_log_sistema
├── id_usuario → tbl_usuario (FK)

MÓDULO DE CADASTRO BÁSICO
═══════════════════════════════════════════════════════════════

tbl_fornecedor
├── id_cidade → tbl_cidade (FK)

tbl_feriado
└── [Sem dependências externas]

MÓDULO DE CLIENTES
═══════════════════════════════════════════════════════════════

tbl_cliente
├── id_cidade → tbl_cidade (FK)

tbl_cliente_contato
├── id_cliente → tbl_cliente (FK) [ON DELETE CASCADE]

MÓDULO DE RH
═══════════════════════════════════════════════════════════════

tbl_funcionario
├── id_funcao → tbl_funcao_cbo (FK)
├── id_cidade → tbl_cidade (FK)

tbl_vendedor
├── id_funcionario → tbl_funcionario (FK)

tbl_agendamento
├── id_cliente → tbl_cliente (FK)
├── id_funcionario → tbl_funcionario (FK)
├── id_usuario_responsavel → tbl_usuario (FK)

MÓDULO DE ESTOQUE ⭐⭐⭐
═══════════════════════════════════════════════════════════════

tbl_produto (CENTRO DO MÓDULO)
├── id_categoria → tbl_categoria_produto (FK)
├── id_unidade → tbl_unidade_medida (FK)
├── id_fornecedor → tbl_fornecedor (FK)

tbl_estoque_movimento (RASTREABILIDADE)
├── id_produto → tbl_produto (FK)
├── id_usuario → tbl_usuario (FK)

tbl_inventario_cabecalho
├── id_usuario → tbl_usuario (FK)

tbl_inventario_detalhe
├── id_inventario → tbl_inventario_cabecalho (FK)
├── id_produto → tbl_produto (FK)

MÓDULO DE VENDAS
═══════════════════════════════════════════════════════════════

tbl_pedido_cabecalho
├── id_serie → tbl_serie_pedido (FK)
├── id_cliente → tbl_cliente (FK)
├── id_usuario_vendedor → tbl_usuario (FK)

tbl_pedido_detalhe
├── id_pedido → tbl_pedido_cabecalho (FK) [ON DELETE CASCADE]
├── id_produto → tbl_produto (FK)

MÓDULO DE ORÇAMENTOS
═══════════════════════════════════════════════════════════════

tbl_orcamento_cabecalho
├── id_cliente → tbl_cliente (FK)
├── id_usuario_vendedor → tbl_usuario (FK)

tbl_orcamento_detalhe
├── id_orcamento → tbl_orcamento_cabecalho (FK) [ON DELETE CASCADE]
├── id_produto → tbl_produto (FK)

MÓDULO FINANCEIRO
═══════════════════════════════════════════════════════════════

tbl_contas_receber
├── id_cliente → tbl_cliente (FK)
├── id_pedido → tbl_pedido_cabecalho (FK)
├── id_forma_pagamento → tbl_forma_pagamento (FK)

tbl_cheque
├── id_banco → tbl_banco (FK)
├── id_cliente → tbl_cliente (FK)

tbl_caixa
├── id_usuario_caixa → tbl_usuario (FK)

tbl_caixa_movimento
├── id_caixa → tbl_caixa (FK)
├── id_forma_pagamento → tbl_forma_pagamento (FK)
├── id_usuario_operador → tbl_usuario (FK)

MÓDULO DE ATENDIMENTO
═══════════════════════════════════════════════════════════════

tbl_atendimento
├── id_cliente → tbl_cliente (FK)
├── id_usuario_atendente → tbl_usuario (FK)

tbl_atendimento_followup
├── id_atendimento → tbl_atendimento (FK) [ON DELETE CASCADE]
├── id_usuario → tbl_usuario (FK)

MÓDULO DE COMISSÕES
═══════════════════════════════════════════════════════════════

tbl_comissao
├── id_vendedor → tbl_vendedor (FK)

MÓDULO DE DOCUMENTOS FISCAIS
═══════════════════════════════════════════════════════════════

tbl_nota_fiscal
├── id_nf_serie → tbl_nota_fiscal_serie (FK)
├── id_cliente → tbl_cliente (FK)
├── id_pedido → tbl_pedido_cabecalho (FK)

MÓDULO DE TRANSPORTE
═══════════════════════════════════════════════════════════════

tbl_transportadora
├── id_cidade → tbl_cidade (FK)

tbl_vale_transporte
├── id_funcionario → tbl_funcionario (FK)
├── id_transportadora → tbl_transportadora (FK)

```

---

## 🌐 Visão Gráfica de Relacionamentos

### Centro: tbl_usuario
```
                    ┌──────────────┐
                    │ tbl_usuario  │
                    └──────┬───────┘
         ┌──────────────────┼──────────────────┬──────────────────┐
         │                  │                  │                  │
    tbl_log_sistema    tbl_pedido_        tbl_atendimento   tbl_caixa
                      cabecalho             tbl_atendimento_  tbl_estoque_
                      tbl_inventario_       followup          movimento
                      cabecalho             tbl_agendamento   tbl_inventario_
                      tbl_orcamento_        tbl_caixa_        cabecalho
                      cabecalho             movimento
```

### Centro: tbl_cliente
```
                    ┌──────────────┐
                    │ tbl_cliente  │
                    └──────┬───────┘
         ┌──────────────────┼──────────────────┬──────────────────┬──────────────┐
         │                  │                  │                  │              │
   tbl_cliente_        tbl_pedido_        tbl_contas_        tbl_atendimento  tbl_cheque
   contato            cabecalho          receber             tbl_orcamento_
                      tbl_agendamento                        cabecalho
                      tbl_nota_fiscal                        tbl_nota_fiscal
```

### Centro: tbl_produto
```
                    ┌──────────────┐
                    │ tbl_produto  │
                    └──────┬───────┘
         ┌──────────────────┼──────────────────┬──────────────────┐
         │                  │                  │                  │
   tbl_categoria_      tbl_unidade_        tbl_fornecedor   tbl_estoque_
   produto            medida                               movimento
                                                          tbl_pedido_
                                                          detalhe
                                                          tbl_orcamento_
                                                          detalhe
                                                          tbl_inventario_
                                                          detalhe
```

### Centro: tbl_pedido_cabecalho
```
                 ┌──────────────────────┐
                 │ tbl_pedido_cabecalho │
                 └──────┬───────────────┘
      ┌──────────────────┼──────────────────┬──────────────────┐
      │                  │                  │                  │
 tbl_pedido_        tbl_contas_        tbl_nota_fiscal    tbl_serie_
 detalhe           receber                               pedido
                   tbl_cliente
                   tbl_usuario_vendedor
                   tbl_serie_pedido
```

---

## 📊 Tabelas Mais Conectadas

```
Ranking de Relacionamentos (Foreign Keys):

1. tbl_usuario                 → 9 referências
   ├─ tbl_log_sistema (1)
   ├─ tbl_pedido_cabecalho (1)
   ├─ tbl_estoque_movimento (1)
   ├─ tbl_inventario_cabecalho (1)
   ├─ tbl_orcamento_cabecalho (1)
   ├─ tbl_caixa (1)
   ├─ tbl_atendimento (1)
   ├─ tbl_atendimento_followup (1)
   └─ tbl_caixa_movimento (1)

2. tbl_cliente                 → 8 referências
   ├─ tbl_cliente_contato (1)
   ├─ tbl_pedido_cabecalho (1)
   ├─ tbl_contas_receber (1)
   ├─ tbl_cheque (1)
   ├─ tbl_atendimento (1)
   ├─ tbl_orcamento_cabecalho (1)
   ├─ tbl_agendamento (1)
   └─ tbl_nota_fiscal (1)

3. tbl_produto                 → 6 referências
   ├─ tbl_pedido_detalhe (1)
   ├─ tbl_orcamento_detalhe (1)
   ├─ tbl_estoque_movimento (1)
   ├─ tbl_inventario_detalhe (1)
   ├─ tbl_categoria_produto (1)
   └─ tbl_unidade_medida (1)
   └─ tbl_fornecedor (1)

4. tbl_pedido_cabecalho        → 4 referências
   ├─ tbl_pedido_detalhe (1)
   ├─ tbl_contas_receber (1)
   └─ tbl_nota_fiscal (1)

5. tbl_cidade                  → 4 referências
   ├─ tbl_cliente (1)
   ├─ tbl_fornecedor (1)
   ├─ tbl_funcionario (1)
   └─ tbl_transportadora (1)

6. tbl_funcionario             → 3 referências
   ├─ tbl_vendedor (1)
   ├─ tbl_agendamento (1)
   └─ tbl_vale_transporte (1)

7. tbl_forma_pagamento         → 2 referências
   ├─ tbl_contas_receber (1)
   └─ tbl_caixa_movimento (1)

[Demais tabelas com 0-1 referência]
```

---

## 🔄 Fluxos de Dados Por Módulo

### FLUXO 1: Venda (Cliente → Pagamento)
```
tbl_cliente
    ↓
tbl_pedido_cabecalho (referencia cliente + vendedor)
    ↓
tbl_pedido_detalhe (referencia produto)
    ↓
tbl_estoque_movimento (SAIDA automatizada)
    ↓
tbl_nota_fiscal (referencia pedido + cliente)
    ↓
tbl_contas_receber (referencia cliente + pedido + forma_pagamento)
    ↓
tbl_caixa + tbl_caixa_movimento (referencia forma_pagamento)
    ↓
tbl_banco ou tbl_cheque (finalização)
```

### FLUXO 2: Compra (Fornecedor → Estoque)
```
tbl_fornecedor
    ↓
tbl_produto (referencia fornecedor + categoria + unidade)
    ↓
tbl_estoque_movimento (ENTRADA)
    ↓
tbl_inventario_cabecalho + detalhe (validação)
```

### FLUXO 3: Orçamento (Sem estoque)
```
tbl_cliente
    ↓
tbl_orcamento_cabecalho (referencia cliente + vendedor)
    ↓
tbl_orcamento_detalhe (referencia produto)
    ↓
[Sem movimento de estoque automático]
    ↓
[Se convertido para venda → tbl_pedido_cabecalho]
```

### FLUXO 4: Atendimento
```
tbl_cliente
    ↓
tbl_atendimento (referencia cliente + atendente)
    ↓
tbl_atendimento_followup (referencia atendimento + usuario)
    ↓
[Resolvido ou reopened]
```

---

## 🔒 Integridade Referencial

### Configuração de Cascata

**ON DELETE CASCADE:**
- tbl_cliente_contato (deleta contatos ao deletar cliente)
- tbl_pedido_detalhe (deleta itens ao deletar pedido)
- tbl_orcamento_detalhe (deleta itens ao deletar orçamento)
- tbl_atendimento_followup (deleta followups ao deletar atendimento)

**Comportamento padrão (RESTRICT):**
- Outras tabelas: impede delete se houver registros dependentes

**Recomendação:**
Use RESTRICT para tabelas críticas (estoque, financeiro)
Use CASCADE para detalhe (itens de pedido)

---

## 🎯 Consultas de Validação

### Verificar Integridade de Relacionamentos

```sql
-- 1. Clientes órfãos em pedidos
SELECT p.id_pedido FROM tbl_pedido_cabecalho p
WHERE NOT EXISTS (SELECT 1 FROM tbl_cliente c WHERE c.id_cliente = p.id_cliente);

-- 2. Produtos órfãos em pedido_detalhe
SELECT pd.id_detalhe_pedido FROM tbl_pedido_detalhe pd
WHERE NOT EXISTS (SELECT 1 FROM tbl_produto p WHERE p.id_produto = pd.id_produto);

-- 3. Usuários órfãos em log
SELECT l.id_log FROM tbl_log_sistema l
WHERE NOT EXISTS (SELECT 1 FROM tbl_usuario u WHERE u.id_usuario = l.id_usuario);

-- 4. Contar todas as referências por tabela
SELECT 
    OBJECT_NAME(parent_object_id) as tabela,
    COUNT(*) as quantidade_referencias
FROM sys.foreign_keys
GROUP BY parent_object_id
ORDER BY quantidade_referencias DESC;
```

---

## 📈 Densidade de Relacionamentos

```
Tabelas "Hub" (mais conectadas):
  tbl_usuario          ███████████░░░░░ (9 refs)
  tbl_cliente          ████████░░░░░░░░ (8 refs)
  tbl_produto          ██████░░░░░░░░░░ (6 refs)
  tbl_pedido_cabeçalho ████░░░░░░░░░░░░ (4 refs)
  tbl_cidade           ████░░░░░░░░░░░░ (4 refs)

Tabelas "Folha" (menos conectadas):
  tbl_categoria_produto
  tbl_unidade_medida
  tbl_feriado
  tbl_forma_pagamento
  tbl_transportadora
```

---

## ✅ Checklist de Relacionamentos

- [ ] Todas as Foreign Keys estão corretas
- [ ] Não existem órfãos no banco
- [ ] Cascata de delete está configurada corretamente
- [ ] Índices nas FKs para performance
- [ ] Constraints de integridade ativas
- [ ] Sem loops circulares
- [ ] Documentação de relacionamentos atualizada

---

## 🎓 Exemplo: Nova Venda Completa

```
1. Cliente entra no sistema
   → tbl_cliente (id=1)

2. Vendedor cria pedido
   → tbl_pedido_cabecalho (id_cliente=1, id_usuario_vendedor=2)
   
3. Adiciona 2 itens
   → tbl_pedido_detalhe (id_pedido=X, id_produto=A)
   → tbl_pedido_detalhe (id_pedido=X, id_produto=B)
   
4. Estoque é reduzido automaticamente (TRIGGER)
   → tbl_estoque_movimento (id_produto=A, tipo=SAIDA)
   → tbl_estoque_movimento (id_produto=B, tipo=SAIDA)
   
5. Nota fiscal é emitida
   → tbl_nota_fiscal (id_cliente=1, id_pedido=X)
   
6. Duplicata é criada
   → tbl_contas_receber (id_cliente=1, id_pedido=X, id_forma_pagamento=5)
   
7. Recebimento no caixa
   → tbl_caixa (id_usuario_caixa=3)
   → tbl_caixa_movimento (id_caixa=Y, id_forma_pagamento=5)
   
8. Deposita em banco
   → tbl_banco (saldo_atual += valor)
   
9. Comissão do vendedor
   → tbl_comissao (id_vendedor=2, valor_total_vendas += total)

Relacionamentos envolvidos: 15 tabelas!
```

---

## 🔍 Mapa de Navegação

Para entender um relacionamento específico:

```
Buscar: "tbl_nomeDaTabela" em:

ESTRUTURA_TABELAS_NOVO_SISTEMA.sql
  └─ Ver CREATE TABLE
  └─ Ver FOREIGN KEY

DICIONARIO_DADOS_E_DIAGRAMA.md
  └─ Ver descrição da tabela
  └─ Ver relacionamentos

EXEMPLOS_DADOS_INSERCAO.sql
  └─ Ver exemplo de INSERT
  └─ Ver como preencher as FKs

ESTE ARQUIVO (MAPA_RELACIONAMENTOS.md)
  └─ Ver todas as conexões
  └─ Ver fluxos de dados
```

---

*Mapa completo de relacionamentos do Sistema SIC Novo*  
*Data: 23 de Dezembro de 2025*  
*Total de Foreign Keys: 45+*
