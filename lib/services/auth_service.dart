import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../models/user.dart';

class AuthService with ChangeNotifier {
  String? _token;
  User? _user;

  final String _baseUrl = 'http://45.149.187.204:3000';
  final String _loginPath = '/api/auth/login';
  final String _profilePath = '/api/auth/me';

  // Getters
  bool get isAuth => _token != null;
  String? get token => _token;
  User? get user => _user;

  Future<void> fetchAndSetUser() async {
    if (_token == null) return;

    final url = Uri.parse('$_baseUrl$_profilePath');
    try {
      final response = await http.get(
        url,
        headers: {'Authorization': 'Bearer $_token'},
      );
      
      if (response.statusCode == 200) {
        final responseData = json.decode(response.body);
        _user = User.fromJson(responseData['body']['data']);
        notifyListeners();
      } else {
        logout();
      }
    } catch (error) {
      print("Error fetching user: $error");
    }
  }

  Future<void> login(String email, String password) async {
    final url = Uri.parse('$_baseUrl$_loginPath');
    try {
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: json.encode({'email': email, 'password': password}),
      );

      if (response.statusCode == 200) {
        final responseData = json.decode(response.body);
        _token = responseData['body']['data']['token'];

        if (_token != null) {
          final prefs = await SharedPreferences.getInstance();
          await prefs.setString('authToken', _token!);

          await fetchAndSetUser(); 

        } else {
          throw Exception('Token tidak ditemukan di dalam respons server.');
        }
      } else {
        throw Exception('Login gagal. Status Code: ${response.statusCode}');
      }
    } catch (error) {
      throw Exception('Gagal terhubung ke server. Periksa kredensial Anda.');
    }
  }

  Future<void> tryAutoLogin() async {
    final prefs = await SharedPreferences.getInstance();
    if (!prefs.containsKey('authToken')) {
      return;
    }
    _token = prefs.getString('authToken');
    
    await fetchAndSetUser();
  }

  Future<void> logout() async {
    _token = null;
    _user = null;
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('authToken');
    notifyListeners();
  }
}