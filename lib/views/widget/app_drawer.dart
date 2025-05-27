// lib/widgets/app_drawer.dart
import 'package:flutter/material.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
            DrawerHeader(
              child: Image.asset(
              'assets/images/logo.png',
              fit: BoxFit.contain,
              width: 50.0,
              height: 50.0,
              ),
            ),
          ListTile(
            leading: const Icon(Icons.grid_view_outlined),
            title: const Text('Kategori'),
            onTap: () {
              Navigator.pop(context); // Tutup drawer
              // Tambahkan navigasi jika perlu
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
        ],
      ),
    );
  }
}