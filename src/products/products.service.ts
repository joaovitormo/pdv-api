import { Injectable, NotFoundException, ConflictException } from '@nestjs/common';
import { PrismaService } from '../prisma/prisma.service';
import { CreateProductDto } from './dto/create-product.dto';
import { UpdateProductDto } from './dto/update-product.dto';

@Injectable()
export class ProductsService {
  constructor(private prisma: PrismaService) {}

  async create(createProductDto: CreateProductDto) {
    const existingProduct = await this.prisma.product.findUnique({
      where: { sku: createProductDto.sku },
    });

    if (existingProduct) {
      throw new ConflictException('Produto com este SKU já existe');
    }

    const category = await this.prisma.category.findUnique({
      where: { id: createProductDto.categoryId },
    });

    if (!category) {
      throw new NotFoundException('Categoria não encontrada');
    }

    return this.prisma.product.create({
      data: {
        sku: createProductDto.sku,
        name: createProductDto.name,
        description: createProductDto.description,
        price: createProductDto.price,
        stockQuantity: createProductDto.stockQuantity || 0,
        categoryId: createProductDto.categoryId,
      },
      include: { category: true },
    });
  }

  async findAll(filters?: { name?: string; categoryId?: number; sku?: string }) {
    const where: any = {};

    if (filters?.name) {
      where.name = { contains: filters.name, mode: 'insensitive' };
    }

    if (filters?.categoryId) {
      where.categoryId = filters.categoryId;
    }

    if (filters?.sku) {
      where.sku = filters.sku;
    }

    return this.prisma.product.findMany({
      where,
      include: { category: true },
      orderBy: { name: 'asc' },
    });
  }

  async searchByName(name: string) {
    return this.prisma.product.findMany({
      where: {
        name: { contains: name, mode: 'insensitive' },
      },
      include: { category: true },
      orderBy: { name: 'asc' },
    });
  }

  async findOne(id: number) {
    const product = await this.prisma.product.findUnique({
      where: { id },
      include: { category: true },
    });

    if (!product) {
      throw new NotFoundException(`Produto com ID ${id} não encontrado`);
    }

    return product;
  }

  async update(id: number, updateProductDto: UpdateProductDto) {
    await this.findOne(id);

    if (updateProductDto.sku) {
      const existingProduct = await this.prisma.product.findUnique({
        where: { sku: updateProductDto.sku },
      });

      if (existingProduct && existingProduct.id !== id) {
        throw new ConflictException('Produto com este SKU já existe');
      }
    }

    if (updateProductDto.categoryId) {
      const category = await this.prisma.category.findUnique({
        where: { id: updateProductDto.categoryId },
      });

      if (!category) {
        throw new NotFoundException('Categoria não encontrada');
      }
    }

    return this.prisma.product.update({
      where: { id },
      data: updateProductDto,
      include: { category: true },
    });
  }

  async remove(id: number) {
    await this.findOne(id);

    return this.prisma.product.delete({
      where: { id },
      include: { category: true },
    });
  }

  async decrementStock(id: number, quantity: number) {
    const product = await this.findOne(id);

    if (product.stockQuantity < quantity) {
      throw new NotFoundException('Estoque insuficiente');
    }

    return this.prisma.product.update({
      where: { id },
      data: { stockQuantity: { decrement: quantity } },
      include: { category: true },
    });
  }
}
