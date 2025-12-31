import { Injectable, NotFoundException, ConflictException } from '@nestjs/common';
import { PrismaService } from '../prisma/prisma.service';
import { CreateCustomerDto } from './dto/create-customer.dto';
import { UpdateCustomerDto } from './dto/update-customer.dto';

@Injectable()
export class CustomersService {
  constructor(private prisma: PrismaService) {}

  async create(createCustomerDto: CreateCustomerDto) {
    if (createCustomerDto.document) {
      const existingCustomer = await this.prisma.customer.findUnique({
        where: { document: createCustomerDto.document },
      });

      if (existingCustomer) {
        throw new ConflictException('Cliente com este documento já existe');
      }
    }

    return this.prisma.customer.create({
      data: createCustomerDto,
      include: { sales: true },
    });
  }

  async findAll(filters?: { name?: string; document?: string }) {
    const where: any = {};

    if (filters?.name) {
      where.name = { contains: filters.name, mode: 'insensitive' };
    }

    if (filters?.document) {
      where.document = filters.document;
    }

    return this.prisma.customer.findMany({
      where,
      include: { sales: true },
      orderBy: { name: 'asc' },
    });
  }

  async findOne(id: number) {
    const customer = await this.prisma.customer.findUnique({
      where: { id },
      include: { sales: true },
    });

    if (!customer) {
      throw new NotFoundException(`Cliente com ID ${id} não encontrado`);
    }

    return customer;
  }

  async update(id: number, updateCustomerDto: UpdateCustomerDto) {
    await this.findOne(id);

    if (updateCustomerDto.document) {
      const existingCustomer = await this.prisma.customer.findUnique({
        where: { document: updateCustomerDto.document },
      });

      if (existingCustomer && existingCustomer.id !== id) {
        throw new ConflictException('Cliente com este documento já existe');
      }
    }

    return this.prisma.customer.update({
      where: { id },
      data: updateCustomerDto,
      include: { sales: true },
    });
  }

  async remove(id: number) {
    await this.findOne(id);

    return this.prisma.customer.delete({
      where: { id },
      include: { sales: true },
    });
  }
}
