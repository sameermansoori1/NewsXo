import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class ArticleView extends StatefulWidget {
  String blogUrl;
  ArticleView({required this.blogUrl});

  @override
  State<ArticleView> createState() => _ArticleViewState();
}

class _ArticleViewState extends State<ArticleView> {
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
        appBar: AppBar(backgroundColor: Colors.black38,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("News",style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
              Text(
                "Xo",
                style: TextStyle(color: Colors.orange, fontWeight: FontWeight.bold),
              )
            ],
          ),
          centerTitle: true,
          elevation: 0.0,
          leading: IconButton(
            icon: Icon(
                Icons.adaptive.arrow_back,
                color: Colors.white
            ),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ),
        body: Container(
          child: WebView(
            initialUrl:widget.blogUrl ,
            javascriptMode: JavascriptMode.unrestricted,
          ),
        ));;
  }
}
