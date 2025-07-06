import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:news_app/widgets/app_bar.dart';
import 'package:news_app/widgets/app_button.dart';
import 'package:news_app/widgets/app_text.dart';
import '../../data/model/news_model.dart';
import 'package:url_launcher/url_launcher.dart';

class ArticleView extends StatelessWidget {
  const ArticleView({super.key});

  @override
  Widget build(BuildContext context) {
    final Article article = Get.arguments;

    return Scaffold(
      appBar: buildAppBar(title:article.title,showHome: true),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: ListView(
          children: [
            if (article.urlToImage.isNotEmpty)
              Image.network(article.urlToImage),
            const SizedBox(height: 16),
            Text(
              article.title,
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Text(article.content),
            const SizedBox(height: 20),
            AppButton(
              onPressed:
                  () => launchUrl(
                    Uri.parse(article.url),
                    mode: LaunchMode.inAppBrowserView,
                  ),
              label: "Read Full Article",
            ),
          ],
        ),
      ),
    );
  }
}
