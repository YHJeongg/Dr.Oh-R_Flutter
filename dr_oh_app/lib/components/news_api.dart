import 'dart:convert';

import 'package:dr_oh_app/model/news_model.dart';
import 'package:http/http.dart' as http;

class NewsAPI {
  Uri uri = Uri.parse(
      "https://newsapi.org/v2/top-headlines?country=kr&category=health&apiKey=9640fd4c518148688afc7e9c4093e0a5");

  Future<List<NewsModel>> getNews() async {
    List<NewsModel> news = [];

    final response = await http.get(uri);

    if (response.statusCode == 200) {
      news = jsonDecode(response.body)['articles'].map<NewsModel>((article) {
        return NewsModel.fromMap(article);
      }).toList();
    }

    return news;
  }
}
