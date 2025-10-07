import 'package:shared_preferences/shared_preferences.dart';

class TokenManager {
  Future<SharedPreferences> get _prefs async => await SharedPreferences.getInstance();

  Future<void> saveTokens({
    required String accessToken,
    required String refreshToken,
  }) async {
    final prefs = await _prefs;
    await prefs.setString('access_token', accessToken);
    await prefs.setString('refresh_token', refreshToken);
  }

  Future<String?> getAccessToken() async {
    final prefs = await _prefs;
    return prefs.getString('access_token');
  }

  Future<String?> getRefreshToken() async {
    final prefs = await _prefs;
    return prefs.getString('refresh_token');
  }

  Future<bool> hasValidRefreshToken() async {
    final prefs = await _prefs;
    final token = prefs.getString('refresh_token');
    return token != null && token.isNotEmpty;
  }

  Future<void> deleteTokens() async {
    final prefs = await _prefs;
    await prefs.remove('access_token');
    await prefs.remove('refresh_token');
  }
}
