// lib/views/category_articles_screen.dart
import 'package:flutter/material.dart';
import 'package:satufakta/models/category_page_models.dart';
import 'package:satufakta/data/category_dummy_data.dart';
import 'package:satufakta/views/widget/article_list_item.dart';

class CategoryArticlesScreen extends StatelessWidget {
  static const routeName = '/category-articles';

  // Tidak perlu constructor jika mengambil argumen dari ModalRoute
  // final String categoryId;
  // final String categoryTitle;
  // const CategoryArticlesScreen({super.key, required this.categoryId, required this.categoryTitle});

  const CategoryArticlesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final routeArgs = ModalRoute.of(context)!.settings.arguments as Map<String, String>;
    final categoryId = routeArgs['id']!;
    final categoryTitle = routeArgs['title']!;

    final categoryArticles = DUMMY_ARTICLES_PAGE.where((article) {
      return article.categoryId == categoryId;
    }).toList();

    return Scaffold(
      appBar: AppBar(
        title: Text('Artikel: $categoryTitle'),
      ),
      body: categoryArticles.isEmpty
          ? Center(
              child: Text(
                'Tidak ada artikel untuk kategori "$categoryTitle".',
                style: TextStyle(fontSize: 16, color: Colors.grey[600]),
                textAlign: TextAlign.center,
              ),
            )
          : ListView.builder(
              padding: const EdgeInsets.all(10.0),
              itemCount: categoryArticles.length,
              itemBuilder: (ctx, i) => ArticleListItem(
                article: categoryArticles[i],
              ),
            ),
    );
  }
}