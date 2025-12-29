# Análise de Bancos de Dados - Sistema SIC

**Data da Análise:** 23 de Dezembro de 2025  
**Caminho:** `c:\Users\Eroni\Desktop\winsic`  
**Última atualização dos arquivos:** 17-26 de Julho de 2019

---

## Resumo Executivo

Foram identificados **170 tabelas de banco de dados** (arquivo `.db` e `.PX`), além de **41 arquivos de índice e metadados** (`.mb`, `.XG0-6`, `.YG0-6`). O sistema utiliza **Paradox Database** como engine de dados.

**Arquivos críticos identificados:**
- **1 arquivo `.db` de 35+ MB** - TabEst1.mb (Maior arquivo de dados)
- **6 arquivos `.db` com > 100KB** - Contêm volume significativo de dados
- **Múltiplas tabelas vazias** - Estrutura padrão de 2-4KB

---

## Estrutura de Tipo de Arquivo

### 1. **Arquivos Paradox Nativo (.PX)**
- **Formato:** Bancos de dados Paradox nativo
- **Extensão principal:** `.PX`
- **Quantidade:** 123 tabelas
- **Tamanho típico:** 4-8 KB (estrutura vazia/mínima)
- **Descrição:** Arquivo principal da tabela Paradox

### 2. **Arquivos de Dados (.DB)**
- **Formato:** Archivos de dados Paradox
- **Extensão:** `.db`
- **Quantidade:** 170 tabelas
- **Tamanho:** 2 KB a 35+ MB
- **Descrição:** Contém dados da tabela

### 3. **Arquivos de Memo (.MB)**
- **Formato:** Campos memo/blob de Paradox
- **Extensão:** `.mb`
- **Quantidade:** 41 arquivos
- **Tamanho:** 4-35 MB
- **Descrição:** Armazena campos BLOB, texto longo, imagens

### 4. **Arquivos de Índice (.XG0-6, .YG0-6)**
- **Formato:** Índices secundários Paradox
- **Extensões:** `.XG0`, `.XG1`, `.XG2`, `.XG3`, `.XG4`, `.XG5`, `.XG6`
                `.YG0`, `.YG1`, `.YG2`, `.YG3`, `.YG4`, `.YG5`, `.YG6`
- **Quantidade:** 182 arquivos de índice
- **Descrição:** Índices para aceleração de buscas

### 5. **Arquivo de Cidades (.DB)**
- **Arquivo:** `cidades.db`
- **Tamanho:** 317 KB
- **Função:** Tabela de referência de cidades/localidades
- **Data:** 20/03/2002

---

## Categorias de Tabelas por Função

### **GESTÃO DE ATENDIMENTO**
| Tabela | Tamanho | Descrição |
|--------|---------|-----------|
| TabAgend | 4 KB | Agendamentos |
| TabAtnd1 | 4 KB | Atendimento 1 |
| TabAtnd2 | 2 KB | Atendimento 2 |
| TabAtnd3 | 2 KB | Atendimento 3 |
| TabAtnd4 | 4 KB | Atendimento 4 |

### **GESTÃO COMERCIAL - CLIENTES**
| Tabela | Tamanho | Descrição |
|--------|---------|-----------|
| TabCli | 30 KB | Cliente principal |
| TabCliC | 4 KB | Clientes cadastro |
| TabCliM | 4 KB | Clientes movimento |
| TabCliT | 4 KB | Clientes temporário |

### **GESTÃO COMERCIAL - PEDIDOS**
| Tabela | Tamanho | Descrição |
|--------|---------|-----------|
| TabCP1 | 346 KB | Cabeçalho Pedido 1 |
| TabCP2 | 4 KB | Cabeçalho Pedido 2 |
| TabCP3 | 4 KB | Cabeçalho Pedido 3 |
| TabCpr1 | 4 KB | Complemento Pedido 1 |
| TabCpr2 | 4 KB | Complemento Pedido 2 |

### **GESTÃO COMERCIAL - ORÇAMENTOS**
| Tabela | Tamanho | Descrição |
|--------|---------|-----------|
| TabCAR0 | 4 KB | Carrinho 0 |
| TabCAR1 | 4 KB | Carrinho 1 |
| TabCAR2 | 4 KB | Carrinho 2 |
| TabCART | 4 KB | Carrinho geral |

### **GESTÃO FINANCEIRA - CHEQUES**
| Tabela | Tamanho | Descrição |
|--------|---------|-----------|
| TabChq1 | 4 KB | Cheques 1 |
| TabChq2 | 4 KB | Cheques 2 |

