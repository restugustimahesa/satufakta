// lib/models/category_page_models.dart
class CategoryItemModel { // Diubah namanya untuk menghindari konflik jika ada CategoryItem lain
  final String id;
  final String title;
  final String imageUrl; // Bisa berupa URL atau path asset tergantung implementasi widget
  final List<String> subCategories;

  CategoryItemModel({
    required this.id,
    required this.title,
    required this.imageUrl,
    required this.subCategories,
  });
}

class ArticleItemModel { // Diubah namanya untuk menghindari konflik
  final String id;
  final String title;
  final String imageUrl; // Bisa berupa URL atau path asset
  final String authorName;
  final String authorImageUrl; // Bisa berupa URL atau path asset
  final String date;
  final String categoryId;

  ArticleItemModel({
    required this.id,
    required this.title,
    required this.imageUrl,
    required this.authorName,
    required this.authorImageUrl,
    required this.date,
    required this.categoryId,
  });
}