import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class User {
  final String name, username, email, token, id, userType;
  User(
      {required this.userType,
      required this.name,
      required this.username,
      required this.email,
      required this.token,
      required this.id});
}

class LocalDb with ChangeNotifier {
  User? user;
  bool isLoggedIn = false;
  checkForUserDetailsFromLocalDb() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    String token = await getCounter(pref, 'token');
    if (token != '') {
      await _getUserDetailsLocalDb();
      isLoggedIn = true;
      notifyListeners();
    } else {
      isLoggedIn = false;
      notifyListeners();
    }
  }

  _getUserDetailsLocalDb() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    String name, email, username, token, id, userTpe;
    token = await getCounter(pref, 'token');
    name = await getCounter(pref, 'name');
    email = await getCounter(pref, 'email');
    username = await getCounter(pref, 'username');
    id = await getCounter(pref, 'id');
    userTpe = await getCounter(pref, 'userType');
    user = User(
        email: email,
        name: name,
        id: id,
        username: username,
        token: token,
        userType: userTpe);
  }

  saveUserDetailsToLocalDb(Map<String, dynamic> mp) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    String name, email, username, token, id, userType;
    name = mp['user']['name'];
    email = mp['user']['email'];
    username = mp['user']['username'];
    id = mp['user']['id'] ?? "null";
    token = mp['authToken'];
    userType = 'Creator';

    await setCounter(pref, 'token', token);
    await setCounter(pref, 'name', name);
    await setCounter(pref, 'email', email);
    await setCounter(pref, 'username', username);
    await setCounter(pref, 'id', id);
    user = User(
        email: email,
        name: name,
        id: id,
        username: username,
        token: token,
        userType: userType);
    isLoggedIn = true;
    debugPrint(user.toString());
    notifyListeners();
  }

  Future<String> getCounter(SharedPreferences pref, String key) async {
    return pref.getString(key) ?? '';
  }

  Future<void> setCounter(
      SharedPreferences pref, String key, String value) async {
    await pref.setString(key, value);
  }

  logout() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    pref.clear();
    isLoggedIn = false;
    user = null;
  }
}
