import 'dart:convert';

import 'package:dr_oh_app/model/news.dart';
import 'package:http/http.dart' as http;

class NewsProvider {
  Uri uri = Uri.parse(
      "https://newsapi.org/v2/top-headlines?country=kr&category=health&apiKey=9640fd4c518148688afc7e9c4093e0a5");

  Future<List<News>> getNews() async {
    List<News> news = [];

    final response = await http.get(uri);

    if (response.statusCode == 200) {
      news = jsonDecode(response.body)['articles'].map<News>((article) {
        return News.fromMap(article);
      }).toList();
    }

    return news;
  }
}
