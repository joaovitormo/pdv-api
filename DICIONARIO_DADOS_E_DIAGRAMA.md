# Diagrama e Estrutura do Sistema Novo

## 📊 Diagrama de Entidades (ER)

```
┌──────────────────────────────────────────────────────────────────┐
│                      SISTEMA DE GESTÃO SIC                       │
│                        Estrutura Simplificada                     │
└──────────────────────────────────────────────────────────────────┘

                          ╔════════════════╗
                          ║  tbl_usuario   ║
                          ╚════════════════╝
                                  │
                    ┌─────────────┼─────────────┐
                    │             │             │
                    ▼             ▼             ▼
            ┌─────────────┐ ┌────────────┐ ┌─────────────┐
            │ tbl_cliente │ │ tbl_pedido_│ │ tbl_log_    │
            │             │ │cabecalho   │ │sistema      │
            └─────────────┘ └────────────┘ └─────────────┘
                    │             │
                    │       ┌─────┴──────┐
                    │       │            │
                    │       ▼            ▼
                    │  ┌──────────┐  ┌─────────────┐
                    │  │tbl_pedido│  │tbl_contas_  │
                    │  │detalhe   │  │receber      │
                    │  └──────────┘  └─────────────┘
                    │       │
                    │       └──────────┬────────────┐
                    │                  │            │
                    ▼                  ▼            ▼
            ┌─────────────────────────────────────────────┐
            │       MÓDULO DE ESTOQUE (MAIOR)            │
            ├─────────────────────────────────────────────┤
            │  ┌───────────────┐    ┌──────────────────┐ │
            │  │ tbl_produto   │◄───┤tbl_categoria_    │ │
            │  │               │    │produto           │ │
            │  │ - id_produto  │    └──────────────────┘ │
            │  │ - codigo_*    │    ┌──────────────────┐ │
            │  │ - nome        │◄───┤tbl_unidade_      │ │
            │  │ - precos      │    │medida            │ │
            │  │ - estoque_*   │    └──────────────────┘ │
            │  │ - imagem      │    ┌──────────────────┐ │
            │  │ - observ.     │◄───┤tbl_fornecedor    │ │
            │  └───────────────┘    └──────────────────┘ │
            │         │                                  │
            │   ┌─────┴─────┐                            │
            │   │           │                            │
            │   ▼           ▼                            │
            │ ┌──────────────────┐ ┌────────────────┐   │
            │ │tbl_estoque_      │ │tbl_inventario_│   │
            │ │movimento         │ │cabecalho       │   │
            │ │ RASTREABILIDADE  │ └────────────────┘   │
            │ └──────────────────┘        │              │
            │                             ▼              │
            │                    ┌────────────────┐      │
            │                    │tbl_inventario_ │      │
            │                    │detalhe         │      │
            │                    └────────────────┘      │
            └─────────────────────────────────────────────┘
                    │
        ┌───────────┼───────────┐
        │           │           │
        ▼           ▼           ▼
   ┌─────────┐ ┌──────────┐ ┌──────────┐
   │tbl_     │ │tbl_      │ │tbl_      │
   │orcamento│ │comissao  │ │atendimen-│
   │_cabeca. │ │          │ │to        │
   └─────────┘ └──────────┘ └──────────┘
        │           │           │
        ▼           ▼           ▼
   ┌─────────┐ ┌──────────┐ ┌──────────┐
   │tbl_     │ │tbl_      │ │tbl_      │
   │orcamento│ │vendedor  │ │atendimen-│
   │_detalhe │ │          │ │to_follow-│
   └─────────┘ └──────────┘ │up        │
                            └──────────┘

        ┌────────────────────────────┐
        │   MÓDULO FINANCEIRO        │
        ├────────────────────────────┤
        │  ┌──────────────────────┐  │
        │  │tbl_forma_pagamento   │  │
        │  └──────────────────────┘  │
        │           │                │
        │   ┌───────┼────────┐       │
        │   │       │        │       │
        │   ▼       ▼        ▼       │
        │ ┌──────┐ ┌──────┐ ┌──────┐ │
        │ │tbl_  │ │tbl_  │ │tbl_  │ │
        │ │contas│ │cheque│ │caixa │ │
        │ │recb. │ │      │ │      │ │
        │ └──────┘ └──────┘ └──────┘ │
        │                        │   │
        │                        ▼   │
        │                    ┌──────┐│
        │                    │tbl_  ││
        │                    │caixa_││
        │                    │movim.││
        │                    └──────┘│
        └────────────────────────────┘
              │          │
              ▼          ▼
        ┌──────────┐ ┌──────────┐
        │tbl_banco │ │tbl_      │
        │          │ │agendamen-│
        │          │ │to        │
        └──────────┘ └──────────┘

        ┌────────────────────────────┐
        │  MÓDULO FISCAL             │
        ├────────────────────────────┤
        │  ┌──────────────────────┐  │
        │  │tbl_nota_fiscal_      │  │
        │  │serie                 │  │
        │  └──────────────────────┘  │
        │           │                │
        │           ▼                │
        │  ┌──────────────────────┐  │
        │  │tbl_nota_fiscal       │  │
        │  │ (SAIDA/ENTRADA)      │  │
        │  └──────────────────────┘  │
        └────────────────────────────┘
              │
              ▼
        ┌─────────────────────┐
        │tbl_transportadora   │
        │tbl_vale_transporte  │
        └─────────────────────┘

        ┌─────────────────────┐
        │tbl_cidade (Básico)  │
        │tbl_feriado          │
        │tbl_configuracao     │
        └─────────────────────┘
```

