// lib/main.dart
import 'package:flutter/material.dart';
import 'package:satufakta/views/splash_screen.dart';
import 'package:satufakta/views/login_screen.dart';
import 'package:satufakta/views/home_screen.dart';
import 'package:satufakta/views/resgister_screen.dart';

// Impor baru untuk halaman kategori
import 'package:satufakta/views/categories_screen.dart';
import 'package:satufakta/views/category_articles_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
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
        CategoriesScreen.routeName: (ctx) => const CategoriesScreen(),
      },
      onGenerateRoute: (settings) {
        if (settings.name == CategoryArticlesScreen.routeName) {
          final args = settings.arguments as Map<String, String>?;

          if (args != null && args.containsKey('id') && args.containsKey('title')) {
            // Argumen valid, navigasi ke CategoryArticlesScreen
            return MaterialPageRoute(
              builder: (context) {
                // CategoryArticlesScreen akan mengambil argumennya sendiri
                // dari 'settings.arguments' melalui ModalRoute.of(context)
                return const CategoryArticlesScreen();
              },
              settings: settings, // Penting: teruskan settings ke MaterialPageRoute
            );
          } else {
            // Argumen tidak valid atau hilang untuk rute CategoryArticlesScreen
            return MaterialPageRoute(
              builder: (_) => Scaffold(
                appBar: AppBar(title: const Text("Kesalahan Navigasi")),
                body: Center(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Text(
                      "Error: Argumen tidak sesuai untuk rute ${settings.name}.\n"
                      "Harapan: Map dengan key 'id' dan 'title'.\n"
                      "Diterima: ${settings.arguments}",
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              ),
            );
          }
        }
        // Jika nama rute tidak cocok dengan kondisi di atas, kembalikan null
        // Ini akan menyebabkan Flutter mencari di 'routes' map atau menampilkan error jika tidak ditemukan sama sekali.
        // Untuk rute yang tidak didefinisikan di sini, ini adalah perilaku yang diharapkan.
        return null;
      },
      debugShowCheckedModeBanner: false,
    );
  }
}