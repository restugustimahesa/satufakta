import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:satufakta/views/home_screen.dart';
import 'package:satufakta/views/login_screen.dart';
import 'package:satufakta/services/auth_service.dart';

class AuthCheckScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Logika ini kita pindahkan dari main.dart
    return Consumer<AuthService>(
      builder: (ctx, auth, _) => auth.isAuth
          ? HomeScreen()
          : FutureBuilder(
              future: auth.tryAutoLogin(),
              builder: (ctx, authResultSnapshot) =>
                  authResultSnapshot.connectionState == ConnectionState.waiting
                      ? Scaffold(
                          body: Center(child: CircularProgressIndicator()),
                        )
                      : LoginScreen(),
            ),
    );
  }
}