### **GESTÃO FINANCEIRA - CAIXA**
| Tabela | Tamanho | Descrição |
|--------|---------|-----------|
| TabCx1 | 10 KB | Caixa 1 |
| TabCx2 | 4 KB | Caixa 2 |
| TabCx3 | 4 KB | Caixa 3 |
| TabCx4 | 4 KB | Caixa 4 |
| TabBanco | 4 KB | Bancos |

### **GESTÃO FINANCEIRA - CONTAS A RECEBER**
| Tabela | Tamanho | Descrição |
|--------|---------|-----------|
| TabCR1 | 4 KB | Contas a receber 1 |
| TabCR2 | 4 KB | Contas a receber 2 |
| TabCR3 | 4 KB | Contas a receber 3 |
| TabCR4 | 4 KB | Contas a receber 4 |
| TabCR5 | 2 KB | Contas a receber 5 |
| TabCR6 | 2 KB | Contas a receber 6 |

### **GESTÃO FINANCEIRA - COMISSÕES**
| Tabela | Tamanho | Descrição |
|--------|---------|-----------|
| TabComi | 4 KB | Comissões |

### **ESTOQUE/INVENTÁRIO (Maior Volume de Dados)**
| Tabela | Tamanho | Descrição |
|--------|---------|-----------|
| **TabEst1** | **657 KB** | **Estoque 1 - Tabela Gigante** |
| **TabEst1.mb** | **35 MB** | **Dados memo do Estoque 1** |
| TabEst12 | 4 KB | Estoque 1.2 |
| TabEst1s | 4 KB | Estoque 1s |
| TabEst2A | 194 KB | Estoque 2A |
| TabEst2B | 253 KB | Estoque 2B |
| TabEst3A | 397 KB | Estoque 3A |
| TabEst3B | 1,8 MB | Estoque 3B (Segunda maior) |
| TabEst3R | 4 KB | Estoque 3R |
| TabEst3s | 4 KB | Estoque 3s |
| TabEst3Y | 4 KB | Estoque 3Y |
| TabEst3Z | 4 KB | Estoque 3Z |
| TabEst4 | 4 KB | Estoque 4 |
| TabEst5 | 12 KB | Estoque 5 |
| TabEst6 | 4 KB | Estoque 6 |
| TabEst7 | 4 KB | Estoque 7 |
| TabEst8 | 4 KB | Estoque 8 |
| TabEst9 | 4 KB | Estoque 9 |
| TabEst9b | 4 KB | Estoque 9b |

### **CONFIGURAÇÃO & SISTEMA**
| Tabela | Tamanho | Descrição |
|--------|---------|-----------|
| TabConfig1 | 4 KB | Configuração 1 |
| TabConfig2 | 4 KB | Configuração 2 |
| TabUser | 6 KB | Usuários do sistema |

### **RECURSOS HUMANOS**
| Tabela | Tamanho | Descrição |
|--------|---------|-----------|
| TabFun1 | 4 KB | Funcionário 1 |
| TabFun2 | 4 KB | Funcionário 2 |
| TabFun3 | 4 KB | Funcionário 3 |
| TabFun4 | 4 KB | Funcionário 4 |
| TabFun5 | 4 KB | Funcionário 5 |
| TabFun6a | 4 KB | Funcionário 6a |
| TabFun6b | 4 KB | Funcionário 6b |
| TabFunCBO | 4 KB | Função CBO |

### **DOCUMENTOS & NOTAS FISCAIS**
| Tabela | Tamanho | Descrição |
|--------|---------|-----------|
| TabNotaC1 | 4 KB | Nota Conhecimento 1 |
| TabNotaC2 | 4 KB | Nota Conhecimento 2 |
| TabNotaC3 | 4 KB | Nota Conhecimento 3 |
| TabNotaC4 | 4 KB | Nota Conhecimento 4 |
| TabNotaCan | 4 KB | Nota Cancelada |
| TabNotaEm | 4 KB | Nota Emitida |
| TabNotaIn | 4 KB | Nota Inicial |

### **LOGÍSTICA & TRANSPORTE**
| Tabela | Tamanho | Descrição |
|--------|---------|-----------|
| TabTrans | 4 KB | Transportes |
| TabTrocas | 2 KB | Trocas |
| TabVale | 4 KB | Vales |
| TabVend | 4 KB | Vendedor |

