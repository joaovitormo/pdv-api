# 🎯 Quick Reference - Guia Rápido

Informações rápidas sobre o projeto PDV API.

## 📍 Principais Diretórios

```
docs/               → Toda documentação (API, guias, troubleshooting)
scripts/            → Scripts bash (setup, testes)
src/
  ├── auth/         → Autenticação (JWT, login, register)
  ├── products/     → Gestão de produtos
  ├── categories/   → Gestão de categorias
  ├── customers/    → Gestão de clientes
  ├── sales/        → Gestão de vendas (com estoque)
  ├── health/       → Health checks (4 endpoints)
  ├── constants/    → Constantes da app
  ├── types/        → Tipos e interfaces
  ├── utils/        → Funções utilitárias
  ├── middlewares/  → Logging, rate limit
  ├── config/       → Configurações (logger)
  └── prisma/       → ORM Prisma
prisma/
  ├── schema.prisma → Modelo de BD
  └── seed.ts       → Dados iniciais
```

---

## 🚀 Comandos Essenciais

```bash
# Setup
npm install                    # Instalar deps
npx prisma migrate dev        # Migrations
npm run seed                  # Carregar dados iniciais
npm run build                 # Build
npm run start:dev             # Iniciar dev

# Testes
npm run test                  # Testes unitários
npm run test:watch            # Watch mode
./scripts/test-api.sh         # Testes API

# Utilitários
npm run lint                  # ESLint
npm run format                # Prettier
npm run start:debug           # Debug mode
```

---

## 🔌 Endpoints Principais

### Auth
```
POST   /api/auth/login        → Login (public)
POST   /api/auth/register     → Register (public)
GET    /api/auth/profile      → Meu perfil (protegido)
```

### Products
```
GET    /api/products          → Listar
GET    /api/products/:id      → Detalhes
POST   /api/products          → Criar (protegido)
PUT    /api/products/:id      → Atualizar (protegido)
DELETE /api/products/:id      → Deletar (protegido)
```

### Health Check
```
GET    /api/health            → Status geral
GET    /api/health/db         → Verificar BD
GET    /api/health/live       → Liveness probe
GET    /api/health/ready      → Readiness probe
```

---

## 🔐 Credenciais de Teste

```
Username: admin
Password: Admin@123

Username: vendedor
Password: Vendedor@123
```

---

## 📝 Estrutura de Request/Response

### Requisição
```json
{
  "username": "admin",
  "password": "Admin@123"
}
```

### Resposta Sucesso
```json
{
  "statusCode": 200,
  "message": "Login realizado com sucesso",
  "data": {
    "access_token": "eyJhbGc...",
    "user": { "id": "...", "username": "admin" }
  }
}
```

### Resposta Erro
```json
{
  "statusCode": 400,
  "error": "Bad Request",
  "message": "Dados de entrada inválidos"
}
```

---

## 🔍 Tipos Principais

```typescript
// Resposta padrão
ApiResponse<T> {
  success: boolean
  data?: T
  message?: string
  error?: string
  timestamp: string
}

// Usuário no token
UserPayload {
  sub: string
  username: string
  role: string
}

// Health status
HealthStatus {
  status: 'UP' | 'DOWN'
  timestamp: string
  uptime: number
  database?: { status: 'UP' | 'DOWN' }
}
```

---

## 🎯 Constantes Importantes

```typescript
// De src/constants/index.ts

JWT_EXPIRES_IN = '24h'
RATE_LIMIT_WINDOW = 15 min
RATE_LIMIT_MAX = 100 requests
AUTH_MAX_ATTEMPTS = 5

SALE_STATUS = {
  OPEN: 'OPEN',
  COMPLETED: 'COMPLETED',
  CANCELED: 'CANCELED'
}

USER_ROLES = {
  USER: 'USER',
  ADMIN: 'ADMIN'
}
```

---

## 🧪 Testar com cURL

### Login
```bash
curl -X POST http://localhost:3001/api/auth/login \
  -H "Content-Type: application/json" \
  -d '{"username":"admin","password":"Admin@123"}'
```

### Usar Token
```bash
TOKEN="seu_token_aqui"
curl -H "Authorization: Bearer $TOKEN" \
  http://localhost:3001/api/products
```

### Health Check
```bash
curl http://localhost:3001/api/health
```

---

## 📚 Documentação

| Arquivo | Propósito |
|---------|-----------|
| `docs/README.md` | Índice de documentação |
| `docs/PROJECT_STRUCTURE.md` | Arquitetura detalhada |
| `docs/API_DOCUMENTATION.md` | Referência de endpoints |
| `docs/CONTRIBUTING.md` | Padrões de código |
| `docs/TROUBLESHOOTING.md` | Solução de problemas |
| `ORGANIZATION.md` | Resumo da reorganização |

---

## 🔧 Variáveis de Ambiente

```env
DATABASE_URL=postgresql://user:password@localhost:5432/pdvdb
JWT_SECRET=your-secret-key
PORT=3001
NODE_ENV=development
CORS_ORIGIN=*
```

---

## 📊 Stack Tecnológico

- **Framework**: NestJS 11
- **Linguagem**: TypeScript
- **Banco**: PostgreSQL + Prisma
- **Auth**: JWT + Passport
- **Validation**: class-validator
- **Logging**: Winston
- **Testing**: Jest
- **Container**: Docker

---

## ✅ Checklist de Desenvolvimento

- [ ] Ler `docs/PROJECT_STRUCTURE.md`
- [ ] Entender estrutura de modules
- [ ] Revisar padrões em `docs/CONTRIBUTING.md`
- [ ] Consultar tipos em `src/types/`
- [ ] Usar constantes em `src/constants/`
- [ ] Usar utils em `src/utils/`
- [ ] Testar endpoints
- [ ] Documentar mudanças

---

## 🎓 Links Úteis

- [NestJS Docs](https://docs.nestjs.com)
- [Prisma Docs](https://www.prisma.io/docs)
- [TypeScript Handbook](https://www.typescriptlang.org/docs)
- [Pasta docs/ local](./docs/)

---

## 📞 Troubleshooting Rápido

| Problema | Solução |
|----------|---------|
| Porta 3001 em uso | `lsof -i :3001 && kill -9 <PID>` |
| DB não conecta | Verificar `.env` e `docker-compose` |
| Imports quebrados | `npm install` e `npm run build` |
| JWT inválido | Fazer login novamente |
| Muitas requisições | Aguardar 15 minutos |

---

## 🎯 Próximas Ações

1. **Começar**: `npm run start:dev`
2. **Testar**: `curl http://localhost:3001/api/health`
3. **Explorar**: `docs/API_DOCUMENTATION.md`
4. **Codar**: Seguir padrões em `docs/CONTRIBUTING.md`
5. **Debugar**: Consultar `docs/TROUBLESHOOTING.md`

---

**Última atualização**: 2 de janeiro de 2026
**Versão**: 1.0.0
