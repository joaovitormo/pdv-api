#!/bin/bash

# ============================================
# PDV API - Exemplos de Teste com cURL
# ============================================
# Execute este arquivo assim:
# chmod +x test-api.sh
# ./test-api.sh
# ============================================

API_URL="http://localhost:3001/api"
TOKEN=""

echo "🚀 Iniciando testes da API PDV..."
echo ""

# ============================================
# 1. AUTENTICAÇÃO
# ============================================
echo "📝 1. Registrando novo usuário..."
REGISTER_RESPONSE=$(curl -s -X POST "$API_URL/auth/register" \
  -H "Content-Type: application/json" \
  -d '{
    "username": "admin_test",
    "email": "admin@test.com",
    "password": "Senha@123"
  }')
echo "Response: $REGISTER_RESPONSE"
echo ""

echo "🔐 2. Fazendo login..."
LOGIN_RESPONSE=$(curl -s -X POST "$API_URL/auth/login" \
  -H "Content-Type: application/json" \
  -d '{
    "username": "admin_test",
    "password": "Senha@123"
  }')
echo "Response: $LOGIN_RESPONSE"

# Extrair token (requer jq instalado)
TOKEN=$(echo $LOGIN_RESPONSE | grep -o '"access_token":"[^"]*' | cut -d'"' -f4)
if [ -z "$TOKEN" ]; then
  echo "❌ Falha ao obter token"
  exit 1
fi
echo "✅ Token obtido: ${TOKEN:0:20}..."
echo ""

# ============================================
# 2. CATEGORIAS
# ============================================
echo "🏷️ 3. Criando categoria..."
CATEGORY_RESPONSE=$(curl -s -X POST "$API_URL/categories" \
  -H "Content-Type: application/json" \
  -H "Authorization: Bearer $TOKEN" \
  -d '{
    "name": "Bebidas"
  }')
echo "Response: $CATEGORY_RESPONSE"

CATEGORY_ID=$(echo $CATEGORY_RESPONSE | grep -o '"id":[0-9]*' | head -1 | cut -d':' -f2)
echo "✅ Categoria criada com ID: $CATEGORY_ID"
echo ""

echo "📋 4. Listando categorias..."
curl -s -X GET "$API_URL/categories" \
  -H "Content-Type: application/json" | jq '.' || echo "Sem jq: listagem realizada"
echo ""

# ============================================
# 3. PRODUTOS
# ============================================
echo "📦 5. Criando produto..."
PRODUCT_RESPONSE=$(curl -s -X POST "$API_URL/products" \
  -H "Content-Type: application/json" \
  -H "Authorization: Bearer $TOKEN" \
  -d "{
    \"sku\": \"PROD-001\",
    \"name\": \"Coca-Cola 2L\",
    \"description\": \"Refrigerante Coca-Cola em garrafa de 2 litros\",
    \"price\": 8.50,
    \"stockQuantity\": 50,
    \"categoryId\": $CATEGORY_ID
  }")
echo "Response: $PRODUCT_RESPONSE"

PRODUCT_ID=$(echo $PRODUCT_RESPONSE | grep -o '"id":[0-9]*' | head -1 | cut -d':' -f2)
echo "✅ Produto criado com ID: $PRODUCT_ID"
echo ""

echo "🔍 6. Listando produtos..."
curl -s -X GET "$API_URL/products" \
  -H "Content-Type: application/json" | jq '.' || echo "Sem jq: listagem realizada"
echo ""

# ============================================
# 4. CLIENTES
# ============================================
echo "👤 7. Criando cliente..."
CUSTOMER_RESPONSE=$(curl -s -X POST "$API_URL/customers" \
  -H "Content-Type: application/json" \
  -H "Authorization: Bearer $TOKEN" \
  -d '{
    "name": "João Silva",
    "document": "123.456.789-00",
    "email": "joao@example.com",
    "phone": "(11) 98765-4321"
  }')
echo "Response: $CUSTOMER_RESPONSE"

CUSTOMER_ID=$(echo $CUSTOMER_RESPONSE | grep -o '"id":[0-9]*' | head -1 | cut -d':' -f2)
echo "✅ Cliente criado com ID: $CUSTOMER_ID"
echo ""

echo "📞 8. Listando clientes..."
curl -s -X GET "$API_URL/customers" \
  -H "Content-Type: application/json" | jq '.' || echo "Sem jq: listagem realizada"
echo ""

# ============================================
# 5. VENDAS
# ============================================
echo "💳 9. Criando venda..."
SALE_RESPONSE=$(curl -s -X POST "$API_URL/sales" \
  -H "Content-Type: application/json" \
  -H "Authorization: Bearer $TOKEN" \
  -d "{
    \"items\": [
      {
        \"productId\": $PRODUCT_ID,
        \"quantity\": 2,
        \"unitPrice\": 8.50
      }
    ],
    \"customerId\": $CUSTOMER_ID,
    \"paymentMethod\": \"DINHEIRO\",
    \"status\": \"COMPLETED\"
  }")
echo "Response: $SALE_RESPONSE"

SALE_ID=$(echo $SALE_RESPONSE | grep -o '"id":[0-9]*' | head -1 | cut -d':' -f2)
echo "✅ Venda criada com ID: $SALE_ID"
echo ""

echo "🧾 10. Listando vendas..."
curl -s -X GET "$API_URL/sales" \
  -H "Content-Type: application/json" | jq '.' || echo "Sem jq: listagem realizada"
echo ""

echo "📊 11. Consultando venda específica..."
curl -s -X GET "$API_URL/sales/$SALE_ID" \
  -H "Content-Type: application/json" | jq '.' || echo "Sem jq: consulta realizada"
echo ""

# ============================================
# 6. CANCELAMENTO
# ============================================
echo "❌ 12. Cancelando venda..."
curl -s -X POST "$API_URL/sales/$SALE_ID/cancel" \
  -H "Content-Type: application/json" \
  -H "Authorization: Bearer $TOKEN" | jq '.' || echo "Venda cancelada"
echo ""

echo "✅ Testes concluídos!"
echo ""
echo "📌 Notas:"
echo "  - Instale 'jq' para melhor visualização: sudo apt install jq"
echo "  - Guarde o TOKEN para requisições futuras"
echo "  - Estoque foi decrementado ao vender e restaurado ao cancelar"
