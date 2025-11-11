"use strict";
var __importDefault = (this && this.__importDefault) || function (mod) {
    return (mod && mod.__esModule) ? mod : { "default": mod };
};
Object.defineProperty(exports, "__esModule", { value: true });
exports.validateBody = validateBody;
exports.validateQuery = validateQuery;
const http_errors_1 = __importDefault(require("http-errors"));
function validateBody(schema) {
    return (req, _res, next) => {
        try {
            req.body = schema.parse(req.body);
            next();
        }
        catch (error) {
            next((0, http_errors_1.default)(400, 'Invalid request body', { cause: error }));
        }
    };
}
function validateQuery(schema) {
    return (req, _res, next) => {
        try {
            req.query = schema.parse(req.query);
            next();
        }
        catch (error) {
            next((0, http_errors_1.default)(400, 'Invalid query parameters', { cause: error }));
        }
    };
}
