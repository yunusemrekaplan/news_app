import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:news_app/services/news_service.dart';

import '../models/news.dart';

class NewsController extends GetxController {
  final NewsService newsService = NewsService();
  final TextEditingController searchController = TextEditingController();
  RxList<News> originalNews = <News>[].obs;
  RxList<News> filteredNews = <News>[].obs;

  Future<bool> getNewsByCategory(String category) async {
    final maps = await newsService.getNewsByCategory(category);
    if (maps.isEmpty) {
      Get.snackbar(
        'Hata',
        'Haberler getirilirken bir hata oluştu.',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Get.theme.colorScheme.error,
        colorText: Get.theme.colorScheme.onError,
      );
      return false;
    }
    print('getNewsByCategory');
    originalNews = maps.map((e) => News.fromJson(e)).toList().obs;
    filteredNews = originalNews;
    return true;
  }

  void searchNews(String query) {
    final news = originalNews.where((element) {
      return element.title.toLowerCase().contains(query.toLowerCase());
    }).toList();
    print('searchNewsLength: ${news.length}');

    filteredNews = news.obs;
    update(['news']);
  }
}
