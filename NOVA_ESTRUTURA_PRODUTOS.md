# 📊 NOVA ESTRUTURA DA TABELA DE PRODUTOS

## Alterações Realizadas

A tabela `tbl_produto` foi completamente reestruturada para corresponder ao formato JSON do Paradox, com nomes amigáveis em português.

---

## 🗂️ Mapeamento JSON → Nova Estrutura

| Campo Original (JSON) | Nova Coluna SQL | Tipo | Descrição |
|---|---|---|---|
| `RecNo` | `numero_registro` | INT | ID único do produto (chave primária) |
| `Controle` | `numero_controle` | INT | Número de controle interno |
| `Codigo` | `codigo_produto` | VARCHAR(50) | Código único do produto |
| `CodInterno` | `codigo_interno` | VARCHAR(100) | Código interno alternativo |
| `Produto` | `nome_produto` | VARCHAR(255) | Nome do produto |
| `LkSetor` | `id_setor` | INT | FK para tabela de setores |
| `Fabricante` | `nome_fabricante` | VARCHAR(150) | Nome do fabricante |
| `LkFornec` | `id_fornecedor` | INT | FK para tabela de fornecedores |
| `PrecoCusto` | `preco_custo` | DECIMAL(12,2) | Preço de custo |
| `CustoMedio` | `custo_medio` | DECIMAL(12,4) | Custo médio ponderado |
| `PrecoVenda` | `preco_venda` | DECIMAL(12,2) | Preço de venda |
| `Quantidade` | `quantidade_estoque` | INT | Quantidade atual em estoque |
| `EstMinimo` | `estoque_minimo` | INT | Quantidade mínima recomendada |
| `Unidade` | `id_unidade_medida` | INT | FK para unidades de medida |
| `Lucro` | `margem_lucro` | DECIMAL(8,2) | Margem de lucro em % |
| `Moeda` | `codigo_moeda` | VARCHAR(10) | Código da moeda (BRL, USD, etc) |
| `UltReaj` | `data_ultimo_reajuste` | DATE | Data do último reajuste de preço |
| `Obs` | `observacoes` | VARCHAR(MAX) | Observações e anotações |
| `NaoSaiTabela` | `nao_sai_tabela` | BIT | Flag (0=sai, 1=não sai da tabela) |
| `Inativo` | `inativo` | BIT | Flag de inatividade (0=ativo, 1=inativo) |
| `CodIPI` | `codigo_ipi` | VARCHAR(20) | Código IPI |
| `IPI` | `percentual_ipi` | DECIMAL(8,2) | Percentual de IPI |
| `CST` | `codigo_cst` | VARCHAR(10) | Código de Situação Tributária |
| `ICMS` | `percentual_icms` | DECIMAL(8,2) | Percentual de ICMS |
| `BaseCalculo` | `base_calculo_icms` | DECIMAL(6,2) | Base de cálculo ICMS (%) |
| `PesoBruto` | `peso_bruto` | DECIMAL(10,3) | Peso bruto em kg |
| `PesoLiq` | `peso_liquido` | DECIMAL(10,3) | Peso líquido em kg |
| `LkModulo` | `id_modulo` | INT | FK para módulos (Vendas, Estoque, etc) |
| `Armazenamento` | `local_armazenamento` | VARCHAR(100) | Local/prateleira de armazenamento |
| `QntEmbalagem` | `quantidade_embalagem` | INT | Quantidade por embalagem |
| `ELV` | `codigo_elv` | VARCHAR(50) | Código ELV |
| `Previsao` | `previsao_estoque` | VARCHAR(MAX) | Previsão de estoque/reposição |
| `DataFoto` | `data_foto` | DATETIME | Data da foto/última atualização visual |
| `DataInc` | `data_inclusao` | DATETIME | Data de inclusão no sistema |
| `LkUserInc` | `id_usuario_inclusao` | INT | FK para usuário que incluiu o produto |
| `CodEx` | `codigo_ex` | VARCHAR(50) | Código exclusivo |
| `IVA_ST` | `percentual_iva_st` | DECIMAL(8,2) | Percentual IVA ST |
| `PFC` | `codigo_pfc` | VARCHAR(50) | Código PFC |
| `IPI_CST` | `codigo_ipi_cst` | VARCHAR(10) | Código IPI CST |
| `IPI_BaseCalc` | `ipi_base_calculo` | DECIMAL(12,2) | Base de cálculo IPI |
| *(novo)* | `imagem_produto` | VARBINARY(MAX) | Imagem/foto do produto |
| *(novo)* | `data_atualizacao` | DATETIME | Data da última atualização |

---

## 📋 Estrutura Completa da Tabela

