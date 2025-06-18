import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:satufakta/models/news_article.dart';
import 'package:satufakta/services/bookmark_service.dart';
import 'package:satufakta/services/news_service.dart';
import 'package:satufakta/views/home_screen.dart';
import 'package:satufakta/views/post_detail_page.dart';
import 'package:satufakta/views/profile_screen.dart';
import 'package:satufakta/views/widget/app_drawer.dart';
// Pastikan path import AppDrawer sudah benar sesuai struktur proyek Anda
// import 'package:test_api/widgets/app_drawer.dart';

// Diubah kembali menjadi StatefulWidget untuk mengelola ScaffoldKey
class SavedScreen extends StatefulWidget {
  const SavedScreen({Key? key}) : super(key: key);

  @override
  State<SavedScreen> createState() => _SavedScreenState();
}

class _SavedScreenState extends State<SavedScreen> {
  // Menambahkan GlobalKey untuk mengontrol Scaffold (terutama untuk membuka Drawer)
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  // Fungsi untuk menangani navigasi Bottom Nav
  void _onBottomNavTapped(int index) {
    if (index == 0) {
      // Home
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const HomeScreen()),
      );
    } else if (index == 1) {
      // Saved
      // Sudah di halaman ini
    } else if (index == 2) {
      // Profile
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const ProfileScreen()),
      );
    } else if (index == 3) {
      // Lainnya
      _scaffoldKey.currentState?.openDrawer();
    }
  }

  @override
  Widget build(BuildContext context) {
    const int currentBottomNavIndex = 1;

    return Scaffold(
      key: _scaffoldKey, // Menggunakan GlobalKey
      backgroundColor: Colors.grey[100],
      // --- MENGADOPSI AppBar DARI DESAIN ANDA ---
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
            child: TextField(
              decoration: InputDecoration(
                hintText: 'Cari di Berita Tersimpan...',
                prefixIcon: Icon(
                  Icons.search,
                  color: Colors.grey[700],
                  size: 20,
                ),
                border: InputBorder.none,
                contentPadding: const EdgeInsets.symmetric(vertical: 10.0),
              ),
              style: const TextStyle(fontSize: 14),
            ),
          ),
        ),
      ),
      drawer: AppDrawer(),

      // Bagian body (Consumer2) tidak berubah, karena logikanya sudah benar.
      body: Consumer2<BookmarkService, NewsService>(
        builder: (context, bookmarkService, newsService, child) {
          final bookmarkedArticles =
              newsService.allNews
                  .where((article) => bookmarkService.isBookmarked(article.id!))
                  .toList();

          if (bookmarkedArticles.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.bookmark_border_rounded,
                    size: 80,
                    color: Colors.grey[400],
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'Belum Ada Berita Disimpan',
                    style: TextStyle(fontSize: 16, color: Colors.grey[600]),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Tandai berita untuk melihatnya di sini.',
                    style: TextStyle(fontSize: 14, color: Colors.grey[500]),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            );
          }

          return ListView.builder(
            itemCount: bookmarkedArticles.length,
            itemBuilder: (ctx, index) {
              final article = bookmarkedArticles[index];
              return Card(
                margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                child: ListTile(
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 8,
                  ),
                  leading:
                      (article.featuredImageUrl != null &&
                              article.featuredImageUrl!.isNotEmpty)
                          ? ClipRRect(
                            borderRadius: BorderRadius.circular(8.0),
                            child: Image.network(
                              article.featuredImageUrl!,
                              width: 80,
                              height: 80,
                              fit: BoxFit.cover,
                            ),
                          )
                          : Container(
                            width: 80,
                            height: 80,
                            color: Colors.grey[200],
                            child: const Icon(Icons.image_not_supported),
                          ),
                  title: Text(
                    article.title,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  subtitle: Text(
                    'Oleh: ${article.author}',
                    style: TextStyle(color: Colors.grey[600], fontSize: 12),
                  ),
                  trailing: IconButton(
                    icon: Icon(
                      Icons.bookmark,
                      color: Theme.of(context).primaryColor,
                    ),
                    tooltip: 'Hapus dari Bookmark',
                    onPressed: () {
                      bookmarkService.toggleBookmark(article.id!);
                    },
                  ),
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => PostDetailPage(post: article),
                      ),
                    );
                  },
                ),
              );
            },
          );
        },
      ),

      // BottomNavigationBar tetap sama
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentBottomNavIndex,
        onTap: _onBottomNavTapped,
        type: BottomNavigationBarType.fixed,
        selectedItemColor: const Color(0xFFF56A79),
        unselectedItemColor: Colors.grey[600],
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home_outlined),
            activeIcon: Icon(Icons.home_filled),
            label: 'Beranda',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.bookmark_border_outlined),
            activeIcon: Icon(Icons.bookmark),
            label: 'Disimpan',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_outline),
            activeIcon: Icon(Icons.person),
            label: 'Profil',
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
