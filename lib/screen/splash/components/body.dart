import 'dart:io';

import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/material.dart';
import 'package:idaman/api/api_service.dart';
import 'package:idaman/components/default_button.dart';
import 'package:idaman/helper/location_service.dart';
import 'package:idaman/models/login_model.dart';
import 'package:idaman/screen/home/home_screen.dart';
import 'package:idaman/screen/login/login_screen.dart';
import 'package:idaman/screen/prelogin/prelogin_screen.dart';
import 'package:idaman/screen/splash/components/splash_content.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../../constants.dart';
import '../../../helper/notification_controller.dart';
import '../../../main.dart';
import '../splash_screen.dart';

class Body extends StatefulWidget {
  const Body({Key? key}) : super(key: key);

  @override
  _BodyState createState() => _BodyState();
}


class _BodyState extends State<Body> {


  late LoginRequestModel loginRequestModel;
  int currentPage = 0;
  List<Map<String, String>> splashData = [
    {
      "headText" : "",
      "text" : "Selamat Datang di Aplikasi Idaman",
      "image" : "assets/images/logo_juarasa.png"
    },
    {
      "headText" : "Idaman",
      "text" : "Adalah Aplikasi Integrasi Dalam Genggaman",
      "image" : "assets/images/splash_2.png"
    },
    {
      "headText" : "Idaman",
      "text" : "Berselancar di Idaman dengan mudah. \nDari mana saja",
      "image" : "assets/images/splash_3.png"
    },
    {
      "headText" : "Idaman",
      "text" : "Ayo sukseskan program RT Mandiri, Banjarbaru Juara !",
      "image" : "assets/images/splash_2.png"
    }
  ];

  @override
  void initState(){
    super.initState();
    AwesomeNotifications().isNotificationAllowed().then(
          (isAllowed) {
        if (!isAllowed) {
          showDialog(
            context: context,
            builder: (context) => AlertDialog(
              title: Text('Ijinkan Notifikasi'),
              content: Text('Apakah anda ingin aplikasi ini memberikan notifikasi ? '),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text(
                    'Don\'t Allow',
                    style: TextStyle(color: Colors.grey, fontSize: 18),
                  ),
                ),
                TextButton(
                  onPressed: () => AwesomeNotifications()
                      .requestPermissionToSendNotifications()
                      .then((_) => Navigator.pop(context)),
                  child: Text(
                    'Allow',
                    style: TextStyle(
                      color: Colors.teal,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          );
        }
      },
    );

    // AwesomeNotifications().createdStream.listen((notification) {
    //   ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    //     content: Text(
    //       'Notifikasi aktif ${notification.channelKey}',
    //     ),
    //   ));
    // });
    //
    // AwesomeNotifications().actionStream.listen((notification) {
    //   if (notification.channelKey == 'basic_channel' && Platform.isIOS) {
    //     AwesomeNotifications().getGlobalBadgeCounter().then(
    //           (value) =>
    //           AwesomeNotifications().setGlobalBadgeCounter(value - 1),
    //     );
    //   }
    //
    //   Navigator.pushAndRemoveUntil(
    //     context,
    //     MaterialPageRoute(
    //       builder: (_) => PreloginScreen(),
    //     ),
    //         (route) => route.isFirst,
    //   );
    // });
  }

  @override
  void dispose() {
    // AwesomeNotifications().actionSink.close();
    // AwesomeNotifications().createdSink.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SizedBox(
        width: double.infinity,
        child: Column(
          children: [
            Expanded(
              flex: 3,
                child: PageView.builder(
                  onPageChanged: (value){
                    setState(() {
                      currentPage = value;
                    });
                  },
                  itemCount: splashData.length,
                    itemBuilder: (context,index) => SplashContent(
                        headText : splashData[index]["headText"].toString(),
                        image : splashData[index]["image"].toString(),
                        text : splashData[index]["text"].toString()
                    )
                )
            ),
            Expanded(
              flex: 2,
                child: Column(
                  children: [
                    const Spacer(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: List.generate(
                          splashData.length,
                              (index) => buildDot(index: index)
                      ),
                    ),
                    const Spacer(flex: 3),
                    DefaultButton(
                        text: "Mulai",
                        press: () async{
                          //NotificationController.createChatProdukNotification("23", "produk chat tes", "ada yamng testing produk chat tuh");
                          print(await Permission.location.status);
                          if (await Permission.location.isPermanentlyDenied) {
                            showDialog(
                              context: context,
                              builder: (context) => AlertDialog(
                                title: Text('Fitur Lokasi'),
                                content: Text('Tabe membutuhkan akses lokasi untuk akurasi data pencarian dan akurasi input data.'),
                                actions: [
                                  TextButton(
                                    onPressed: () {
                                      Navigator.pop(context);
                                      Navigator.pushNamedAndRemoveUntil(context, PreloginScreen.routeName, (
                                          route) => true);
                                    },
                                    child: Text(
                                      'Tidak',
                                      style: TextStyle(color: Colors.grey, fontSize: 18),
                                    ),
                                  ),
                                  TextButton(
                                    onPressed: () => openAppSettings()
                                        .then((_) => Navigator.pop(context)),
                                    child: Text(
                                      'Buka setting',
                                      style: TextStyle(
                                        color: Colors.teal,
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            );
                          }else {
                            Navigator.pushNamedAndRemoveUntil(context, PreloginScreen.routeName, (
                                route) => true);
                          }
                        },
                      warna: Colors.orange,
                    ),
                    const Spacer(),
                  ],
                )
            ),
          ],
        ),
      ),
    );
  }

  AnimatedContainer buildDot({required int index}) {
    return AnimatedContainer(
      duration: kAnimationDuration,
      margin: const EdgeInsets.only(right: 5),
      height: 6,
      width: currentPage == index ? 20 : 6,
      decoration: BoxDecoration(
        color: currentPage == index ? kPrimaryColor : kPrimaryLightColor,
        borderRadius: BorderRadius.circular(3)
      ),
    );
  }

  loadData() async {
    String nik = MyApp.localStorage.get("nik").toString();
    print("nik : " + nik + " id :" + MyApp.localStorage.get("id").toString());
    if (nik != "null") {
      if (nik.length == 16) {
        loginRequestModel = new LoginRequestModel(nik: nik,password: MyApp.localStorage.get("pass").toString(),appId:appId,appToken: appToken,modeAkses: "login");
        alreadyLogin();
      }
    }
  }

  alreadyLogin(){
    APIService apiService = new APIService();
    apiService.login(loginRequestModel).then((value) {
      if (value.apiStatus == 1) {

        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(
              builder: (context){
                return HomeScreen();
              }
          ),
              (route) => false,
        );
      } else {
        final snackBar = SnackBar(
            content: Text(value.apiMessage)
        );
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      }
    });
  }
}


