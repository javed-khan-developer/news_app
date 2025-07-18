import 'package:get/get.dart';
import '../core/utils/app_snackbar.dart';
import '../core/utils/debouncer.dart';
import '../data/model/news_model.dart';

import '../data/provider/api_service.dart';


class CategoryController extends GetxController {
  final articles = <Article>[].obs;
  final searchResults = <Article>[].obs;
  final isSearching = false.obs;
  final isLoading = false.obs;
  final hasMore = true.obs;
  final isRefreshing = false.obs;

  int _page = 1;
  String category = '';
  String searchQuery = '';
  final Debouncer _debouncer = Debouncer(milliseconds: 600);

  void loadCategory(String categoryName) {
    if (category != categoryName) {
      category = categoryName;
      refreshNews();
    }
  }

   fetchNews() async {
    if (isLoading.value || !hasMore.value) return;

    isLoading.value = true;
    try {
      final result = await ApiService.fetchNews(category, _page);
      if (result.isEmpty) {
        hasMore.value = false;
      } else {
        articles.addAll(result);
        _page++;
      }
    } catch (e) {
      showAppSnackBar("Error", "Failed to fetch articles.");
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> refreshNews() async {
    isRefreshing.value = true;
    _page = 1;
    hasMore.value = true;
    isSearching.value = false;
    searchQuery = '';
    searchResults.clear();
    articles.clear();
    await fetchNews();
    isRefreshing.value = false;
  }

  Future<void> searchNews(String query) async {
    if (query.trim().isEmpty) return;

    isSearching.value = true;
    isLoading.value = true;
    searchQuery = query;

    try {
      final result = await ApiService.searchNews(query);
      searchResults.assignAll(result);
    } catch (e) {
      showAppSnackBar("Error", "Search failed.");
      searchResults.clear();
    } finally {
      isLoading.value = false;
    }
  }

  void clearSearch() {
    isSearching.value = false;
    searchQuery = '';
    searchResults.clear();
  }
  void onSearchChanged(String value) {
    _debouncer.run(() {
      if (value.trim().isEmpty) {
        clearSearch();
      } else {
        searchNews(value);
      }
    });
  }

  @override
  void onClose() {
    _debouncer.dispose();
    super.onClose();
  }

}
