import 'package:flutter/material.dart';

class AccountPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        appBar: new AppBar(
          title: new Text('Wookiee Bank'),
        ),
        body: Center(
          child: Column(
            children: <Widget>[
              SizedBox(height: 150.0),
              Text(
                'You have 1000 Wookiee Coins!',
                style: TextStyle(fontSize: 20),
              ),
              SizedBox(height: 20.0),
              Image(
                  image: AssetImage("assets/wookie_head.png"),
                  fit: BoxFit.scaleDown,
                  width: 200)
            ],
          ),
        ));
  }
}
