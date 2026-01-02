# 🛒 PDV API - Backend

Sistema completo de API REST para gerenciamento de Ponto de Venda (PDV) com suporte a produtos, vendas, clientes e categorias.

## ✨ Características

- ✅ **Autenticação JWT** - Login e registro de usuários
- ✅ **CRUD Completo** - Produtos, Categorias, Clientes e Vendas
- ✅ **Controle de Estoque** - Validação e decremento automático
- ✅ **Cancelamento de Vendas** - Com restauração de estoque
- ✅ **Validação de DTOs** - Usando class-validator
- ✅ **Global Error Handling** - Tratamento centralizado de erros
- ✅ **CORS** - Configurável via variáveis de ambiente
- ✅ **Docker** - Containerização completa

## 🚀 Quick Start

### Pré-requisitos

- Node.js 18+ (LTS)
- PostgreSQL 12+
- npm ou yarn

### 1. Instalação

```bash
# Instalar dependências
npm install
```

### 2. Configurar Variáveis de Ambiente

Copie o arquivo `.env` (já está configurado) e ajuste conforme necessário:

```bash
cp .env .env.local
```

### 3. Inicializar Banco de Dados

```bash
# Executar migrations do Prisma
npx prisma migrate dev

# (Opcional) Seed inicial
npx prisma db seed
```

### 4. Executar Servidor

```bash
# Desenvolvimento
npm run start:dev

# Produção
npm run build
npm run start
```

O servidor estará rodando em `http://localhost:3001`

---

## 📚 Documentação

- **[📖 Estrutura do Projeto](./docs/PROJECT_STRUCTURE.md)** - Guia completo da organização
- **[🔌 API Documentation](./docs/API_DOCUMENTATION.md)** - Referência de endpoints
- **[🛠️ FASE 3: Logging & Health](./docs/PHASE3_DOCS.md)** - Observabilidade
- **[📝 Guia de Contribuição](./docs/CONTRIBUTING.md)** - Padrões de código
- **[🔧 Troubleshooting](./docs/TROUBLESHOOTING.md)** - Solução de problemas
- **[✅ Implementação Completa](./docs/IMPLEMENTATION_COMPLETE.md)** - Resumo final

---

## 🧪 Testando a API

### Opção 1: Script Automatizado

```bash
chmod +x scripts/test-api.sh
./scripts/test-api.sh
```

### Opção 2: Postman/Insomnia

1. File → Import
2. Selecione `pdv-api-collection.json`
3. Use credenciais: `admin` / `Admin@123`

### Opção 3: cURL Manual

```bash
# Registrar usuário
curl -X POST http://localhost:3001/api/auth/register \
  -H "Content-Type: application/json" \
  -d '{
    "username": "teste",
    "email": "teste@example.com",
    "password": "senha123"
  }'

# Fazer login
curl -X POST http://localhost:3001/api/auth/login \
  -H "Content-Type: application/json" \
  -d '{
    "username": "teste",
    "password": "senha123"
  }'

# Usar token em requisições protegidas
curl -X GET http://localhost:3001/api/products \
  -H "Authorization: Bearer seu_token_aqui"
```

---

## 📁 Estrutura do Projeto

```
src/
├── auth/                    # Autenticação e JWT
│   ├── dto/                 # Login e Register DTOs
│   ├── guards/              # JWT Guard
│   ├── decorators/          # @Public, @CurrentUser
│   ├── auth.controller.ts
│   ├── auth.service.ts
│   └── auth.module.ts
├── products/                # Módulo de Produtos
├── categories/              # Módulo de Categorias
├── customers/               # Módulo de Clientes
├── sales/                   # Módulo de Vendas
├── common/
│   └── filters/             # Global Exception Filter
├── prisma/                  # Configuração do Prisma
├── app.module.ts
└── main.ts

prisma/
├── schema.prisma            # Schema do banco
├── seed.ts                  # Seeds iniciais
└── migrations/              # Histórico de migrations
```

---

## 🔐 Segurança

- **Senhas** - Hash com bcrypt, nunca expostas nas respostas
- **JWT** - Token com expiração de 24 horas
- **Validação** - DTOs validados com class-validator
- **CORS** - Configurável via `.env`
- **Proteção** - Rotas protegidas com JWT Guard

---

## 🗄️ Banco de Dados

### Tabelas Principais

| Tabela | Descrição |
|--------|-----------|
| `users` | Usuários do sistema com autenticação |
| `categories` | Categorias de produtos |
| `products` | Produtos com controle de estoque |
| `customers` | Clientes das vendas |
| `sales` | Histórico de vendas |
| `sale_items` | Itens de cada venda |

### Diagrama de Relacionamentos

```
users (id, username, email, passwordHash, role, active)
categories (id, name) ─┐
products (id, sku, name, price, stockQuantity) ←┘
customers (id, name, document, email, phone)
sales (id, date, total, paymentMethod, status) ←┐
sale_items (id, productId, quantity, unitPrice) ←┘
```

---

## 📊 Endpoints Principais

### Autenticação
- `POST /api/auth/register` - Registrar usuário
- `POST /api/auth/login` - Login

### Produtos
- `GET /api/products` - Listar produtos
- `POST /api/products` - Criar produto (requer auth)
- `PUT /api/products/:id` - Atualizar produto
- `DELETE /api/products/:id` - Deletar produto

### Categorias
- `GET /api/categories` - Listar categorias
- `POST /api/categories` - Criar categoria (requer auth)

### Clientes
- `GET /api/customers` - Listar clientes
- `POST /api/customers` - Criar cliente (requer auth)

