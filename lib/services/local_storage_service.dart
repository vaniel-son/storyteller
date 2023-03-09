import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SecureLocalStorageService {
  // Initialize DB object with methods to call DB

  /// Constructor
  SecureLocalStorageService() {
    //
  }

  final storage = const FlutterSecureStorage();

  Future<String?> getSecureStorage({required String key}) {
    Future<String?> value = storage.read(key: key);
    return value;
  }

  Future<void> setSecureStorage({required String key, required String value}) async {
    await storage.write(key: key, value: value);
  }

  Future<void> deleteSecureStorage() async {
    await storage.deleteAll();
  }

  Future<void> deleteSecureStorageItem({required String key}) {
    Future<void> value = storage.delete(key: key);
    return value;
  }

  Future<void> saveStorage({required String name, required String value}) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(name, value);
  }

  Future<String?> readStorageItem({required String name}) async {
    final prefs = await SharedPreferences.getInstance();
    final String? item = prefs.getString(name);

    return item;
  }

}
