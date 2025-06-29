import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:satufakta/services/auth_service.dart';
import 'package:satufakta/services/bookmark_service.dart';
import 'package:satufakta/services/news_service.dart';
import 'package:satufakta/views/about_screen.dart';
import 'package:satufakta/views/splash_screen.dart';
import 'package:satufakta/views/login_screen.dart';
import 'package:satufakta/views/home_screen.dart';
import 'package:satufakta/views/resgister_screen.dart';
import 'package:satufakta/views/categories_screen.dart';
import 'package:satufakta/views/category_articles_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (ctx) => AuthService()),
        ChangeNotifierProvider(create: (ctx) => BookmarkService()),
        ChangeNotifierProvider(create: (ctx) => NewsService()),
      ],
      child: MaterialApp(
        title: 'Satu Fakta',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFFF56A79)),
          fontFamily: 'Poppins',
          useMaterial3: true,
          appBarTheme: AppBarTheme(
            backgroundColor: Colors.white,
            elevation: 0.5,
            iconTheme: IconThemeData(color: Colors.grey[800]),
            titleTextStyle: TextStyle(
              color: Colors.grey[800],
              fontSize: 18,
              fontWeight: FontWeight.w600,
              fontFamily: 'Poppins',
            ),
          ),
        ),
        initialRoute: '/',
        routes: {
          '/': (ctx) => const SplashScreen(),
          '/login': (ctx) => const LoginScreen(),
          '/register': (ctx) => const ResgisterScreen(),
          '/home': (ctx) => const HomeScreen(),
          AboutScreen.routeName: (ctx) => const AboutScreen(),
        },
        onGenerateRoute: (settings) {
          
          return null;
        },
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}