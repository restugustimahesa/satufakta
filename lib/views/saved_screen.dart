// lib/views/saved_screen.dart
import 'package:flutter/material.dart';
import 'package:satufakta/models/post_model.dart';
import 'package:satufakta/views/profile_screen.dart';
import 'package:satufakta/views/widget/post_card.dart';
import 'package:satufakta/views/widget/app_drawer.dart';
import 'package:satufakta/views/utils/helper.dart';    

class SavedScreen extends StatefulWidget {
  static const routeName = '/saved-posts'; 
  final List<Post> allPosts; 
  final Function(String) onToggleBookmark; 

  const SavedScreen({
    super.key,
    required this.allPosts,
    required this.onToggleBookmark,
  });

  @override
  State<SavedScreen> createState() => _SavedScreenState();
}

class _SavedScreenState extends State<SavedScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  late List<Post> _bookmarkedPosts;

  @override
  void initState() {
    super.initState();
    _filterBookmarkedPosts();
  }

  @override
  void didUpdateWidget(SavedScreen oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.allPosts != oldWidget.allPosts) {
      _filterBookmarkedPosts();
    }
  }

  void _filterBookmarkedPosts() {
    setState(() {
      _bookmarkedPosts = widget.allPosts.where((post) => post.isBookmarked).toList();
      _bookmarkedPosts.sort((a, b) => b.date.compareTo(a.date));
    });
  }

  void _handleToggleBookmark(String postId) {
    widget.onToggleBookmark(postId);
    _filterBookmarkedPosts();
  }

  // Fungsi untuk menangani tap pada BottomNavigationBar
  void _onBottomNavTapped(int index, BuildContext context) {
    if (index == 0) { // Home
      if (ModalRoute.of(context)?.settings.name != '/home') {
        Navigator.pushNamedAndRemoveUntil(context, '/home', (route) => false);
      }
    } else if (index == 1) { // Saved
    } else if (index == 2) { // Profile
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const ProfileScreen(),
        ),
      ).then((_) {
        if (mounted) {
        }
      });
    } else if (index == 3) { // More/Up
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Aksi Lainnya (Belum dibuat)')),
      );
    }
  }


  @override
  Widget build(BuildContext context) {
    // Index untuk BottomNavigationBar di halaman ini adalah 1 (Saved)
    const int currentBottomNavIndex = 1;

    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: Colors.grey[100],
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
                      hintText: 'Cari di Postingan Tersimpan...',
                      hintStyle: TextStyle(color: Colors.grey[500], fontSize: 14),
                      border: InputBorder.none,
                      contentPadding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 0),
                    ),
                    style: const TextStyle(fontSize: 14),
                    onSubmitted: (value) {
                       ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Pencarian "$value" (belum diimplementasikan)')),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.notifications_none_outlined, color: Colors.grey[700]),
              onPressed: () {
                 ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Halaman Notifikasi (Belum dibuat)')),
                );
              },
            ),
          ],
        ),
      ),
      drawer: const AppDrawer(),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 8.0),
            child: Row(
              children: [
                Container( // Indikator merah kecil seperti di HomeScreen
                  width: 4,
                  height: 20,
                  color: const Color(0xFFF56A79), // Warna pink
                  margin: const EdgeInsets.only(right: 8.0),
                ),
                const Text(
                  'Postingan Tersimpan',
                  style: TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: _bookmarkedPosts.isEmpty
                ? Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.bookmark_border_rounded, size: 80, color: Colors.grey[400]),
                        vsMedium,
                        Text(
                          'Belum Ada Postingan Disimpan',
                          style: TextStyle(fontSize: 16, color: Colors.grey[600]),
                        ),
                        vsSmall,
                        Text(
                          'Tandai postingan untuk melihatnya di sini.',
                          style: TextStyle(fontSize: 14, color: Colors.grey[500]),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  )
                : ListView.builder(
                    padding: const EdgeInsets.only(top:0, bottom: 8.0),
                    itemCount: _bookmarkedPosts.length,
                    itemBuilder: (context, index) {
                      final post = _bookmarkedPosts[index];
                      return PostCard(
                        post: post,
                        onBookmarkTap: () => _handleToggleBookmark(post.id),
                      );
                    },
                  ),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentBottomNavIndex, // Item "Saved" aktif
        onTap: (index) => _onBottomNavTapped(index, context),
        type: BottomNavigationBarType.fixed,
        selectedItemColor: const Color(0xFFF56A79),
        unselectedItemColor: Colors.grey[600],
        selectedLabelStyle: const TextStyle(fontWeight: FontWeight.w600, fontSize: 10),
        unselectedLabelStyle: const TextStyle(fontSize: 10),
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home_outlined), // Outlined untuk tidak aktif
            activeIcon: Icon(Icons.home_filled), // Filled untuk aktif
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.bookmark_border_outlined),
            activeIcon: Icon(Icons.bookmark), // Ikon aktif untuk bookmark
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