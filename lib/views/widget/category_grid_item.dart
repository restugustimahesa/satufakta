// lib/widgets/category_grid_item.dart
import 'package:flutter/material.dart';
import 'package:satufakta/models/category_page_models.dart'; // Sesuaikan path

class CategoryGridItem extends StatelessWidget {
  final CategoryItemModel category;
  final VoidCallback onTap;

  const CategoryGridItem({
    super.key,
    required this.category,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        elevation: 3,
        margin: EdgeInsets.zero,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Expanded(
              flex: 5,
              child: ClipRRect(
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(10),
                  topRight: Radius.circular(10),
                ),
                child: Image.network( // Atau Image.asset jika gambar lokal
                  category.imageUrl,
                  height: double.infinity,
                  width: double.infinity,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) => const Center(
                      child: Icon(Icons.broken_image, size: 50, color: Colors.grey)),
                  loadingBuilder: (context, child, loadingProgress) {
                    if (loadingProgress == null) return child;
                    return const Center(child: CircularProgressIndicator());
                  },
                ),
              ),
            ),
            Expanded(
              flex: 4,
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center, // Pusatkan konten teks
                  children: <Widget>[
                    Text(
                      '❚ ${category.title}',
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFFF56A79), // Warna aksen
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 5),
                    ...category.subCategories.take(2).map((sub) { // Tampilkan maks 2 subkategori
                      return Text(
                        sub,
                        style: TextStyle(fontSize: 12, color: Colors.grey[700]),
                        overflow: TextOverflow.ellipsis,
                      );
                    }).toList(),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}