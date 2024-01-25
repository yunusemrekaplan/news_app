import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:news_app/controller/news_controller.dart';
import 'package:news_app/models/category.dart';

import '../../models/route.dart';

class TabBarContent extends StatelessWidget {
  TabBarContent({super.key, required this.category});
  static const physics = BouncingScrollPhysics(
    parent: AlwaysScrollableScrollPhysics(),
  );

  final NewsController _newsController = Get.find();
  final Category category;

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
      init: _newsController,
      id: 'news',
      builder: (_) {
        return buildBody();
      },
    );
  }

  FutureBuilder buildBody() {
    return FutureBuilder(
      future: fetchNewsIfEmpty(),
      builder: buildContentBasedOnSnapshot,
    );
  }

  Future<dynamic> fetchNewsIfEmpty() {
    return _newsController.originalNews.isEmpty
        ? _newsController.getNewsByCategory(category.tag)
        : Future.value(true);
  }

  Widget buildContentBasedOnSnapshot(context, snapshot) {
    if (snapshot.hasData) {
      return buildNews();
    } else {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }
  }

  ListView buildNews() {
    return ListView.builder(
      physics: physics,
      itemCount: _newsController.filteredNews.length,
      itemBuilder: (context, index) {
        return Column(
          children: [
            ListTile(
              onTap: () => navigateToNewsDetail(index),
              title: Text(
                _newsController.filteredNews[index].title,
                style: Theme.of(context).textTheme.titleMedium!,
              ),
              subtitle: Container(
                alignment: const AlignmentDirectional(-1, 0),
                height: 50,
                child: Text(
                  'Kaynak: ${_newsController.filteredNews[index].source}',
                  style: Theme.of(context).textTheme.bodyMedium!,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 3,
                ),
              ),
              trailing: Image.network(
                _newsController.filteredNews[index].urlToImage,
                errorBuilder: (context, error, stackTrace) {
                  return const Icon(Icons.error);
                },
                width: 100,
                height: 100,
                fit: BoxFit.cover,
              ),
              tileColor: Theme.of(context).colorScheme.surface,
              dense: false,
            ),
            const Divider(
              height: 2,
              thickness: 2,
            ),
            const SizedBox(
              height: 5,
            ),
          ],
        );
      },
    );
  }

  Future<dynamic>? navigateToNewsDetail(int index) {
    return Get.toNamed(
      RouteType.detail.name,
      arguments: _newsController.filteredNews[index],
    );
  }
}
