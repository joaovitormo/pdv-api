# ⚡ GUIA RÁPIDO: Visualizar Paradox em 5 Minutos

## 🎯 Meta: Abrir seu banco Paradox e ver os dados

---

## 🚀 Solução Recomendada: DBeaver (Gratuito)

### ⏱️ Tempo Total: 10 minutos

---

## PASSO 1: Baixar DBeaver (2 minutos)

```
1. Acesse: https://dbeaver.io/download/
2. Clique em: "Download DBeaver Community"
3. Selecione: Windows 64-bit (ou sua arquitetura)
4. Salve o arquivo
```

---

## PASSO 2: Instalar (3 minutos)

```
1. Execute o arquivo baixado: dbeaver-xxx-setup.exe
2. Clique em "Next" nos diálogos
3. Escolha local padrão
4. Clique "Finish"
5. Deixe abrir automaticamente
```

---

## PASSO 3: Conectar ao Paradox (3 minutos)

### Na janela do DBeaver:

```
1. Menu superior: Database
   ↓
2. New Database Connection
   ↓
3. Na lista, procure: "Paradox"
   (ou role para baixo)
   ↓
4. Clique em "Paradox"
   ↓
5. Clique em "Next"
```

---

## PASSO 4: Configurar Caminho (2 minutos)

```
Na tela de configuração:

1. Campo "Database" → Paradox
2. Campo "Location/Path" → Clique em "..."
3. Navegue até: C:\Users\Eroni\Desktop\winsic
4. Clique OK
5. Clique "Test Connection"
6. Se aparecer "Connected" → Sucesso! ✅
```

---

## PASSO 5: Finalizar (1 minuto)

```
1. Clique "Finish"
2. Aguarde alguns segundos
3. Do lado esquerdo aparecerá sua conexão
```

---

## PASSO 6: Explorar as Tabelas (2 minutos)

```
Do lado esquerdo:
├─ Seu Paradox Database
│  ├─ Tabelas
│  │  ├─ TabAgend (Agendamentos)
│  │  ├─ TabAtnd1 (Atendimentos)
│  │  ├─ TabBanco (Bancos)
│  │  ├─ TabCli (Clientes) ← clique aqui!
│  │  ├─ TabCP1 (Pedidos)
│  │  ├─ TabEst1 (Estoque)
│  │  └─ [170 tabelas ao total]
```

---

## PASSO 7: Ver os Dados (1 minuto)

```
1. Expanda "Tabelas"
2. Clique com DIREITO em "TabCli" (Clientes)
3. Selecione "View Data"
4. Uma aba com os dados aparecerá!
```

---

## ✨ PRONTO! Você está visualizando os dados!

```
Você verá algo assim:

┌──────────┬──────────────┬───────────────────┐
│ ID       │ Nome         │ Email             │
├──────────┼──────────────┼───────────────────┤
│ 1        │ João Silva   │ joao@empresa.com  │
│ 2        │ Maria Santos │ maria@empresa.com │
│ 3        │ Carlos F.    │ carlos@empresa.com│
│ ...      │ ...          │ ...               │
└──────────┴──────────────┴───────────────────┘
```

---

## 🎁 Dicas Extras

### Ver todas as tabelas:
```
Clique com DIREITO na pasta "Tabelas"
→ Selecione "Refresh"
→ Vê todas as 170 tabelas
```

### Fazer uma busca rápida:
```
1. Clique em uma tabela
2. Aba "Data" 
3. Campo "Filter" (superior direito)
4. Digite para filtrar
```

### Exportar dados:
```
1. Clique com DIREITO na tabela
2. Select "Tools" → "Export Data"
3. Escolha formato (CSV, Excel, JSON)
4. Salve o arquivo
```

### Voltar aos dados de outra tabela:
```
1. Clique com DIREITO em qualquer tabela
2. "View Data"
3. Uma nova aba abre
4. Navegue entre abas
```

---

## 📊 Principais Tabelas para Explorar

```
TabCli              → Clientes
TabCP1              → Pedidos/Compras
TabEst1             → Estoque (maior!)
TabCR1              → Contas a Receber
TabAtnd1            → Atendimentos
TabFun1             → Funcionários
TabVend             → Vendedores
TabCx1              → Caixa
TabBanco            → Contas Bancárias
TabFor              → Fornecedores
```

---

## ❓ Problemas?

### "Driver não encontrado"
```
Solução:
1. Feche DBeaver
2. Instale BDE: https://www.embarcadero.com/
3. Reabra DBeaver
4. Tente novamente
```

### "Não vê as tabelas"
```
Solução:
1. Clique com direito no "Tabelas"
2. Selecione "Refresh"
3. Aguarde alguns segundos
```

### "Muito lento"
```
Solução:
1. A tabela TabEst1 é gigante (35 MB em imagens)
2. Use filtros para ver só alguns registros
3. Ou convertá para SQL (mais rápido)
```

---

## 🎯 Próximo Passo

Após explorar os dados:

### Opção 1: Apenas Visualizar
→ Pronto! Use DBeaver quando quiser ver dados

### Opção 2: Converter para SQL (Recomendado)
→ Use meu guia **GUIA_IMPLEMENTACAO.md**

### Opção 3: Entender Estrutura
→ Leia **ANALISE_BANCOS_DADOS.md**

---

## ✅ Checklist

- [ ] Baixou DBeaver
- [ ] Instalou DBeaver
- [ ] Conectou ao Paradox
- [ ] Viu algumas tabelas
- [ ] Explorou os dados
- [ ] Entendeu como funciona

---

*Guia Rápido - 23 de Dezembro de 2025*
