import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'message_bubble.dart';
import 'package:firebase_auth/firebase_auth.dart';

final FirebaseFirestore _firestore = FirebaseFirestore.instance;
final _auth = FirebaseAuth.instance;

class Messages extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: _firestore
            .collection('chats/DrUb0vDcE4Ho79z5dI26/messages')
            .orderBy('createdAt', descending: true)
            .snapshots(),
        builder:
            (BuildContext context, AsyncSnapshot<QuerySnapshot> chatsSnapshot) {
          if (chatsSnapshot.hasError) {
            return Text('Something went wrong');
          }
          if (chatsSnapshot.connectionState == ConnectionState.waiting)
            return Center(
              child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(
                    Theme.of(context).accentColor),
              ),
            );
          final docs = chatsSnapshot.data.docs;
          return ListView.builder(
            reverse: true,
            itemCount: docs.length,
            itemBuilder: (ctx, i) => MessageBubble(
              docs[i]['text'],
              docs[i]['username'],
              docs[i]['userImage'],
              docs[i]['userId'] == _auth.currentUser.uid,
              key: ValueKey(docs[i].id),
            ),
          );
        });
  }
}

// StreamBuilder(
// stream: _firestore
//     .collection('chats/zM3xt1W7nQnKv7OtLRbu/messages')
// .snapshots(),
// builder: (BuildContext context,
//     AsyncSnapshot<QuerySnapshot> streamSnapshot) {
// if (streamSnapshot.hasError) {
// return Text('Something went wrong');
// }
// if (streamSnapshot.connectionState == ConnectionState.waiting) {
// return Center(
// child: CircularProgressIndicator(
// backgroundColor: Colors.blueAccent,
// ),
// );
// }
// final docs = streamSnapshot.data.docs;
// return ListView.builder(
// itemCount: docs.length,
// itemBuilder: (ctx, i) => Container(
// padding: const EdgeInsets.all(8),
// child: Text(docs[i]['text']),
// ));
// },
// ),
