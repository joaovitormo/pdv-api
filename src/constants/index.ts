// Application constants

export const APP_CONFIG = {
  NAME: 'PDV API',
  VERSION: '1.0.0',
  DESCRIPTION: 'Sistema de Ponto de Venda - API Backend',
  PORT: process.env.PORT || 3001,
  NODE_ENV: process.env.NODE_ENV || 'development',
} as const;

export const DATABASE_CONFIG = {
  URL: process.env.DATABASE_URL,
  LOG_QUERIES: process.env.NODE_ENV === 'development',
} as const;

export const JWT_CONFIG = {
  SECRET: process.env.JWT_SECRET || 'fallback-secret-change-in-production',
  EXPIRES_IN: process.env.JWT_EXPIRES_IN || '24h',
} as const;

export const CORS_CONFIG = {
  ORIGIN: process.env.CORS_ORIGIN || '*',
  CREDENTIALS: true,
} as const;

export const RATE_LIMIT_CONFIG = {
  WINDOW_MS: 15 * 60 * 1000, 
  MAX_REQUESTS: 100, 
  AUTH_MAX_REQUESTS: 5, 
} as const;

export const PAGINATION_CONFIG = {
  DEFAULT_PAGE: 1,
  DEFAULT_LIMIT: 10,
  MAX_LIMIT: 100,
} as const;

export const LOGGING_CONFIG = {
  LEVEL: process.env.LOG_LEVEL || 'info',
  MAX_SIZE: '20m',
  MAX_FILES: '14d',
} as const;

// Enums as constants
export const SALE_STATUS = {
  OPEN: 'OPEN',
  COMPLETED: 'COMPLETED',
  CANCELED: 'CANCELED',
} as const;

export const USER_ROLES = {
  USER: 'USER',
  ADMIN: 'ADMIN',
} as const;

export const PAYMENT_METHODS = {
  CASH: 'CASH',
  CREDIT_CARD: 'CREDIT_CARD',
  DEBIT_CARD: 'DEBIT_CARD',
  PIX: 'PIX',
  TRANSFER: 'TRANSFER',
} as const;

// HTTP Status Codes
export const HTTP_STATUS = {
  OK: 200,
  CREATED: 201,
  BAD_REQUEST: 400,
  UNAUTHORIZED: 401,
  FORBIDDEN: 403,
  NOT_FOUND: 404,
  CONFLICT: 409,
  UNPROCESSABLE_ENTITY: 422,
  TOO_MANY_REQUESTS: 429,
  INTERNAL_SERVER_ERROR: 500,
} as const;

// Error Messages
export const ERROR_MESSAGES = {
  UNAUTHORIZED: 'Acesso não autorizado',
  FORBIDDEN: 'Acesso proibido',
  NOT_FOUND: 'Recurso não encontrado',
  VALIDATION_FAILED: 'Dados de entrada inválidos',
  INSUFFICIENT_STOCK: 'Estoque insuficiente',
  SALE_ALREADY_COMPLETED: 'Venda já foi finalizada',
  SALE_ALREADY_CANCELED: 'Venda já foi cancelada',
  INVALID_CREDENTIALS: 'Credenciais inválidas',
  USER_ALREADY_EXISTS: 'Usuário já existe',
  PRODUCT_NOT_FOUND: 'Produto não encontrado',
  CATEGORY_NOT_FOUND: 'Categoria não encontrada',
  CUSTOMER_NOT_FOUND: 'Cliente não encontrado',
  DATABASE_ERROR: 'Erro interno do banco de dados',
  RATE_LIMIT_EXCEEDED: 'Muitas requisições. Tente novamente mais tarde.',
} as const;

// Success Messages
export const SUCCESS_MESSAGES = {
  LOGIN_SUCCESSFUL: 'Login realizado com sucesso',
  LOGOUT_SUCCESSFUL: 'Logout realizado com sucesso',
  USER_CREATED: 'Usuário criado com sucesso',
  PRODUCT_CREATED: 'Produto criado com sucesso',
  PRODUCT_UPDATED: 'Produto atualizado com sucesso',
  PRODUCT_DELETED: 'Produto removido com sucesso',
  CATEGORY_CREATED: 'Categoria criada com sucesso',
  CATEGORY_UPDATED: 'Categoria atualizada com sucesso',
  CATEGORY_DELETED: 'Categoria removida com sucesso',
  CUSTOMER_CREATED: 'Cliente criado com sucesso',
  CUSTOMER_UPDATED: 'Cliente atualizado com sucesso',
  CUSTOMER_DELETED: 'Cliente removido com sucesso',
  SALE_CREATED: 'Venda criada com sucesso',
  SALE_COMPLETED: 'Venda finalizada com sucesso',
  SALE_CANCELED: 'Venda cancelada com sucesso',
} as const;