// lib/views/categories_screen.dart
import 'package:flutter/material.dart';
import 'package:satufakta/models/category_page_models.dart'; 
import 'package:satufakta/data/category_dummy_data.dart'; 
import 'package:satufakta/views/widget/category_grid_item.dart'; 
import 'package:satufakta/views/category_articles_screen.dart'; 

class CategoriesScreen extends StatelessWidget {
  static const routeName = '/categories'; // Route name untuk navigasi

  const CategoriesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pilih Kategori'),
        // Anda bisa menyesuaikan AppBar ini agar konsisten dengan tema aplikasi Anda
      ),
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
    );
  }
}