### Vendas
- `POST /api/sales` - Criar venda (requer auth, valida estoque)
- `GET /api/sales` - Listar vendas
- `POST /api/sales/:id/cancel` - Cancelar venda (restaura estoque)

---

## 🐳 Docker

### Executar com Docker Compose

```bash
# Iniciar serviços (PostgreSQL + API)
docker-compose up -d

# Ver logs
docker-compose logs -f

# Parar serviços
docker-compose down
```

O arquivo `docker-compose.yml` já está configurado com:
- PostgreSQL 14
- API NestJS
- Volumes para persistência

---

## 📦 Scripts Disponíveis

```bash
npm run start:dev      # Desenvolvimento com watch
npm run build          # Build para produção
npm run start          # Executar build produção
npm run lint           # ESLint
npm run test           # Testes unitários
npm test:e2e           # Testes E2E
```

---

## 🛠️ Variáveis de Ambiente

Criar/editar `.env`:

```bash
# Database
DATABASE_URL="postgresql://user:password@localhost:5432/pdvdb"

# JWT
JWT_SECRET="sua_chave_secreta_aqui"
JWT_EXPIRES_IN="24h"

# App
PORT=3001
NODE_ENV=development
CORS_ORIGIN=*
```

---

## 📝 Exemplos de Uso

### Criar Produto

```bash
curl -X POST http://localhost:3001/api/products \
  -H "Content-Type: application/json" \
  -H "Authorization: Bearer $TOKEN" \
  -d '{
    "sku": "PROD-001",
    "name": "Coca-Cola 2L",
    "price": 8.50,
    "stockQuantity": 50,
    "categoryId": 1
  }'
```

### Criar Venda

```bash
curl -X POST http://localhost:3001/api/sales \
  -H "Content-Type: application/json" \
  -H "Authorization: Bearer $TOKEN" \
  -d '{
    "items": [
      {
        "productId": 1,
        "quantity": 2,
        "unitPrice": 8.50
      }
    ],
    "customerId": 1,
    "paymentMethod": "DINHEIRO"
  }'
```

---

## 🚨 Troubleshooting

**Erro: `EADDRINUSE: address already in use :::3001`**
```bash
# Matar processo na porta 3001
lsof -i :3001 | grep LISTEN | awk '{print $2}' | xargs kill -9
```

**Erro: `database does not exist`**
```bash
# Recriar banco e migrations
npx prisma migrate dev
```

**Erro: `Can't reach database server`**
- Verifique se PostgreSQL está rodando
- Confirm DATABASE_URL no `.env`

---

## 🤝 Contribuindo

1. Crie uma branch (`git checkout -b feature/AmazingFeature`)
2. Commit suas mudanças (`git commit -m 'Add some AmazingFeature'`)
3. Push para a branch (`git push origin feature/AmazingFeature`)
4. Abra um Pull Request

---

## 📄 Licença

Este projeto está sob licença MIT.

---

## 📞 Suporte

Para dúvidas ou problemas, consulte a [Documentação Completa](./API_DOCUMENTATION.md).

---

**Versão:** 1.0  
**Última atualização:** 31 de dezembro de 2025

$ npm install
```

## Compile and run the project

```bash
# development
$ npm run start

# watch mode
$ npm run start:dev

# production mode
$ npm run start:prod
```

## Run tests

```bash
# unit tests
$ npm run test

# e2e tests
$ npm run test:e2e

# test coverage
$ npm run test:cov
```

## Deployment

When you're ready to deploy your NestJS application to production, there are some key steps you can take to ensure it runs as efficiently as possible. Check out the [deployment documentation](https://docs.nestjs.com/deployment) for more information.

If you are looking for a cloud-based platform to deploy your NestJS application, check out [Mau](https://mau.nestjs.com), our official platform for deploying NestJS applications on AWS. Mau makes deployment straightforward and fast, requiring just a few simple steps:

```bash
$ npm install -g @nestjs/mau
$ mau deploy
```

With Mau, you can deploy your application in just a few clicks, allowing you to focus on building features rather than managing infrastructure.

## Resources

Check out a few resources that may come in handy when working with NestJS:

- Visit the [NestJS Documentation](https://docs.nestjs.com) to learn more about the framework.
- For questions and support, please visit our [Discord channel](https://discord.gg/G7Qnnhy).
- To dive deeper and get more hands-on experience, check out our official video [courses](https://courses.nestjs.com/).
- Deploy your application to AWS with the help of [NestJS Mau](https://mau.nestjs.com) in just a few clicks.
- Visualize your application graph and interact with the NestJS application in real-time using [NestJS Devtools](https://devtools.nestjs.com).
- Need help with your project (part-time to full-time)? Check out our official [enterprise support](https://enterprise.nestjs.com).
- To stay in the loop and get updates, follow us on [X](https://x.com/nestframework) and [LinkedIn](https://linkedin.com/company/nestjs).
- Looking for a job, or have a job to offer? Check out our official [Jobs board](https://jobs.nestjs.com).

## Support

Nest is an MIT-licensed open source project. It can grow thanks to the sponsors and support by the amazing backers. If you'd like to join them, please [read more here](https://docs.nestjs.com/support).

## Stay in touch

- Author - [Kamil Myśliwiec](https://twitter.com/kammysliwiec)
- Website - [https://nestjs.com](https://nestjs.com/)
- Twitter - [@nestframework](https://twitter.com/nestframework)

## License

Nest is [MIT licensed](https://github.com/nestjs/nest/blob/master/LICENSE).
