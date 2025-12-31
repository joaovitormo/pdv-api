import { PrismaClient, Role } from '@prisma/client';
import * as bcrypt from 'bcrypt';
import 'dotenv/config';

const prisma = new PrismaClient({
  datasource: {
    url: process.env.DATABASE_URL,
  },
} as any); 

async function main() {
  const hashedPassword = await bcrypt.hash('adminpassword', 10);

  console.log('🌱 Tentando conectar e rodar o seed...');

  const admin = await prisma.user.upsert({
    where: { username: 'admin' },
    update: {
      passwordHash: hashedPassword,
      email: 'admin@sistema.com',
    },
    create: {
      username: 'admin',
      email: 'admin@sistema.com',
      passwordHash: hashedPassword,
      role: Role.ADMIN,
      active: true,
    },
  });

  console.log('✅ Usuário Admin garantido no banco:', admin.username);
}

main()
  .catch((e) => {
    console.error('❌ Erro no seed:', e);
    process.exit(1);
  })
  .finally(async () => {
    await prisma.$disconnect();
  });