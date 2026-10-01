import 'package:dio/dio.dart';

import '../../../core/constant/endpointes.dart';
import '../../../shared/utils/persist_data.dart';

class AuthRepository {
  // Separate client so the refresh call never goes through the auth
  // interceptor in DioHelper.
  static final Dio _dio = Dio(
    BaseOptions(
      baseUrl: Endpoints.baseUrl,
      contentType: Headers.jsonContentType,
    ),
  );

  /// Exchanges [refreshToken] for a new access token, saves the new tokens
  /// and returns the new access token. Throws a [DioException] on failure.
  static Future<String> refreshToken(String refreshToken) async {
    final response = await _dio.post(
      Endpoints.refresh,
      data: {'refreshToken': refreshToken},
    );

    // TODO: match these keys to your backend's refresh response.
    final data = response.data as Map<String, dynamic>;
    final accessToken = data['accessToken'] as String;
    final newRefreshToken = data['refreshToken'] as String? ?? refreshToken;
    final expiresIn = (data['expiresIn'] as num?)?.toInt() ?? 3600;

    await PersistData.persistTokens(
      accessToken: accessToken,
      refreshToken: newRefreshToken,
      expiryDate: DateTime.now().add(Duration(seconds: expiresIn)),
    );
    return accessToken;
  }
}
