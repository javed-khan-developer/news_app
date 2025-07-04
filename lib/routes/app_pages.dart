import 'package:get/get.dart';
import '../modules/home/home_view.dart';
import '../modules/category/category_view.dart';
import '../modules/article/article_view.dart';

part 'app_routes.dart';

class AppPages {
  static final transition = Transition.leftToRight;
  static final routes = [
    GetPage(name: '/', page: () => HomeView(), transition: transition),
    GetPage(name: Routes.category, page: () => CategoryView()),
    GetPage(name: Routes.article, page: () => ArticleView()),
  ];
}
