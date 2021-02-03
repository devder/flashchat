import '../widgets/chat/new_message.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../widgets/chat/messages.dart';
import 'package:flutter/services.dart';

class ChatScreen extends StatefulWidget {
  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  int _batteryLevel;

  Future<void> _getBatteryLevel() async {
    // the name in the method call can be anything
    const platform = MethodChannel('chats.flutter/dev/battery');
    try {
      final batteryLevel = await platform.invokeMethod('getBatteryLevel');
      setState(() {
        _batteryLevel = batteryLevel;
      });
    } on PlatformException catch (e) {
      setState(() {
        _batteryLevel = null;
      });
      throw e;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Chat'),
        actions: [
          DropdownButton(
            underline: Container(),
            items: [
              DropdownMenuItem(
                value: 'logout',
                child: Row(
                  children: [
                    Icon(Icons.logout),
                    SizedBox(
                      width: 8,
                    ),
                    Text('Logout')
                  ],
                ),
              )
            ],
            onChanged: (itemIdentifier) {
              if (itemIdentifier == 'logout') {
                FirebaseAuth.instance.signOut();
              }
            },
            icon: Icon(
              Icons.expand_more,
              color: Theme.of(context).primaryIconTheme.color,
            ),
          )
        ],
      ),
      body: SafeArea(
        child: Column(
          children: [
            Text('Battery = $_batteryLevel  '),
            Expanded(child: Messages()),
            NewMessage()
          ],
        ),
      ),
    );
  }
}
