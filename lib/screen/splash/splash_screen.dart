import 'package:flutter/material.dart';
import 'package:idaman/screen/splash/components/body.dart';
import 'package:idaman/size_config.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key}) : super(key: key);
  static String routeName = "/splash";
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      body: Container(
        // decoration: BoxDecoration(
        //   image: DecorationImage(
        //     image: AssetImage("assets/images/bg_splash.png"),
        //     fit: BoxFit.cover,
        //   ),
        // ),
          child: Body()
      ),
    );
  }
}
