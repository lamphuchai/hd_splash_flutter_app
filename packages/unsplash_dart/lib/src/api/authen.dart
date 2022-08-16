import 'package:dio/dio.dart';

import '../network/dio_client.dart';

abstract class AuthImp {
  Future<Map<String, dynamic>> getToken({
    required String clientId,
    required String clientSecret,
    required String redirectUri,
    required String code,
    String grantType = "authorization_code",
  });
  Future<Map<String, dynamic>> refreshToken({
    required String clientId,
    required String clientSecret,
    required String refreshToken,
    String grantType = "refresh_token",
  });
}

class Auth implements AuthImp {
  Auth();
  final DioClient _dioClient = DioClient.auth();
  @override
  Future<Map<String, dynamic>> getToken({
    required String clientId,
    required String clientSecret,
    required String redirectUri,
    required String code,
    String grantType = "authorization_code",
  }) async {
    final data = await _dioClient
        .post("/oauth/token", options: Options(), queryParameters: {
      "client_id": clientId,
      "client_secret": clientSecret,
      "redirect_uri": redirectUri,
      "code": code,
      "grant_type": grantType
    });
    return data;
  }

  @override
  Future<Map<String, dynamic>> refreshToken(
      {required String clientId,
      required String clientSecret,
      required String refreshToken,
      String grantType = "refresh_token"}) async {
    final data = await _dioClient.post("/oauth/token", queryParameters: {
      "client_id": clientId,
      "client_secret": clientSecret,
      "refresh_token": refreshToken,
      "grant_type": grantType
    });
    return data;
  }
}
