"use strict";
var __importDefault = (this && this.__importDefault) || function (mod) {
    return (mod && mod.__esModule) ? mod : { "default": mod };
};
Object.defineProperty(exports, "__esModule", { value: true });
exports.config = void 0;
const dotenv_1 = __importDefault(require("dotenv"));
dotenv_1.default.config();
exports.config = {
    nodeEnv: process.env.NODE_ENV ?? 'development',
    port: parseInt(process.env.PORT ?? '3333', 10),
    databaseUrl: process.env.DATABASE_URL ?? '',
    jwt: {
        accessSecret: process.env.JWT_ACCESS_SECRET ?? '',
        refreshSecret: process.env.JWT_REFRESH_SECRET ?? '',
        accessTtl: process.env.JWT_ACCESS_TTL ?? '15m',
        refreshTtl: process.env.JWT_REFRESH_TTL ?? '7d',
    },
    stripe: {
        secretKey: process.env.STRIPE_SECRET_KEY ?? '',
        webhookSecret: process.env.STRIPE_WEBHOOK_SECRET ?? '',
    },
};
if (!exports.config.databaseUrl) {
    // eslint-disable-next-line no-console
    console.warn('⚠️ DATABASE_URL is not set.');
}
