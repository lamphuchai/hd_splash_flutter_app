import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SecureStorage {
  static const FlutterSecureStorage storage = FlutterSecureStorage();

  static Future<void> writeValue(
          {required String key, required String value}) async =>
      await storage.write(key: key, value: value);

  static Future<String?> readValue(String key) async =>
      await storage.read(key: key);

  static Future<void> deleteAll() async {
    await storage.deleteAll();
  }
}

class StorageKey {
  static const accessToken = "access_token";
  static const refreshToken = "refresh_token";
}
