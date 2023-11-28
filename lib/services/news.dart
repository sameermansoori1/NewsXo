import 'dart:convert';

import 'package:newsxo/models/article_model.dart';
import 'package:http/http.dart' as http;


class News{
  List<ArticleModel>news= [];

  Future<void> getNews()async{
    String url="https://newsapi.org/v2/everything?q=tesla&from=2023-10-28&sortBy=publishedAt&apiKey=b1e2093c90324961b1d5ab92c12e253b";
        var response = await http.get(Uri.parse(url));


    var jsonData= jsonDecode(response.body);

    if(jsonData['status']=='ok'){
      jsonData["articles"].forEach((element){
        if(element["urlToImage"]!=null && element['description']!=null){
          ArticleModel articleModel= ArticleModel(
            title: element["title"],
            description: element["description"],
            url: element["url"],
            urlToImage: element["urlToImage"],
            content: element["content"],
            author: element["author"],
          );
          news.add(articleModel);
        }
      });
    }
  }
}