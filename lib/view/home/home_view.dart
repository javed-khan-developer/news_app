import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:news_app/core/constants/app_colors.dart';
import 'package:news_app/core/constants/app_strings.dart';
import 'package:news_app/widgets/app_text.dart';
import '../../routes/app_pages.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  int _selectedIndex = 0;

  final List<Map<String, dynamic>> categories = [
    {
      'name': 'general',
      'icon': Icons.public,
      'color': AppColors.general,
      'description': 'Latest world news and current events',
    },
    {
      'name': 'technology',
      'icon': Icons.computer,
      'color': AppColors.technology,
      'description': 'Tech innovations and digital trends',
    },
    {
      'name': 'sports',
      'icon': Icons.sports_soccer,
      'color': AppColors.sports,
      'description': 'Sports news and live updates',
    },
    {
      'name': 'entertainment',
      'icon': Icons.movie,
      'color': AppColors.entertainment,
      'description': 'Entertainment and celebrity news',
    },
    {
      'name': 'business',
      'icon': Icons.business,
      'color': AppColors.business,
      'description': 'Business and financial news',
    },
    {
      'name': 'health',
      'icon': Icons.health_and_safety,
      'color': AppColors.health,
      'description': 'Health and medical updates',
    },
    {
      'name': 'science',
      'icon': Icons.science,
      'color': AppColors.science,
      'description': 'Scientific discoveries and research',
    },
  ];

  final List<String> trendingTopics = [
    'Climate Change',
    'AI Technology',
    'Space Exploration',
    'Global Economy',
    'Health & Wellness',
    'Digital Privacy',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: SafeArea(
        child: Column(
          children: [
            // Header Section
            Container(
              padding: EdgeInsets.all(20.sp),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [AppColors.gradientStart, AppColors.gradientEnd],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(30.sp),
                  bottomRight: Radius.circular(30.sp),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          AppText(
                            '${context.tr('welcome')} to',
                            fontSize: 16.sp,
                            color: AppColors.white,
                          ),
                          AppText(
                            AppStrings.appName,
                            fontSize: 24.sp,
                            fontWeight: FontWeight.bold,
                            color: AppColors.white,
                          ),
                        ],
                      ),
                      IconButton(
                        onPressed: () => Get.toNamed(Routes.language),
                        icon: Icon(
                          Icons.language,
                          color: AppColors.white,
                          size: 24.sp,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 20.sp),
                  Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: 16.sp,
                      vertical: 8.sp,
                    ),
                    decoration: BoxDecoration(
                      color: AppColors.white.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(20.sp),
                    ),
                    child: Row(
                      children: [
                        Icon(
                          Icons.trending_up,
                          color: AppColors.white,
                          size: 20.sp,
                        ),
                        SizedBox(width: 8.sp),
                        AppText(
                          context.tr('stay_informed'),
                          fontSize: 14.sp,
                          color: AppColors.white,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            // Content Section
            Expanded(
              child: SingleChildScrollView(
                padding: EdgeInsets.all(20.sp),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Trending Topics Section
                    AppText(
                      context.tr('trending_topics'),
                      fontSize: 20.sp,
                      fontWeight: FontWeight.bold,
                    ),
                    SizedBox(height: 12.sp),
                    SizedBox(
                      height: 40.sp,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: trendingTopics.length,
                        itemBuilder: (context, index) {
                          return Container(
                            margin: EdgeInsets.only(right: 12.sp),
                            padding: EdgeInsets.symmetric(
                              horizontal: 16.sp,
                              vertical: 8.sp,
                            ),
                            decoration: BoxDecoration(
                              color: AppColors.primary.withOpacity(0.1),
                              borderRadius: BorderRadius.circular(20.sp),
                              border: Border.all(
                                color: AppColors.primary.withOpacity(0.3),
                                width: 1,
                              ),
                            ),
                            child: AppText(
                              trendingTopics[index],
                              fontSize: 12.sp,
                              color: AppColors.primary,
                              fontWeight: FontWeight.w500,
                            ),
                          );
                        },
                      ),
                    ),

                    SizedBox(height: 30.sp),

                    // Categories Section
                    AppText(
                      context.tr('news_categories'),
                      fontSize: 20.sp,
                      fontWeight: FontWeight.bold,
                    ),
                    SizedBox(height: 16.sp),

                    GridView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: 16.sp,
                        mainAxisSpacing: 16.sp,
                        childAspectRatio: 1.2,
                      ),
                      itemCount: categories.length,
                      itemBuilder: (context, index) {
                        final category = categories[index];
                        return GestureDetector(
                          onTap:
                              () => Get.toNamed(
                                Routes.category,
                                arguments: category['name'],
                              ),
                          child: Container(
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                colors: [
                                  category['color'].withOpacity(0.8),
                                  category['color'].withOpacity(0.6),
                                ],
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                              ),
                              borderRadius: BorderRadius.circular(20.sp),
                              boxShadow: [
                                BoxShadow(
                                  color: category['color'].withOpacity(0.3),
                                  blurRadius: 8,
                                  offset: const Offset(0, 4),
                                ),
                              ],
                            ),
                            child: Padding(
                              padding: EdgeInsets.all(16.sp),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Icon(
                                    category['icon'],
                                    color: AppColors.white,
                                    size: 32.sp,
                                  ),
                                  SizedBox(height: 12.sp),
                                  AppText(
                                    category['name'].toString().toUpperCase(),
                                    fontSize: 14.sp,
                                    fontWeight: FontWeight.bold,
                                    color: AppColors.white,
                                  ),
                                  SizedBox(height: 4.sp),
                                  AppText(
                                    category['description'],
                                    fontSize: 10.sp,
                                    color: AppColors.white.withOpacity(0.8),
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: (index) {
          setState(() {
            _selectedIndex = index;
          });

          switch (index) {
            case 0:
              // Already on home
              break;
            case 1:
              Get.toNamed(Routes.bookmark);
              break;
            case 2:
              Get.toNamed(Routes.settings);
              break;
          }
        },
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: context.tr('home'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.bookmark),
            label: context.tr('bookmarks'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: context.tr('settings'),
          ),
        ],
      ),
    );
  }
}
