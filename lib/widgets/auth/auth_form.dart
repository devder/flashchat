import '../pickers/user_image_picker.dart';
import 'package:flutter/material.dart';
import 'dart:io';

class AuthForm extends StatefulWidget {
  final void Function(String email, String username, File image,
      String password, bool isLogin, BuildContext ctx) _submitFn;
  final bool isLoading;
  AuthForm(this._submitFn, this.isLoading);
  @override
  _AuthFormState createState() => _AuthFormState();
}

class _AuthFormState extends State<AuthForm> {
  final _formKey = GlobalKey<FormState>();
  var _isLogin = true;
  String userEmail = '';
  String userName = '';
  String userPassword = '';
  File userImage;

  void _pickImage(File image) {
    userImage = image;
  }

  void _trySubmit() {
    final isValid = _formKey.currentState.validate();
    FocusScope.of(context).unfocus();
    if (userImage == null && !_isLogin) {
      Scaffold.of(context)
          .showSnackBar(SnackBar(content: Text('no image was selected')));
      return;
    }

    if (isValid) {
      _formKey.currentState.save();
      //use those values to send to firebase
      widget._submitFn(userEmail.trim(), userName.trim(), userImage,
          userPassword.trim(), _isLogin, context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment(0.5, 0.5),
          end: Alignment(0.7, 0.7),
          colors: [
            Color(0xffCB3D3D),
            Colors.black54,
          ],
          tileMode: TileMode.mirror,
        ),
      ),
      child: Center(
        child: Card(
          margin: const EdgeInsets.all(10),
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Form(
                key: _formKey,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    if (!_isLogin) UserImagePicker(_pickImage),
                    TextFormField(
                      key: ValueKey('email'),
                      autocorrect: false,
                      textCapitalization: TextCapitalization.none,
                      enableSuggestions: false,
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(labelText: 'Email Address'),
                      validator: (value) {
                        if (value.isEmpty || !value.contains('@')) {
                          return 'Please enter a valid email';
                        }
                        return null;
                      },
                      onSaved: (value) {
                        userEmail = value;
                      },
                    ),
                    if (!_isLogin)
                      TextFormField(
                        key: ValueKey('username'),
                        autocorrect: true,
                        textCapitalization: TextCapitalization.words,
                        enableSuggestions: false,
                        decoration: InputDecoration(labelText: 'Username'),
                        validator: (value) {
                          if (value.isEmpty || value.length < 3) {
                            return 'please enter at least 3 characters';
                          }
                          return null;
                        },
                        onSaved: (value) {
                          userName = value;
                        },
                      ),
                    TextFormField(
                      key: ValueKey('password'),
                      decoration: InputDecoration(labelText: 'Password'),
                      obscureText: true,
                      validator: (value) {
                        if (value.isEmpty || value.length < 7) {
                          return 'Password must be at least 7 characters long';
                        }
                        return null;
                      },
                      onSaved: (value) {
                        userPassword = value;
                      },
                    ),
                    SizedBox(
                      height: 12,
                    ),
                    if (widget.isLoading)
                      CircularProgressIndicator(
                        valueColor:
                            AlwaysStoppedAnimation<Color>(Color(0xffCB3D3D)),
                      ),
                    if (!widget.isLoading)
                      RaisedButton(
                        onPressed: _trySubmit,
                        child: Text(_isLogin ? 'Login' : 'Sign Up'),
                      ),
                    if (!widget.isLoading)
                      FlatButton.icon(
                        onPressed: () {
                          setState(() {
                            _isLogin = !_isLogin;
                          });
                        },
                        icon: Icon(Icons.create_outlined),
                        label: Text(_isLogin
                            ? 'Create new account'
                            : 'I already have an account'),
                        textColor: Color(0xffCB3D3D),
                      )
                  ],
                )),
          ),
        ),
      ),
    );
  }
}
