import 'package:flutter/material.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import '../components/rounded_button.dart';

//check welcomescreen.dart for code

class WelcomeScreen extends StatefulWidget {
  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen>
    with SingleTickerProviderStateMixin {
  AnimationController controller;
  Animation animation1;
  Animation animation2;

  @override
  void initState() {
    super.initState();
    controller = AnimationController(
        duration: Duration(seconds: 1), vsync: this, upperBound: 1);

    //when we add the animation object beneath, the max upperbound should be 1
    animation1 =
        CurvedAnimation(parent: controller, curve: Curves.easeInOutExpo);
    animation2 = ColorTween(begin: Colors.blueGrey, end: Colors.white)
        .animate(controller);

    controller.forward();
    controller.addListener(() {
      setState(() {});
    });
  }

  //to free memory
  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Colors.red.withOpacity(controller.value),
      backgroundColor: animation2.value,
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Row(
              children: <Widget>[
                Hero(
                  tag: 'logo',
                  child: Container(
                    child: Image.asset('images/logo.png'),
                    // height: 60.0,
                    height: animation1.value * 50,
                  ),
                ),
                TypewriterAnimatedTextKit(
                  speed: Duration(milliseconds: 100),
                  text: ['Flash Chat'],
                  // '${controller.value.toInt()}%',
                  textStyle: TextStyle(
                      fontSize: 45.0,
                      fontWeight: FontWeight.w900,
                      color: Colors.black),
                ),
              ],
            ),
            SizedBox(
              height: 48.0,
            ),
            RoundedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/login');
              },
              title: 'Log In',
              color: Colors.lightBlueAccent,
            ),
            RoundedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/register');
              },
              title: 'Register',
              color: Colors.blueAccent,
            ),
          ],
        ),
      ),
    );
  }
}
