import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:newsxo/pages/home_page.dart';
import 'package:newsxo/pages/starting_page.dart';

void main() {
  SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(statusBarColor: Colors.transparent));
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          scaffoldBackgroundColor: Colors.black38,
          primarySwatch: Colors.orange,
        ),
        home: StartingPage());
  }
}
