import { IsString, IsNumber, IsPositive, IsOptional, IsInt, Min, IsEnum } from 'class-validator';

export class UpdateProductDto {
  @IsString()
  @IsOptional()
  sku?: string;

  @IsString()
  @IsOptional()
  name?: string;

  @IsString()
  @IsOptional()
  description?: string;

  @IsNumber()
  @IsPositive()
  @IsOptional()
  price?: number;

  @IsInt()
  @Min(0)
  @IsOptional()
  stockQuantity?: number;

  @IsInt()
  @IsOptional()
  categoryId?: number;
}
