import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SharedPreferencesHandler {
  static late FlutterSecureStorage _sharedPreferences;
  static SharedPreferencesHandler? _instance;

  static Future<void> initialize() async {
    if (_instance == null) {
      _instance = SharedPreferencesHandler();
      _sharedPreferences = const FlutterSecureStorage(aOptions: AndroidOptions(encryptedSharedPreferences: true));
    }
  }

  static SharedPreferencesHandler? get instance => _instance;

  Future<void> clear() async => await _sharedPreferences.deleteAll();

  Future<void> remove(String key) => _sharedPreferences.delete(key: key);

  Future<bool?> getBool(String key) async {
    try {
      return await _sharedPreferences.read(key: key) as bool?;
    } catch (e) {
      return null;
    }
  }

  Future<String?> getString(String key) async {
    try {
      return await _sharedPreferences.read(key: key);
    } catch (e) {
      return null;
    }
  }

  Future<int?> getInt(String key) async {
    try {
      return await _sharedPreferences.read(key: key) as int?;
    } catch (e) {
      return null;
    }
  }

  Future<double?> getDouble(String key) async {
    try {
      return await _sharedPreferences.read(key: key) as double?;
    } catch (e) {
      return null;
    }
  }

  //setter
  Future<void> setBool(String key, bool value) =>
      _sharedPreferences.write(key: key, value: value.toString());

  Future<void> setString(String key, String value) =>
      _sharedPreferences.write(key: key, value: value);

  Future<void> setInt(String key, int value) =>
      _sharedPreferences.write(key: key, value: value.toString());

  Future<void> setDouble(String key, double value) =>
      _sharedPreferences.write(key: key, value: value.toString());

}
