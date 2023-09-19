import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:ml_emotion/view/screen_splash.dart';

List<CameraDescription>? cameras;
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  cameras = await availableCameras();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      darkTheme: ThemeData.dark(),
      title: "Emotion",
      home: const ScreenSplash(),
    );
  }
}
