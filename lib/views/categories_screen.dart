import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:satufakta/services/news_service.dart';
import 'package:satufakta/views/category_articles_screen.dart';
import 'package:satufakta/views/widget/category_grid_item.dart'; 
import 'package:satufakta/views/widget/app_drawer.dart'; 

// Cukup StatelessWidget karena data dikelola oleh Provider
class CategoriesScreen extends StatelessWidget {
  const CategoriesScreen({super.key});

  void _navigateToCategory(BuildContext context, String categoryTitle) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => CategoryArticlesScreen(categoryTitle: categoryTitle),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(60.0),
        child: AppBar(
          title: const Text('Kategori Berita'),
          // ... Anda bisa menggunakan AppBar dari desain Anda sebelumnya di sini ...
        ),
      ),
      // drawer: const AppDrawer(),
      body: Consumer<NewsService>(
        builder: (context, newsService, child) {
          if (newsService.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }
          if (newsService.allNews.isEmpty) {
            return const Center(child: Text('Tidak ada berita untuk menampilkan kategori.'));
          }

          // --- LOGIKA UTAMA: Ekstrak Kategori Unik dari Semua Berita ---
          final uniqueCategories = newsService.allNews
              .where((article) => article.category != null && article.category!.isNotEmpty) // Filter kategori yang tidak null/kosong
              .map((article) => article.category!) // Ambil semua nama kategori
              .toSet() // Hapus duplikat
              .toList(); // Ubah kembali menjadi list

          if (uniqueCategories.isEmpty) {
            return const Center(child: Text('Tidak ada kategori yang ditemukan.'));
          }

          // Tampilkan kategori dalam bentuk Grid
          return GridView.builder(
            padding: const EdgeInsets.all(10.0),
            itemCount: uniqueCategories.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 3 / 2, // Sesuaikan rasio
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
            ),
            itemBuilder: (ctx, i) {
              final categoryTitle = uniqueCategories[i];
              // Menggunakan Card sederhana sebagai pengganti CategoryGridItem
              return InkWell(
                onTap: () => _navigateToCategory(context, categoryTitle),
                child: Card(
                  elevation: 2.0,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                  child: Center(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        categoryTitle,
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}