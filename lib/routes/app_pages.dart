import 'package:get/get.dart';

import '../view/article/article_view.dart';
import '../view/bookmark/bookmark_view.dart';
import '../view/category/category_view.dart';
import '../view/home/home_view.dart';

part 'app_routes.dart';

class AppPages {
  static final transition = Transition.leftToRight;
  static final routes = [
    GetPage(name: Routes.home, page: () => HomeView(), transition: transition),
    GetPage(name: Routes.category, page: () => CategoryView(),transition: transition),
    GetPage(name: Routes.article, page: () => ArticleView(),transition: transition),
    GetPage(name: Routes.bookmark, page: () => BookmarkView(),transition: transition),
  ];
}
