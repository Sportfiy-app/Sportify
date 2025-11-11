"use strict";
var __importDefault = (this && this.__importDefault) || function (mod) {
    return (mod && mod.__esModule) ? mod : { "default": mod };
};
Object.defineProperty(exports, "__esModule", { value: true });
exports.authenticate = authenticate;
const http_errors_1 = __importDefault(require("http-errors"));
const jsonwebtoken_1 = __importDefault(require("jsonwebtoken"));
const config_1 = require("../config");
function authenticate(required = true) {
    return (req, _res, next) => {
        const authorization = req.headers.authorization;
        if (!authorization) {
            if (!required) {
                return next();
            }
            return next((0, http_errors_1.default)(401, 'Authorization header missing'));
        }
        const token = authorization.replace(/Bearer\s+/i, '').trim();
        try {
            const payload = jsonwebtoken_1.default.verify(token, config_1.config.jwt.accessSecret);
            req.user = payload;
            return next();
        }
        catch (error) {
            return next((0, http_errors_1.default)(401, 'Invalid or expired token'));
        }
    };
}
