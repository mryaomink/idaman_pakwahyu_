import 'package:flutter/material.dart';
import 'package:idaman/components/coustom_bottom_nav_bar.dart';
import 'package:idaman/main.dart';
import 'package:idaman/screen/prelogin/components/body.dart';

import '../../enums.dart';
import '../../size_config.dart';

class PreloginScreen extends StatelessWidget {
  const PreloginScreen({Key? key}) : super(key: key);
  static String routeName = "/prelogin";
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    // print("akunnya " + MyApp.localStorage.getString("nik").toString());
    return Scaffold(
        body: Body(),
      //bottomNavigationBar: CustomBottomNavBar(selectedMenu: MenuState.home),
    );
  }
}
