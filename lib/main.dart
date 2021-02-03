import 'screens/splash_screen.dart';
import 'package:flutter/material.dart';
import 'screens/chat_screen.dart';
import 'screens/auth_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.pink,
        backgroundColor: Color(0xffCB3D3D),
        accentColor: Color(0xff6c6fd4),
        //used to  tell  flutter that the above color is dark
        // so contrasting values should take position
        accentColorBrightness: Brightness.dark,
        buttonTheme: ButtonTheme.of(context).copyWith(
            buttonColor: Color(0xffCB3D3D),
            textTheme: ButtonTextTheme.primary,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20))),
      ),
      home: StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (ctx, userSnapshot) {
          if (userSnapshot.connectionState == ConnectionState.waiting)
            return SplashScreen();
          if (userSnapshot.hasData) return ChatScreen();
          return AuthScreen();
        },
      ),
    );
  }
}
