"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
exports.prisma = void 0;
exports.connectPrisma = connectPrisma;
exports.disconnectPrisma = disconnectPrisma;
const client_1 = require("@prisma/client");
const config_1 = require("../config");
exports.prisma = new client_1.PrismaClient({
    datasources: {
        db: {
            url: config_1.config.databaseUrl,
        },
    },
});
async function connectPrisma() {
    await exports.prisma.$connect();
}
async function disconnectPrisma() {
    await exports.prisma.$disconnect();
}
