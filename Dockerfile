# ============================================
# Build Stage
# ============================================
FROM node:22-alpine AS builder

WORKDIR /app

# Copia package.json e package-lock.json
COPY package*.json ./

# Instala dependências
RUN npm ci

# Copia código-fonte
COPY . .

# Gera o cliente Prisma
RUN npx prisma generate

# Build do projeto
RUN npm run build

# ============================================
# Production Stage
# ============================================
FROM node:22-alpine

WORKDIR /app

# Copia package.json e package-lock.json
COPY package*.json ./

# Instala apenas dependências de produção
RUN npm ci --only=production && npm cache clean --force

# Copia o código compilado do builder
COPY --from=builder /app/dist ./dist

# Copia o arquivo .env (se existir) - melhor usar em docker-compose
# COPY .env .env

# Expõe a porta padrão
EXPOSE 3001

# Comando para iniciar a aplicação
CMD ["sh", "-c", "npm run migrate && npm run start:prod"]
