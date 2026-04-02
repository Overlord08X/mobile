import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class LocalStorageService {
  static const String _tokenKey = 'auth_token';
  static const String _userIdKey = 'user_id';
  static const String _usernameKey = 'username';
  static const String _saveUsersKey = 'saved_users';

  // -- Token Management - -
  Future<void> saveToken(String token) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_tokenKey, token);
  }

  Future<String?> getToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_tokenKey);
  }

  Future<void> removeToken() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_tokenKey);
  }

  //-- User Info Management - -
  Future<void> saveUser({
    required String userId,
    required String username,
  }) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_userIdKey, userId);
    await prefs.setString(_usernameKey, username);
  }

  Future<String?> getUserId() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_userIdKey);
  }

  Future<String?> getUsername() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_usernameKey);
  }

  //-- Saved Users Management - -
  // tambah user ke list (tidak menghapus yang lama)
  Future<void> addUserToSavedList({
    required String userId,
    required String username,
  }) async {
    final prefs = await SharedPreferences.getInstance();
    final rawList = prefs.getStringList(_saveUsersKey) ?? [];

    //Cek duplikasi userId
    final isDuplicate = rawList.any((item) {
      final map = jsonDecode(item) as Map<String, dynamic>;
      return map['userId'] == userId;
    });

    if (isDuplicate) return; //Jika sudah ada, lewati

    final newUser = jsonEncode({
      'user_id': userId,
      'username': username,
      'saved_at': DateTime.now().toIso8601String(),
    });

    rawList.add(newUser);
    await prefs.setStringList(_saveUsersKey, rawList);
  }

  //Ambil semua user yang disimpan
  Future<List<Map<String, String>>> getSavedUsers() async {
    final prefs = await SharedPreferences.getInstance();
    final rawList = prefs.getStringList(_saveUsersKey) ?? [];

    return rawList.map((item) {
      final map = jsonDecode(item) as Map<String, dynamic>;
      return {
        'user_id': (map['user_id'] ?? '').toString(),
        'username': (map['username'] ?? '').toString(),
        'saved_at': (map['saved_at'] ?? '').toString(),
      };
    }).toList();
  }

  //Hapus user tertentu dari list
  Future<void> removeSavedUser(String userId) async {
    final prefs = await SharedPreferences.getInstance();
    final rawList = prefs.getStringList(_saveUsersKey) ?? [];

    rawList.removeWhere((item) {
      final map = jsonDecode(item) as Map<String, dynamic>;
      return map['user_id'] == userId;
    });

    await prefs.setStringList(_saveUsersKey, rawList);
  }

  //Hapus semua user dari list
  Future<void> clearSavedUsers() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_saveUsersKey);
  }

  //Clear all preferences
  Future<void> clearAll() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.clear();
  }
}