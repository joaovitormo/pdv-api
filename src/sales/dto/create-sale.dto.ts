import { Type } from 'class-transformer';
import { IsArray, IsInt, IsPositive, IsNotEmpty, IsOptional, IsEnum, ValidateNested } from 'class-validator';
import { SaleStatus } from '@prisma/client';

export class CreateSaleItemDto {
  @IsInt()
  @IsPositive({ message: 'ID do produto deve ser positivo' })
  @IsNotEmpty({ message: 'ID do produto é obrigatório' })
  productId: number;

  @IsInt()
  @IsPositive({ message: 'Quantidade deve ser positiva' })
  @IsNotEmpty({ message: 'Quantidade é obrigatória' })
  quantity: number;

  @IsInt()
  @IsPositive({ message: 'Preço unitário deve ser positivo' })
  @IsNotEmpty({ message: 'Preço unitário é obrigatório' })
  unitPrice: number;
}

export class CreateSaleDto {
  @IsArray()
  @ValidateNested({ each: true })
  @Type(() => CreateSaleItemDto)
  @IsNotEmpty({ message: 'Itens da venda são obrigatórios' })
  items: CreateSaleItemDto[];

  @IsOptional()
  @IsInt()
  customerId?: number;

  @IsNotEmpty({ message: 'Método de pagamento é obrigatório' })
  paymentMethod: string;

  @IsOptional()
  @IsEnum(SaleStatus)
  status?: SaleStatus = SaleStatus.COMPLETED;
}
