"use strict";
var __importDefault = (this && this.__importDefault) || function (mod) {
    return (mod && mod.__esModule) ? mod : { "default": mod };
};
Object.defineProperty(exports, "__esModule", { value: true });
exports.notFoundHandler = notFoundHandler;
exports.errorHandler = errorHandler;
const http_errors_1 = __importDefault(require("http-errors"));
function notFoundHandler(req, _res, next) {
    next((0, http_errors_1.default)(404, `Route ${req.originalUrl} not found`));
}
function errorHandler(err, _req, res, _next) {
    void _next;
    const httpError = (0, http_errors_1.default)(err);
    const status = httpError.status ?? 500;
    const response = {
        status,
        message: httpError.message,
        ...(process.env.NODE_ENV === 'development' && { stack: err.stack }),
    };
    res.status(status).json(response);
}
