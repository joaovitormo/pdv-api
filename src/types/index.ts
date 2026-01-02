
export interface ApiResponse<T = any> {
  success: boolean;
  data?: T;
  message?: string;
  error?: string;
  timestamp: string;
}

export interface PaginatedResponse<T> extends ApiResponse<T[]> {
  pagination: {
    page: number;
    limit: number;
    total: number;
    totalPages: number;
  };
}

export interface HealthStatus {
  status: 'UP' | 'DOWN';
  timestamp: string;
  uptime: number;
  database?: {
    status: 'UP' | 'DOWN';
    database: string;
  };
}

export interface UserPayload {
  sub: string;
  username: string;
  role: string;
  iat?: number;
  exp?: number;
}

export interface SaleItem {
  productId: string;
  quantity: number;
  unitPrice: number;
  subtotal: number;
}

export interface CreateSaleDto {
  customerId?: string;
  items: SaleItem[];
  paymentMethod: string;
}

export interface ProductFilters {
  name?: string;
  categoryId?: string;
  sku?: string;
  minPrice?: number;
  maxPrice?: number;
}

export interface CustomerFilters {
  name?: string;
  document?: string;
}

export interface SaleFilters {
  status?: string;
  customerId?: string;
  startDate?: Date;
  endDate?: Date;
}

// Enums
export enum SaleStatus {
  OPEN = 'OPEN',
  COMPLETED = 'COMPLETED',
  CANCELED = 'CANCELED',
}

export enum UserRole {
  USER = 'USER',
  ADMIN = 'ADMIN',
}

// Error types
export class ValidationError extends Error {
  constructor(message: string, public field?: string) {
    super(message);
    this.name = 'ValidationError';
  }
}

export class NotFoundError extends Error {
  constructor(resource: string, id?: string) {
    super(`${resource}${id ? ` with id ${id}` : ''} not found`);
    this.name = 'NotFoundError';
  }
}

export class InsufficientStockError extends Error {
  constructor(productName: string, requested: number, available: number) {
    super(`Insufficient stock for ${productName}. Requested: ${requested}, Available: ${available}`);
    this.name = 'InsufficientStockError';
  }
}

export class UnauthorizedError extends Error {
  constructor(message = 'Unauthorized access') {
    super(message);
    this.name = 'UnauthorizedError';
  }
}