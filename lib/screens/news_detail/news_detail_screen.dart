import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../models/news.dart';

class NewsDetailScreen extends StatelessWidget {
  NewsDetailScreen({super.key});

  final News news = Get.arguments;

  @override
  Widget build(BuildContext context) {
    return buildScaffold(context);
  }

  Scaffold buildScaffold(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(news.source),
      ),
      body: buildBody(context),
    );
  }

  Column buildBody(BuildContext context) {
    return Column(
      children: [
        buildTitle(context),
        buildImage(context),
        buildDescription(context),
        buildContinueReading(context),
      ],
    );
  }

  Padding buildTitle(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Text(
        news.title,
        style: Theme.of(context).textTheme.titleLarge!,
      ),
    );
  }

  Padding buildImage(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Image.network(
        news.urlToImage,
        errorBuilder: (context, error, stackTrace) {
          return const Icon(Icons.error);
        },
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height * 0.3,
        fit: BoxFit.cover,
      ),
    );
  }

  Padding buildDescription(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 20.0, top: 20.0, right: 20.0),
      child: Text(
        news.description,
        style: Theme.of(context).textTheme.bodyMedium!,
      ),
    );
  }

  Padding buildContinueReading(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 20.0, right: 20.0, bottom: 20.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          TextButton(
            onPressed: launchNewsUrl,
            child: Text(
              'Continue Reading',
              style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                    color: Theme.of(context).colorScheme.primary,
                  ),
            ),
          ),
        ],
      ),
    );
  }

  void launchNewsUrl() async {
    Uri uri = Uri.parse(news.url);
    await launchUrl(uri);
  }
}