### **SUPORTE ECF (Equipamento de Controle Fiscal)**
| Tabela | Tamanho | Descrição |
|--------|---------|-----------|
| TabEcfId | 2 KB | ECF ID |
| TabEcfM1 | 2 KB | ECF Movimento 1 |
| TabEcfM2 | 2 KB | ECF Movimento 2 |
| TabEcfM3 | 2 KB | ECF Movimento 3 |
| TabEcfZ1 | 2 KB | ECF Z 1 |
| TabEcfZ2 | 2 KB | ECF Z 2 |

### **INTEGRAÇÃO SINTEGRA**
| Tabela | Tamanho | Descrição |
|--------|---------|-----------|
| TabSintegra60A | 2 KB | Sintegra 60A |
| TabSintegra60D | 2 KB | Sintegra 60D |
| TabSintegra60I | 2 KB | Sintegra 60I |
| TabSintegra60M | 2 KB | Sintegra 60M |
| TabSintegra60R | 2 KB | Sintegra 60R |

### **OUTROS**
| Tabela | Tamanho | Descrição |
|--------|---------|-----------|
| TabFeriados | 4 KB | Feriados |
| TabFor | 4 KB | Fornecedores |
| TabInv | 4 KB | Inventário |
| TabLog | 112 KB | Log de sistema (+ 331 KB memo) |
| TabMail | 4 KB | Emails |
| TabPDV2 | 4 KB | PDV (Ponto de Venda) 2 |
| TabPDV2b | 2 KB | PDV 2b |
| TabPDV2c | 2 KB | PDV 2c |
| TabPrecoNome | 4 KB | Preço por Nome |
| TabPrecoProd | 2 KB | Preço Produto |
| TabRecad | 4 KB | Recadastramento |
| TabRecib | 4 KB | Recibos |
| TabRede | 4 KB | Rede |
| TabSer | 4 KB | Série |
| cidades | 317 KB | Cidades (Tabela de Referência) |

---

## Arquivos de Índice por Tabela

### Estrutura de Índices (Exemplo TabEst1)
- `TabEst1.PX` - Arquivo principal
- `TabEst1.XG0` - Índice primário
- `TabEst1.XG1` - Índice secundário 1
- `TabEst1.XG2` - Índice secundário 2
- `TabEst1.YG0` - Índice alternativo 0

**Observação:** Nem todas as tabelas possuem todos os índices. A presença de múltiplos índices indica:
- Buscas frequentes por múltiplos campos
- Desempenho otimizado para consultas específicas
- Possível fragmentação de dados

### Tabelas com Mais Índices
| Tabela | Índices | Função |
|--------|---------|--------|
| TabCP1 | 5 (.XG0-4) | Pedidos com múltiplas buscas |
| TabCR1 | 7 (.XG0-6) | Contas a receber - alta complexidade |
| TabEst1 | 4 (.XG0-3) | Estoque principal |
| TabEst3A | 5 (.XG0-4) | Estoque 3A |
| TabChq1 | 5 (.XG0-4) | Cheques |

---

## Dados em Memo (.MB) - Campos Blob

Tabelas com campos memo para texto longo, imagens ou dados binários:

| Tabela | Tamanho MB | Conteúdo Provável |
|--------|----------|------------------|
| **TabEst1.mb** | **35 MB** | **Imagens, descrições, fotos de produtos** |
| TabLog.mb | 331 KB | Logs detalhados |
| TabCP1.mb | Não identificado | Observações de pedidos |
| TabEst3A.mb | 28 KB | Descrições de estoque |
| TabEst2A.mb | Não identificado | Dados alternativos |
| TabConfig1.mb | Não identificado | Configurações complexas |
| TabConfig2.mb | Não identificado | Configurações sistema |
| TabCli.mb | Não identificado | Observações de clientes |
| TabAtnd1.mb | Não identificado | Notas de atendimento |
| TabBanco.mb | Não identificado | Informações de bancos |
| TabCliC.mb | Não identificado | Dados cliente categoria |
| TabComiPX.mb | Não identificado | Comissões detalhes |
| TabCP2.mb | Não identificado | Complementos pedido |
| TabCx1.mb | Não identificado | Movimento caixa |
| TabCpr1.mb | Não identificado | Complementos |
| TabCR1.mb | Não identificado | Detalhes financeiros |
| TabCR2.mb | Não identificado | Detalhes financeiros 2 |
| TabEst4.mb | 8 KB | Estoque alternativo |
| TabFun1.mb | Não identificado | Dados funcionário |
| TabFun4.mb | Não identificado | Dados funcionário 4 |
| TabFun6a.mb | Não identificado | Dados funcionário 6a |
| TabFun6b.mb | Não identificado | Dados funcionário 6b |
| TabFunCBO.mb | Não identificado | Função CBO detalhes |
| TabFor.mb | Não identificado | Dados fornecedor |
| TabMail.mb | Não identificado | Mensagens email |
| TabNotaCan.mb | Não identificado | Notas canceladas |
| TabNotaEm.mb | Não identificado | Notas emitidas |
| TabNotaIn.mb | Não identificado | Notas iniciais |
| TabRecad.mb | Não identificado | Recadastramento |
| TabRecib.mb | Não identificado | Recibos |
| TabAtnd4.mb | Não identificado | Atendimento 4 |

