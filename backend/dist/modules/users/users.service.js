"use strict";
var __importDefault = (this && this.__importDefault) || function (mod) {
    return (mod && mod.__esModule) ? mod : { "default": mod };
};
Object.defineProperty(exports, "__esModule", { value: true });
exports.UsersService = void 0;
const http_errors_1 = __importDefault(require("http-errors"));
const prisma_1 = require("../../db/prisma");
class UsersService {
    async findById(id) {
        const user = await prisma_1.prisma.user.findUnique({
            where: { id },
            select: {
                id: true,
                email: true,
                phone: true,
                firstName: true,
                lastName: true,
                role: true,
                createdAt: true,
                updatedAt: true,
            },
        });
        if (!user) {
            throw (0, http_errors_1.default)(404, 'User not found');
        }
        return user;
    }
    async updateProfile(id, data) {
        return prisma_1.prisma.user.update({
            where: { id },
            data,
            select: {
                id: true,
                email: true,
                phone: true,
                firstName: true,
                lastName: true,
                role: true,
                createdAt: true,
                updatedAt: true,
            },
        });
    }
}
exports.UsersService = UsersService;
