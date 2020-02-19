import 'dart:typed_data';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'animated_rectangle.dart';

class AccountPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _AccountPageState();
  }
}

class _AccountPageState extends State<AccountPage> {
  static const CHANNEL_NAME = 'wookie.bank/vi';

  bool _isAnimationRunning = false;
  Stopwatch stopwatch = new Stopwatch();
  Duration _packageDeliveryTime;

  @override
  void initState() {
    super.initState();
    _listenChannel();
  }

  void _listenChannel() {
    ServicesBinding.instance.defaultBinaryMessenger
        .setMessageHandler(CHANNEL_NAME, (ByteData message) async {

      stopwatch.stop();
      print(message.getInt32(0));

      setState(() {
        _packageDeliveryTime = stopwatch.elapsed;
        stopwatch.reset();
      });

      return null;
    });
  }

  Future<Null> _sendDataToNative() async {
    final WriteBuffer buffer = WriteBuffer();

    for (var i = 0; i < 1; i++) {
      buffer.putInt32(i);
    }
    final ByteData message = buffer.done();

    stopwatch.start();

    await ServicesBinding.instance.defaultBinaryMessenger
        .send(CHANNEL_NAME, message);
  }

  void _onRunButton() {
    _sendDataToNative();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        body: Center(
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 20),
        child: Column(
          children: <Widget>[
            Padding(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: RaisedButton(
                  child: Text("Send package"),
                  onPressed: _onRunButton,
                )),
            Padding(
              child: Center(
                  child: Text(
                "Time to deliver package: ${_packageDeliveryTime?.inMilliseconds}",
                style: TextStyle(fontSize: 15),
              )),
              padding: EdgeInsets.symmetric(vertical: 20),
            ),
            if (_isAnimationRunning)
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Center(
                  child: AnimatedRectangle(),
                ),
              )
          ],
        ),
      ),
    ));
  }
}
