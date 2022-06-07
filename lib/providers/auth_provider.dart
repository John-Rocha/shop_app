import 'dart:convert';

import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shop_app/remote_config/custom_remote_config.dart';

class AuthProvider with ChangeNotifier {
  final dynamic token = FirebaseRemoteConfig.instance.getString('token');

  Future<void> _authenticate(
    String email,
    String password,
    String urlFragment,
  ) async {
    CustomRemoteConfig().forceFetch();
    final url =
        'https://identitytoolkit.googleapis.com/v1/accounts:$urlFragment?key=$token';
    final response = await http.post(
      Uri.parse(url),
      body: jsonEncode({
        "email": email,
        "password": password,
        "returnSecureToken": true,
      }),
    );
    print(jsonDecode(response.body));
  }

  Future<void> signup(String email, String password) async {
    _authenticate(email, password, 'signUp');
  }

  Future<void> login(String email, String password) async {
    _authenticate(email, password, 'signInWithPassword');
  }
}
