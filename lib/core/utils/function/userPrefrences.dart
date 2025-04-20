import 'dart:convert';

import 'package:collab_doc/core/class/UserConnected.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Userprefrences {
  
 static Future<UserConnected?> getUserFromPrefs() async {
  final prefs = await SharedPreferences.getInstance();
  String? userJson = prefs.getString('user');
  
  if (userJson != null) {
    Map<String, dynamic> userMap = jsonDecode(userJson);
    return UserConnected.fromJson(userMap);
  }
  
  return null;
}

static Future<void> saveUserToPrefs(UserConnected user) async {
  final prefs = await SharedPreferences.getInstance();
  String userJson = jsonEncode(user.toJson());
  await prefs.setString('user', userJson);
}
}