---

## 📋 Categorias de Tabelas (Resumido)

### **1️⃣ CONFIGURAÇÃO E SISTEMA (3 tabelas)**
- `tbl_usuario` - Usuários do sistema
- `tbl_configuracao` - Parâmetros e configurações
- `tbl_log_sistema` - Auditoria de operações

### **2️⃣ CADASTRO BÁSICO (4 tabelas)**
- `tbl_cidade` - Localidades
- `tbl_banco` - Contas bancárias
- `tbl_fornecedor` - Fornecedores
- `tbl_feriado` - Datas especiais

### **3️⃣ GESTÃO DE CLIENTES (2 tabelas)**
- `tbl_cliente` - Clientes principais
- `tbl_cliente_contato` - Contatos adicionais

### **4️⃣ RECURSOS HUMANOS (3 tabelas)**
- `tbl_funcao_cbo` - Funções e CBO
- `tbl_funcionario` - Dados de funcionários
- `tbl_vendedor` - Dados de vendedores
- `tbl_agendamento` - Agendamentos

### **5️⃣ ESTOQUE - PRINCIPAL (9 tabelas) ⭐⭐⭐**
- `tbl_categoria_produto` - Categorias
- `tbl_unidade_medida` - Unidades (KG, UN, L, etc)
- **`tbl_produto`** - Tabela central de estoque
  - Código interno e código de barras
  - Nomes e descrições
  - Preços: custo, tabela, venda
  - Margem de lucro
  - Quantidades: mínima, máxima, atual
  - **Imagem do produto (BLOB/Binário)**
  - Observações e histórico
- `tbl_estoque_movimento` - Rastreabilidade completa
  - Tipos: ENTRADA, SAIDA, AJUSTE, DEVOLUCAO, INVENTARIO
- `tbl_inventario_cabecalho` - Inventário periódico
- `tbl_inventario_detalhe` - Itens do inventário

### **6️⃣ VENDAS/PEDIDOS (3 tabelas)**
- `tbl_serie_pedido` - Séries de numeração
- `tbl_pedido_cabecalho` - Cabeçalho do pedido
  - Tipos: VENDA, ORÇAMENTO, DEVOLUÇÃO
  - Status: ABERTO, CONFIRMADO, FATURADO, ENTREGUE, CANCELADO
  - Descontos, frete, valores
- `tbl_pedido_detalhe` - Itens do pedido

### **7️⃣ ORÇAMENTOS (2 tabelas)**
- `tbl_orcamento_cabecalho` - Cabeçalho de orçamento
  - Status: ABERTO, ENVIADO, APROVADO, REJEITADO, CONVERTIDO, EXPIRADO
  - Data de validade
- `tbl_orcamento_detalhe` - Itens do orçamento

### **8️⃣ FINANCEIRO (6 tabelas)**
- `tbl_forma_pagamento` - Formas (Dinheiro, Cheque, PIX, etc)
- `tbl_contas_receber` - Duplicatas e recebíveis
  - Controle de juros e descontos
  - Acompanhamento de atraso
- `tbl_cheque` - Cheques recebidos/devolvidos
- `tbl_caixa` - Movimentação de caixa diária
- `tbl_caixa_movimento` - Detalhe do caixa

### **9️⃣ ATENDIMENTO (2 tabelas)**
- `tbl_atendimento` - Atendimentos ao cliente
  - Tipos: CONSULTA, RECLAMAÇÃO, SUGESTÃO, DÚVIDA, SUPORTE
  - Prioridade: BAIXA, MEDIA, ALTA, CRÍTICA
- `tbl_atendimento_followup` - Acompanhamento

### **🔟 COMISSÕES E VENDAS (2 tabelas)**
- `tbl_vendedor` - Cadastro de vendedores
  - Percentual de comissão
  - Meta de vendas
- `tbl_comissao` - Cálculo mensal de comissões

### **1️⃣1️⃣ DOCUMENTOS FISCAIS (2 tabelas)**
- `tbl_nota_fiscal_serie` - Séries NF
  - Tipos: SAIDA, ENTRADA, DEVOLUÇÃO
