import 'dart:convert';
import 'package:news_app/models/slider_model.dart';
import 'package:http/http.dart' as http;

class Sliders {
  List<SliderModel> sliders = [];

  Future<void> getSlider() async {
    String url = 'https://newsapi.org/v2/top-headlines?sources=techcrunch&apiKey=ffe2d5c3f6aa4400a0cb2e38593ff9f6';
    var responce = await http.get(Uri.parse(url));

    var jsonData = jsonDecode(responce.body);

    if(jsonData['status'] == 'ok'){
      jsonData['articles'].forEach((element){
        if(element['urlToImage'] != null && element['description'] != null){
          SliderModel sliderModel= SliderModel(
              title: element['title'],
              description: element['description'],
              url: element['url'],
              urlToImage: element['urlToImage'],
              content: element['content'],
              author: element['author']
          );
          sliders.add(sliderModel);
        }
      });
    }
  }
}