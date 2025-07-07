import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:news_app/widgets/app_bar.dart';

import '../../controller/bookmark_controller.dart';
import '../../widgets/app_text.dart';
import '../category/category_view.dart';


class BookmarkView extends StatelessWidget {
  final BookmarkController controller = Get.put(BookmarkController());

   BookmarkView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(title: "Bookmarks",showHome: true,showBookmarked: false,),
      body: Obx(() {
        if (controller.bookmarks.isEmpty) {
          return  Center(child: AppText("No bookmarks yet.",fontSize: 20.sp,));
        }
        return ListView.builder(
          itemCount: controller.bookmarks.length,
          itemBuilder: (context, index) {
            return NewsTile(article: controller.bookmarks[index]);
          },
        );
      }),
    );
  }
}
