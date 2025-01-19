import 'dart:async';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:chatify/registrationPage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

import 'homescreen.dart';

class SplashPage extends StatefulWidget {  @override

  State<SplashPage> createState() => SplashPageState();
}

class SplashPageState extends State<SplashPage> {
  static const String KEYLOGIN = "login";
  @override
  void initState() {
    super.initState();
    whereToGo();
  }
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.orange.shade200,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Lottie.asset('assets/animation/chat_bubble.json', fit: BoxFit.contain, width: 200,height: 200),
              RichText(
                text: TextSpan(
                  text: "Chat", style: TextStyle(
                    fontSize: 40,
                    fontWeight: FontWeight.w100,
                    fontFamily: 'MyFonts',
                    color: Colors.red.shade300),
                  children: <TextSpan>[
                    TextSpan(text: "Junction",
                      style: TextStyle(
                          fontSize: 50,
                          fontWeight: FontWeight.w100,
                          fontFamily: 'MyFonts',
                          color: Colors.red.shade200),)
                  ]
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void whereToGo() async{
    var sharedPref = await SharedPreferences.getInstance();
    var isLoggedIn = sharedPref.getBool(KEYLOGIN);
    Timer(Duration(seconds: 2), (){
      if(isLoggedIn!=null){
        if(isLoggedIn){
          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => MyHomePage(title: 'Home Page'),));
        }else{
          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => Registrationpage(),));
        }
      }else{
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => Registrationpage(),));
      }
    });
  }
}
