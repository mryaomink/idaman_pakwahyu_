import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:idaman/screen/penjual/usaha/picker/picker_screen.dart';

class ProfilePicNew extends StatelessWidget {
  final Image photo;
  final Function() take;
  const ProfilePicNew({
    Key? key,
    required this.photo,
    required this.take
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 215,
      child: Stack(
        fit: StackFit.expand,
        clipBehavior: Clip.none,
        children: [
          photo,
          Positioned(
            right: 16,
            bottom: 10,
            child: SizedBox(
              height: 46,
              width: 46,
              child: TextButton(
                style: TextButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(50),
                    side: BorderSide(color: Colors.white),
                  ),
                  primary: Colors.white,
                  backgroundColor: Color(0xFFF5F6F9),
                ),
                onPressed: take
                ,
                child: SvgPicture.asset("assets/icons/Camera Icon.svg"),
              ),
            ),
          )
        ],
      ),
    );
  }
}
