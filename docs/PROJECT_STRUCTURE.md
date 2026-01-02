# 📁 Estrutura do Projeto

## Organização de Pastas

```
pdv-backend/
├── src/
│   ├── auth/                    # Autenticação e Segurança
│   │   ├── decorators/          # Custom decorators (@CurrentUser, etc)
│   │   ├── dto/                 # Data Transfer Objects (LoginDto, RegisterDto)
│   │   ├── guards/              # Guards (JwtAuthGuard)
│   │   ├── auth.controller.ts   # Controlador de autenticação
│   │   ├── auth.module.ts       # Módulo de autenticação
│   │   ├── auth.service.ts      # Lógica de autenticação
│   │   └── jwt.strategy.ts      # Estratégia JWT/Passport
│   │
│   ├── products/                # Módulo de Produtos
│   │   ├── dto/                 # CreateProductDto, UpdateProductDto
│   │   ├── products.controller.ts
│   │   ├── products.module.ts
│   │   └── products.service.ts
│   │
│   ├── categories/              # Módulo de Categorias
│   │   ├── dto/
│   │   ├── categories.controller.ts
│   │   ├── categories.module.ts
│   │   └── categories.service.ts
│   │
│   ├── customers/               # Módulo de Clientes
│   │   ├── dto/
│   │   ├── customers.controller.ts
│   │   ├── customers.module.ts
│   │   └── customers.service.ts
│   │
│   ├── sales/                   # Módulo de Vendas
│   │   ├── dto/                 # CreateSaleDto, UpdateSaleStatusDto
│   │   ├── sales.controller.ts
│   │   ├── sales.module.ts
│   │   └── sales.service.ts
│   │
│   ├── health/                  # Módulo de Health Check
│   │   ├── health.controller.ts # GET /api/health, /db, /live, /ready
│   │   ├── health.module.ts
│   │   └── health.service.ts
│   │
│   ├── common/                  # Código Compartilhado
│   │   └── filters/             # Exception filters
│   │       └── all-exceptions.filter.ts
│   │
│   ├── config/                  # Configurações da Aplicação
│   │   └── logger.ts            # Winston logger configuration
│   │
│   ├── middlewares/             # Middlewares e Interceptors
│   │   ├── logging.interceptor.ts   # Interceptor de requisições
│   │   └── rate-limit.config.ts     # Rate limiting middleware
│   │
│   ├── prisma/                  # ORM Prisma
│   │   └── prisma.module.ts
│   │   └── prisma.service.ts
│   │
│   ├── types/                   # Tipos e Interfaces Compartilhados
│   │   └── index.ts             # ApiResponse, HealthStatus, etc
│   │
│   ├── utils/                   # Funções Utilitárias
│   │   └── index.ts             # DateUtils, StringUtils, NumberUtils
│   │
│   ├── constants/               # Constantes da Aplicação
│   │   └── index.ts             # Config, Status, Messages
│   │
│   ├── test/                    # Testes
│   │   └── app.e2e-spec.ts
│   │
│   ├── app.controller.ts        # Controlador da Aplicação
│   ├── app.controller.spec.ts
│   ├── app.module.ts            # Módulo Raiz
│   ├── app.service.ts           # Serviço da Aplicação
│   └── main.ts                  # Arquivo de inicialização
│
├── prisma/
│   ├── schema.prisma            # Schema do banco de dados
│   ├── seed.ts                  # Script de seed com dados iniciais
│   └── migrations/              # Histórico de migrações
│
├── docs/                        # Documentação
│   ├── README.md                # Guia principal
│   ├── API_DOCUMENTATION.md     # Referência de endpoints
│   ├── PHASE3_DOCS.md           # Logging e Health Checks
│   ├── IMPLEMENTATION_COMPLETE.md
│   ├── BRUNO_GUIDE.md           # Como importar no Bruno
│   └── prompt.md                # Checklist do projeto
│
├── scripts/                     # Scripts de Utilidade
│   ├── setup.sh                 # Setup automático
│   └── test-api.sh              # Testes de API
│
├── logs/                        # Arquivos de Log (gerado em runtime)
│   ├── combined.log
│   ├── error.log
│   ├── exceptions.log
│   └── rejections.log
│
├── dist/                        # Código compilado (gerado pelo build)
│
├── node_modules/                # Dependências (npm install)
│
├── .env                         # Variáveis de ambiente
├── .env.example                 # Exemplo de variáveis de ambiente
├── .gitignore                   # Git ignore
├── .prettierrc                  # Prettier config
├── docker-compose.yml           # Docker Compose para desenvolvimento
├── Dockerfile                   # Dockerfile para produção
├── package.json                 # Dependências do projeto
├── package-lock.json
├── tsconfig.json                # TypeScript config
├── tsconfig.build.json          # TypeScript build config
├── nest-cli.json                # NestJS CLI config
├── eslint.config.mjs            # ESLint config
├── jest.config.js               # Jest config (se existir)
├── jest-e2e.json                # Jest E2E config
├── bruno.json                   # Bruno API Client config
├── openapi.yaml                 # OpenAPI specification
├── pdv-api-collection.json      # Postman collection
└── README.md                    # Este arquivo
```

