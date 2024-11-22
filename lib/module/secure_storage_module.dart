import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SecureStorageModule {
  const SecureStorageModule();

  final storage = const FlutterSecureStorage();

  Future<void> write({
    required String key,
    required String value,
  }) async {
    return await storage.write(key: key, value: value);
  }

  Future<String?> read({
    required String key,
  }) async {
    return await storage.read(key: key);
  }

  Future<bool> containsKey({
    required String key,
  }) async {
    return await storage.containsKey(key: key);
  }

  Future<void> delete({
    required String key,
  }) async {
    return await storage.delete(key: key);
  }

  Future<Map<String, String>> readAll() async {
    return await storage.readAll();
  }

  Future<void> deleteAll() async {
    return await storage.deleteAll();
  }
}
