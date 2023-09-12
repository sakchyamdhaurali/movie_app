import 'package:flutter/material.dart';
import 'package:movie_app/Design/HomePage.dart';

void main() {
  runApp(const MovieApp());
}

class MovieApp extends StatelessWidget {
const MovieApp({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context){
    return MaterialApp(
debugShowCheckedModeBanner: false,
        home: HomePage(),
    );
  }
}