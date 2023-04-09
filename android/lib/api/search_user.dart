import 'dart:convert';

import 'package:android/models/urls.dart';
import 'package:http/http.dart' as http;

class SearchUser {
  getUserById(String tokken, String id) async {
    final url = Uri.parse('$baseUrl/api/user/getuserbyid');
    try {
      final response = await http.get(url, headers: {
        'Content-Type': 'application/json',
        'authToken': tokken,
        'id': id
      });
      return jsonDecode(response.body);
    } on Exception catch (e) {
      //print(e);
    }
  }

  getUserByName(String name, String tokken) async {
    final url = Uri.parse('$baseUrl/api/search/users');
    try {
      final response = await http.get(url, headers: {
        'Content-Type': 'application/json',
        'authToken': tokken,
        'searchString': name
      });
      return jsonDecode(response.body);
    } on Exception catch (e) {
      //print(e);
    }
  }
}
