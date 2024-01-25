import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:news_app/screens/home_page/home_page_screen.dart';
import 'package:news_app/screens/news_detail/news_detail_screen.dart';

import 'models/route.dart';
import 'themes/custom_dark_theme.dart';
import 'themes/custom_light_theme.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(const NewsApp());
}

class NewsApp extends StatelessWidget {
  const NewsApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      themeMode: ThemeMode.dark,
      theme: CustomLightTheme().themeData,
      darkTheme: CustomDarkTheme().themeData,
      initialRoute: RouteType.home.name,
      getPages: [
        GetPage(
          name: RouteType.home.name,
          page: () => HomePageScreen(),
        ),
        GetPage(
          name: RouteType.detail.name,
          page: () => NewsDetailScreen(),
        ),
      ],
    );
  }
}
