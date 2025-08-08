import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:news_app/core/constants/app_colors.dart';
import 'package:news_app/widgets/app_text.dart';
import 'package:news_app/widgets/news_tile.dart';

import '../../controller/bookmark_controller.dart';

class BookmarkView extends StatelessWidget {
  final BookmarkController controller = Get.put(BookmarkController());

  BookmarkView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: SafeArea(
        child: Column(
          children: [
            // Custom App Bar
            Container(
              padding: EdgeInsets.symmetric(horizontal: 16.sp, vertical: 12.sp),
              decoration: BoxDecoration(
                color: Theme.of(context).appBarTheme.backgroundColor,
                boxShadow: [
                  BoxShadow(
                    color: AppColors.cardShadow,
                    blurRadius: 4,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Row(
                children: [
                  IconButton(
                    onPressed: () => Get.back(),
                    icon: Icon(
                      Icons.arrow_back,
                      color: Theme.of(context).iconTheme.color,
                    ),
                  ),
                  Expanded(
                    child: AppText(
                      'Bookmarks',
                      fontSize: 20.sp,
                      fontWeight: FontWeight.bold,
                      textAlign: TextAlign.center,
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      // Clear all bookmarks
                      controller.clearAllBookmarks();
                    },
                    icon: Icon(
                      Icons.delete_sweep,
                      color: Theme.of(context).iconTheme.color,
                    ),
                  ),
                ],
              ),
            ),

            // Content
            Expanded(
              child: Obx(() {
                if (controller.bookmarks.isEmpty) {
                  return _buildEmptyState();
                }
                return _buildBookmarksList();
              }),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Padding(
        padding: EdgeInsets.all(32.sp),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 120.sp,
              height: 120.sp,
              decoration: BoxDecoration(
                color: AppColors.primary.withOpacity(0.1),
                borderRadius: BorderRadius.circular(60.sp),
              ),
              child: Icon(
                Icons.bookmark_outline,
                size: 60.sp,
                color: AppColors.primary,
              ),
            ),
            SizedBox(height: 24.sp),
            AppText(
              'No Bookmarks Yet',
              fontSize: 24.sp,
              fontWeight: FontWeight.bold,
              color: AppColors.textPrimary,
            ),
            SizedBox(height: 12.sp),
            AppText(
              'Save interesting articles to read them later',
              fontSize: 16.sp,
              color: AppColors.textSecondary,
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 32.sp),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 24.sp, vertical: 12.sp),
              decoration: BoxDecoration(
                color: AppColors.primary.withOpacity(0.1),
                borderRadius: BorderRadius.circular(20.sp),
              ),
              child: AppText(
                'Start exploring news categories',
                fontSize: 14.sp,
                color: AppColors.primary,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBookmarksList() {
    return Column(
      children: [
        // Header with count
        Container(
          padding: EdgeInsets.all(16.sp),
          child: Row(
            children: [
              Icon(Icons.bookmark, color: AppColors.primary, size: 20.sp),
              SizedBox(width: 8.sp),
              AppText(
                '${controller.bookmarks.length} Saved Articles',
                fontSize: 16.sp,
                fontWeight: FontWeight.w600,
                color: AppColors.primary,
              ),
            ],
          ),
        ),

        // Bookmarks List
        Expanded(
          child: ListView.builder(
            padding: EdgeInsets.symmetric(horizontal: 8.sp),
            itemCount: controller.bookmarks.length,
            itemBuilder: (context, index) {
              return NewsTile(article: controller.bookmarks[index]);
            },
          ),
        ),
      ],
    );
  }
}
