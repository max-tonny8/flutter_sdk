import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SecureStorageUtil {
  final _storage = FlutterSecureStorage();

  Future<void> setAccessToken(String token) async {
    await _storage.write(key: 'access_token', value: token);
  }

  Future<void> setKeyShare(String token) async {
    await _storage.write(key: 'key_share', value: token);
  }

  Future<String?> getAccessToken() async {
    return await _storage.read(key: 'access_token');
  }

  Future<String?> getKeyShare() async {
    return await _storage.read(key: 'key_share');
  }

  Future<void> deleteAccessToken() async {
    await _storage.delete(key: 'access_token');
  }

  Future<void> deleteAll() async {
    await _storage.deleteAll();
  }
}
