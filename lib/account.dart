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

  String _nativeMessage = '';
  int _incomingCounter = 0;
  int _outcomingCounter = 0;
  int _missingCounter = 0;
  bool _isCounterRunning = false;
  bool _isAnimationRunning = false;

  @override
  void initState() {
    super.initState();
    _listenChannel();
  }

  void _listenChannel() {
    ServicesBinding.instance.defaultBinaryMessenger
        .setMessageHandler(CHANNEL_NAME, (ByteData message) async {
      final int n = message.getInt32(0);

      if (n != (_incomingCounter + 1) && n != 0 && _isCounterRunning) {
        _missingCounter++;
        print('Error! Missed $_missingCounter times');
      }
      _incomingCounter = n;
      setState(() {
        _nativeMessage = "$n";
      });

      return null;
    });
  }

  Future<Null> _sendDataToNative() async {
    do {
      final WriteBuffer buffer = WriteBuffer()..putInt32(_outcomingCounter);
      final ByteData message = buffer.done();

      await ServicesBinding.instance.defaultBinaryMessenger
          .send(CHANNEL_NAME, message);
      _outcomingCounter++;
    } while (_isCounterRunning);
  }

  void _onRunButton() {
    _isCounterRunning = !_isCounterRunning;
    if (_isCounterRunning) {
      _outcomingCounter = _incomingCounter = 0;
    }
    _sendDataToNative();
  }

  void _onAnimationButton() {
    setState(() {
      _isAnimationRunning = !_isAnimationRunning;
    });
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        body: Center(
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 20),
        child: Column(
          children: <Widget>[
            Row(children: <Widget>[
              Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: RaisedButton(
                    child: _isCounterRunning ? Text("Stop") : Text("Run"),
                    onPressed: _onRunButton,
                  )),
              Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: RaisedButton(
                    child: _isAnimationRunning
                        ? Text("Hide animation")
                        : Text("Show animation"),
                    onPressed: _onAnimationButton,
                  )),
            ], mainAxisAlignment: MainAxisAlignment.center),
            Padding(
              child: Center(
                  child: Text(
                _nativeMessage,
                style: TextStyle(fontSize: 15),
              )),
              padding: EdgeInsets.symmetric(vertical: 20),
            ),
            Padding(
              child: Center(
                  child: Text(
                "Missed messages: $_missingCounter",
                style: TextStyle(fontSize: 15, color: Colors.red),
              )),
              padding: EdgeInsets.only(bottom: 20),
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
