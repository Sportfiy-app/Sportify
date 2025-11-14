import 'dart:convert';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import 'api_exception.dart';
import '../auth/auth_session.dart';

class ApiClient extends GetxService {
  ApiClient({http.Client? httpClient}) : _client = httpClient ?? http.Client();

  final http.Client _client;

  static String? _cachedBaseUrl;

  String get baseUrl => _cachedBaseUrl ??= _resolveBaseUrl();

  Future<Map<String, dynamic>> post(
    String path, {
    Map<String, dynamic>? body,
    Map<String, String>? headers,
    bool requireAuth = false,
  }) async {
    final uri = _composeUri(path);
    try {
      final response = await _client.post(
        uri,
        headers: _buildHeaders(headers, requireAuth: requireAuth),
        body: body == null ? null : jsonEncode(body),
      );
      return _handleResponse(response);
    } on SocketException {
      throw ApiException(0, 'Impossible de se connecter au serveur. Vérifiez votre connexion internet.');
    }
  }

  Future<Map<String, dynamic>> get(
    String path, {
    Map<String, String>? headers,
    bool requireAuth = false,
  }) async {
    final uri = _composeUri(path);
    try {
      final response = await _client.get(uri, headers: _buildHeaders(headers, requireAuth: requireAuth));
      return _handleResponse(response);
    } on SocketException {
      throw ApiException(0, 'Impossible de se connecter au serveur. Vérifiez votre connexion internet.');
    }
  }

  Future<Map<String, dynamic>> patch(
    String path, {
    Map<String, dynamic>? body,
    Map<String, String>? headers,
    bool requireAuth = false,
  }) async {
    final uri = _composeUri(path);
    try {
      final response = await _client.patch(
        uri,
        headers: _buildHeaders(headers, requireAuth: requireAuth),
        body: body == null ? null : jsonEncode(body),
      );
      return _handleResponse(response);
    } on SocketException {
      throw ApiException(0, 'Impossible de se connecter au serveur. Vérifiez votre connexion internet.');
    }
  }

  Future<Map<String, dynamic>> delete(
    String path, {
    Map<String, String>? headers,
    bool requireAuth = false,
  }) async {
    final uri = _composeUri(path);
    try {
      final response = await _client.delete(uri, headers: _buildHeaders(headers, requireAuth: requireAuth));
      return _handleResponse(response);
    } on SocketException {
      throw ApiException(0, 'Impossible de se connecter au serveur. Vérifiez votre connexion internet.');
    }
  }

  Uri _composeUri(String path) {
    final normalizedPath = path.startsWith('/') ? path : '/$path';
    return Uri.parse('${baseUrl.trim()}$normalizedPath');
  }

  Map<String, String> _buildHeaders(Map<String, String>? headers, {bool requireAuth = false}) {
    final defaultHeaders = <String, String>{
      'Content-Type': 'application/json; charset=utf-8',
      'Accept': 'application/json',
    };

    // Add authentication token if required
    if (requireAuth) {
      try {
        final authSession = Get.find<AuthSession>();
        final token = authSession.accessToken;
        if (token != null && token.isNotEmpty) {
          defaultHeaders['Authorization'] = 'Bearer $token';
        }
      } catch (e) {
        // AuthSession not found, continue without token
      }
    }

    if (headers != null) {
      defaultHeaders.addAll(headers);
    }

    return defaultHeaders;
  }

  Map<String, dynamic> _handleResponse(http.Response response) {
    if (response.statusCode >= 200 && response.statusCode < 300) {
      if (response.body.isEmpty) {
        return <String, dynamic>{};
      }
      try {
        final decoded = jsonDecode(response.body);
        if (decoded is Map<String, dynamic>) {
          return decoded;
        }
        return {'data': decoded};
      } catch (e) {
        if (kDebugMode) {
          debugPrint('Error decoding response: $e');
          debugPrint('Response body: ${response.body}');
        }
        throw ApiException(response.statusCode, 'Erreur lors du décodage de la réponse du serveur');
      }
    }

    dynamic decodedBody;
    String message = 'Une erreur est survenue (${response.statusCode}).';
    if (response.body.isNotEmpty) {
      try {
        decodedBody = jsonDecode(response.body);
        if (decodedBody is Map<String, dynamic>) {
          final serverMessage = decodedBody['message'];
          if (serverMessage is String && serverMessage.isNotEmpty) {
            message = serverMessage;
          }
          // Include errors array if present (from Zod validation)
          if (decodedBody.containsKey('errors')) {
            decodedBody['errors'] = decodedBody['errors'];
          }
        }
      } catch (e) {
        decodedBody = response.body;
        message = 'Erreur serveur: ${response.body}';
      }
    }

    throw ApiException(response.statusCode, message, details: decodedBody);
  }

  static String _resolveBaseUrl() {
    // Try API_URL first (used in CI/CD), then SPORTIFY_API_URL (legacy)
    const envUrl = String.fromEnvironment('API_URL');
    const legacyUrl = String.fromEnvironment('SPORTIFY_API_URL');
    
    final url = envUrl.isNotEmpty ? envUrl : legacyUrl;
    
    if (url.isNotEmpty) {
      // Ensure URL ends with /api if not already present
      var baseUrl = url.endsWith('/') ? url.substring(0, url.length - 1) : url;
      if (!baseUrl.endsWith('/api')) {
        baseUrl = '$baseUrl/api';
      }
      return baseUrl;
    }

    // Default to localhost for development
    if (kIsWeb) {
      return 'http://localhost:3333/api';
    }

    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return 'http://10.0.2.2:3333/api';
      case TargetPlatform.iOS:
        return 'http://127.0.0.1:3333/api';
      case TargetPlatform.macOS:
      case TargetPlatform.windows:
      case TargetPlatform.linux:
      case TargetPlatform.fuchsia:
        return 'http://localhost:3333/api';
    }
  }

  @override
  void onClose() {
    _client.close();
    super.onClose();
  }
}
