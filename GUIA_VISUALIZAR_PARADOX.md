# 📖 GUIA: Como Visualizar Dados Paradox

## 🎯 Problema
Você tem arquivos Paradox (.PX, .db, .mb) e quer visualizar o conteúdo das tabelas.

## ✅ Soluções (do mais fácil ao mais complexo)

---

## 1️⃣ OPÇÃO MAIS FÁCIL: DBeaver (Recomendado)

### O que é:
- Ferramenta universal de banco de dados
- Gratuita e open source
- Suporta Paradox nativamente
- Interface gráfica intuitiva

### Como Instalar:
1. Baixe em: https://dbeaver.io/download/
2. Escolha: DBeaver Community (gratuito)
3. Instale normalmente

### Como Usar:
```
1. Abra DBeaver
2. File → New → Database Connection
3. Selecione: Paradox
4. Em "Location" aponte para: c:\Users\Eroni\Desktop\winsic
5. Test Connection
6. Finish
7. Veja as tabelas no painel esquerdo
8. Duplo clique em qualquer tabela para ver dados
```

### Vantagens:
✅ Fácil de usar
✅ Interface gráfica
✅ Ver dados em tempo real
✅ Fazer queries SQL
✅ Exportar dados
✅ Gratuito

### Desvantagens:
❌ Requer instalação Java
❌ Pode ser lento com muitos dados

---

## 2️⃣ OPÇÃO: Microsoft Access

### O que é:
- Banco de dados Microsoft
- Pode abrir arquivos Paradox diretamente
- Tem interface visual

### Como Usar:
```
1. Abra Microsoft Access
2. File → Open
3. Procure por: c:\Users\Eroni\Desktop\winsic
4. Em "Tipos de arquivo" selecione: "Paradox Database"
5. Selecione o arquivo .PX
6. Access importará automaticamente
7. Veja as tabelas e dados
```

### Vantagens:
✅ Interface familiar
✅ Sem instalação adicional (se tiver Office)
✅ Fácil de navegar

### Desvantagens:
❌ Requer licença Access
❌ Pode ter problemas com dados grandes

---

## 3️⃣ OPÇÃO: Conversão para SQL

### Este é um ÓTIMO caminho!

#### Ferramenta: DBConvert (Paradox → SQL)
https://www.dbconvert.com/paradox-to-mssql/

```
Passo a passo:
1. Baixe DBConvert for Paradox and MS SQL
2. Instale
3. Na interface:
   - Source: Paradox Database
   - Location: c:\Users\Eroni\Desktop\winsic
   - Destination: SQL Server (ou MySQL)
   - Selecione as tabelas que quer converter
   - Clique "Convert"
4. Seus dados estão em SQL Server!
5. Abra com SQL Server Management Studio
```

---

## 4️⃣ OPÇÃO: LibreOffice Base

### O que é:
- Alternativa open source ao Access
- Suporta Paradox
- Gratuito

### Como Usar:
```
1. Baixe: https://www.libreoffice.org/
2. Instale LibreOffice
3. Abra LibreOffice Base
4. File → Open Database
5. Selecione Paradox como tipo
6. Aponte para sua pasta
7. Veja as tabelas
```

### Vantagens:
✅ Gratuito
✅ Multiplataforma
✅ Suporta Paradox

---

## 5️⃣ OPÇÃO: PowerBuilder (Se tiver)

Se você tiver Borland PowerBuilder instalado:

```
1. Abra PowerBuilder
2. File → Open
3. Navegue até: c:\Users\Eroni\Desktop\winsic
4. Veja as tabelas
5. Use o DataWindow para visualizar dados
```

---

## 6️⃣ OPÇÃO AVANÇADA: Script Python

Se souber programar:

```python
# Instale:
pip install pyodbc

# Script simples:
import pyodbc

# Caminho do banco Paradox
paradox_path = r"c:\Users\Eroni\Desktop\winsic"

# Conectar
conn = pyodbc.connect(
    f'Driver={{Paradox Driver}};DriverID=25;DBQ={paradox_path};'
)

# Ler dados
cursor = conn.cursor()
cursor.execute("SELECT * FROM tbl_cliente")

for row in cursor.fetchall():
    print(row)

conn.close()
```

---

## 7️⃣ OPÇÃO: SQL Server Management Studio (Direto)

Se souber SQL:

```
1. Abra SSMS
2. File → Open → File
3. Mude o tipo para "All Files"
4. Navegue até: c:\Users\Eroni\Desktop\winsic
5. Selecione um arquivo .PX
6. SSMS pode abrir e converter
```

---

## 🎯 RECOMENDAÇÃO FINAL

### Para Visualizar Rápido:
→ **Use DBeaver** (fácil e gratuito)

### Para Converter e Manter em SQL:
→ **Use DBConvert** (profissional)

### Para Usar com Office:
→ **Use Microsoft Access** (se tiver licença)

---

## 📊 Exemplo Prático com DBeaver

### Passo 1: Instalar
```
1. Baixe: https://dbeaver.io/download/
2. Execute o instalador
3. Escolha caminho padrão
4. Instale
```

### Passo 2: Conectar ao Paradox
```
1. Abra DBeaver
2. Window → New Database Connection
3. Procure por "Paradox"
4. Clique Next
```

