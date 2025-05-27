class Author {
  final String name;
  final String avatarUrl;

  Author({required this.name, required this.avatarUrl});
}

class Post {
  final String id;
  final String title;
  final String content;
  final String imageUrl;
  final Author author;
  final DateTime date;
  bool isBookmarked;
  final String category; // 'popular' atau 'new'

  Post({
    required this.id,
    required this.title,
    required this.content,
    required this.imageUrl,
    required this.author,
    required this.date,
    this.isBookmarked = false,
    required this.category,
  });
}