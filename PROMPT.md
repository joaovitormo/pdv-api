# Resumo e Prompt para Criação do Backend — Node.js + PostgreSQL

Este documento resume tudo o que é necessário para criar um backend em Node.js (preferencialmente com TypeScript) conectado a PostgreSQL para o sistema presente neste workspace. Use este arquivo como prompt para gerar o projeto automaticamente ou manualmente.

## Objetivo
- Criar um backend RESTful em Node.js (recomendado: NestJS ou Express + TypeScript) conectado a PostgreSQL para gerir produtos, vendas (PDV), clientes e usuários.

## Tecnologias recomendadas
- Runtime: Node.js 18+ (LTS)
- Linguagem: TypeScript (recomendado) ou JavaScript
- Frameworks: NestJS (estrutura completa) ou Express.js (mais leve)
- ORM/Query: Prisma (recomendado) ou TypeORM / Sequelize
- Banco de dados: PostgreSQL (>= 12)
- Migrations: Prisma Migrate ou TypeORM Migrations
- Build / Package: npm ou yarn (com `package.json`)
- Containerização: Docker + docker-compose
- Segurança: passport-jwt / jsonwebtoken (JWT) ou @nestjs/jwt
- Testes: Jest, Supertest
- Logging: Winston ou Pino
- CI: GitHub Actions

## Estrutura de projeto sugerida

- src/
  - controllers (rotas / controllers)
  - services (lógica de negócio)
  - repositories / prisma (acesso a dados)
  - models / entities (tipos e schemas)
  - dtos (interfaces / tipos para request/response)
  - config (carregamento de env, logger, db)
  - middlewares (auth, error-handling)
  - migrations (se usar SQL ou pasta `prisma/migrations`)
- prisma/ (se usar Prisma) ou ormconfig / migrations (se TypeORM)
- package.json, tsconfig.json, .env.example, Dockerfile, docker-compose.yml

## Arquivos essenciais a gerar
- `package.json` com scripts e dependências (ex.: `start`, `build`, `dev`, `test`)
  - Dependências típicas:
    - `express` ou `@nestjs/core`, `@nestjs/common`, `@nestjs/platform-express`
    - `prisma` + `@prisma/client` (ou `typeorm` + drivers)
    - `pg` (driver PostgreSQL)
    - `jsonwebtoken` (JWT) e/ou `passport` + `passport-jwt`
    - `dotenv` para variáveis de ambiente
    - `winston` ou `pino` para logging
  - DevDependencies:
    - `typescript`, `ts-node-dev` (ou `nodemon`), `jest`, `ts-jest`, `supertest`

- `application.yml` com profiles `dev` e `prod` e parâmetros:
  - spring.datasource.url, username, password
  - spring.jpa.hibernate.ddl-auto (usar none em prod)
  - flyway.enabled

- `Dockerfile` para a aplicação e `docker-compose.yml` com serviço `db` (Postgres) e `app`.

## Variáveis de ambiente sugeridas
- `NODE_ENV` (development/production)
- `DATABASE_URL` (ex.: `postgresql://user:pass@db:5432/pdvdb` — usado por Prisma/ORM)
- `DB_HOST`, `DB_PORT`, `DB_USER`, `DB_PASSWORD`, `DB_NAME` (alternativa)
- `JWT_SECRET`
- `PORT` (ex.: 3000/4000)

## Modelo de dados inicial (tabelas principais)

As tabelas sugeridas seguem o mesmo modelo do documento original; seguem campos principais para uso com PostgreSQL/Prisma:

1) `product` (produtos)
  - id: serial PK
  - sku: varchar unique
  - name: varchar
  - description: text
  - price: numeric(12,2)
  - stock_quantity: integer
  - category_id: FK -> category(id)

2) `category`
  - id: serial PK
  - name: varchar

3) `customer`
  - id: serial PK
  - name: varchar
  - document: varchar (CPF/CNPJ)
  - phone: varchar
  - email: varchar

4) `sale` (venda / pedido)
  - id: serial PK
  - date: timestamp
  - customer_id: FK -> customer(id) NULLABLE
  - total: numeric(12,2)
  - payment_method: varchar
  - status: varchar (OPEN, CLOSED, CANCELED)

5) `sale_item`
  - id: serial PK
  - sale_id: FK -> sale(id)
  - product_id: FK -> product(id)
  - quantity: integer
  - unit_price: numeric(12,2)
  - subtotal: numeric(12,2)

6) `user` (autenticação)
  - id: serial PK
  - username: varchar unique
  - password_hash: varchar
  - role: varchar

Índices e constraints: FK, índices em `sku`, `name`, `date`.

Observação: se usar Prisma, defina o schema `prisma/schema.prisma` refletindo esses modelos e use `prisma migrate dev` para criar as migrations.

Observação: há arquivos no workspace como `TabEst1.SQL` e `TabEst1.CSV` que podem conter dados e estruturas iniciais; use-os para modelagem ou importação.

## Endpoints REST sugeridos

- Auth
  - POST `/api/auth/login` -> retorna JWT
  - POST `/api/auth/register` (opcional)

