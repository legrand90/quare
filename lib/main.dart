import 'package:flutter/material.dart';
import 'authentification/Screen/login_page.dart';
import 'authentification/Screen/register_page.dart';
import 'authentification/routes/route.dart';
import 'screen/homePage.dart';
import 'Slidesplashscreen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.red,
      ),
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      home: SlideSplashScreen(),
      routes: <String, WidgetBuilder>{
        SLIDE_SPLASH : (BuildContext context)=> new SlideSplashScreen(),
        HOME_SCREEN  : (BuildContext context) => new HomeScreen(),
      },
    );
  }
}