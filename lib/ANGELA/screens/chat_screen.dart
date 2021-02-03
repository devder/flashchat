import 'package:flutter/material.dart';
import '../constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

final FirebaseFirestore _firestore = FirebaseFirestore.instance;
User loggedInUser;

//check the rules on firebase console
class ChatScreen extends StatefulWidget {
  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final messageTextController = TextEditingController();
  final _auth = FirebaseAuth.instance;
  String messageText;

  @override
  void initState() {
    super.initState();
    getCurrentUser();
  }

  void getCurrentUser() {
    try {
      final user = _auth.currentUser;
      if (user != null) {
        loggedInUser = user;
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: null,
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.logout),
            onPressed: () {
              //Implement logout functionality
              _auth.signOut();
              Navigator.pop(context);
            },
          ),
        ],
        title: Text('⚡️Chat'),
        backgroundColor: Colors.lightBlueAccent,
      ),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            MessagesStream(),
            Container(
              decoration: kMessageContainerDecoration,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Expanded(
                    child: TextField(
                      controller: messageTextController,
                      onChanged: (value) {
                        messageText = value;
                      },
                      decoration: kMessageTextFieldDecoration,
                    ),
                  ),
                  FlatButton(
                    onPressed: () {
                      messageTextController.clear();
                      _firestore.collection('messages').add({
                        'sender': loggedInUser.email,
                        'text': messageText,
                        'time': DateTime.now()
                      });
                    },
                    child: Text(
                      'Send',
                      style: kSendButtonTextStyle,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class MessagesStream extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
        stream: _firestore.collection('messages').orderBy('time').snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            return Text('Something went wrong');
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(
                backgroundColor: Colors.blueAccent,
              ),
            );
          }

          return Expanded(
            child: ListView(
                reverse: true,
                padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 0.0),
                children:
                    snapshot.data.docs.reversed.map((DocumentSnapshot msg) {
                  final msgSender = msg.data()['sender'];
                  final currentUser = loggedInUser.email;
                  //a listTitle can be returned
                  return MessageBubble(
                    text: '${msg.data()['text']}',
                    sender: msgSender,
                    isMe: currentUser == msgSender,
                  );
                }).toList()),
          );
        });
  }
}

class MessageBubble extends StatelessWidget {
  MessageBubble({@required this.text, @required this.sender, this.isMe});
  final String sender;
  final String text;
  final bool isMe;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(10.0),
      child: Column(
        crossAxisAlignment:
            isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
        children: [
          Material(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(30.0),
                bottomLeft: isMe ? Radius.circular(30.0) : Radius.circular(0),
                topRight: Radius.circular(30.0),
                bottomRight: isMe ? Radius.circular(0) : Radius.circular(30.0)),
            elevation: 5.0,
            color: isMe ? Colors.blueAccent : Colors.blueGrey,
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
              child: Text(
                text,
                style: TextStyle(fontSize: 18.0, color: Colors.white),
              ),
            ),
          ),
          Text(
            sender,
            style: TextStyle(color: Colors.black54, fontSize: 12.0),
          ),
        ],
      ),
    );
  }
}
