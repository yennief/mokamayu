import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import '../models/calendar_event.dart';
import 'authentication/authentication.dart';

class AppCache {
  static const user = 'user';
  final AuthService _auth = AuthService();

  Future<void> invalidate() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(user, false);
  }

  Future<void> cacheUser() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(user, true);
  }

  Future<bool> isUserLoggedIn() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(user) ?? false;
  }

  // Future<void> cacheIndexList(List<int> indexList) async {
  //   final prefs = await SharedPreferences.getInstance();
  //   List<String> strList = indexList.map((i) => i.toString()).toList();
  //   prefs.setStringList(_auth.getCurrentUserID(), strList);
  // }

  Future<void> cacheEvents(Map<String, String> events) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString(_auth.getCurrentUserID(), json.encode(events));
  }
}
