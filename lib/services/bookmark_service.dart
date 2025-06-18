import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

class BookmarkService with ChangeNotifier {
  static const _bookmarkKey = 'bookmarked_news_ids';

  List<String> _bookmarkedIds = [];

  List<String> get bookmarkedIds => _bookmarkedIds;

  // Memuat bookmark dari storage saat aplikasi dimulai
  Future<void> loadBookmarks() async {
    final prefs = await SharedPreferences.getInstance();
    _bookmarkedIds = prefs.getStringList(_bookmarkKey) ?? [];
    notifyListeners();
  }

  // Menyimpan bookmark ke storage
  Future<void> _saveBookmarks() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setStringList(_bookmarkKey, _bookmarkedIds);
  }

  // Mengecek apakah sebuah artikel sudah di-bookmark
  bool isBookmarked(String articleId) {
    return _bookmarkedIds.contains(articleId);
  }

  // Fungsi utama untuk menambah/menghapus bookmark
  Future<void> toggleBookmark(String articleId) async {
    if (isBookmarked(articleId)) {
      _bookmarkedIds.remove(articleId);
    } else {
      _bookmarkedIds.add(articleId);
    }
    
    // Simpan perubahan dan beri tahu UI untuk update
    await _saveBookmarks();
    notifyListeners();
  }
}