```sql
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
    imagem_produto VARBINARY(MAX),
    data_atualizacao DATETIME DEFAULT GETDATE(),
    FOREIGN KEY (id_setor) REFERENCES tbl_setor(id_setor),
    FOREIGN KEY (id_fornecedor) REFERENCES tbl_fornecedor(id_fornecedor),
    FOREIGN KEY (id_unidade_medida) REFERENCES tbl_unidade_medida(id_unidade),
    FOREIGN KEY (id_modulo) REFERENCES tbl_modulo(id_modulo),
    FOREIGN KEY (id_usuario_inclusao) REFERENCES tbl_usuario(id_usuario)
);
```

---

## ✨ Novas Tabelas de Suporte

### tbl_setor
```sql
CREATE TABLE tbl_setor (
    id_setor INT PRIMARY KEY IDENTITY(1,1),
    nome_setor VARCHAR(100) NOT NULL,
    descricao_setor VARCHAR(255),
    ativo BIT DEFAULT 1
);
```
**Valores padrão:**
- Eletrônicos
- Hidráulica
- Elétrica
- Construção
- Comercial

### tbl_modulo
```sql
CREATE TABLE tbl_modulo (
    id_modulo INT PRIMARY KEY IDENTITY(1,1),
    nome_modulo VARCHAR(100) NOT NULL,
    descricao_modulo VARCHAR(255),
    ativo BIT DEFAULT 1
);
```
**Valores padrão:**
- Vendas
- Estoque
- Financeiro

---

## 🔄 Mudanças nas Outras Tabelas

As seguintes tabelas foram atualizadas para referenciar `numero_registro` (antes era `id_produto`):
- `tbl_estoque_movimento`
- `tbl_inventario_detalhe`
- `tbl_pedido_detalhe`
- `tbl_orcamento_detalhe`

---

## 📊 Exemplo de Dado Completo

```json
{
    "numero_registro": 3,
    "numero_controle": 4,
    "codigo_produto": "000004",
    "codigo_interno": "",
    "nome_produto": "Tê esgoto 100x krona",
    "id_setor": 2,
    "nome_fabricante": "",
    "id_fornecedor": 1,
    "preco_custo": 5.50,
    "custo_medio": 5.22903225806452,
    "preco_venda": 11.00,
    "quantidade_estoque": 22,
    "estoque_minimo": 2,
    "id_unidade_medida": 1,
    "margem_lucro": 100.0,
    "codigo_moeda": "BRL",
    "data_ultimo_reajuste": "2017-12-10",
    "observacoes": "",
    "nao_sai_tabela": false,
    "inativo": false,
    "codigo_ipi": "",
    "percentual_ipi": 0.0,
    "codigo_cst": "",
    "percentual_icms": 0.0,
    "base_calculo_icms": 100.0,
    "peso_bruto": 0.0,
    "peso_liquido": 0.0,
    "id_modulo": 2,
    "local_armazenamento": "",
    "quantidade_embalagem": 40,
    "codigo_elv": "",
    "previsao_estoque": "",
    "data_foto": "2014-08-30T17:43:18",
    "data_inclusao": "2014-08-30T17:38:32",
    "id_usuario_inclusao": 1,
    "codigo_ex": "",
    "percentual_iva_st": 0.0,
    "codigo_pfc": "",
    "codigo_ipi_cst": "",
    "ipi_base_calculo": 0.0
}
```

---

## 🎯 Índices para Performance

```sql
CREATE INDEX idx_produto_codigo ON tbl_produto(codigo_produto);
CREATE INDEX idx_produto_interno ON tbl_produto(codigo_interno);
CREATE INDEX idx_produto_setor ON tbl_produto(id_setor);
CREATE INDEX idx_produto_fornecedor ON tbl_produto(id_fornecedor);
CREATE INDEX idx_produto_ativo ON tbl_produto(inativo);
CREATE INDEX idx_produto_estoque ON tbl_produto(quantidade_estoque);
```

---

## 📝 Arquivos Relacionados

| Arquivo | Descrição |
|---------|-----------|
| `ESTRUTURA_TABELAS_NOVO_SISTEMA.sql` | Definição completa de todas as 40 tabelas |
| `EXEMPLOS_DADOS_PRODUTOS_NOVO.sql` | Dados de teste com a nova estrutura |
| `DICIONARIO_DADOS_E_DIAGRAMA.md` | Documentação das relações |

---

## ✅ Checklist de Implementação

- [ ] Criar tabelas `tbl_setor` e `tbl_modulo`
- [ ] Criar tabela `tbl_produto` com nova estrutura
- [ ] Executar script `EXEMPLOS_DADOS_PRODUTOS_NOVO.sql`
- [ ] Validar integridade referencial
- [ ] Criar índices para performance
- [ ] Realizar testes de consulta
- [ ] Importar dados do Paradox
- [ ] Validar margem de lucro para produtos
- [ ] Atualizar aplicação para usar novos nomes de coluna

---

*Estrutura de Produtos Atualizada - 23 de Dezembro de 2025*
