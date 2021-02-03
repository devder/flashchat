import 'package:flutter/services.dart';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import '../widgets/auth/auth_form.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

final FirebaseFirestore _firestore = FirebaseFirestore.instance;

// FirebaseStorage storage = FirebaseStorage.instance;
// Reference ref = FirebaseStorage.instance.ref('/notes.txt');

class AuthScreen extends StatefulWidget {
  @override
  _AuthScreenState createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  var isLoading = false;

  Future<void> _submitAuthForm(String email, String username, File image,
      String password, bool isLogin, BuildContext context) async {
    UserCredential userCredential;
    try {
      setState(() {
        isLoading = true;
      });
      if (isLogin) {
        userCredential = await _auth.signInWithEmailAndPassword(
            email: email, password: password);
      } else {
        userCredential = await _auth.createUserWithEmailAndPassword(
            email: email, password: password);

        final ref = FirebaseStorage.instance
            .ref()
            .child("user_image")
            .child(_auth.currentUser.uid + '.jpg');

        await ref.putFile(image);

        final imageUrl = await ref.getDownloadURL();

        //create a user with the id gotten back
        await _firestore.collection('users').doc(userCredential.user.uid).set({
          'username': username,
          'email': userCredential.user.email,
          'image_url': imageUrl
        });
      }
    } on PlatformException catch (e) {
      var message = 'an error occured, please check your credentials';

      if (e.message != null) {
        message = e.message;
      }
      Scaffold.of(context).showSnackBar(SnackBar(
        content: Text(message),
        backgroundColor: Theme.of(context).errorColor,
      ));
      setState(() {
        isLoading = false;
      });
    } catch (e) {
      Scaffold.of(context).showSnackBar(SnackBar(
        content: Text(e.message),
        backgroundColor: Theme.of(context).errorColor,
      ));
      setState(() {
        isLoading = false;
      });
      print(e);
      setState(() {
        isLoading = false;
      });
      throw e;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AuthForm(_submitAuthForm, isLoading),
    );
  }
}
