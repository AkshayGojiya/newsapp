import 'dart:convert';

import '../models/article_model.dart';
import 'package:http/http.dart' as http;

class News {
  List<ArticleModel> news = [];

  Future<void> getNews() async {
    String url = 'https://newsapi.org/v2/everything?q=tesla&from=2024-05-18&sortBy=publishedAt&apiKey=ffe2d5c3f6aa4400a0cb2e38593ff9f6';
    var responce = await http.get(Uri.parse(url));

    var jsonData = jsonDecode(responce.body);

    if(jsonData['status'] == 'ok'){
      jsonData['articles'].forEach((element){
        if(element['urlToImage'] != null && element['description'] != null){
          ArticleModel articleModel= ArticleModel(
            title: element['title'],
            description: element['description'],
            url: element['url'],
            urlToImage: element['urlToImage'],
            content: element['content'],
            author: element['author']
          );
          news.add(articleModel);
        }
      });
    }
  }
}