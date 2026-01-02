# 📚 Índice de Documentação

Bem-vindo à documentação do **PDV API**! Este arquivo ajuda você a navegar por toda a documentação do projeto.

## 🚀 Comece por Aqui

1. **Novo no projeto?** → Leia [README.md](README.md)
2. **Entender a estrutura?** → Leia [docs/PROJECT_STRUCTURE.md](docs/PROJECT_STRUCTURE.md)
3. **Testar endpoints?** → Leia [docs/API_DOCUMENTATION.md](docs/API_DOCUMENTATION.md)
4. **Teve um problema?** → Leia [docs/TROUBLESHOOTING.md](docs/TROUBLESHOOTING.md)

---

## 📖 Documentação por Categoria

### 🎯 Primeiros Passos

| Documento | Descrição | Tempo |
|-----------|-----------|-------|
| [README.md](README.md) | Visão geral e quick start | 5 min |
| [ORGANIZATION.md](ORGANIZATION.md) | Resumo da organização do projeto | 5 min |
| [docs/PROJECT_STRUCTURE.md](docs/PROJECT_STRUCTURE.md) | Explicação detalhada de cada pasta | 15 min |

### 🔌 API & Endpoints

| Documento | Descrição | Tempo |
|-----------|-----------|-------|
| [docs/API_DOCUMENTATION.md](docs/API_DOCUMENTATION.md) | Referência completa de endpoints | 20 min |
| [docs/BRUNO_GUIDE.md](docs/BRUNO_GUIDE.md) | Como testar no Bruno API Client | 5 min |
| [openapi.yaml](openapi.yaml) | Especificação OpenAPI 3.0 | Para IDE |
| [pdv-api-collection.json](pdv-api-collection.json) | Coleção Postman | Para Postman |

### 🔐 Autenticação & Segurança

| Documento | Descrição | Detalhes |
|-----------|-----------|----------|
| JWT Auth | Implementado em `src/auth/` | Login com token |
| Rate Limiting | Implementado em `src/middlewares/` | 5 tentativas/15min |
| Validation | DTOs com class-validator | Automático |

**Arquivos:**
- `src/auth/jwt.strategy.ts` - Estratégia JWT
- `src/auth/guards/jwt.guard.ts` - Guard de proteção
- `src/middlewares/rate-limit.config.ts` - Rate limiting

### 📦 Implementação & Arquitetura

| Documento | Descrição | Tempo |
|-----------|-----------|-------|
| [docs/IMPLEMENTATION_COMPLETE.md](docs/IMPLEMENTATION_COMPLETE.md) | Resumo de tudo implementado | 10 min |
| [docs/PHASE3_DOCS.md](docs/PHASE3_DOCS.md) | Logging, Health Checks, Rate Limit | 15 min |
| [docs/CONTRIBUTING.md](docs/CONTRIBUTING.md) | Padrões de código e boas práticas | 20 min |

### 🔧 Desenvolvimento & Troubleshooting

| Documento | Descrição | Quando usar |
|-----------|-----------|------------|
| [docs/TROUBLESHOOTING.md](docs/TROUBLESHOOTING.md) | Solução de problemas comuns | Quando erro |
| [docs/CONTRIBUTING.md](docs/CONTRIBUTING.md) | Padrões TypeScript/NestJS | Antes de codar |
| [docs/prompt.md](docs/prompt.md) | Checklist do projeto | Planejamento |

---

## 🗂️ Estrutura de Pastas

```
root/
├── README.md                          ← COMECE AQUI
├── ORGANIZATION.md                    ← Resumo da organização
├── docs/
│   ├── README.md                      ← Índice (este arquivo)
│   ├── PROJECT_STRUCTURE.md           ← Arquitetura
│   ├── API_DOCUMENTATION.md           ← Endpoints
│   ├── CONTRIBUTING.md                ← Padrões
│   ├── TROUBLESHOOTING.md             ← Problemas
│   ├── PHASE3_DOCS.md                 ← Logging
│   ├── IMPLEMENTATION_COMPLETE.md     ← Resumo
│   ├── BRUNO_GUIDE.md                 ← Testes
│   └── prompt.md                      ← Checklist
├── scripts/
│   ├── setup.sh                       ← Setup automático
│   └── test-api.sh                    ← Testes
├── src/                               ← Código
│   ├── auth/                          ← Autenticação
│   ├── products/                      ← Produtos
│   ├── categories/                    ← Categorias
│   ├── customers/                     ← Clientes
│   ├── sales/                         ← Vendas
│   ├── health/                        ← Health Check
│   ├── constants/                     ← Constantes
│   ├── types/                         ← Tipos
│   ├── utils/                         ← Utilitários
│   ├── middlewares/                   ← Middlewares
│   ├── config/                        ← Config
│   ├── common/                        ← Compartilhado
│   └── prisma/                        ← ORM
├── prisma/
│   ├── schema.prisma                  ← Banco de dados
│   └── seed.ts                        ← Dados iniciais
├── openapi.yaml                       ← Especificação OpenAPI
├── pdv-api-collection.json            ← Postman
├── docker-compose.yml                 ← Docker
├── package.json                       ← Dependências
└── .env                               ← Config
```

