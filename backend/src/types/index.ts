export type UserRole = 'USER' | 'CLUB_MANAGER' | 'ADMIN';

export interface JwtUser {
  sub: string;
  email: string;
  role: UserRole;
}

