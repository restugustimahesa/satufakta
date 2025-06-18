import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:satufakta/models/news_article.dart';
import 'package:satufakta/services/api_service.dart';
import 'package:satufakta/services/auth_service.dart';
import 'package:satufakta/views/add_edit_news_screen.dart';
import 'package:satufakta/views/home_screen.dart';
import 'package:satufakta/views/saved_screen.dart';
import 'package:satufakta/views/splash_screen.dart';
import 'package:satufakta/views/widget/app_drawer.dart';

class ProfileScreen extends StatefulWidget {
  // Menghapus routeName karena navigasi tidak lagi menggunakan nama
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  late Future<List<NewsArticle>> _myNewsFuture;

  @override
  void initState() {
    super.initState();
    _loadMyNews();
  }

  // Fungsi untuk memuat atau me-refresh daftar berita milik user
  void _loadMyNews() {
    final token = Provider.of<AuthService>(context, listen: false).token;
    setState(() {
      _myNewsFuture = ApiService(token).getMyNews();
    });
  }

  // Fungsi untuk navigasi ke halaman edit
  void _editArticle(NewsArticle article) {
    Navigator.of(context)
        .push(
          MaterialPageRoute(
            builder: (context) => AddEditNewsScreen(article: article),
          ),
        )
        .then((_) => _loadMyNews());
  }

  // Fungsi untuk menghapus artikel
  Future<void> _deleteArticle(String articleId) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder:
          (ctx) => AlertDialog(
            title: const Text('Konfirmasi Hapus'),
            content: const Text(
              'Apakah Anda yakin ingin menghapus berita ini?',
            ),
            actions: [
              TextButton(
                child: const Text('Batal'),
                onPressed: () => Navigator.of(ctx).pop(false),
              ),
              TextButton(
                child: const Text('Hapus'),
                style: TextButton.styleFrom(foregroundColor: Colors.red),
                onPressed: () => Navigator.of(ctx).pop(true),
              ),
            ],
          ),
    );

    if (confirmed == true) {
      try {
        final token = Provider.of<AuthService>(context, listen: false).token;
        await ApiService(token).deleteNews(articleId);
        _loadMyNews(); // Refresh daftar berita
      } catch (e) {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Gagal menghapus berita: $e'),
              backgroundColor: Colors.red,
            ),
          );
        }
      }
    }
  }

  // Mengadopsi navigasi Bottom Nav dari file Anda
  void _onBottomNavTapped(int index) {
    if (index == 0) {
      // Home
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const HomeScreen()),
      );
    } else if (index == 1) {
      // Saved
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => SavedScreen()),
      );
    } else if (index == 2) {
      // Profile
      // Sudah di halaman ini
    } else if (index == 3) {
      // Lainnya
      _scaffoldKey.currentState?.openDrawer();
    }
  }

  @override
  Widget build(BuildContext context) {
    final authService = Provider.of<AuthService>(context, listen: false);
    final user = authService.user;
    const int currentBottomNavIndex = 2;

    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: Colors.grey[100],
      // Menggunakan AppBar dari desain Anda
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
                hintText: 'Cari di Profil...',
                prefixIcon: Icon(
                  Icons.search,
                  color: Colors.grey[700],
                  size: 20,
                ),
                border: InputBorder.none,
                contentPadding: const EdgeInsets.symmetric(vertical: 10.0),
              ),
            ),
          ),
        ),
      ),
      drawer: AppDrawer(),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            // Kartu Info Profil dari desain Anda, dengan data dinamis
            if (user != null)
              Padding(
                padding: const EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 8.0),
                child: Card(
                  elevation: 1.5,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Row(
                      children: <Widget>[
                        CircleAvatar(
                          radius: 35,
                          backgroundImage:
                              user.avatarUrl != null
                                  ? NetworkImage(user.avatarUrl!)
                                  : null,
                          child:
                              user.avatarUrl == null
                                  ? Text(
                                    user.firstName[0].toUpperCase(),
                                    style: const TextStyle(fontSize: 30),
                                  )
                                  : null,
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                user.fullName,
                                style: const TextStyle(
                                  fontSize: 20.0,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                "Lihat & kelola berita Anda",
                                style: TextStyle(
                                  fontSize: 13.0,
                                  color: Colors.grey[600],
                                ),
                              ),
                            ],
                          ),
                        ),
                        IconButton(
                          icon: const Icon(
                            Icons.logout,
                            color: Color(0xFFF56A79),
                          ),
                          onPressed: () {
                            authService.logout();
                            Navigator.of(context).pushAndRemoveUntil(
                              MaterialPageRoute(
                                builder: (context) => SplashScreen(),
                              ),
                              (Route<dynamic> route) => false,
                            );
                          },
                          tooltip: 'Logout',
                        ),
                      ],
                    ),
                  ),
                ),
              ),

            // Judul untuk daftar berita
            const Padding(
              padding: EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 8.0),
              child: Text(
                "Berita yang Saya Buat",
                style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
              ),
            ),

            // FutureBuilder untuk menampilkan daftar berita
            FutureBuilder<List<NewsArticle>>(
              future: _myNewsFuture,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: Padding(
                      padding: EdgeInsets.all(32.0),
                      child: CircularProgressIndicator(),
                    ),
                  );
                }
                if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                }
                if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return const Center(
                    child: Padding(
                      padding: EdgeInsets.all(32.0),
                      child: Text('Anda belum membuat berita apapun.'),
                    ),
                  );
                }

                final myNewsList = snapshot.data!;
                // ListView ditaruh di dalam Column, perlu shrinkWrap dan physics
                return ListView.builder(
                  // Trik penting untuk ListView di dalam Column/SingleChildScrollView
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: myNewsList.length,
                  itemBuilder: (context, index) {
                    final article = myNewsList[index];
                    return Card(
                      margin: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 6,
                      ),
                      child: ListTile(
                        leading:
                            (article.featuredImageUrl != null &&
                                    article.featuredImageUrl!.isNotEmpty)
                                ? SizedBox(
                                  width: 60,
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(4),
                                    child: Image.network(
                                      article.featuredImageUrl!,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                )
                                : const Icon(Icons.broken_image, size: 40),
                        title: Text(
                          article.title,
                          style: const TextStyle(fontWeight: FontWeight.w600),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    );
                  },
                );
              },
            ),
            const SizedBox(height: 20), // Memberi sedikit ruang di bawah
          ],
        ),
      ),
      // Menggunakan BottomNavigationBar dari desain Anda
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentBottomNavIndex,
        onTap: (index) => _onBottomNavTapped(index),
        type: BottomNavigationBarType.fixed,
        selectedItemColor: const Color(0xFFF56A79),
        unselectedItemColor: Colors.grey[600],
        selectedLabelStyle: const TextStyle(
          fontWeight: FontWeight.w600,
          fontSize: 10,
        ),
        unselectedLabelStyle: const TextStyle(fontSize: 10),
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home_outlined),
            activeIcon: Icon(Icons.home_filled),
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
