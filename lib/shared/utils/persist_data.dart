import 'dart:async';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class PersistData {
  // flutter_secure_storage v11 removed `encryptedSharedPreferences`; the
  // default AndroidOptions already encrypt with AES-GCM backed by the KeyStore.
  static const _secureStorage = FlutterSecureStorage(
    aOptions: AndroidOptions(),
  );

  // static const _hasShownOrderShowcases = 'hasShownOrderShowcases';

  static Future<void> setOrderShowcasesShown() async {
    final userId = await getId();
    if (userId != null) {
      await _secureStorage.write(
          key: 'orderShowcaseShown_$userId', value: 'true');
    }
  }

  static Future<bool> get hasShownOrderShowcases async {
    final userId = await getId();
    if (userId == null) return false;
    final value = await _secureStorage.read(key: 'orderShowcaseShown_$userId');
    return value == 'true';
  }

  static Future<void> writeData(String key, dynamic value) async {
    await _secureStorage.write(key: key, value: value);
  }

  static Future<String?> readData(String key) async {
    final String? value = await _secureStorage.read(key: key);
    return value;
  }

  static Future<void> deleteDataByKey(String key) async {
    await _secureStorage.delete(key: key);
  }

  static Future<void> deleteAllData() async {
    await _secureStorage.deleteAll();
  }

  static Future<void> deleteData() async {
    await _secureStorage.delete(key: 'x-auth-token');
    await _secureStorage.delete(key: 'id');
  }

  static Future<void> persistData(String token, num id) async {
    await _secureStorage.write(key: 'x-auth-token', value: token);
    await _secureStorage.write(key: 'id', value: id.toString());
  }

  static Future<void> getStarted() async {
    await _secureStorage.write(key: 'getStarted', value: 'true');
  }

  static Future<String?> readGetStarted() async {
    final String? getStarted = await _secureStorage.read(key: 'getStarted');
    return getStarted;
  }

  static Future<bool> get isNew async =>
      await readGetStarted() == 'true' ? false : true;

  static Future<String?> getToken() async {
    return await _secureStorage.read(key: 'x-auth-token');
  }

  static Future<String?> getId() async {
    return await _secureStorage.read(key: 'id');
  }

  static Future<bool> get isAuth async {
    final token = await _secureStorage.read(key: 'x-auth-token');
    if (token == null) {
      return false;
    }
    return true;
  }

  static Future<void> saveStoreId(String storeId) async {
    await _secureStorage.write(key: 'storeId', value: storeId);
  }

  static Future<String?> getStoreId() async {
    return await _secureStorage.read(key: 'storeId');
  }

  static Future<String?> getStoreName() async {
    return await _secureStorage.read(key: 'storeName');
  }

  static Future<void> saveStoreName(String storeName) async {
    await _secureStorage.write(key: 'storeName', value: storeName);
  }
  //
  static Future<void> persistAuthData({
    required String accessToken,
    required String refreshToken,
    required int userId,
    required DateTime expiryDate,
  }) async {
    await _secureStorage.write(key: 'x-auth-token', value: accessToken);
    await _secureStorage.write(key: 'refresh-token', value: refreshToken);
    await _secureStorage.write(key: 'id', value: userId.toString());
    await _secureStorage.write(
        key: 'token-expiry', value: expiryDate.toIso8601String());
  }

  static Future<void> persistTokens({
    required String accessToken,
    required String refreshToken,
    required DateTime expiryDate,
  }) async {
    await _secureStorage.write(key: 'x-auth-token', value: accessToken);
    await _secureStorage.write(key: 'refresh-token', value: refreshToken);
    await _secureStorage.write(
        key: 'token-expiry', value: expiryDate.toIso8601String());
  }

  static Future<String?> getAccessToken() async =>
      await _secureStorage.read(key: 'x-auth-token');

  static Future<String?> getRefreshToken() async =>
      await _secureStorage.read(key: 'refresh-token');

  static Future<DateTime?> getTokenExpiry() async {
    final expiryStr = await _secureStorage.read(key: 'token-expiry');
    if (expiryStr == null) return null;
    return DateTime.tryParse(expiryStr);
  }

  static Future<int?> getUserId() async {
    final id = await _secureStorage.read(key: 'id');
    return id != null ? int.tryParse(id) : null;
  }

  static Future<void> clearAuthData() async {
    await _secureStorage.deleteAll();
  }
  //

  static Future<String?> get id async => await getId();
  static Future<String?> get token async => await getToken();
}