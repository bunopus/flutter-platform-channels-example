import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AccountPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _AccountPageState();
  }
}

class _AccountPageState extends State<AccountPage> {
  static const CHANNEL_NAME = 'wookie.bank/vi';
  int balance = 1000;

  static const channel = const MethodChannel(CHANNEL_NAME);

  Future<Null> _vibrate() async {
    try {
      final String result = await channel.invokeMethod('vibrateDevice');
      print(result);
    } on PlatformException catch (e) {
      print("ERROR: ${e.message}");
    }
  }

  @override
  void initState() {
    super.initState();
    if (balance >= 1000) {
      _vibrate();
    }
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        body: Center(
          child: Column(
            children: <Widget>[
              Padding(
                child: Text(
                  'You have $balance Wookiee Coins!',
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
