import '../../global_widgets/circular_loading_widget.dart';
import '../../../providers/laravel_provider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/news_controller.dart';
import 'news_list_item_widget.dart';

class NewsListWidget extends GetView<NewsController> {
  @override
  Widget build(BuildContext context) {
    Get.lazyPut(() => NewsController());
    dynamic news = controller.currentStatus.value != 'All'
        ? controller.news
            .where((c) => c['topic'] == controller.currentStatus.value)
            .toList()
        : controller.news;
    print(news.toString());
    return Obx(() {
      if (Get.find<LaravelApiClient>().isLoading(task: 'getFaqs')) {
        return CircularLoadingWidget(height: 300);
      } else {
        return ListView.builder(
          padding: EdgeInsets.symmetric(horizontal: 20),
          primary: false,
          shrinkWrap: true,
          itemCount: news.length,
          itemBuilder: ((_, index) {
            var _status = news.elementAt(index);
            return NewsListItemWidget(
              news: _status,
              index: index,
            );
          }),
        );
      }
    });
  }
}
