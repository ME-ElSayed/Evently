import 'dart:convert';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedprefService extends GetxService {
  static const String _tokenKey = 'auth_token';
  static const String _accessTokenKey = 'access_token';
  static const String _refreshTokenKey = 'refresh_token';
  static const String _userDataKey = 'user_data';
  static const String _isLoggedInKey = 'is_logged_in';
  
  late SharedPreferences sharedPreferences;

  Future<SharedprefService> init() async {
    sharedPreferences = await SharedPreferences.getInstance();
    return this;
  }

  // ==================== Existing Methods ====================
  
  Future<void> boolSetter({required String key, required bool value}) async {
    await sharedPreferences.setBool(key, value);
  }

  bool? boolGetter({required String key}) {
    return sharedPreferences.getBool(key);
  }

  Future<void> stringSetter({required String key, required String value}) async {
    await sharedPreferences.setString(key, value);
  }

  String? stringGetter({required String key}) {
    return sharedPreferences.getString(key);
  }

  Future<void> intSetter({required String key, required int value}) async {
    await sharedPreferences.setInt(key, value);
  }

  int? intGetter({required String key}) {
    return sharedPreferences.getInt(key);
  }

  Future<void> saveToken(String token) async {
    await sharedPreferences.setString(_tokenKey, token);
  }

  Future<String?> getToken() async {
    return sharedPreferences.getString(_tokenKey);
  }

  Future<void> clearToken() async {
    await sharedPreferences.remove(_tokenKey);
  }

  // ==================== New Token Management Methods ====================

  /// Save access token
  Future<void> setAccessToken(String token) async {
    await sharedPreferences.setString(_accessTokenKey, token);
  }

  /// Get access token
  String? getAccessToken() {
    return sharedPreferences.getString(_accessTokenKey);
  }

  /// Save refresh token
  Future<void> setRefreshToken(String token) async {
    await sharedPreferences.setString(_refreshTokenKey, token);
  }

  /// Get refresh token
  String? getRefreshToken() {
    return sharedPreferences.getString(_refreshTokenKey);
  }

  /// Save both access and refresh tokens
  Future<void> saveTokens({
    required String accessToken,
    required String refreshToken,
  }) async {
    await setAccessToken(accessToken);
    await setRefreshToken(refreshToken);
    await setLoggedIn(true);
  }

  /// Clear all tokens
  Future<void> clearTokens() async {
    await sharedPreferences.remove(_accessTokenKey);
    await sharedPreferences.remove(_refreshTokenKey);
    await sharedPreferences.remove(_tokenKey);
    await setLoggedIn(false);
  }

  // ==================== User Data Management ====================

  /// Save user data as JSON
  Future<void> setUserData(Map<String, dynamic> userData) async {
    final String jsonString = jsonEncode(userData);
    await sharedPreferences.setString(_userDataKey, jsonString);
  }

  /// Get user data
  Map<String, dynamic>? getUserData() {
    final String? jsonString = sharedPreferences.getString(_userDataKey);
    if (jsonString == null) return null;
    
    try {
      return jsonDecode(jsonString) as Map<String, dynamic>;
    } catch (e) {
      return null;
    }
  }

  /// Clear user data
  Future<void> clearUserData() async {
    await sharedPreferences.remove(_userDataKey);
  }

  /// Get user ID from stored user data
  int? getUserId() {
    final userData = getUserData();
    return userData?['id'];
  }

  /// Get user email from stored user data
  String? getUserEmail() {
    final userData = getUserData();
    return userData?['email'];
  }

  /// Get user name from stored user data
  String? getUserName() {
    final userData = getUserData();
    return userData?['name'];
  }

  /// Get username from stored user data
  String? getUsername() {
    final userData = getUserData();
    return userData?['username'];
  }

  /// Check if user is verified
  bool isUserVerified() {
    final userData = getUserData();
    return userData?['isVerified'] ?? false;
  }

  // ==================== Login Status ====================

  /// Set login status
  Future<void> setLoggedIn(bool isLoggedIn) async {
    await sharedPreferences.setBool(_isLoggedInKey, isLoggedIn);
  }

  /// Check if user is logged in
  bool isLoggedIn() {
    return sharedPreferences.getBool(_isLoggedInKey) ?? false;
  }

  // ==================== Complete Logout ====================

  /// Clear all user data and tokens (complete logout)
  Future<void> logout() async {
    await clearTokens();
    await clearUserData();
     sharedPreferences.remove('fcm_token');
    //await sharedPreferences.clear();
  }

  // ==================== Generic Methods ====================

  /// Remove specific key
  Future<void> remove(String key) async {
    await sharedPreferences.remove(key);
  }

  /// Clear all data
  Future<void> clearAll() async {
    await sharedPreferences.clear();
  }

  /// Check if key exists
  bool containsKey(String key) {
    return sharedPreferences.containsKey(key);
  }

  /// Get all keys
  Set<String> getAllKeys() {
    return sharedPreferences.getKeys();
  }
}

