import 'dart:convert';

import 'package:android/models/urls.dart';
import 'package:http/http.dart' as http;

class PostsGetAndUpload {
  sendPost(Map<String, dynamic> mp, String token) async {
    final url = Uri.parse('$baseUrl/api/post/create');
    try {
      //print('trying to send data');
      final resposne = await http.post(url, body: jsonEncode(mp), headers: {
        'Content-Type': 'application/json',
        'authToken': token,
      });

      return jsonDecode(resposne.body);
    } on Exception catch (e) {
      //print(e);
    }
  }

  getFeedPost(String tokken) async {
    final url = Uri.parse('$baseUrl/api/search/feed');
    try {
      final resposne = await http.get(url, headers: {
        'Content-Type': 'application/json',
        'authToken': tokken,
      });
      return jsonDecode(resposne.body);
    } on Exception catch (e) {
      //print(e);
    }
  }

  getPostById(String tokken) async {
    final url = Uri.parse('$baseUrl/api/post/getpost');
    try {
      final resposne = await http.get(url, headers: {
        'Content-Type': 'application/json',
        'authToken': tokken,
      });
      return jsonDecode(resposne.body);
    } on Exception catch (e) {
      //print(e);
    }
  }
}
