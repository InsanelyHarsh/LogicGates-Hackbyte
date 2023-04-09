import 'dart:convert';

import 'package:android/models/urls.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Auth {
  
  createUser(Map<String, String> mp) async {
    try {
      final url = Uri.parse('$baseUrl/api/user/create');
      final response = await http.post(
        url,
        body: jsonEncode(mp),
        headers: {'Content-Type': 'application/json'},
      );
      //print('created user');
      final map = jsonDecode(response.body);
      return map;
    } on Exception catch (e) {
      debugPrint(e.toString());
    }
  }


  loginUser(Map<String, String> mp) async {
    try {
      debugPrint('cheking logging in');
      debugPrint(mp.toString());
      final url = Uri.parse('$baseUrl/api/user/login');
      debugPrint('$baseUrl/api/user/login');
      final response = await http.post(
        url,
        body: jsonEncode({
          'email': mp['email'],
          'password': mp['password'],
        }),
        headers: {'Content-Type': 'application/json'},
      );
      final map = jsonDecode(response.body);
      return map;
    } on Exception catch (e) {
      debugPrint(e.toString());
    }
  }
}
