// import 'package:flutter/material.dart';
// import 'package:animated_text_kit/animated_text_kit.dart';
//
// class WelcomeScreen extends StatefulWidget {
//   static const String id = 'welcome_screen';
//   //put here for the routing so mistakes aren't made
//   @override
//   _WelcomeScreenState createState() => _WelcomeScreenState();
// }
//
// class _WelcomeScreenState extends State<WelcomeScreen>
//     with SingleTickerProviderStateMixin {
//   AnimationController controller;
//   Animation animation1;
//   Animation animation2;
//
//   @override
//   void initState() {
//     super.initState();
//     controller = AnimationController(
//         duration: Duration(seconds: 1), vsync: this, upperBound: 1);
//
//     //when we add the animation object beneath, the max upperbound should be 1
//     animation1 =
//         CurvedAnimation(parent: controller, curve: Curves.easeInOutExpo);
//     animation2 = ColorTween(begin: Colors.blueGrey, end: Colors.white)
//         .animate(controller);
//
//     controller.forward();
//
//     // animation.addStatusListener((status) {
//     //   if (status == AnimationStatus.completed) {
//     //     controller.reverse(from: 1.0);
//     //   } else if (status == AnimationStatus.dismissed) {
//     //     controller.forward();
//     //   }
//     // });
//     controller.addListener(() {
//       setState(() {});
//     });
//   }
//
//   //to free memory
//   @override
//   void dispose() {
//     controller.dispose();
//     super.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       // backgroundColor: Colors.red.withOpacity(controller.value),
//       backgroundColor: animation2.value,
//       body: Padding(
//         padding: EdgeInsets.symmetric(horizontal: 24.0),
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           crossAxisAlignment: CrossAxisAlignment.stretch,
//           children: <Widget>[
//             Row(
//               children: <Widget>[
//                 Hero(
//                   tag: 'logo',
//                   child: Container(
//                     child: Image.asset('images/logo.png'),
//                     // height: 60.0,
//                     height: animation1.value * 50,
//                   ),
//                 ),
//                 // Text(
//                 //   'Flash Chat',
//                 //   // '${controller.value.toInt()}%',
//                 //   style: TextStyle(
//                 //     fontSize: 45.0,
//                 //     fontWeight: FontWeight.w900,
//                 //   ),
//                 // ),
//                 TypewriterAnimatedTextKit(
//                   speed: Duration(milliseconds: 100),
//                   text: ['Flash Chat'],
//                   // '${controller.value.toInt()}%',
//                   textStyle: TextStyle(
//                       fontSize: 45.0,
//                       fontWeight: FontWeight.w900,
//                       color: Colors.black),
//                 ),
//               ],
//             ),
//             SizedBox(
//               height: 48.0,
//             ),
//             Padding(
//               padding: EdgeInsets.symmetric(vertical: 16.0),
//               child: Material(
//                 elevation: 5.0,
//                 color: Colors.lightBlueAccent,
//                 borderRadius: BorderRadius.circular(30.0),
//                 child: MaterialButton(
//                   onPressed: () {
//                     Navigator.pushNamed(context, '/login');
//                   },
//                   minWidth: 200.0,
//                   height: 42.0,
//                   child: Text(
//                     'Log In',
//                   ),
//                 ),
//               ),
//             ),
//             Padding(
//               padding: EdgeInsets.symmetric(vertical: 16.0),
//               child: Material(
//                 color: Colors.blueAccent,
//                 borderRadius: BorderRadius.circular(30.0),
//                 elevation: 5.0,
//                 child: MaterialButton(
//                   onPressed: () {
//                     Navigator.pushNamed(context, '/register');
//                   },
//                   minWidth: 200.0,
//                   height: 42.0,
//                   child: Text(
//                     'Register',
//                   ),
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
