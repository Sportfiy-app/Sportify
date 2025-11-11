"use strict";
var __importDefault = (this && this.__importDefault) || function (mod) {
    return (mod && mod.__esModule) ? mod : { "default": mod };
};
Object.defineProperty(exports, "__esModule", { value: true });
const http_1 = __importDefault(require("http"));
const app_1 = require("./app");
const config_1 = require("./config");
const prisma_1 = require("./db/prisma");
async function bootstrap() {
    await (0, prisma_1.connectPrisma)();
    const app = (0, app_1.createApp)();
    const server = http_1.default.createServer(app);
    server.listen(config_1.config.port, () => {
        // eslint-disable-next-line no-console
        console.log(`🚀 Sportify API listening on http://localhost:${config_1.config.port}`);
    });
    const shutdown = async () => {
        await (0, prisma_1.disconnectPrisma)();
        server.close(() => process.exit(0));
    };
    process.on('SIGINT', shutdown);
    process.on('SIGTERM', shutdown);
}
bootstrap().catch((error) => {
    // eslint-disable-next-line no-console
    console.error('Failed to start server', error);
    process.exit(1);
});
