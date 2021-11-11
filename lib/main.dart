import 'package:flutter/material.dart';
import "package:eyubank/theme.dart";
import 'package:eyubank/Screens/homepage.dart';

void main(){
  runApp(MyApp());
}

class MyApp extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return MaterialApp(
      title: "Banking Demo",
      theme: lightThemeData(context),
      darkTheme: darkThemeData(context),
      themeMode: ThemeMode.light,
      home: HomePage(),
    );
  }
}