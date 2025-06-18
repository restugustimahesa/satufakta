// lib/widgets/app_drawer.dart
import 'package:flutter/material.dart';
import 'package:satufakta/views/about_screen.dart';
import 'package:satufakta/views/categories_screen.dart'; // Impor halaman kategori

class AppDrawer extends StatelessWidget {
  const AppDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            decoration: BoxDecoration(color: Colors.grey[100]),
            child: Center(
              child: Image.asset(
                'assets/images/logo.png',
                fit: BoxFit.contain,
                height: 80.0,
              ),
            ),
          ),
          ListTile(
            leading: const Icon(Icons.home_outlined), // Icon untuk Home
            title: const Text('Beranda'),
            onTap: () {
              // Navigator.pop(context);
              Navigator.pushNamedAndRemoveUntil(
                context,
                '/home',
                (route) => false,
              );
            },
          ),
          ListTile(
            leading: const Icon(Icons.grid_view_outlined),
            title: const Text('Semua Kategori'), // Diubah teksnya
            onTap: () {
              Navigator.pop(context); // Tutup drawer
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => CategoriesScreen()),
              ); // Navigasi ke halaman Kategori
            },
          ),
          ListTile(
            leading: const Icon(Icons.info_outline),
            title: const Text('Tentang Kami'),
            onTap: () {
              Navigator.pop(context);
              Navigator.pushNamed(context, AboutScreen.routeName);
            },
          ),
        ],
      ),
    );
  }
}
