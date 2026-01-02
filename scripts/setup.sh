#!/bin/bash

# Colors for output
GREEN='\033[0;32m'
RED='\033[0;31m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

echo -e "${BLUE}========================================${NC}"
echo -e "${BLUE}🌱 PDV API - Setup Complete Script${NC}"
echo -e "${BLUE}========================================${NC}"
echo ""

# Check if .env exists
if [ ! -f .env ]; then
    echo -e "${RED}❌ .env file not found!${NC}"
    echo -e "${YELLOW}Creating .env from .env.example...${NC}"
    if [ -f .env.example ]; then
        cp .env.example .env
        echo -e "${GREEN}✅ .env created${NC}"
    else
        echo -e "${RED}❌ .env.example not found!${NC}"
        exit 1
    fi
fi

# Check if node_modules exists
if [ ! -d node_modules ]; then
    echo -e "${YELLOW}Installing dependencies...${NC}"
    npm install
    if [ $? -ne 0 ]; then
        echo -e "${RED}❌ Failed to install dependencies${NC}"
        exit 1
    fi
    echo -e "${GREEN}✅ Dependencies installed${NC}"
fi

echo ""
echo -e "${BLUE}========== Database Setup ==========${NC}"

# Run Prisma migrations
echo -e "${YELLOW}Running Prisma migrations...${NC}"
npx prisma migrate deploy

if [ $? -ne 0 ]; then
    echo -e "${YELLOW}⚠️  Migrate deploy failed, trying migrate dev...${NC}"
    npx prisma migrate dev --name initial_setup
fi

echo -e "${GREEN}✅ Database migrations completed${NC}"

echo ""
echo -e "${BLUE}========== Database Seed ==========${NC}"

# Run seed
echo -e "${YELLOW}Running database seed...${NC}"
npm run seed

if [ $? -eq 0 ]; then
    echo -e "${GREEN}✅ Seed completed successfully${NC}"
else
    echo -e "${RED}❌ Seed failed${NC}"
    exit 1
fi

echo ""
echo -e "${BLUE}========= Build Application =========${NC}"

# Build application
echo -e "${YELLOW}Building application...${NC}"
npm run build

if [ $? -eq 0 ]; then
    echo -e "${GREEN}✅ Build completed${NC}"
else
    echo -e "${RED}❌ Build failed${NC}"
    exit 1
fi

echo ""
echo -e "${GREEN}========================================${NC}"
echo -e "${GREEN}✅ Setup Complete!${NC}"
echo -e "${GREEN}========================================${NC}"
echo ""
echo -e "${YELLOW}Next steps:${NC}"
echo -e "  1. Start development server:"
echo -e "     ${BLUE}npm run start:dev${NC}"
echo ""
echo -e "  2. Test health endpoint:"
echo -e "     ${BLUE}curl http://localhost:3001/api/health${NC}"
echo ""
echo -e "  3. Login with test credentials:"
echo -e "     Username: ${GREEN}admin${NC}"
echo -e "     Password: ${GREEN}Admin@123${NC}"
echo ""
echo -e "  4. Check logs:"
echo -e "     ${BLUE}tail -f logs/combined.log${NC}"
echo ""
echo -e "  5. View API documentation:"
echo -e "     See ${BLUE}API_DOCUMENTATION.md${NC} or ${BLUE}PHASE3_DOCS.md${NC}"
echo ""
echo -e "${BLUE}Default API Base URL:${NC} http://localhost:3001/api"
echo -e "${BLUE}Database:${NC} PostgreSQL (configure in .env)"
echo ""
