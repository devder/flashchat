import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

final FirebaseFirestore _firestore = FirebaseFirestore.instance;

class NewMessage extends StatefulWidget {
  @override
  _NewMessageState createState() => _NewMessageState();
}

class _NewMessageState extends State<NewMessage> {
  final TextEditingController _textEditingController = TextEditingController();
  var _enteredMessage = '';
  final _auth = FirebaseAuth.instance;

  void _sendMessage() async {
    FocusScope.of(context).unfocus();
    final userData =
        await _firestore.collection('users').doc(_auth.currentUser.uid).get();
    _firestore.collection('chats/DrUb0vDcE4Ho79z5dI26/messages').add({
      'text': _textEditingController.text,
      'createdAt': Timestamp.now(),
      'userId': _auth.currentUser.uid,
      'username': userData['username'],
      'userImage': userData['image_url']
    });
    _textEditingController.clear();
    _enteredMessage = '';
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          margin: const EdgeInsets.only(top: 8),
          padding: const EdgeInsets.all(8),
          child: Row(
            children: [
              Expanded(
                  child: TextField(
                textCapitalization: TextCapitalization.sentences,
                autocorrect: true,
                enableSuggestions: true,
                controller: _textEditingController,
                decoration: InputDecoration(labelText: 'Enter your message...'),
                onChanged: (value) {
                  setState(() {
                    _enteredMessage = value;
                  });
                },
              )),
              IconButton(
                icon: Icon(Icons.send),
                onPressed: _enteredMessage.trim().isEmpty ? null : _sendMessage,
                color: Theme.of(context).primaryColor,
              )
            ],
          ),
        ),
      ],
    );
  }
}
