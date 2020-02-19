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

  String _nativeMessage = '';
  static const channel =
      BasicMessageChannel<String>(CHANNEL_NAME, StringCodec());

  @override
  void initState() {
    super.initState();
  }

  Future<String> _sendDataToNative() async {
    return channel.send("Hello!");
  }

  void _onRunButton() async {
    _nativeMessage = await _sendDataToNative();
    setState(() {});
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
                  child: Text("Send string"),
                  onPressed: _onRunButton,
                )),
            Padding(
              child: Center(
                  child: Text(
                _nativeMessage,
                style: TextStyle(fontSize: 15),
              )),
              padding: EdgeInsets.symmetric(vertical: 20),
            ),
          ],
        ),
      ),
    ));
  }
}
