import 'package:get/get.dart';

import 'models/auth_tokens.dart';

class AuthSession extends GetxService {
  final Rx<AuthTokens?> _tokens = Rx<AuthTokens?>(null);

  AuthTokens? get tokens => _tokens.value;
  String? get accessToken => _tokens.value?.accessToken;
  String? get refreshToken => _tokens.value?.refreshToken;
  bool get isAuthenticated => _tokens.value?.hasTokens ?? false;

  Future<void> saveTokens(AuthTokens tokens) async {
    _tokens.value = tokens;
  }

  Future<void> clear() async {
    _tokens.value = null;
  }
}
