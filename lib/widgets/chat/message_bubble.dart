import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class MessageBubble extends StatelessWidget {
  final String _message;
  final String _username;
  final String _userImage;
  final bool _isMe;
  final Key key;
  MessageBubble(this._message, this._username, this._userImage, this._isMe,
      {this.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Row(
          mainAxisAlignment:
              _isMe ? MainAxisAlignment.end : MainAxisAlignment.start,
          children: [
            Container(
              margin: const EdgeInsets.symmetric(vertical: 16, horizontal: 8),
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
              width: 250,
              decoration: BoxDecoration(
                color: _isMe ? Colors.grey : Theme.of(context).accentColor,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(12),
                  topRight: Radius.circular(12),
                  bottomLeft: !_isMe ? Radius.circular(0) : Radius.circular(12),
                  bottomRight: _isMe ? Radius.circular(0) : Radius.circular(12),
                ),
              ),
              child: Column(
                crossAxisAlignment:
                    _isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
                children: [
                  Text(
                    _username,
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: _isMe ? Colors.black : Colors.white),
                  ),
                  Text(
                    _message,
                    style: TextStyle(
                        fontSize: 18,
                        color: _isMe ? Colors.black : Colors.white),
                  ),
                ],
              ),
            ),
          ],
        ),
        Positioned(
            top: -8,
            right: _isMe ? 230 : null,
            left: !_isMe ? 230 : null,
            child: CircleAvatar(
              backgroundImage: NetworkImage(_userImage),
            )),
      ],
      overflow: Overflow.visible,
    );
  }
}
