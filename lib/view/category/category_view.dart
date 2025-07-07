import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:news_app/routes/app_pages.dart';
import 'package:news_app/widgets/app_text.dart';
import 'package:news_app/widgets/app_textfield.dart';
import '../../controller/bookmark_controller.dart';
import '../../data/model/news_model.dart';
import '../../controller/category_controller.dart';
import '../../widgets/app_bar.dart';

class CategoryView extends StatelessWidget {
  final CategoryController controller = Get.put(CategoryController());
  final TextEditingController searchController = TextEditingController();

  CategoryView({super.key});

  @override
  Widget build(BuildContext context) {
    final String category = Get.arguments??'';

    WidgetsBinding.instance.addPostFrameCallback((_) {
      controller.loadCategory(category);
    });

    return Scaffold(
      appBar: buildAppBar(
        title: category.toUpperCase(),
        fontSize: 20.sp,
        showHome: true,
        showRefresh: true,
        onRefresh: controller.refreshNews,
      ),
      body: Obx(() {
        if (controller.isLoading.value && controller.articles.isEmpty) {
          return const Center(child: CircularProgressIndicator());
        }

        final articlesToDisplay =
            controller.isSearching.value
                ? controller.searchResults
                : controller.articles;

        return Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
              child: AppTextField(
                controller: searchController,
                hintText: 'Search news...',
                prefixIcon: const Icon(Icons.search),
                suffixIcon:
                    controller.isSearching.value
                        ? IconButton(
                          icon: const Icon(Icons.clear),
                          onPressed: () {
                            searchController.clear();
                            controller.clearSearch();
                          },
                        )
                        : null,
                onChanged: controller.onSearchChanged,
              ),
            ),
            Expanded(
              child: RefreshIndicator(
                onRefresh: controller.refreshNews,
                child: NotificationListener<ScrollNotification>(
                  onNotification: (scrollInfo) {
                    if (!controller.isSearching.value &&
                        scrollInfo.metrics.pixels >=
                            scrollInfo.metrics.maxScrollExtent - 100 &&
                        !controller.isLoading.value &&
                        controller.hasMore.value) {
                      controller.fetchNews();
                    }
                    return false;
                  },
                  child: ListView.builder(
                    physics: const AlwaysScrollableScrollPhysics(),
                    itemCount:
                        articlesToDisplay.length +
                        (controller.isSearching.value ||
                                !controller.hasMore.value
                            ? 1
                            : 1),
                    itemBuilder: (context, index) {
                      if (articlesToDisplay.isEmpty) {
                        return  Center(child: Padding(
                          padding:  EdgeInsets.only(top: 18.sp),
                          child: AppText("No articles found.",fontSize: 20.sp,),
                        ));
                      }
                      if (index < articlesToDisplay.length) {
                        return NewsTile(article: articlesToDisplay[index]);
                      }
                      if (!controller.hasMore.value) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(vertical: 24),
                          child: Center(
                            child: AppText(
                              "You've reached the end.",
                              fontSize: 20.sp,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        );
                      }
                      return const Padding(
                        padding: EdgeInsets.all(16),
                        child: Center(child: CircularProgressIndicator()),
                      );
                    },
                  ),
                ),
              ),
            ),
          ],
        );
      }),
    );
  }
}

class NewsTile extends StatelessWidget {
  final Article article;
  final BookmarkController bookmarkController = Get.put(BookmarkController());

  NewsTile({super.key, required this.article});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CachedNetworkImage(
        imageUrl: article.urlToImage,
        width: MediaQuery.sizeOf(context).width / 4,
        fit: BoxFit.cover,
        placeholder: (_, __) => const CircularProgressIndicator(),
        errorWidget: (_, __, ___) => const Icon(Icons.error),
      ),
      title: AppText(
        article.title,
        fontWeight: FontWeight.bold,
        maxLines: 2,
        overflow: TextOverflow.ellipsis,
      ),
      subtitle: AppText(
        article.description,
        maxLines: 3,
        overflow: TextOverflow.ellipsis,
      ),
      trailing: Obx(() {
        final isSaved = bookmarkController.isBookmarked(article);
        return IconButton(
          icon: Icon(
            isSaved ? Icons.bookmark : Icons.bookmark_outline,
            color: isSaved ? Colors.blue : Colors.grey,
          ),
          onPressed: () => bookmarkController.toggleBookmark(article),
        );
      }),
      onTap: () => Get.toNamed(Routes.article, arguments: article),
    );
  }
}
