// lib/views/profile_screen.dart
import 'package:flutter/material.dart';
import 'package:satufakta/views/widget/app_drawer.dart'; // Sesuaikan path jika berbeda
import 'package:satufakta/views/utils/helper.dart';     // Sesuaikan path jika berbeda
// Impor lain yang mungkin Anda perlukan, misalnya HomeScreen untuk navigasi
// import 'package:satufakta/views/home_screen.dart';
// import 'package:satufakta/views/saved_screen.dart';

class ProfileScreen extends StatefulWidget {
  static const routeName = '/profile'; // Jika ingin diakses via named route

  // Anda bisa menambahkan parameter jika perlu, misal UserProfile data
  // final UserProfile user;
  // const ProfileScreen({super.key, required this.user});

  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  // Contoh data pengguna (ganti dengan data aktual jika ada)
  final String _userName = "Restu Gusti"; // Nama dari gambar referensi
  final String _userAvatarUrl = 'assets/images/avatar.png'; // Path ke avatar pengguna

  // Fungsi untuk menangani tap pada BottomNavigationBar
  void _onBottomNavTapped(int index, BuildContext context) {
    // Navigasi berdasarkan index bottom nav
    // Indeks 0 = Home, 1 = Saved, 2 = Profile, 3 = More/Up
    if (index == 0) { // Home
      if (ModalRoute.of(context)?.settings.name != '/home') {
        Navigator.pushNamedAndRemoveUntil(context, '/home', (route) => false);
      }
    } else if (index == 1) { // Saved
      // Navigasi ke SavedScreen. Anda perlu memastikan SavedScreen dapat diakses
      // dan menerima argumen yang benar jika diperlukan (misal dari state management)
      // Contoh: Navigator.pushNamed(context, SavedScreen.routeName);
      // Untuk saat ini, kita tampilkan pesan saja jika belum diimplementasikan
       ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Navigasi ke Halaman Tersimpan (perlu implementasi)')),
      );
    } else if (index == 2) { // Profile
      // Sudah di halaman Profile
    } else if (index == 3) { // More/Up
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Aksi Lainnya (Belum dibuat)')),
      );
    }
  }


  @override
  Widget build(BuildContext context) {
    // Index untuk BottomNavigationBar di halaman ini adalah 2 (Profile)
    const int currentBottomNavIndex = 2;

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
                      hintText: 'Cari di Profil...',
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
        ),
      ),
      drawer: const AppDrawer(),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            // Breadcrumbs (sesuai gambar, namun bisa diganti dengan judul halaman)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
              child: Row(
                children: [
                  GestureDetector(
                    onTap: () {
                       if (ModalRoute.of(context)?.settings.name != '/home') {
                          Navigator.pushNamedAndRemoveUntil(context, '/home', (route) => false);
                        }
                    },
                    child: Text('Home', style: TextStyle(color: Colors.grey[700], fontSize: 14))
                  ),
                  Icon(Icons.chevron_right, color: Colors.grey[500], size: 18),
                  Text('Profile', style: TextStyle(color: cBlack, fontSize: 14, fontWeight: FontWeight.w500)),
                ],
              ),
            ),

            // Kartu Info Profil
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
              child: Card(
                elevation: 1.5,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Row(
                    children: <Widget>[
                      CircleAvatar(
                        radius: 35,
                        backgroundImage: AssetImage(_userAvatarUrl), // Ganti dengan NetworkImage jika URL
                        // backgroundColor: Colors.grey[300], // Fallback jika gambar tidak ada
                        // child: AssetImage(_userAvatarUrl) == null ? Icon(Icons.person, size: 35, color: Colors.white) : null,
                      ),
                      hsMedium, // Dari helper.dart
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              _userName,
                              style: const TextStyle(
                                fontSize: 20.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            vsSuperTiny,
                            Text(
                              "Lihat & edit profil", // Subtitle atau status
                              style: TextStyle(fontSize: 13.0, color: Colors.grey[600]),
                            ),
                          ],
                        ),
                      ),
                      hsSmall,
                      // Tombol/Ikon di sisi kanan kartu (seperti pada gambar)
                      Container(
                        padding: const EdgeInsets.all(8.0),
                        decoration: BoxDecoration(
                          color: const Color(0xFFF56A79).withOpacity(0.1), // Warna pink transparan
                          borderRadius: BorderRadius.circular(20.0),
                        ),
                        child: Icon(
                          Icons.person_outline, // Atau Icons.edit_outlined
                          color: const Color(0xFFF56A79), // Warna pink
                          size: 22,
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
            vsMassive, // Beri ruang di bagian bawah
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentBottomNavIndex, // Item "Profile" aktif
        onTap: (index) => _onBottomNavTapped(index, context),
        type: BottomNavigationBarType.fixed,
        selectedItemColor: const Color(0xFFF56A79),
        unselectedItemColor: Colors.grey[600],
        selectedLabelStyle: const TextStyle(fontWeight: FontWeight.w600, fontSize: 10),
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
            activeIcon: Icon(Icons.person), // Ikon aktif untuk Profile
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

  // Helper widget untuk membuat item opsi profil
  Widget _buildProfileOptionItem({
    required IconData icon,
    required String title,
    required VoidCallback onTap,
    Color? textColor,
  }) {
    return ListTile(
      leading: Icon(icon, color: textColor ?? Colors.grey[700], size: 22),
      title: Text(title, style: TextStyle(fontSize: 15, color: textColor ?? cBlack, fontWeight: FontWeight.w500)),
      trailing: Icon(Icons.chevron_right, color: Colors.grey[400], size: 20),
      onTap: onTap,
      contentPadding: EdgeInsets.symmetric(vertical: 2.0, horizontal: 0), // Kurangi padding vertikal
    );
  }
}