## 📋 Descrição das Pastas Principais

### `src/auth/`
Toda a lógica de autenticação, JWT, login, registro e proteção de rotas.

### `src/modules/` (Products, Categories, Customers, Sales)
Cada módulo segue o padrão NestJS com controller, service, module e DTOs.

### `src/common/`
Código compartilhado entre módulos: filters, pipes, decorators, guards.

### `src/config/`
Configurações centralizadas: logger, database, environment variables.

### `src/middlewares/`
Interceptors e middlewares: logging, rate limiting, tratamento de erros.

### `src/types/`
Tipos e interfaces TypeScript reutilizáveis em toda a aplicação.

### `src/utils/`
Funções utilitárias: formatação de datas, strings, números.

### `src/constants/`
Constantes usadas na aplicação: mensagens, status codes, configurações.

### `prisma/`
Definições de banco de dados (schema), migrations e seed.

### `docs/`
Documentação do projeto: guias, referências, especificações.

### `scripts/`
Scripts bash para automação: setup, testes, deploy.

## 🔄 Fluxo de Requisição

```
1. main.ts - Inicializa a aplicação
2. app.module.ts - Carrega todos os módulos
3. Middleware/Interceptor - Valida rate limit, logging
4. Controller - Recebe requisição
5. Guard - Verifica autenticação (se necessário)
6. Service - Lógica de negócio
7. Prisma - Acesso ao banco de dados
8. Response - Retorna ao cliente
```

## 📦 Padrão de Organização de Módulos

Cada módulo (auth, products, categories, etc) segue este padrão:

```typescript
// module.ts
import { Module } from '@nestjs/common';
import { MyController } from './my.controller';
import { MyService } from './my.service';
import { PrismaModule } from '../prisma/prisma.module';

@Module({
  imports: [PrismaModule],
  controllers: [MyController],
  providers: [MyService],
  exports: [MyService], // Se usado por outro módulo
})
export class MyModule {}
```

## 🧪 Testes

- Testes unitários: `src/**/*.spec.ts`
- Testes E2E: `src/test/`
- Rodar: `npm run test`, `npm run test:e2e`

## 📝 Convenções de Naming

| Tipo | Padrão | Exemplo |
|------|--------|---------|
| Arquivo | camelCase | `user.service.ts` |
| Classe | PascalCase | `UserService` |
| Interface | PascalCase | `IUser` ou `User` |
| Constante | UPPER_SNAKE_CASE | `MAX_LOGIN_ATTEMPTS` |
| Variável | camelCase | `userId` |
| Função | camelCase | `calculateTotal()` |

## 🚀 Como Adicionar um Novo Módulo

1. Criar pasta: `src/mymodule/`
2. Criar controller: `mymodule.controller.ts`
3. Criar service: `mymodule.service.ts`
4. Criar module: `mymodule.module.ts`
5. Criar DTOs: `dto/create-mymodule.dto.ts`
6. Adicionar ao `app.module.ts` imports
7. Criar rotas no controller com `@Controller()` e `@Get()`, etc

## 📚 Referências

- [NestJS Documentation](https://docs.nestjs.com)
- [Prisma Documentation](https://www.prisma.io/docs)
- [TypeScript Handbook](https://www.typescriptlang.org/docs)
- Documentação local: `docs/API_DOCUMENTATION.md`
