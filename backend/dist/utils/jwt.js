"use strict";
var __importDefault = (this && this.__importDefault) || function (mod) {
    return (mod && mod.__esModule) ? mod : { "default": mod };
};
Object.defineProperty(exports, "__esModule", { value: true });
exports.signAccessToken = signAccessToken;
exports.signRefreshToken = signRefreshToken;
exports.verifyRefreshToken = verifyRefreshToken;
const jsonwebtoken_1 = __importDefault(require("jsonwebtoken"));
const config_1 = require("../config");
function signAccessToken(payload) {
    const options = { expiresIn: config_1.config.jwt.accessTtl };
    return jsonwebtoken_1.default.sign(payload, config_1.config.jwt.accessSecret, options);
}
function signRefreshToken(payload) {
    const options = { expiresIn: config_1.config.jwt.refreshTtl };
    return jsonwebtoken_1.default.sign(payload, config_1.config.jwt.refreshSecret, options);
}
function verifyRefreshToken(token) {
    return jsonwebtoken_1.default.verify(token, config_1.config.jwt.refreshSecret);
}