- `tbl_nota_fiscal` - Notas emitidas/recebidas
  - Status: RASCUNHO, EMITIDA, CANCELADA, SUBSTITUÍDA

### **1️⃣2️⃣ TRANSPORTE (2 tabelas)**
- `tbl_transportadora` - Transportadoras
- `tbl_vale_transporte` - Vales de transporte

---

## 🔑 Relacionamentos Principais

### Fluxo de Vendas
```
Cliente → Pedido → Pedido_Detalhe → Produto
                        │
                        └──→ Nota_Fiscal
                              │
                              └──→ Contas_Receber
                                   │
                                   └──→ Caixa
```

### Fluxo de Estoque
```
Fornecedor → Produto ← Categoria
                    ↓
            Estoque_Movimento
                    ↓
            Inventário_Periódico
                    ↓
            Vendas/Pedidos
```

### Fluxo Financeiro
```
Pedido → Nota_Fiscal → Contas_Receber → Caixa
                            ↓
                      Forma_Pagamento
                            ↓
                      Cheque/Banco
```

---

## 📊 Estatísticas da Estrutura

| Categoria | Qtd Tabelas | Descrição |
|-----------|------------|-----------|
| Sistema | 3 | Configuração e logs |
| Cadastro | 4 | Dados básicos |
| Clientes | 2 | Clientes e contatos |
| RH | 3 | Funcionários e funções |
| **Estoque** | **9** | **MÓDULO PRINCIPAL** |
| Vendas | 3 | Pedidos e detalhes |
| Orçamentos | 2 | Orçamentos e itens |
| Financeiro | 6 | Contas, cheques, caixa |
| Atendimento | 2 | Atendimento e follow-up |
| Comissões | 2 | Vendedores e comissões |
| Fiscal | 2 | Notas fiscais |
| Transporte | 2 | Transportadoras e vales |
| **TOTAL** | **40 tabelas** | **Estrutura completa** |

---

## 💾 Campos Principais da Tabela de Produtos

```
tbl_produto
├── Identificação
│   ├── id_produto (PK)
│   ├── codigo_interno (UNIQUE)
│   ├── codigo_barras (UNIQUE)
│   └── nome_produto
├── Descrição
│   ├── descricao_produto (LONG)
│   ├── observacoes_produto (LONG)
│   └── imagem_produto (BINARY/BLOB) ⭐ Até 35MB por produto
├── Classificação
│   ├── id_categoria (FK)
│   ├── id_unidade (FK)
│   └── id_fornecedor (FK)
├── Preços
│   ├── preco_custo
│   ├── preco_tabela
│   ├── preco_venda
│   └── margem_lucro (%)
├── Controle de Estoque
│   ├── estoque_atual
│   ├── quantidade_minima
│   ├── quantidade_maxima
│   └── [Vinculado a tbl_estoque_movimento]
└── Auditoria
    ├── data_cadastro
    ├── data_atualizacao
    └── ativo (BIT)
```

---

## 🔍 Campos Principais do Estoque_Movimento

```
tbl_estoque_movimento (RASTREABILIDADE TOTAL)
├── id_movimento (PK)
├── id_produto (FK)
├── Movimentação
│   ├── tipo_movimento: ENTRADA | SAIDA | AJUSTE | DEVOLUCAO | INVENTARIO
│   ├── quantidade_anterior (Para auditoria)
│   ├── quantidade_movimento (Delta)
│   └── quantidade_final (Resultado)
├── Valor
│   └── preco_unitario
├── Informações
│   ├── motivo_movimento
│   ├── observacao_movimento
│   └── data_movimento (TIMESTAMP)
└── Responsabilidade
    └── id_usuario (Quem fez)
```

---

## ✅ Vantagens da Nova Estrutura

1. **Normalização** - Eliminação de redundância
2. **Relacionamentos** - Integridade referencial via FK
3. **Auditoria** - Log completo de movimentações
4. **Rastreabilidade** - Histórico de estoque
5. **Performance** - Índices estratégicos
6. **Escalabilidade** - Suporta crescimento
7. **Imagens** - Campo BLOB para fotos de produtos
8. **Descontos** - Aplicáveis em nível de pedido e item
9. **Comissões** - Controle mensal de vendedores
10. **Atendimento** - Sistema de follow-up integrado

---

## 🚀 Próximos Passos

1. ✅ **SQL gerado** - Use em SQL Server, MySQL ou PostgreSQL
2. ⏳ **Views** - Criar relatórios principais
3. ⏳ **Stored Procedures** - Automação de processos
4. ⏳ **Triggers** - Atualizar saldos automaticamente
5. ⏳ **Dashboard** - Relatórios de estoque e vendas

---

*Estrutura criada: 23 de Dezembro de 2025*
*Baseado na análise do sistema SIC existente*
