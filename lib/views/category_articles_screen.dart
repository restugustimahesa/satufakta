// lib/views/category_articles_screen.dart
import 'package:flutter/material.dart';
import 'package:satufakta/models/category_page_models.dart';
import 'package:satufakta/data/category_dummy_data.dart';
import 'package:satufakta/views/profile_screen.dart';
import 'package:satufakta/views/widget/article_list_item.dart';
import 'package:satufakta/views/widget/app_drawer.dart'; // Impor AppDrawer
import 'package:satufakta/views/home_screen.dart'; // Impor HomeScreen untuk navigasi


class CategoryArticlesScreen extends StatefulWidget { // Diubah menjadi StatefulWidget
  static const routeName = '/category-articles';

  const CategoryArticlesScreen({super.key});

  @override
  State<CategoryArticlesScreen> createState() => _CategoryArticlesScreenState();
}

class _CategoryArticlesScreenState extends State<CategoryArticlesScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  int _selectedBottomNavIndex = 0; // Default ke Home atau indeks yang relevan

  // Fungsi untuk menangani tap pada BottomNavigationBar
  void _onBottomNavTapped(int index) {
    setState(() {
      _selectedBottomNavIndex = index;
    });
    if (index == 0) {
      // Jika sudah di halaman kategori dan ada item Home, mungkin kembali ke HomeScreen
      // atau jika CategoriesScreen adalah bagian dari tab Home, tidak melakukan apa-apa.
      // Untuk contoh ini, kita navigasi ke HomeScreen jika belum di sana.
      if (ModalRoute.of(context)?.settings.name != '/home') {
        // Asumsi '/home' adalah routeName HomeScreen
        Navigator.pushNamedAndRemoveUntil(context, '/home', (route) => false);
      }
    } else if (index == 1) {
      Navigator.pushNamed(context, '/saved');
    } else if (index == 2) {
      Navigator.push(
        // Gunakan push agar bisa kembali
        context,
        MaterialPageRoute(
          builder: (context) => const ProfileScreen(),
        ),
      ).then((_) {
        if (mounted) {
          // setState(() {}); // Contoh refresh sederhana jika ada state yang berubah
        }
      });
    } else if (index == 3) {
      _scaffoldKey.currentState?.openDrawer();
    }
    // Tambahkan logika navigasi lain jika diperlukan
  }


  @override
  Widget build(BuildContext context) {
    final routeArgs = ModalRoute.of(context)!.settings.arguments as Map<String, String>;
    final categoryId = routeArgs['id']!;
    final categoryTitle = routeArgs['title']!;

    final categoryArticles = DUMMY_ARTICLES_PAGE.where((article) {
      return article.categoryId == categoryId;
    }).toList();

    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: Colors.grey[100],
      appBar: PreferredSize( // Menggunakan AppBar yang sama
        preferredSize: const Size.fromHeight(60.0),
        child: AppBar(
          backgroundColor: Colors.white,
          elevation: 0.5,
          // Tombol kembali akan otomatis ditambahkan oleh Navigator jika halaman ini di-push
          // Jika ingin kustomisasi tombol kembali atau drawer di sini:
          // leading: IconButton(
          //   icon: Icon(Icons.arrow_back_ios, color: Colors.grey[700]),
          //   onPressed: () => Navigator.of(context).pop(),
          // ),
          title: Container( // Menggunakan search bar di title seperti HomeScreen
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
                      hintText: 'Cari di "$categoryTitle"...', // Disesuaikan
                      hintStyle: TextStyle(color: Colors.grey[500], fontSize: 14),
                      border: InputBorder.none,
                      contentPadding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 0),
                    ),
                    style: const TextStyle(fontSize: 14),
                     onSubmitted: (value) {
                      // Logika pencarian artikel dalam kategori
                       ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Mencari artikel: $value (Belum diimplementasikan)')),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      // drawer: const AppDrawer(), // Drawer mungkin tidak umum di halaman detail seperti ini, tapi bisa ditambahkan jika perlu
      body: categoryArticles.isEmpty
          ? Center(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  'Tidak ada artikel untuk kategori "$categoryTitle".',
                  style: TextStyle(fontSize: 16, color: Colors.grey[600]),
                  textAlign: TextAlign.center,
                ),
              ),
            )
          : ListView.builder(
              padding: const EdgeInsets.all(10.0),
              itemCount: categoryArticles.length,
              itemBuilder: (ctx, i) => ArticleListItem(
                article: categoryArticles[i],
                // Jika ingin navigasi ke detail artikel dari sini, tambahkan onTap
              ),
            ),
      bottomNavigationBar: BottomNavigationBar( // Bottom Nav Bar ditambahkan
        currentIndex: _selectedBottomNavIndex,
        onTap: _onBottomNavTapped,
        type: BottomNavigationBarType.fixed,
        selectedItemColor: const Color(0xFFF56A79),
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
            icon: Icon(Icons.apps_outlined),
            activeIcon: Icon(Icons.apps),
            label: 'Lainnya',
          ),
        ],
      ),
    );
  }
}