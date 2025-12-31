import { PrismaClient, Role, Category, Customer } from '@prisma/client';
import * as bcrypt from 'bcrypt';
import 'dotenv/config';

const prisma = new PrismaClient({
  datasource: {
    url: process.env.DATABASE_URL,
  },
} as any);

async function main() {
  console.log('🌱 Iniciando seed do banco de dados...');

  const adminPassword = await bcrypt.hash('Admin@123', 10);
  const adminUser = await prisma.user.upsert({
    where: { username: 'admin' },
    update: {
      passwordHash: adminPassword,
      email: 'admin@pdv.com',
      active: true,
    },
    create: {
      username: 'admin',
      email: 'admin@pdv.com',
      passwordHash: adminPassword,
      role: Role.ADMIN,
      active: true,
    },
  });
  console.log('✅ Usuário admin criado/atualizado:', adminUser.username);

  const sellerPassword = await bcrypt.hash('Vendedor@123', 10);
  const sellerUser = await prisma.user.upsert({
    where: { username: 'vendedor' },
    update: {
      passwordHash: sellerPassword,
      email: 'vendedor@pdv.com',
      active: true,
    },
    create: {
      username: 'vendedor',
      email: 'vendedor@pdv.com',
      passwordHash: sellerPassword,
      role: Role.USER,
      active: true,
    },
  });
  console.log('✅ Usuário vendedor criado/atualizado:', sellerUser.username);

  const categories = [
    { name: 'Bebidas' },
    { name: 'Alimentos' },
    { name: 'Produtos de Limpeza' },
    { name: 'Higiene e Saúde' },
    { name: 'Eletrônicos' },
  ];

  const createdCategories: Category[] = [];
  for (const cat of categories) {
    const category = await prisma.category.upsert({
      where: { name: cat.name },
      update: {},
      create: cat,
    });
    createdCategories.push(category);
    console.log('✅ Categoria criada:', category.name);
  }

  const products = [
    {
      sku: 'BEB-001',
      name: 'Coca-Cola 2L',
      description: 'Refrigerante Coca-Cola em garrafa de 2 litros',
      price: 8.5,
      stockQuantity: 100,
      categoryId: createdCategories[0].id, 
    },
    {
      sku: 'BEB-002',
      name: 'Suco Natural 1L',
      description: 'Suco natural de laranja 100%',
      price: 7.99,
      stockQuantity: 50,
      categoryId: createdCategories[0].id,
    },
    {
      sku: 'ALI-001',
      name: 'Pão Francês (kg)',
      description: 'Pão francês fresco diário',
      price: 12.0,
      stockQuantity: 30,
      categoryId: createdCategories[1].id, 
    },
    {
      sku: 'ALI-002',
      name: 'Queijo Meia Cura 500g',
      description: 'Queijo meia cura premium',
      price: 35.0,
      stockQuantity: 20,
      categoryId: createdCategories[1].id,
    },
    {
      sku: 'LIM-001',
      name: 'Detergente 500ml',
      description: 'Detergente neutro para lavar louça',
      price: 3.5,
      stockQuantity: 150,
      categoryId: createdCategories[2].id,
    },
    {
      sku: 'HIG-001',
      name: 'Sabonete Líquido 250ml',
      description: 'Sabonete líquido hidratante',
      price: 5.99,
      stockQuantity: 80,
      categoryId: createdCategories[3].id, 
    },
    {
      sku: 'ELE-001',
      name: 'Carregador Rápido USB-C',
      description: 'Carregador rápido de 20W',
      price: 89.99,
      stockQuantity: 25,
      categoryId: createdCategories[4].id, 
    },
  ];

  for (const prod of products) {
    const product = await prisma.product.upsert({
      where: { sku: prod.sku },
      update: {},
      create: prod,
    });
    console.log('✅ Produto criado:', product.name);
  }

  const customers = [
    {
      name: 'João Silva',
      document: '123.456.789-00',
      email: 'joao.silva@email.com',
      phone: '(11) 98765-4321',
    },
    {
      name: 'Maria Santos',
      document: '987.654.321-00',
      email: 'maria.santos@email.com',
      phone: '(11) 99876-5432',
    },
    {
      name: 'Pedro Oliveira',
      document: '456.789.123-00',
      email: 'pedro.oliveira@email.com',
      phone: '(11) 97654-3210',
    },
  ];

  const createdCustomers: Customer[] = [];
  for (const cust of customers) {
    const customer = await prisma.customer.upsert({
      where: { document: cust.document },
      update: {},
      create: cust,
    });
    createdCustomers.push(customer);
    console.log('✅ Cliente criado:', customer.name);
  }

  console.log('✅ Seed concluído com sucesso!');
  console.log(`
📊 Resumo:
  - 2 usuários criados
  - 5 categorias criadas
  - 7 produtos criados
  - 3 clientes criados

🔐 Credenciais de Teste:
  Admin: admin / Admin@123
  Vendedor: vendedor / Vendedor@123
  `);
}

main()
  .catch((e) => {
    console.error('❌ Erro durante seed:', e);
    process.exit(1);
  })
  .finally(async () => {
    await prisma.$disconnect();
  });