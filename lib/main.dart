import 'package:flutter/material.dart';
import 'package:wookie_bank/account.dart';
import 'package:wookie_bank/login.dart';

void main() {
  runApp(new MyApp());
}
class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Wookiee Bank',
      theme: new ThemeData(
        primarySwatch: Colors.amber,
        primaryColor: Colors.amber,
        canvasColor: Colors.white,
      ),
      home: new MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key}) : super(key: key);
  @override
  _MyHomePageState createState() => new _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
    @override
    Widget build(BuildContext context) {
      return new Scaffold(
        appBar: new AppBar(
          title: new Text('Wookiee Bank'),
          ),
        body: LoginPage()
       ) ;
    }
}
