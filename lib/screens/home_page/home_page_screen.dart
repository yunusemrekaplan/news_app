import 'package:dynamic_tabbar/dynamic_tabbar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:news_app/models/category.dart';

import '../../controller/news_controller.dart';
import 'tab_bar_content.dart';

class HomePageScreen extends StatelessWidget {
  HomePageScreen({super.key});

  final NewsController _newsController = Get.put(NewsController());

  final List<TabData> dynamicTabs = [
    _buildTab(Category.general),
    _buildTab(Category.sport),
    _buildTab(Category.economy),
    _buildTab(Category.technology),
  ];

  static TabData _buildTab(Category category) {
    return TabData(
      index: category.index,
      title: Tab(
        child: Text(category.name),
      ),
      content: TabBarContent(category: category),
    );
  }

  @override
  Widget build(BuildContext context) {
    return buildScaffold(context);
  }

  Scaffold buildScaffold(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          buildSearchBox(context),
          buildTabBar(),
        ],
      ),
    );
  }

  Padding buildSearchBox(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
      child: Container(
        width: double.infinity,
        height: 40,
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.primaryContainer,
          borderRadius: BorderRadius.circular(18),
        ),
        child: Padding(
          padding: const EdgeInsetsDirectional.fromSTEB(15, 0, 15, 0),
          child: Row(
            children: [
              Icon(
                Icons.search,
                color: Theme.of(context).colorScheme.onSecondaryContainer,
                size: 24,
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsetsDirectional.fromSTEB(7, 0, 0, 2),
                  child: TextField(
                    controller: _newsController.searchController,
                    onSubmitted: (value) {
                      _newsController.searchNews(value);
                    },
                    decoration: InputDecoration(
                      hintText: 'Search',
                      hintStyle:
                          Theme.of(context).textTheme.bodyMedium!.copyWith(
                                color: Theme.of(context)
                                    .colorScheme
                                    .onSecondaryContainer,
                              ),
                    ),
                    style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                          color: Theme.of(context)
                              .colorScheme
                              .onSecondaryContainer,
                        ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Expanded buildTabBar() {
    return Expanded(
      child: DynamicTabBarWidget(
        dynamicTabs: dynamicTabs,
        onTabChanged: (index) {
          _newsController.searchController.clear();
          _newsController.originalNews.clear();
          _newsController.filteredNews.clear();
          debugPrint("onTabChanged tab index: $index");
        },
        onTabControllerUpdated: (controller) {
          //debugPrint("onTabControllerUpdated");
        },
      ),
    );
  }
}
