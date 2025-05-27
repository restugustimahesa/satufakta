// lib/pages/home_page.dart
import 'package:flutter/material.dart';
import 'package:satufakta/models/post_model.dart';
import 'package:satufakta/views/widget/post_card.dart';
import 'package:satufakta/views/widget/app_drawer.dart';
import 'package:satufakta/views/utils/helper.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  int _selectedBottomNavIndex = 0;
  String _currentPostType = 'Postingan Populer';

  late List<Post> _allPosts;
  List<Post> _displayPosts = [];

  final String _sampleImageUrl1 =
      'assets/images/news1.jpg';
  final String _sampleImageUrl2 =
      'assets/images/news1.jpg';
  final String _sampleImageUrl3 =
      'assets/images/news2.jpeg';
  final String _sampleAvatarUrl = 'assets/images/avatar.png';


  @override
  void initState() {
    super.initState();
    _allPosts = [
      Post(
          id: '1',
          title: 'Exploring the Serene Lakes',
          content: 'Lorem Ipsum Dolor Sit Amet, Consectetur Adipiscing Elit, Sed Do Eiusmod Tempor incididunt ut labore et dolore magna aliqua.',
          imageUrl: _sampleImageUrl1,
          author: Author(name: 'Diar', avatarUrl: '${_sampleAvatarUrl}'),
          date: DateTime(2025, 7, 14),
          category: 'popular',
          isBookmarked: false),
      Post(
          id: '2',
          title: 'Mountain Vistas & Adventure',
          content: 'Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.',
          imageUrl: _sampleImageUrl2,
          author: Author(name: 'Restu', avatarUrl: '${_sampleAvatarUrl}'),
          date: DateTime(2025, 7, 12),
          category: 'popular',
          isBookmarked: true),
      Post(
          id: '3',
          title: 'Forest Trails and Wildlife',
          content: 'Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur.',
          imageUrl: _sampleImageUrl3,
          author: Author(name: 'Jembar', avatarUrl: '${_sampleAvatarUrl}'),
          date: DateTime(2025, 5, 20),
          category: 'new',
          isBookmarked: false),
      Post(
          id: '4',
          title: 'City Skylines at Night',
          content: 'Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.',
          imageUrl: _sampleImageUrl3,
          author: Author(name: 'KDM', avatarUrl: '${_sampleAvatarUrl}'),
          date: DateTime(2025, 5, 15),
          category: 'new',
          isBookmarked: false),
    ];
    _filterPosts();
  }

  void _filterPosts() {
    if (_currentPostType == 'Postingan Populer') {
      _displayPosts = _allPosts.where((post) => post.category == 'popular').toList();
    } else {
      _displayPosts = _allPosts.where((post) => post.category == 'new').toList();
    }
    setState(() {});
  }

  void _togglePostType() {
    setState(() {
      if (_currentPostType == 'Postingan Populer') {
        _currentPostType = 'Postingan Baru';
      } else {
        _currentPostType = 'Postingan Populer';
      }
      _filterPosts();
    });
  }

  void _toggleBookmark(String postId) {
    setState(() {
      final postIndex = _allPosts.indexWhere((p) => p.id == postId);
      if (postIndex != -1) {
        _allPosts[postIndex].isBookmarked = !_allPosts[postIndex].isBookmarked;
         // Jika Anda ingin perubahan bookmark langsung terlihat di _displayPosts
        final displayPostIndex = _displayPosts.indexWhere((p) => p.id == postId);
        if (displayPostIndex != -1) {
          _displayPosts[displayPostIndex].isBookmarked = _allPosts[postIndex].isBookmarked;
        }
      }
    });
  }

  void _onBottomNavTapped(int index) {
    setState(() {
      _selectedBottomNavIndex = index;
      // Tambahkan logika navigasi atau aksi lain di sini
      if (index == 0) { // Home
        // Sudah di home
      } else if (index == 1) { // Bookmark
        // Mungkin navigasi ke halaman bookmark
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Halaman Bookmark (Belum dibuat)')),
        );
      } else if (index == 2) { // Profile
         ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Halaman Profil (Belum dibuat)')),
        );
      } else if (index == 3) { // Up Arrow
         ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Aksi Panah Atas (Belum dibuat)')),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: Colors.grey[100], // Background halaman
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
              borderRadius: BorderRadius.circular(20.0),
            ),
            child: Row(
              children: <Widget>[
                hsSmall,
                Padding(
                  padding: const EdgeInsets.only(left: 2.0, right:0), // Adjust spacing
                  child: Icon(Icons.search, color: Colors.grey[700], size: 20)
                ),
                hsSmall,
                Expanded(
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: 'Search Anything',
                      hintStyle: TextStyle(color: Colors.grey[500], fontSize: 14),
                      border: InputBorder.none,
                      contentPadding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 0), // Adjust padding
                    ),
                    style: const TextStyle(fontSize: 14),
                  ),
                ),
              ],
            ),
          ),
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.search, color: Colors.grey[700]),
              onPressed: () {
                // Aksi pencarian
              },
            ),
          ],
        ),
      ),
      drawer: const AppDrawer(),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Row(
                  children: [
                     Container( // Indikator merah kecil
                      width: 4,
                      height: 20,
                      color: const Color(0xFFF56A79), // Warna pink
                      margin: const EdgeInsets.only(right: 8.0),
                    ),
                    Text(
                      _currentPostType,
                      style: const TextStyle(
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                Row(
                  children: <Widget>[
                    IconButton(
                      icon: const Icon(Icons.chevron_left),
                      onPressed: _togglePostType,
                      tooltip: 'Previous',
                    ),
                    IconButton(
                      icon: const Icon(Icons.chevron_right),
                      onPressed: _togglePostType,
                       tooltip: 'Next',
                    ),
                  ],
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
                    itemCount: _displayPosts.length,
                    itemBuilder: (context, index) {
                      final post = _displayPosts[index];
                      return PostCard(
                        post: post,
                        onBookmarkTap: () => _toggleBookmark(post.id),
                      );
                    },
                  ),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedBottomNavIndex,
        onTap: _onBottomNavTapped,
        type: BottomNavigationBarType.fixed, // Agar semua item terlihat
        selectedItemColor: const Color(0xFFF56A79), // Warna pink untuk item terpilih
        unselectedItemColor: Colors.grey[600],
        selectedLabelStyle: const TextStyle(fontWeight: FontWeight.w600, fontSize: 12),
        unselectedLabelStyle: const TextStyle(fontSize: 12),
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home_filled), // Menggunakan home_filled untuk yang terpilih
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
            icon: Icon(Icons.arrow_upward_outlined),
            activeIcon: Icon(Icons.arrow_upward),
            label: 'Up',
          ),
        ],
      ),
    );
  }
}