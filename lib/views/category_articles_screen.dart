import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:satufakta/models/news_article.dart';
import 'package:satufakta/services/news_service.dart';
import 'package:satufakta/views/post_detail_page.dart';

// Diubah agar menerima categoryTitle secara langsung
class CategoryArticlesScreen extends StatelessWidget {
  final String categoryTitle;

  const CategoryArticlesScreen({required this.categoryTitle, super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        // Judul AppBar sekarang dinamis sesuai kategori yang dipilih
        title: Text(categoryTitle),
      ),
      body: Consumer<NewsService>(
        builder: (context, newsService, child) {
          if (newsService.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          // --- LOGIKA UTAMA: Filter Semua Berita Berdasarkan Kategori ---
          final categoryArticles = newsService.allNews
              .where((article) => article.category == categoryTitle)
              .toList();
          
          if (categoryArticles.isEmpty) {
            return Center(
              child: Text('Tidak ada artikel untuk kategori "$categoryTitle".'),
            );
          }

          // Tampilkan daftar artikel yang sudah difilter
          return ListView.builder(
            padding: const EdgeInsets.all(8.0),
            itemCount: categoryArticles.length,
            itemBuilder: (ctx, i) {
              final article = categoryArticles[i];
              // Menggunakan ListTile sederhana sebagai pengganti ArticleListItem
              return Card(
                margin: const EdgeInsets.symmetric(vertical: 6, horizontal: 8),
                child: ListTile(
                  title: Text(article.title, style: const TextStyle(fontWeight: FontWeight.bold)),
                  subtitle: Text(article.summary ?? '', maxLines: 2, overflow: TextOverflow.ellipsis),
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (_) => PostDetailPage(post: article),
                      ),
                    );
                  },
                ),
              );
            },
          );
        },
      ),
    );
  }
}