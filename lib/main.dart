import 'package:flutter/material.dart';
import 'login_page.dart';
import 'home_page.dart';
import 'barbar_code.dart';
import 'sekinfo.dart';

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  final routes = <String, WidgetBuilder>{
    LoginPage.tag: (context) => LoginPage(),
    HomePage.tag: (context) => HomePage(),
    Barcode.tag: (context) => Barcode(),
    SekInfo.tag: (context) => SekInfo(),
  };
  
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Ctrl. Login',
      debugShowCheckedModeBanner: false,
      theme: new ThemeData(
        primarySwatch: Colors.deepPurple,
        fontFamily: 'Productsans',
      ),
      home: LoginPage(),
      routes: routes,
    );
  }
}
