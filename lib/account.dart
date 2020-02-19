import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:wookie_bank/login.dart';

class AccountPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _AccountPageState();
  }
}

class _AccountPageState extends State<AccountPage> {
  static const CHANNEL_NAME = 'wookie.bank/vi';

  static const channel = EventChannel(CHANNEL_NAME);
  StreamSubscription subscription;

  @override
  void initState() {
    subscription = channel
        .receiveBroadcastStream()
        .where((value) => value > 10)
        .listen((_) {
      Navigator.pop(context);
      subscription.cancel();
    }, onError: (dynamic error) {
      print('Received error: ${error.message}');
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        appBar: new AppBar(
          title: new Text('Wookiee Bank'),
        ),
        body: Center(
          child: Column(
            children: <Widget>[
              Padding(
                child: Text(
                  'You have 1000 Wookiee Coins!',
                  style: TextStyle(fontSize: 20),
                ),
                padding: EdgeInsets.only(top: 170, bottom: 25),
              ),
              Image(
                  image: AssetImage("assets/wookie_head.png"),
                  fit: BoxFit.scaleDown,
                  width: 200)
            ],
          ),
        ));
  }
}
