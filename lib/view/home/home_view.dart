import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:news_app/core/constants/app_strings.dart';
import 'package:news_app/widgets/app_bar.dart';
import 'package:news_app/widgets/app_text.dart';
import '../../routes/app_pages.dart';

class HomeView extends StatelessWidget {
  final categories = ['general', 'technology', 'sports', 'entertainment'];

  HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(
        title: AppStrings.welcome,
        fontSize: 20.sp,
        centreTitle: true,
      ),
      body: ListView.builder(
        itemCount: categories.length,
        itemBuilder: (context, index) {
          return Card(
            margin: const EdgeInsets.all(12),
            child: ListTile(
              title: AppText(categories[index].toUpperCase()),
              trailing: const Icon(Icons.arrow_forward_ios),
              onTap:
                  () => Get.toNamed(
                    Routes.category,
                    arguments: categories[index],
                  ),
            ),
          );
        },
      ),
    );
  }
}
