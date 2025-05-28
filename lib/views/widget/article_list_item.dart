// lib/widgets/article_list_item.dart
import 'package:flutter/material.dart';
import 'package:satufakta/models/category_page_models.dart'; // Sesuaikan path

class ArticleListItem extends StatelessWidget {
  final ArticleItemModel article;

  const ArticleListItem({super.key, required this.article});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 10.0),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      elevation: 3,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          ClipRRect(
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(10),
              topRight: Radius.circular(10),
            ),
            child: Image.network( // Atau Image.asset jika gambar lokal
              article.imageUrl,
              width: double.infinity,
              height: 200,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) => Container(
                  height: 200,
                  color: Colors.grey[200],
                  child: const Center(child: Icon(Icons.broken_image, size: 50, color: Colors.grey))),
              loadingBuilder: (context, child, loadingProgress) {
                if (loadingProgress == null) return child;
                return SizedBox(
                    height: 200,
                    child: const Center(child: CircularProgressIndicator()));
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  article.title,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 8),
                Row(
                  children: <Widget>[
                    CircleAvatar(
                      radius: 15,
                      backgroundImage: NetworkImage(article.authorImageUrl), // Atau AssetImage
                       onBackgroundImageError: (exception, stackTrace) {},
                       // ignore: unnecessary_null_comparison
                       child: NetworkImage(article.authorImageUrl) == null ? Icon(Icons.person) : null,
                    ),
                    const SizedBox(width: 8),
                    Expanded( // Agar nama author tidak overflow
                      child: Text(
                        article.authorName,
                        style: TextStyle(fontSize: 12, color: Colors.grey[700]),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    const Spacer(),
                    Text(
                      article.date,
                      style: TextStyle(fontSize: 12, color: Colors.grey[700]),
                    ),
                    // Icon bookmark bisa ditambahkan jika perlu
                    // SizedBox(width: 8),
                    // Icon(Icons.bookmark_border, color: Colors.grey[700], size: 20),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}