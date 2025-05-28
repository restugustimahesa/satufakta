// lib/widgets/app_drawer.dart
import 'package:flutter/material.dart';
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
            decoration: BoxDecoration(
              color: Colors.grey[100],
            ),
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
              Navigator.pop(context); // Tutup drawer
              // Jika sudah di HomeScreen, tidak perlu navigasi,
              // atau bisa menggunakan Navigator.pushReplacementNamed jika HomeScreen punya routeName
              // Misalnya, jika Anda ada di halaman detail dan ingin kembali ke Home:
              // Navigator.pushNamedAndRemoveUntil(context, '/home', (route) => false);
            },
          ),
          ListTile(
            leading: const Icon(Icons.grid_view_outlined),
            title: const Text('Semua Kategori'), // Diubah teksnya
            onTap: () {
              Navigator.pop(context); // Tutup drawer
              Navigator.pushNamed(context, CategoriesScreen.routeName); // Navigasi ke halaman Kategori
            },
          ),
          ListTile(
            leading: const Icon(Icons.pages_outlined),
            title: const Text('Halaman'),
            onTap: () {
              Navigator.pop(context);
              // Tambahkan navigasi
            },
          ),
          ListTile(
            leading: const Icon(Icons.info_outline),
            title: const Text('Tentang Kami'),
            onTap: () {
              Navigator.pop(context);
              // Tambahkan navigasi
            },
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.settings_outlined),
            title: const Text('Pengaturan'),
            onTap: () {
              Navigator.pop(context);
              // Tambahkan navigasi
            },
          ),
        ],
      ),
    );
  }
}