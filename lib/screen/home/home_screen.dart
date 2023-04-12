
import 'package:flutter/material.dart';
import 'package:idaman/components/coustom_bottom_nav_bar.dart';

import '../../enums.dart';
import 'components/body.dart';


class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  static String routeName = "/home";
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: Body(),
      bottomNavigationBar: CustomBottomNavBar(selectedMenu: MenuState.home),
    );
  }


}


