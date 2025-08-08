import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:news_app/core/constants/app_colors.dart';
import 'package:news_app/widgets/app_text.dart';
import 'package:news_app/widgets/app_button.dart';
import '../../data/model/news_model.dart';
import 'package:url_launcher/url_launcher.dart';

class ArticleView extends StatefulWidget {
  const ArticleView({super.key});

  @override
  State<ArticleView> createState() => _ArticleViewState();
}

class _ArticleViewState extends State<ArticleView> {
  final ScrollController _scrollController = ScrollController();
  double _readingProgress = 0.0;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_updateReadingProgress);
  }

  @override
  void dispose() {
    _scrollController.removeListener(_updateReadingProgress);
    _scrollController.dispose();
    super.dispose();
  }

  void _updateReadingProgress() {
    if (_scrollController.hasClients) {
      setState(() {
        _readingProgress =
            _scrollController.offset /
            (_scrollController.position.maxScrollExtent +
                _scrollController.position.viewportDimension);
      });
    }
  }

  String _getReadingTime(String content) {
    final words = content.split(' ').length;
    final readingTime = (words / 200).ceil(); // Average reading speed
    return '$readingTime min read';
  }

  @override
  Widget build(BuildContext context) {
    final Article article = Get.arguments;

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: SafeArea(
        child: Column(
          children: [
            // Custom App Bar with Progress
            Container(
              padding: EdgeInsets.symmetric(horizontal: 16.sp, vertical: 8.sp),
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
              child: Column(
                children: [
                  Row(
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
                          'Article',
                          fontSize: 18.sp,
                          fontWeight: FontWeight.bold,
                          textAlign: TextAlign.center,
                        ),
                      ),
                      IconButton(
                        onPressed: () {
                          // Share functionality
                        },
                        icon: Icon(
                          Icons.share,
                          color: Theme.of(context).iconTheme.color,
                        ),
                      ),
                    ],
                  ),
                  // Reading Progress Bar
                  LinearProgressIndicator(
                    value: _readingProgress,
                    backgroundColor: AppColors.background,
                    valueColor: AlwaysStoppedAnimation<Color>(
                      AppColors.primary,
                    ),
                  ),
                ],
              ),
            ),

            // Article Content
            Expanded(
              child: SingleChildScrollView(
                controller: _scrollController,
                padding: EdgeInsets.all(20.sp),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Article Image
                    if (article.urlToImage.isNotEmpty)
                      Container(
                        width: double.infinity,
                        height: 250.sp,
                        margin: EdgeInsets.only(bottom: 20.sp),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(16.sp),
                          boxShadow: [
                            BoxShadow(
                              color: AppColors.cardShadow,
                              blurRadius: 8,
                              offset: const Offset(0, 4),
                            ),
                          ],
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(16.sp),
                          child: CachedNetworkImage(
                            imageUrl: article.urlToImage,
                            fit: BoxFit.cover,
                            placeholder:
                                (context, url) => Container(
                                  color: AppColors.background,
                                  child: Center(
                                    child: CircularProgressIndicator(
                                      color: AppColors.primary,
                                    ),
                                  ),
                                ),
                            errorWidget:
                                (context, url, error) => Container(
                                  color: AppColors.background,
                                  child: Icon(
                                    Icons.error,
                                    color: AppColors.error,
                                    size: 40.sp,
                                  ),
                                ),
                          ),
                        ),
                      ),

                    // Article Title
                    AppText(
                      article.title,
                      fontSize: 24.sp,
                      fontWeight: FontWeight.bold,
                      maxLines: 3,
                    ),

                    SizedBox(height: 16.sp),

                    // Article Meta Information
                    Row(
                      children: [
                        Icon(
                          Icons.timer,
                          size: 16.sp,
                          color: AppColors.textLight,
                        ),
                        SizedBox(width: 8.sp),
                        AppText(
                          _getReadingTime(article.content),
                          fontSize: 14.sp,
                          color: AppColors.textLight,
                        ),
                        const Spacer(),
                        Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: 12.sp,
                            vertical: 6.sp,
                          ),
                          decoration: BoxDecoration(
                            color: AppColors.primary.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(20.sp),
                          ),
                          child: AppText(
                            'News',
                            fontSize: 12.sp,
                            color: AppColors.primary,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),

                    SizedBox(height: 24.sp),

                    // Article Description
                    AppText(
                      'Summary',
                      fontSize: 18.sp,
                      fontWeight: FontWeight.bold,
                      color: AppColors.primary,
                    ),
                    SizedBox(height: 8.sp),
                    Text(
                      article.description,
                      style: TextStyle(
                        fontSize: 16.sp,
                        color: AppColors.textSecondary,
                        height: 1.6,
                      ),
                    ),

                    SizedBox(height: 24.sp),

                    // Article Content
                    AppText(
                      'Full Article',
                      fontSize: 18.sp,
                      fontWeight: FontWeight.bold,
                      color: AppColors.primary,
                    ),
                    SizedBox(height: 8.sp),
                    Text(
                      article.content,
                      style: TextStyle(
                        fontSize: 16.sp,
                        color: AppColors.textPrimary,
                        height: 1.6,
                      ),
                    ),

                    SizedBox(height: 32.sp),

                    // Call to Action
                    Container(
                      width: double.infinity,
                      padding: EdgeInsets.all(20.sp),
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            AppColors.gradientStart,
                            AppColors.gradientEnd,
                          ],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                        borderRadius: BorderRadius.circular(16.sp),
                      ),
                      child: Column(
                        children: [
                          AppText(
                            'Read the full article',
                            fontSize: 18.sp,
                            fontWeight: FontWeight.bold,
                            color: AppColors.white,
                          ),
                          SizedBox(height: 8.sp),
                          AppText(
                            'Get the complete story with all details and context',
                            fontSize: 14.sp,
                            color: AppColors.white.withOpacity(0.8),
                            textAlign: TextAlign.center,
                          ),
                          SizedBox(height: 16.sp),
                          AppButton(
                            onPressed:
                                () => launchUrl(
                                  Uri.parse(article.url),
                                  mode: LaunchMode.inAppBrowserView,
                                ),
                            label: "Read Full Article",
                            backgroundColor: AppColors.white,
                            textColor: AppColors.primary,
                          ),
                        ],
                      ),
                    ),
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
