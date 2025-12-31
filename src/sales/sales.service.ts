import { Injectable, NotFoundException, BadRequestException } from '@nestjs/common';
import { PrismaService } from '../prisma/prisma.service';
import { ProductsService } from '../products/products.service';
import { CreateSaleDto, CreateSaleItemDto } from './dto/create-sale.dto';
import { UpdateSaleDto } from './dto/update-sale.dto';
import { SaleStatus } from '@prisma/client';

@Injectable()
export class SalesService {
  constructor(
    private prisma: PrismaService,
    private productsService: ProductsService,
  ) {}

  async create(createSaleDto: CreateSaleDto) {
    if (!createSaleDto.items || createSaleDto.items.length === 0) {
      throw new BadRequestException('Venda deve ter pelo menos um item');
    }

    let total = 0;
    const itemsData: any[] = [];

    for (const item of createSaleDto.items) {
      const product = await this.productsService.findOne(item.productId);

      if (product.stockQuantity < item.quantity) {
        throw new BadRequestException(
          `Estoque insuficiente para produto ${product.name}. Disponível: ${product.stockQuantity}, solicitado: ${item.quantity}`,
        );
      }

      const subtotal = item.quantity * item.unitPrice;
      total += subtotal;

      itemsData.push({
        productId: item.productId,
        quantity: item.quantity,
        unitPrice: item.unitPrice,
        subtotal,
      });
    }

    if (createSaleDto.customerId) {
      const customer = await this.prisma.customer.findUnique({
        where: { id: createSaleDto.customerId },
      });

      if (!customer) {
        throw new NotFoundException(
          `Cliente com ID ${createSaleDto.customerId} não encontrado`,
        );
      }
    }

    const sale = await this.prisma.sale.create({
      data: {
        total,
        paymentMethod: createSaleDto.paymentMethod,
        status: createSaleDto.status || SaleStatus.COMPLETED,
        customerId: createSaleDto.customerId,
        items: {
          create: itemsData,
        },
      },
      include: {
        items: {
          include: { product: true },
        },
        customer: true,
      },
    });

    for (const item of createSaleDto.items) {
      await this.productsService.decrementStock(
        item.productId,
        item.quantity,
      );
    }

    return sale;
  }

  async findAll(filters?: { status?: SaleStatus; customerId?: number }) {
    const where: any = {};

    if (filters?.status) {
      where.status = filters.status;
    }

    if (filters?.customerId) {
      where.customerId = filters.customerId;
    }

    return this.prisma.sale.findMany({
      where,
      include: {
        items: {
          include: { product: true },
        },
        customer: true,
      },
      orderBy: { date: 'desc' },
    });
  }

  async findOne(id: number) {
    const sale = await this.prisma.sale.findUnique({
      where: { id },
      include: {
        items: {
          include: { product: true },
        },
        customer: true,
      },
    });

    if (!sale) {
      throw new NotFoundException(`Venda com ID ${id} não encontrada`);
    }

    return sale;
  }

  async update(id: number, updateSaleDto: UpdateSaleDto) {
    const sale = await this.findOne(id);

    if (sale && sale.status === SaleStatus.CANCELED && updateSaleDto.status) {
      throw new BadRequestException('Não é possível alterar venda cancelada');
    }

    return this.prisma.sale.update({
      where: { id },
      data: updateSaleDto,
      include: {
        items: {
          include: { product: true },
        },
        customer: true,
      },
    });
  }

  async cancel(id: number) {
    const sale = await this.findOne(id);

    if (sale.status === SaleStatus.CANCELED) {
      throw new BadRequestException('Venda já está cancelada');
    }

    for (const item of sale.items) {
      await this.prisma.product.update({
        where: { id: item.productId },
        data: { stockQuantity: { increment: item.quantity } },
      });
    }

    return this.prisma.sale.update({
      where: { id },
      data: { status: SaleStatus.CANCELED },
      include: {
        items: {
          include: { product: true },
        },
        customer: true,
      },
    });
  }
}
