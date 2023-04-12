import 'package:flutter/widgets.dart';
import 'package:idaman/screen/Chat/chat_screen.dart';
import 'package:idaman/screen/Homecare/homecare_screen.dart';
import 'package:idaman/screen/Messages/messages_screen.dart';
import 'package:idaman/screen/Notifikasi/notifikasi_screen.dart';
import 'package:idaman/screen/account/account_screen.dart';
import 'package:idaman/screen/browser/browser_screen.dart';
import 'package:idaman/screen/cart/cart_screen.dart';
import 'package:idaman/screen/complete_profile/complete_profile_screen.dart';
import 'package:idaman/screen/details/details_screen.dart';
import 'package:idaman/screen/forgot_password/forgot_password_screen.dart';
import 'package:idaman/screen/home/home_screen.dart';
import 'package:idaman/screen/kurir/home/home_screen.dart';
import 'package:idaman/screen/kurir/tracker/webviewfs.dart';
import 'package:idaman/screen/kurir/tracker/webviewfs2.dart';
import 'package:idaman/screen/login/login_screen.dart';
import 'package:idaman/screen/mendaftar/scan/scan_screen.dart';
import 'package:idaman/screen/osm/osm_screen.dart';
import 'package:idaman/screen/otp/otp_screen.dart';
import 'package:idaman/screen/penjual/bantuan/bantuan_screen.dart';
import 'package:idaman/screen/penjual/bantuan/details/bantuan_detail_screen.dart';
import 'package:idaman/screen/penjual/home/home_screen.dart';
import 'package:idaman/screen/penjual/pelatihan/details/pelatihan_detail_screen.dart';
import 'package:idaman/screen/penjual/pelatihan/pelatihan_screen.dart';
import 'package:idaman/screen/penjual/produk/produk_screen.dart';
import 'package:idaman/screen/penjual/home/components/aspirasi_form.dart';
import 'package:idaman/screen/penjual/usaha/components/edit_usaha_lanjutan_form.dart';
import 'package:idaman/screen/penjual/usaha/picker/picker_screen.dart';
import 'package:idaman/screen/penjual/usaha/usaha_screen.dart';
import 'package:idaman/screen/photo/photo_view.dart';
import 'package:idaman/screen/prelogin/leaflet/webviewmap.dart';
import 'package:idaman/screen/prelogin/prelogin_screen.dart';
import 'package:idaman/screen/profile/components/edit_data_form.dart';
import 'package:idaman/screen/profile/edit_screen.dart';
import 'package:idaman/screen/profile/profile_screen.dart';
import 'package:idaman/screen/sign_in/sign_in_screen.dart';
import 'package:idaman/screen/splash/splash_screen.dart';


// We use name route
// All our routes will be available here
final Map<String, WidgetBuilder> routes = {
  SplashScreen.routeName: (context) => const SplashScreen(),
  SignInScreen.routeName: (context) => const SignInScreen(),
  LoginScreen.routeName: (context) => const LoginScreen(),
  ForgotPasswordScreen.routeName: (context) => const ForgotPasswordScreen(),
  CompleteProfileScreen.routeName: (context) => CompleteProfileScreen(),
   OtpScreen.routeName: (context) => const OtpScreen(),
   HomeScreen.routeName: (context) => HomeScreen(),
  DetailsScreen.routeName: (context) => DetailsScreen(),
  CartScreen.routeName: (context) => CartScreen(),
  ProfileScreen.routeName: (context) => ProfileScreen(),
  ChatScreen.routeName: (context) => ChatScreen(),
  MessageScreen.routeName: (context) => MessageScreen(),
  BrowserScreen.routeName: (context) => BrowserScreen(),
  AccountScreen.routeName: (context) => AccountScreen(),
  KurirHomeScreen.routeName: (context) => KurirHomeScreen(),
  WebViewerFS.routeName: (context) => WebViewerFS(),
  PenjualHomeScreen.routeName:(context) => PenjualHomeScreen(),
  UsahaScreen.routeName:(context) => UsahaScreen(),
  PickerScreen.routeName:(context) => PickerScreen(),
  PreloginScreen.routeName:(context) => PreloginScreen(),
  PhotoViewScreen.routeName:(context) => PhotoViewScreen(),
  WebViewMap.routeName:(context) => WebViewMap(),
  ProdukScreen.routeName:(context) => ProdukScreen(),
  EditScreen.routeName:(context) => EditScreen(),
  PelatihanScreen.routeName:(context) => PelatihanScreen(),
  BantuanScreen.routeName:(context) => BantuanScreen(),
  PelatihanDetailScreen.routeName:(context) => PelatihanDetailScreen(),
  BantuanDetailScreen.routeName:(context) => BantuanDetailScreen(),
  ScanScreen.routeName:(context) => ScanScreen(),
  EditUsahaLanjutan.routeName:(context) => EditUsahaLanjutan(),
  AspirasiScreen.routeName:(context) => AspirasiScreen(),
  NotifikasiScreen.routeName:(context) => NotifikasiScreen(),
  OsmScreen.routeName:(context) => OsmScreen(),
  HomecareScreen.routeName:(context) => HomecareScreen(),
};
