import 'dart:convert';

import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shop_app/remote_config/custom_remote_config.dart';

class AuthProvider with ChangeNotifier {
  late dynamic token;
  static const _url =
      'https://identitytoolkit.googleapis.com/v1/accounts:signUp?key=';

  Future<void> signup(String email, String password) async {
    CustomRemoteConfig().forceFetch();
    token = FirebaseRemoteConfig.instance.getString('token');
    final response = await http.post(
      Uri.parse('$_url$token'),
      body: jsonEncode({
        "email": email,
        "password": password,
        "returnSecureToken": true,
      }),
    );
    print(jsonDecode(response.body));
  }
}