- Produtos
  - GET `/api/products` -> list, filtros (name, category, sku)
  - GET `/api/products/:id`
  - POST `/api/products` -> create
  - PUT `/api/products/:id` -> update
  - DELETE `/api/products/:id`

- Vendas
  - POST `/api/sales` -> criar venda (body inclui itens)
  - GET `/api/sales/:id`
  - GET `/api/sales` -> filtros por date, status

- Clientes
  - CRUD padrão em `/api/customers`

- Usuários/Admin
  - CRUD básico em `/api/users` (apenas admins)

## Regras de negócio e validações importantes
- Ao criar uma `sale`, decrementar `product.stock_quantity` dentro de transação atômica.
- Validar estoque antes de confirmar a venda; considerar locking/serializable ou reservas via tabela de reservas.
- Calcular `subtotal` e `total` no backend (não confiar no cliente).
- Não expor `password_hash` nas respostas; armazenar senhas com bcrypt/argon2.

## Migrations e dados iniciais
- Se usar Prisma: criar `prisma/schema.prisma` e usar `prisma migrate` para gerar migrations (`prisma migrate dev` / `prisma migrate deploy`).
- Se usar TypeORM: usar migrations do TypeORM ou scripts SQL em `migrations/`.

Exemplo minimal de V1 em SQL (compatível com PostgreSQL):
```sql
CREATE TABLE category (id SERIAL PRIMARY KEY, name VARCHAR(255) NOT NULL);
CREATE TABLE product (id SERIAL PRIMARY KEY, sku VARCHAR(100) UNIQUE, name VARCHAR(255) NOT NULL, description TEXT, price NUMERIC(12,2) NOT NULL, stock_quantity INT NOT NULL DEFAULT 0, category_id INT REFERENCES category(id));
-- criar demais tabelas: customer, sale, sale_item, "user"
```

## Docker / docker-compose (exemplo)

- `docker-compose.yml` básico para Node.js + Postgres:
```yaml
version: '3.8'
services:
  db:
    image: postgres:14
    environment:
      POSTGRES_DB: pdvdb
      POSTGRES_USER: pdvuser
      POSTGRES_PASSWORD: pdvpass
    volumes:
      - db-data:/var/lib/postgresql/data
    ports:
      - '5432:5432'
  app:
    build: .
    depends_on:
      - db
    environment:
      DATABASE_URL: postgresql://pdvuser:pdvpass@db:5432/pdvdb
      JWT_SECRET: change-me
      NODE_ENV: development
    ports:
      - '3000:3000'
volumes:
  db-data:
```

Exemplo de `Dockerfile` simples (Node + TypeScript build):
```dockerfile
FROM node:18-alpine
WORKDIR /app
COPY package*.json ./
RUN npm ci --only=production
COPY . .
RUN npm run build
CMD ["node", "dist/main.js"]
```

## Segurança
- Usar HTTPS em produção (reverse proxy / ingress).
- Usar JWT para autenticação (`jsonwebtoken` / `@nestjs/jwt`) e proteger rotas via middleware/guards.
- Hash de senhas com `bcrypt` ou `argon2`.
- Roles: `ROLE_USER`, `ROLE_ADMIN`.

## Testes
- Unitários: Jest para serviços e lógica isolada.
- Integração: usar `supertest` para endpoints e Testcontainers (postgres) ou base de testes em memória quando aplicável.

## Logging e monitoramento
- Logs com Winston/Pino, preferir logs estruturados (JSON) para integração com ELK/Graylog.
- Expor métricas com Prometheus client (ou integrações específicas do framework).

## CI/CD
- Pipeline básico (GitHub Actions):
  - Instalar dependências (`npm ci`)
  - Lint / TypeCheck (`tsc`)
  - Testes (`npm test`)
  - Build da imagem Docker
  - Push para registry (opcional)

## Checklist mínimo para gerar o projeto automaticamente a partir deste prompt
1. Escolher: `NestJS` (recomendado) ou `Express` + infra.
2. Inicializar projeto (`npm init` ou `nest new / express + TS`).
3. Configurar `prisma` ou ORM escolhido e `DATABASE_URL`.
4. Criar migrations iniciais (`V1__init.sql` ou `prisma migrate`).
5. Implementar entidades/models, repositórios e serviços essenciais.
6. Implementar controllers/rotas REST para `products` e `sales`.
7. Adicionar `Dockerfile` e `docker-compose.yml` de exemplo.
8. Adicionar testes básicos, lint/tsc and workflow de CI.

## Notas finais / Observações específicas deste workspace
- Verifique `TabEst1.SQL` e `TabEst1.CSV` no root para importar dados ou adaptar o esquema.
- Ajuste nomes de campos e tipos conforme regras fiscais locais (ex.: alíquotas, impostos) se necessário.

## Próximos passos possíveis (sugestões)
- Gerar scaffold automático (`NestJS CLI` ou boilerplate Express + TypeScript) e commit inicial.
- Implementar endpoints mínimos (`Products` + `Sales`) e validar fluxo PDV.
- Acrescentar autenticação JWT e testes de integração.

----
Para eu gerar o projeto completo (código, Dockerfile, migrations e testes), responda se prefere `NestJS` ou `Express` e se quer autenticação JWT já inclusa. Posso então criar o scaffold completo e os primeiros endpoints.
