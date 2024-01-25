import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../constants/api_constants.dart';

class NewsService {
  static final NewsService _instance = NewsService._internal();

  factory NewsService() {
    return _instance;
  }

  NewsService._internal();

  Future<List> getNewsByCategory(String category) async {
    List<dynamic> news = [];

    try {
      final response = await http.get(
        Uri.parse(baseUrl + category),
        headers: {
          'content-type': contentType,
          'authorization': authorization,
        },
      );

      String responseBody = response.body;

      var decodedJson = jsonDecode(responseBody);

      news = decodedJson['result'];
    } catch (e) {
      debugPrint('Error: $e');
    }

    return news;
  }
}
