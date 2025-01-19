import 'package:chatify/splashPage.dart';
import 'package:flutter/material.dart';
class LockScreen extends StatefulWidget {
  @override
  _LockScreenState createState() => _LockScreenState();
}
class _LockScreenState extends State<LockScreen> {
  TextEditingController _pinController = TextEditingController();
  final String _correctPin = '1234';
  void _navigateToHomeScreen() {
    Navigator.pushReplacement( context, MaterialPageRoute(builder: (context) => SplashPage()), );
  }
  @override Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(title: Text('Lock Screen')),
      body: Container(
        color: Colors.orangeAccent.shade100,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircleAvatar(
                radius: 31,
                child: Icon(Icons.lock, size: 35,),
              ),
              SizedBox(height: 20),
              Text('Chat Junction Locked', style: TextStyle(fontSize: 25,fontWeight: FontWeight.bold),),
              SizedBox(height: 10),
              Text('Enter PIN to unlock',style: TextStyle(fontSize: 16)),
              SizedBox(height: 20),
              TextField(
                controller: _pinController,
                obscureText: true,
                keyboardType: TextInputType.numberWithOptions(),
                decoration: InputDecoration( labelText: 'Enter PIN',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(21),
                  ),
                ),
              ),
              SizedBox(height: 20),
              ElevatedButton( onPressed: _unlock,
                child: Text('Unlock',style: TextStyle(fontSize: 17,fontWeight: FontWeight.bold,color: Colors.black),),
              ),
            ],
          ),
        ),
      ),
    );
  }
  void _unlock() {
    if (_pinController.text == _correctPin)
    { _navigateToHomeScreen();
    } else {
      ScaffoldMessenger.of(context).showSnackBar( SnackBar(content: Text('Incorrect PIN')),
      );
    }
  }
}