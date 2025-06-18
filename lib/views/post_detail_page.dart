// lib/pages/post_detail_page.dart
import 'package:flutter/material.dart';
import 'package:satufakta/models/news_article.dart';
import 'package:satufakta/models/post_model.dart';
import 'package:intl/intl.dart';
import 'package:satufakta/views/utils/helper.dart';

class PostDetailPage extends StatelessWidget {
  final NewsArticle post;

  const PostDetailPage({super.key, required this.post});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          post.title,
          style: const TextStyle(color: Colors.black87, fontSize: 18),
        ),
        backgroundColor: Colors.white,
        elevation: 1,
        iconTheme: const IconThemeData(color: Colors.black54),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    post.title,
                    style: const TextStyle(
                      fontSize: 24.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  vsLarge,
                  Image.network(
                    '${post.featuredImageUrl}',
                    height: 200, // Ukuran disesuaikan
                    width: double.infinity,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      return Container(
                        alignment: Alignment.center,
                        height: 200,
                        color: Colors.grey[300],
                        child: Icon(
                          Icons.broken_image,
                          color: Colors.grey[600],
                        ),
                      );
                    },
                  ),
                  vsMedium,
                  const SizedBox(height: 8.0),
                  Row(
                    children: [
                      vsTiny,
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Icon(
                                Icons.calendar_month_outlined,
                                size: 16,
                                color: Colors.grey[600],
                              ),
                              hsMedium,
                              if (post.createdAt != null)
                                Text(
                                  DateFormat(
                                    'd MMM yyyy',
                                  ).format(post.createdAt!),
                                  style: TextStyle(
                                    color: Colors.grey[600],
                                    fontSize: 12.0,
                                  ),
                                ),
                            ],
                          ),
                          hsMassive,
                          hsXLarge,
                          Row(
                            children: [
                              Icon(
                                Icons.category_outlined,
                                size: 16,
                                color: Colors.grey[600],
                              ),
                              hsMedium,
                              Text(
                                post.category == 'popular' ? 'Populer' : 'Baru',
                                style: TextStyle(
                                  color: Colors.grey[600],
                                  fontSize: 12,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 16.0),
                  const Divider(),
                  const SizedBox(height: 10.0),
                  Text(
                    post.title,
                    style: const TextStyle(
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  vsMedium,
                  Text(
                    post.content, // Isi konten yang lebih panjang
                    style: TextStyle(
                      fontSize: 16.0,
                      height: 1.5, // Jarak antar baris
                      color: Colors.grey[800],
                    ),
                  ),
                  vsMedium,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      ElevatedButton.icon(
                        onPressed: () {
                          // Implementasi logika share
                          // final shareContent =
                          //   '${post.title}\n\n${post.content}\n\n${post.imageUrl}';
                          // Gunakan package seperti 'share_plus' untuk berbagi
                          // Share.share(shareContent);
                        },
                        icon: const Icon(Icons.share_outlined),
                        label: const Text('Bagikan'),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: cWhite,
                          foregroundColor: cBlack,
                        ),
                      ),
                      IconButton(
                        onPressed: () {
                          // Implementasi logika bookmark
                          // Misalnya, simpan ke database lokal atau state management
                        },
                        icon: Row(
                          children: [
                            Text(
                              'Simpan',
                              style: TextStyle(fontSize: 12, color: cBlack),
                            ),
                            const SizedBox(width: 4),
                            Icon(Icons.bookmark_border, color: cBlack),
                          ],
                        ),
                      ),
                    ],
                  ),
                  vsMedium,
                  Row(
                    children: [
                      vsSmall,
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          hsMedium,
                          Text(
                            post.author!,
                            style: const TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 14.0,
                            ),
                          ),
                          vsMedium,
                          ElevatedButton.icon(
                            onPressed: () {
                              // Implementasi logika share
                              // final shareContent =
                              //   '${post.title}\n\n${post.content}\n\n${post.imageUrl}';
                              // Gunakan package seperti 'share_plus' untuk berbagi
                              // Share.share(shareContent);
                            },
                            icon: const Icon(Icons.add_circle_outline),
                            label: const Text('Ikuti'),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.pinkAccent,
                              foregroundColor: cWhite,
                            ),
                          ),
                        ],
                      ),
                      vsMedium,
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
