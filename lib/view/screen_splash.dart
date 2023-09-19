import 'package:flutter/material.dart';
import 'package:ml_emotion/view/screen_home.dart';

class ScreenSplash extends StatefulWidget {
  const ScreenSplash({super.key});

  @override
  State<ScreenSplash> createState() => _ScreenSplashState();
}

class _ScreenSplashState extends State<ScreenSplash> {
  @override
  void initState() {
    gotoScreenHome(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: const Color.fromARGB(255, 0, 0, 0),
        height: double.infinity,
        width: double.infinity,
        child: Image.network(
          'https://i.seadn.io/gae/p9jPZKQ04Vm86g9p4nzJKgi9Ap2T7s07quXvV2W4IDf7S0ckTH8l2-FuH_43it1YhPeCvK_di70XSlsVTul5LsIOuuHrPykhgZKE?auto=format&dpr=1&w=1000',
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}

Future gotoScreenHome(context) async {
  await Future.delayed(const Duration(
    seconds: 10,
  ));
  return Navigator.of(context).pushReplacement(MaterialPageRoute(
    builder: (context) => const ScreenHome(),
  ));
}
