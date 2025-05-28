// lib/views/categories_screen.dart
import 'package:flutter/material.dart';
import 'package:satufakta/models/category_page_models.dart';
import 'package:satufakta/data/category_dummy_data.dart';
import 'package:satufakta/views/widget/category_grid_item.dart';
import 'package:satufakta/views/category_articles_screen.dart';
import 'package:satufakta/views/widget/app_drawer.dart'; // Impor AppDrawer
import 'package:satufakta/views/home_screen.dart'; // Impor HomeScreen untuk navigasi

class CategoriesScreen extends StatefulWidget { // Diubah menjadi StatefulWidget
  static const routeName = '/categories';

  const CategoriesScreen({super.key});

  @override
  State<CategoriesScreen> createState() => _CategoriesScreenState();
}

class _CategoriesScreenState extends State<CategoriesScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  int _selectedBottomNavIndex = 0; // Indeks untuk BottomNavigationBar, sesuaikan jika perlu

  // Fungsi untuk menangani tap pada BottomNavigationBar
  void _onBottomNavTapped(int index) {
    setState(() {
      _selectedBottomNavIndex = index;
    });
    if (index == 0) {
      // Jika sudah di halaman kategori dan ada item Home, mungkin kembali ke HomeScreen
      // atau jika CategoriesScreen adalah bagian dari tab Home, tidak melakukan apa-apa.
      // Untuk contoh ini, kita navigasi ke HomeScreen jika belum di sana.
      if (ModalRoute.of(context)?.settings.name != '/home') { // Asumsi '/home' adalah routeName HomeScreen
        Navigator.pushNamedAndRemoveUntil(context, '/home', (route) => false);
      }
    } else if (index == 1) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Halaman Bookmark (Belum dibuat)')),
      );
    } else if (index == 2) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Halaman Profil (Belum dibuat)')),
      );
    } else if (index == 3) {
       ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Aksi Lain (Belum dibuat)')),
      );
    }
    // Tambahkan logika navigasi lain jika diperlukan
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey, // Kunci untuk membuka drawer
      backgroundColor: Colors.grey[100], // Background konsisten
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(60.0),
        child: AppBar(
          backgroundColor: Colors.white,
          elevation: 0.5,
          leading: IconButton(
            icon: Icon(Icons.menu, color: Colors.grey[700]),
            onPressed: () => _scaffoldKey.currentState?.openDrawer(),
          ),
          title: Container(
            height: 40,
            decoration: BoxDecoration(
              color: Colors.grey[200],
              borderRadius: BorderRadius.circular(8.0),
            ),
            child: Row(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(left: 10.0, right: 4.0),
                  child: Icon(Icons.search, color: Colors.grey[700], size: 20),
                ),
                Expanded(
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: 'Cari Kategori...', // Disesuaikan
                      hintStyle: TextStyle(color: Colors.grey[500], fontSize: 14),
                      border: InputBorder.none,
                      contentPadding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 0),
                    ),
                    style: const TextStyle(fontSize: 14),
                    onSubmitted: (value) {
                      // Logika pencarian kategori
                       ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Mencari kategori: $value (Belum diimplementasikan)')),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      drawer: const AppDrawer(), // Menggunakan AppDrawer yang sudah ada
      body: GridView.builder(
        padding: const EdgeInsets.all(10.0),
        itemCount: DUMMY_CATEGORIES_PAGE.length,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 2 / 2.8,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
        ),
        itemBuilder: (ctx, i) => CategoryGridItem(
          category: DUMMY_CATEGORIES_PAGE[i],
          onTap: () {
            Navigator.of(context).pushNamed(
              CategoryArticlesScreen.routeName,
              arguments: {
                'id': DUMMY_CATEGORIES_PAGE[i].id,
                'title': DUMMY_CATEGORIES_PAGE[i].title,
              },
            );
          },
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedBottomNavIndex, // Indeks item yang aktif
        onTap: _onBottomNavTapped,
        type: BottomNavigationBarType.fixed,
        selectedItemColor: const Color(0xFFF56A79), // Warna item aktif
        unselectedItemColor: Colors.grey[600],
        selectedLabelStyle: const TextStyle(fontWeight: FontWeight.w600, fontSize: 10),
        unselectedLabelStyle: const TextStyle(fontSize: 10),
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home_filled),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.bookmark_border_outlined),
            activeIcon: Icon(Icons.bookmark),
            label: 'Saved',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_outline),
            activeIcon: Icon(Icons.person),
            label: 'Profile',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.apps_outlined), // Mengganti ikon panah atas
            activeIcon: Icon(Icons.apps),    // Mengganti ikon panah atas
            label: 'Lainnya', // Mengganti label
          ),
        ],
      ),
    );
  }
}