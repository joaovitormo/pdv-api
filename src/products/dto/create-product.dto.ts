import { IsString, IsNotEmpty, IsNumber, IsPositive, IsOptional, IsInt, Min } from 'class-validator';

export class CreateProductDto {
  @IsString()
  @IsNotEmpty({ message: 'SKU é obrigatório' })
  sku: string;

  @IsString()
  @IsNotEmpty({ message: 'Nome é obrigatório' })
  name: string;

  @IsString()
  @IsOptional()
  description?: string;

  @IsNumber()
  @IsPositive({ message: 'Preço deve ser positivo' })
  @IsNotEmpty({ message: 'Preço é obrigatório' })
  price: number;

  @IsInt()
  @Min(0, { message: 'Quantidade de estoque não pode ser negativa' })
  @IsOptional()
  stockQuantity?: number = 0;

  @IsInt()
  @IsNotEmpty({ message: 'ID da categoria é obrigatório' })
  categoryId: number;
}
