
import 'package:flutter/material.dart';
import 'package:idaman/helper/location_service.dart';
import 'package:idaman/screen/kurir/home/components/coustom_bottom_nav_bar.dart';

import '../../../enums.dart';
import 'components/body.dart';


class KurirHomeScreen extends StatelessWidget {
  const KurirHomeScreen({Key? key}) : super(key: key);

  static String routeName = "/kurirHome";
  @override
  Widget build(BuildContext context) {
    LocationService ls = new LocationService();


    return Scaffold(
      body: Body(),
      bottomNavigationBar: CustomBottomNavBar(selectedMenu: MenuState.home),
    );

  }

}