---

## 🎓 Aprendizado Progressivo

### Nível 1: Iniciante
1. [README.md](README.md) - O que é o projeto
2. [docs/PROJECT_STRUCTURE.md](docs/PROJECT_STRUCTURE.md) - Como é organizado
3. [docs/API_DOCUMENTATION.md](docs/API_DOCUMENTATION.md) - Quais endpoints existem

### Nível 2: Desenvolvedor
1. [docs/CONTRIBUTING.md](docs/CONTRIBUTING.md) - Como programar no projeto
2. [docs/PHASE3_DOCS.md](docs/PHASE3_DOCS.md) - Features avançadas
3. [src/types/index.ts](src/types/index.ts) - Tipos do projeto

### Nível 3: Arquiteto
1. [docs/PROJECT_STRUCTURE.md](docs/PROJECT_STRUCTURE.md) - Arquitetura completa
2. [docs/CONTRIBUTING.md](docs/CONTRIBUTING.md) - Padrões de design
3. [docs/IMPLEMENTATION_COMPLETE.md](docs/IMPLEMENTATION_COMPLETE.md) - Decisões técnicas

---

## 🔍 Buscar por Tópico

### Autenticação & Segurança
- [docs/API_DOCUMENTATION.md](docs/API_DOCUMENTATION.md#auth) - Login/Register
- `src/auth/` - Implementação
- [docs/CONTRIBUTING.md](docs/CONTRIBUTING.md#segurança) - Boas práticas

### Banco de Dados
- [prisma/schema.prisma](prisma/schema.prisma) - Modelo
- [prisma/seed.ts](prisma/seed.ts) - Dados iniciais
- [docs/CONTRIBUTING.md](docs/CONTRIBUTING.md#banco-de-dados) - Padrões

### Testes
- [scripts/test-api.sh](scripts/test-api.sh) - Testes bash
- [docs/BRUNO_GUIDE.md](docs/BRUNO_GUIDE.md) - Testes com Bruno
- [pdv-api-collection.json](pdv-api-collection.json) - Postman

### Logging & Monitoramento
- [docs/PHASE3_DOCS.md](docs/PHASE3_DOCS.md) - Logging detalhado
- [src/config/logger.ts](src/config/logger.ts) - Winston config
- [src/health/](src/health/) - Health checks

### Performance & Troubleshooting
- [docs/TROUBLESHOOTING.md](docs/TROUBLESHOOTING.md) - Problemas comuns
- [docs/CONTRIBUTING.md](docs/CONTRIBUTING.md#performance) - Otimizações

---

## 📊 Checklist de Leitura

Marque conforme lê:

- [ ] README.md - Overview
- [ ] ORGANIZATION.md - Estrutura
- [ ] docs/PROJECT_STRUCTURE.md - Pastas
- [ ] docs/API_DOCUMENTATION.md - Endpoints
- [ ] docs/CONTRIBUTING.md - Padrões
- [ ] docs/PHASE3_DOCS.md - Features
- [ ] docs/TROUBLESHOOTING.md - Problemas

---

## 🚀 Atalhos Úteis

### Setup Rápido
```bash
npm install              # Instalar dependências
npm run build            # Compilar
npm run start:dev        # Iniciar dev
npm run seed             # Carregar dados iniciais
npm run test             # Rodar testes
```

### Documentação Rápida
```bash
cat docs/PROJECT_STRUCTURE.md   # Ver arquitetura
cat docs/API_DOCUMENTATION.md   # Ver endpoints
cat docs/TROUBLESHOOTING.md     # Ver problemas
```

### Testar API
```bash
curl http://localhost:3001/api/health                    # Health check
curl http://localhost:3001/api/products                  # Listar produtos
chmod +x scripts/test-api.sh && ./scripts/test-api.sh   # Testes
```

---

## 💡 Dicas

1. **Novo no projeto?** Comece pelo README.md
2. **Precisa de arquivo?** Use Ctrl+F aqui para buscar
3. **Tem um problema?** Consulte TROUBLESHOOTING.md
4. **Quer contribuir?** Leia CONTRIBUTING.md
5. **Quer testar?** Use Bruno ou BRUNO_GUIDE.md

---

## 📞 Suporte

- **GitHub Issues** - Para bugs e features
- **GitHub Discussions** - Para perguntas
- **docs/TROUBLESHOOTING.md** - Soluções rápidas

---

## ✨ Últimas Atualizações

- ✅ Documentação reorganizada e centralizada em `docs/`
- ✅ Novas pastas: `constants/`, `types/`, `utils/`, `middlewares/`
- ✅ Novos guias: PROJECT_STRUCTURE.md, CONTRIBUTING.md, TROUBLESHOOTING.md
- ✅ Imports atualizados e compilação verificada
- ✅ 35+ endpoints implementados e funcionais
- ✅ Logging, Health Checks e Rate Limiting prontos

---

**Última atualização:** 2 de janeiro de 2026
**Status:** ✅ Pronto para desenvolvimento
**Versão:** 1.0.0
