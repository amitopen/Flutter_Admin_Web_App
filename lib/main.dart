
import 'package:canary_admin/BaseHome.dart';
import 'package:flutter/material.dart';
import 'package:canary_admin/authentication/register.dart';
import 'package:canary_admin/authentication/splash_page.dart';
import 'package:canary_admin/authentication/login_screen.dart';


void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(

        ),
        home: SplashPage(),
        routes: <String, WidgetBuilder>{
          '/home': (BuildContext context) => BaseHome(title: 'Home'),
          '/login': (BuildContext context) => LoginPage(),
          '/register': (BuildContext context) => RegisterPage(),
        });
  }
}