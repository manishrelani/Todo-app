import 'dart:async';
import 'package:flutter/material.dart';
import 'package:todo/LocalData/ShareManager.dart';
import 'package:todo/Screen/EventListScreen.dart';
import 'package:todo/Screen/LoginScreen.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(Duration(seconds: 1), () {
      isUserLoggedin(context);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text("TODO",
              style: TextStyle(
                fontSize: 35,
              ))
        ],
      )),
    );
  }

  // Functions
   
  void isUserLoggedin(BuildContext context) async {
    var isLogin = await ShareManager.getLogin();
    if (isLogin) {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (ctx) => EventListScreen()));
    } else {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (ctx) => LoginScreen()),
      );
    }
  }
}
