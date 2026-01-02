# 🔧 Troubleshooting & FAQ

## Problemas Comuns

### 1. Porta 3001 Já em Uso

**Erro:**
```
Error: listen EADDRINUSE: address already in use :::3001
```

**Solução:**
```bash
# Linux/Mac - Encontrar processo
lsof -i :3001

# Matar processo
kill -9 <PID>

# Ou usar porta diferente
PORT=3002 npm run start:dev
```

### 2. Erro de Conexão com Banco de Dados

**Erro:**
```
Error: Can't reach database server at `localhost:5432`
```

**Solução:**
```bash
# Verificar se PostgreSQL está rodando
psql -U postgres

# Ou se usar Docker
docker-compose up -d db

# Verificar variável DATABASE_URL em .env
cat .env | grep DATABASE_URL

# Testar conexão
psql postgresql://user:password@localhost:5432/pdvdb
```

### 3. Prisma Migration Falha

**Erro:**
```
Error: Migrations have failed
```

**Solução:**
```bash
# Reset do banco (DELETE todos dados)
npx prisma migrate reset

# Ou criar migration manualmente
npx prisma migrate dev --name fix_schema

# Rever migrations
npx prisma migrate resolve
```

### 4. "Cannot find module" Errors

**Erro:**
```
Cannot find module '@nestjs/common'
```

**Solução:**
```bash
# Reinstalar node_modules
rm -rf node_modules package-lock.json
npm install

# Ou limpar cache npm
npm cache clean --force
npm install
```

### 5. Erro de Compilação TypeScript

**Erro:**
```
error TS2345: Argument of type 'X' is not assignable to parameter of type 'Y'
```

**Solução:**
```bash
# Verificar tipos
npx tsc --noEmit

# Limpar dist e recompilar
rm -rf dist
npm run build

# Verificar importações e tipos no arquivo
```

### 6. JWT Token Inválido

**Erro:**
```
Unauthorized: Invalid token
```

**Solução:**
```bash
# 1. Verificar se JWT_SECRET está em .env
cat .env | grep JWT_SECRET

# 2. Gerar novo token (login)
curl -X POST http://localhost:3001/api/auth/login \
  -H "Content-Type: application/json" \
  -d '{"username":"admin","password":"Admin@123"}'

# 3. Usar token no header
curl -H "Authorization: Bearer <token>" http://localhost:3001/api/products
```

### 7. Rate Limit - Muitas Requisições

**Erro:**
```
{"statusCode": 429, "message": "Muitas requisições"}
```

**Solução:**
```bash
# Aguardar 15 minutos
# Ou mudar de IP/proxy
# Ou alterar RATE_LIMIT_CONFIG em src/constants/index.ts
```

### 8. Seed Falha

**Erro:**
```
Error during seed: Unique constraint failed
```

**Solução:**
```bash
# Reset do banco antes de seed
npx prisma migrate reset

# Ou deletar dados e rodar seed
npx prisma db execute --stdin < delete-data.sql
npm run seed
```

### 9. Arquivo de Log Não Criado

**Erro:**
```
EACCES: permission denied, open 'logs/combined.log'
```

**Solução:**
```bash
# Criar pasta logs
mkdir -p logs

# Dar permissões
chmod 755 logs
chmod 644 logs/*.log

# Ou rodar com permissões corretas
sudo npm run start:dev
```

### 10. Docker Build Falha

**Erro:**
```
Docker build failed
```

**Solução:**
```bash
# Verificar Dockerfile
cat Dockerfile

# Limpar build antigo
docker system prune

# Rebuildar
docker build -t pdv-api:latest .

# Ou usar docker-compose
docker-compose build --no-cache
```

---

## Problemas de Performance

### Queries Lentas

```bash
# 1. Ativar logging de queries
NODE_ENV=development npm run start:dev

# 2. Verificar índices
npx prisma studio

# 3. Analisar EXPLAIN PLAN
psql -U postgres -d pdvdb -c "EXPLAIN ANALYZE SELECT ..."

# 4. Adicionar índices em schema.prisma
```

### Alto Uso de Memória

```bash
# 1. Profiler
node --inspect dist/main.js

# 2. Aumentar limite Node.js
node --max-old-space-size=4096 dist/main.js

# 3. Verificar leaks
npm install clinic
clinic doctor -- npm run start:dev
```

### Compilação Lenta

```bash
# 1. Incrementar TypeScript
npm run build

# 2. Usar SWC (mais rápido)
npm install -D @swc/core

# 3. Desabilitar type checking em dev
npm run start:dev -- --no-emit
```

---

## Debugging

### Visual Studio Code

**`.vscode/launch.json`:**
```json
{
  "version": "0.2.0",
  "configurations": [
    {
      "type": "node",
      "request": "launch",
      "name": "Debug NestJS",
      "program": "${workspaceFolder}/node_modules/.bin/nest",
      "args": ["start", "--debug", "--watch"],
      "console": "integratedTerminal"
    }
  ]
}
```

### Chrome DevTools

```bash
npm run start:debug

# Abrir chrome://inspect no Chrome
# Click em "inspect"
```

### console.log vs Logger

```typescript
// ❌ RUIM
console.log('User found:', user);

// ✅ BOM
this.logger.log('User found', { userId: user.id });
```

### Logs em Produção

```bash
# Visualizar todos os logs
tail -f logs/combined.log

# Apenas erros
tail -f logs/error.log

# JSON parsing
cat logs/combined.log | jq .

# Filtrar por status
cat logs/combined.log | jq 'select(.statusCode >= 400)'
```

---

## Checklist de Troubleshooting

Quando encontrar um problema, verificar nesta ordem:

- [ ] Erro está no console/logs?
- [ ] Variáveis de ambiente estão corretas?
- [ ] Banco de dados está rodando?
- [ ] Node.js/npm estão atualizados?
- [ ] Port está disponível?
- [ ] Dependências estão instaladas?
- [ ] TypeScript compila sem erros?
- [ ] Git está atualizado?
- [ ] Cache está limpo?

---

## Reporting Issues

Ao reportar bugs, incluir:

1. **Versão do Node.js**: `node -v`
2. **Sistema Operacional**: Windows/Linux/Mac
3. **Erro completo**: copiar stack trace
4. **Passos para reproduzir**: como gerar o erro
5. **Comportamento esperado**: o que deveria acontecer
6. **Logs relevantes**: do arquivo ou console

---

## Suporte

- 📖 Documentação: `docs/`
- 🐛 Issues: GitHub Issues
- 💬 Discussões: GitHub Discussions
- 📧 Email: seu-email@exemplo.com

---

**Não achou a solução?** Crie uma issue com todos os detalhes! 🙏
