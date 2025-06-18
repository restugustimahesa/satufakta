import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:satufakta/models/post_model.dart';
import 'package:satufakta/views/post_detail_page.dart';
import 'package:satufakta/views/utils/helper.dart';

class PostCard extends StatelessWidget {
  final Post post;
  final VoidCallback onBookmarkTap;

  const PostCard({
    super.key,
    required this.post,
    required this.onBookmarkTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      // onTap: () {
      //   Navigator.push(
      //     context,
      //     MaterialPageRoute(
      //       builder: (context) => PostDetailPage(post: post),
      //     ),
      //   );
      // },
      child: Column(
        children: [
          Card(
            elevation: 2.0,
            margin: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12.0),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                ClipRRect(
                  borderRadius: const BorderRadius.all(Radius.circular(12.0)),
                  child: Image.network(
                    post.imageUrl,
                    height: 240,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        post.title,
                        style: const TextStyle(
                          fontSize: 18.0,
                          fontWeight: FontWeight.bold,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 6.0),
                      Text(
                        post.content,
                        style: TextStyle(
                          fontSize: 14.0,
                          color: Colors.grey[700],
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 12.0),
                      Row(
                        children: <Widget>[
                          CircleAvatar(
                            radius: 18,
                            backgroundImage: NetworkImage(post.author.avatarUrl),
                          ),
                          const SizedBox(width: 8.0),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                post.author.name,
                                style: const TextStyle(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 14.0,
                                ),
                              ),
                              Text(
                                DateFormat('MMMM d, yyyy').format(post.date), // Format tanggal
                                style: TextStyle(
                                  color: Colors.grey[600],
                                  fontSize: 12.0,
                                ),
                              ),
                            ],
                          ),
                          const Spacer(),
                          IconButton(
                            icon: Icon(
                              post.isBookmarked ? Icons.bookmark : Icons.bookmark_border,
                              color: post.isBookmarked ? const Color(0xFFF56A79) : Colors.grey,
                            ),
                            onPressed: onBookmarkTap,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          vsXLarge,
        ],
      ),
    );
  }
}