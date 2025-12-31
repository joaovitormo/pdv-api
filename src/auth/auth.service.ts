import { Injectable, UnauthorizedException, ConflictException } from '@nestjs/common';
import { JwtService } from '@nestjs/jwt';
import { PrismaService } from '../prisma/prisma.service';
import { Role } from '@prisma/client'; 
import * as bcrypt from 'bcrypt';

@Injectable()
export class AuthService {
  constructor(
    private prisma: PrismaService,
    private jwtService: JwtService,
  ) {}

  async login(username: string, pass: string) {
    const user = await this.prisma.user.findUnique({
      where: { username },
    });

    if (!user || !user.active) {
      throw new UnauthorizedException('Credenciais inválidas ou usuário inativo');
    }

    const isPasswordValid = await bcrypt.compare(pass, user.passwordHash);

    if (!isPasswordValid) {
      throw new UnauthorizedException('Credenciais inválidas');
    }

    const payload = { 
      sub: user.id, 
      username: user.username, 
      role: user.role 
    };

    return {
      access_token: this.jwtService.sign(payload),
      user: {
        id: user.id,
        username: user.username,
        email: user.email,
        role: user.role,
      },
    };
  }

  async register(username: string, email: string, pass: string, role: Role = Role.USER) {
    const existingUser = await this.prisma.user.findFirst({
      where: {
        OR: [{ username }, { email }],
      },
    });

    if (existingUser) {
      throw new ConflictException('Usuário ou Email já cadastrado');
    }

    const salt = await bcrypt.genSalt(10);
    const passwordHash = await bcrypt.hash(pass, salt);

    return this.prisma.user.create({
      data: {
        username,
        email,
        passwordHash,
        role,
      },
      select: { 
        id: true,
        username: true,
        email: true,
        role: true,
        active: true,
      }
    });
  }
}