### Passo 3: Configurar Conexão
```
Settings:
- Database: Paradox
- Location: c:\Users\Eroni\Desktop\winsic
- Driver: Paradox Driver
```

### Passo 4: Testar
```
1. Clique "Test Connection"
2. Se OK, clique "Finish"
```

### Passo 5: Explorar
```
Database Navigator (esquerda):
├─ Seu Paradox Database
│  ├─ Tables
│  │  ├─ TabAgend
│  │  ├─ TabAtnd1
│  │  ├─ TabBanco
│  │  ├─ TabCli
│  │  ├─ [Todas as 170 tabelas]
│  └─ Views
└─ [Outras conexões]
```

### Passo 6: Ver Dados
```
1. Expanda "Tables"
2. Clique com direito em "TabCli" (por exemplo)
3. Selecione "View Data"
4. Veja todos os clientes!
5. Use a aba "SQL" para escrever queries
```

---

## 🔍 O Que Você Vai Ver

Ao abrir uma tabela, você verá algo assim:

```
┌─────────────────────────────────────────────────────────┐
│ Dados de: TabCli (Clientes)                            │
├─────────────────────────────────────────────────────────┤
│ id_cliente │ nome      │ email        │ telefone       │
├─────────────────────────────────────────────────────────┤
│ 1          │ João      │ joao@mail    │ (11) 3000-0000 │
│ 2          │ Maria     │ maria@mail   │ (11) 3000-1111 │
│ 3          │ Carlos    │ carlos@mail  │ (11) 3000-2222 │
│ ...        │ ...       │ ...          │ ...            │
└─────────────────────────────────────────────────────────┘
```

---

## ⚠️ Limitações Paradox

Alguns pontos a observar:

- Arquivo .PX = estrutura da tabela
- Arquivo .db = dados reais
- Arquivo .mb = campos BLOB (imagens, documentos)
- Arquivo .XG0-6 = índices
- Arquivo .YG0-6 = índices alternativos

**Precisa dos 3 para abrir uma tabela completa!**

---

## 💾 Se Quiser Fazer Backup

### Forma Fácil: Copiar Arquivos
```
1. Selecione todos os arquivos .PX, .db, .mb em:
   c:\Users\Eroni\Desktop\winsic
2. Copie para uma pasta de backup
3. Pronto!
```

### Forma Profissional: Exportar
```
1. Com DBeaver aberto
2. Clique direito na tabela
3. Tools → Export Data
4. Escolha formato: CSV, Excel, JSON, SQL
5. Salve no local desejado
```

---

## 🆘 Problemas Comuns

### Problema: "Driver não encontrado"
**Solução:**
```
1. Instale Borland Database Engine (BDE):
   https://www.embarcadero.com/
2. Ou use DBeaver (tem drivers próprios)
```

### Problema: "Arquivo corrompido"
**Solução:**
```
1. Use ferramenta de reparo Paradox
2. Ou converta para SQL (mais seguro)
```

### Problema: "Muito lento"
**Solução:**
```
1. A tabela é grande (35+ MB em imagens)
2. Use filtros para ver parte dos dados
3. Ou converta para SQL (mais rápido)
```

---

## 📈 Próximas Etapas

### Após visualizar os dados:

1. **Entender a estrutura**
   → Use meu arquivo ANALISE_BANCOS_DADOS.md

2. **Pensar em migração**
   → Use meu arquivo GUIA_IMPLEMENTACAO.md

3. **Converter para SQL** (recomendado)
   → Use DBConvert ou DBeaver Export

4. **Arquivar os Paradox**
   → Mantenha como backup

---

## 📊 Comparativo de Ferramentas

| Ferramenta | Fácil? | Gratuito? | Paradox? | Recomendo |
|-----------|--------|----------|---------|-----------|
| DBeaver | ✅ Sim | ✅ Sim | ✅ Sim | ⭐⭐⭐⭐⭐ |
| Access | ✅ Sim | ❌ Não | ✅ Sim | ⭐⭐⭐⭐ |
| LibreOffice | ✅ Sim | ✅ Sim | ✅ Sim | ⭐⭐⭐ |
| DBConvert | ❌ Não | ❌ Não | ✅ Sim | ⭐⭐⭐⭐⭐ |
| PowerBuilder | ❌ Não | ❌ Não | ✅ Sim | ⭐⭐ |
| Python | ❌ Não | ✅ Sim | ✅ Sim | ⭐⭐⭐ |

---

## 🎯 RECOMENDAÇÃO FINAL

### Você quer só visualizar?
→ **DBeaver** (gratuito, fácil, rápido)

### Você quer converter para SQL?
→ **DBConvert** (profissional, automático)

### Você tem Office?
→ **Microsoft Access** (fácil, familiar)

### Você quer aprender?
→ **DBeaver** + **Python** (completo)

---

## 📝 Checklist

- [ ] Escolheu uma ferramenta
- [ ] Instalou a ferramenta
- [ ] Conectou ao banco Paradox
- [ ] Visualizou algumas tabelas
- [ ] Explorou os dados
- [ ] Entendeu a estrutura
- [ ] Planejou próximos passos

---

*Guia de Visualização Paradox - 23 de Dezembro de 2025*