---

## Padrões Identificados

### 1. **Tabelas Vazias vs. Tabelas Ativas**
- **Tamanho 2KB:** Tabelas de estrutura vazia (apenas schema)
- **Tamanho 4KB:** Tabelas com poucos registros
- **Tamanho > 100KB:** Tabelas com volume significativo de dados

### 2. **Duplicação de Estruturas**
- Múltiplas tabelas com prefixos (`TabEst1-9`, `TabCR1-6`, `TabFun1-6`)
- Sugerem evolução ou múltiplas versões dos dados
- Possível manutenção de histórico de dados

### 3. **Índices Secundários**
- Arquivos `.XG0-6` são índices adicionais
- Indicam buscas complexas por múltiplos campos
- Melhor performance de consultas

### 4. **Arquivos de Memo Grandes**
- `TabEst1.mb` (35 MB) - Provavelmente imagens de produtos
- `TabLog.mb` (331 KB) - Histórico detalhado
- `TabEst3B.db` (1,8 MB) - Grande volume de dados

---

## Recomendações de Manutenção

### Backup Prioritário
1. ✅ **Crítico:** TabEst1.db e TabEst1.mb (35+ MB)
2. ✅ **Crítico:** TabEst3B.db (1,8 MB)
3. ✅ **Importante:** TabCP1.db (346 KB)
4. ✅ **Importante:** TabLog.db e TabLog.mb

### Verificação de Integridade
```
Para cada arquivo .PX:
1. Verificar data de modificação (17-26 de Julho de 2019)
2. Confirmar presença de arquivo .db associado
3. Validar índices (.XG0-6, .YG0-6)
4. Se houver .mb, verificar integridade de dados memo
```

### Compactação de Banco
- Tabelas vazias (2-4 KB) podem ser consolidadas
- Arquivo cidades.db é de 2002 - verificar atualização
- Considerar arquivamento de tabelas TabEst duplicadas

### Monitoramento
- TabLog.mb crescendo? Implementar rotação de logs
- TabEst1.mb > 35 MB? Considerar migração para armazenamento externo de imagens
- Índices desatualizados? Executar REINDEX periodicamente

---

## Informações Técnicas

### Sistema de Arquivo
- **Formato Base:** Paradox Database (Borland Paradox)
- **Versão:** Likely Paradox 7.x or 8.x
- **Motor:** Paradox Engine (Borland Database Engine)
- **Compatibilidade:** Requer BDE (Borland Database Engine) ou alternativa como DBISAM

### Requerimentos para Acesso
1. **Borland Database Engine (BDE)** - Legado
2. **DBISAM** - Alternativa mais moderna
3. **Delphi/C++Builder** com Paradox support
4. **Ferramenta de conversão** para migrar para SQL Server, MySQL, PostgreSQL

### Estrutura de Índices Paradox
- **XG0:** Primary key / Unique index
- **XG1-6:** Secondary indexes para otimização
- **YG0-6:** Alternate index sets

---

## Conclusão

O sistema SIC utiliza **Paradox Database** como repositório central com estrutura bem organizada por função (Estoque, Clientes, Financeiro, RH, etc.). O maior volume de dados está nas **tabelas de Estoque (TabEst1, TabEst3B)**, particularmente em campos BLOB (imagens de produtos).

**Status Geral:** Sistema ativo até Julho/2019, sem atualizações recentes. Recomenda-se auditoria e possível migração para banco moderno (SQL Server, MySQL, PostgreSQL).

---

*Documento gerado: 23 de Dezembro de 2025*
