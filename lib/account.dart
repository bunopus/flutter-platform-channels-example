import 'dart:typed_data';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AccountPage extends StatelessWidget {
  static const CHANNEL_NAME = 'wookie.bank/vi';

  Future<Null> _sendDataToNative() async {
    final WriteBuffer buffer = WriteBuffer()
      ..putFloat64(3.1415)
      ..putInt32(12345678);
    final ByteData message = buffer.done();
    await ServicesBinding.instance.defaultBinaryMessenger
        .send(CHANNEL_NAME, message);
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        // appBar: new AppBar(
        //   title: new Text('Wookiee Bank'),
        // ),
        body: Center(
      child: Column(
        children: <Widget>[
          SizedBox(height: 150.0),
          Text(
            'You have 1000 Wookiee Coins!',
            style: TextStyle(fontSize: 20),
          ),
          Padding(
              padding: EdgeInsets.symmetric(vertical: 20),
              child: RaisedButton(
                child: Text("Connect"),
                onPressed: _sendDataToNative,
              )),
          Image(
              image: AssetImage("assets/wookie_head.png"),
              fit: BoxFit.scaleDown,
              width: 200)
        ],
      ),
    ));
  }
}
