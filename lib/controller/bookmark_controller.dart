import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

import '../core/utils/app_snackbar.dart';
import '../data/model/news_model.dart';

class BookmarkController extends GetxController {
  final bookmarks = <Article>[].obs;

  @override
  void onInit() {
    super.onInit();
    loadBookmarks();
  }

  void addBookmark(Article article) {
    if (!bookmarks.contains(article)) {
      bookmarks.add(article);
      saveBookmarks();
      showAppSnackBar("Saved", "Article bookmarked.");
    }
  }

  void removeBookmark(Article article) {
    bookmarks.remove(article);
    saveBookmarks();
    showAppSnackBar("Removed", "Bookmark removed.");
  }

  void toggleBookmark(Article article) {
    if (bookmarks.contains(article)) {
      removeBookmark(article);
    } else {
      addBookmark(article);
    }
  }

  bool isBookmarked(Article article) {
    return bookmarks.contains(article);
  }

  void clearAllBookmarks() {
    bookmarks.clear();
    saveBookmarks();
    showAppSnackBar("Cleared", "All bookmarks removed.");
  }

  Future<void> saveBookmarks() async {
    final prefs = await SharedPreferences.getInstance();
    final encoded = bookmarks.map((e) => jsonEncode(e.toJson())).toList();
    await prefs.setStringList('bookmarked_articles', encoded);
  }

  Future<void> loadBookmarks() async {
    final prefs = await SharedPreferences.getInstance();
    final data = prefs.getStringList('bookmarked_articles') ?? [];
    final loaded = data.map((e) => Article.fromJson(jsonDecode(e))).toList();
    bookmarks.assignAll(loaded);
  }
}
