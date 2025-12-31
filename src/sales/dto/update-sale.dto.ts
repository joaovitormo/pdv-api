import { IsEnum, IsOptional } from 'class-validator';
import { SaleStatus } from '@prisma/client';

export class UpdateSaleDto {
  @IsOptional()
  @IsEnum(SaleStatus)
  status?: SaleStatus;
}
