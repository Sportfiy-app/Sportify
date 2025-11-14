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
            // Log validation errors for debugging
            console.error('Validation errors:', JSON.stringify(error.errors || error, null, 2));
            console.error('Request body:', JSON.stringify(req.body, null, 2));
            // Format Zod errors for better error messages
            let errorMessage = 'Invalid request body';
            if (error.errors && Array.isArray(error.errors) && error.errors.length > 0) {
                const firstError = error.errors[0];
                if (firstError.path && firstError.message) {
                    errorMessage = `${firstError.path.join('.')}: ${firstError.message}`;
                }
                else if (firstError.message) {
                    errorMessage = firstError.message;
                }
            }
            next((0, http_errors_1.default)(400, errorMessage, {
                cause: error,
                errors: error.errors || [],
            }));
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
