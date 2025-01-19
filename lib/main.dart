import 'package:camera/camera.dart';
import 'package:chatify/lockscreen.dart';
import 'package:chatify/remote/authentication_service.dart';
import 'package:flutter/material.dart';

late List<CameraDescription> _cameras;
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  _cameras = await availableCameras();
  Authentication authentication =  Authentication();
  authentication.getToken().then((token) => {
     authentication.setTokenToSP(token)
  });
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: LockScreen(),
    );
  }


}

