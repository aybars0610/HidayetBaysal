// import 'dart:html';
// import 'package:universal_html/html.dart' as html;

import 'package:flutter/material.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:ilk_projem/Data/Kira.dart';

import 'package:ilk_projem/screens/Filtreleme.dart';
import 'package:ilk_projem/screens/aramalar_screen.dart';
import 'package:ilk_projem/screens/bildirimAyarlari.dart';
import 'package:ilk_projem/screens/contact.dart';
import 'package:ilk_projem/screens/customer_screen.dart';
import 'package:ilk_projem/screens/favorilerim_screen.dart';
import 'package:ilk_projem/screens/kiraGetirilerim.dart';
import 'package:ilk_projem/screens/kiraliklar.dart';
import 'package:ilk_projem/screens/main_menu.dart';
import 'package:ilk_projem/screens/phoneChange.dart';

import 'package:ilk_projem/screens/product_screen.dart';
import 'package:ilk_projem/screens/profilim_screen.dart';
import 'package:ilk_projem/screens/proje_screen.dart';
import 'package:ilk_projem/screens/projeler_screen.dart';
import 'package:ilk_projem/screens/satilik_screen.dart';
import 'package:ilk_projem/screens/satiliklar.dart';
import 'package:ilk_projem/screens/sifreDegis.dart';
import 'package:ilk_projem/screens/sifremiUnuttum_screen.dart';
import 'package:ilk_projem/screens/speech_screen.dart';
import 'package:ilk_projem/screens/uyeOl.dart';
import 'package:splashscreen/splashscreen.dart';
// import 'package:device_simulator/device_simulator.dart';

import 'screens/home.dart';

const bool debugEnableDeviceSimulator = true;
void main() {
  runApp(
    Phoenix(
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // SizeConfig().init(context);

    const MaterialColor hbRed = const MaterialColor(
      0xFFa90600,
      const <int, Color>{
        50: const Color(0xFFa90600),
        100: const Color(0xFFa90600),
        200: const Color(0xFFa90600),
        300: const Color(0xFFa90600),
        400: const Color(0xFFa90600),
        500: const Color(0xFFa90600),
        600: const Color(0xFFa90600),
        700: const Color(0xFFa90600),
        800: const Color(0xFFa90600),
        900: const Color(0xFFa90600),
      },
    );
    //Color c = const Color(0xFFa90600);
    return MaterialApp(
      title: "Hidayet Baysal Emlak",

      theme: ThemeData(
        primarySwatch: hbRed,
      ),

      home:
          // SplashScreen(
          //   seconds: 5,
          //   backgroundColor: Colors.blue,
          //   photoSize: 150,
          //   image: Image.asset('assets/logo/hbgif.gif'),
          //   loaderColor: Colors.white,
          //   navigateAfterSeconds: Home(),
          //   // until: () => Future.delayed(Duration(seconds: 5)),
          //   // startAnimation: '1',
          // ),
          // DeviceSimulator(
          //   brightness: Brightness.dark,
          //   enable: debugEnableDeviceSimulator,
          //   child:
          Home(),

      // ),
      routes: <String, WidgetBuilder>{
        CustomerScreen.routeName: (BuildContext context) =>
            new CustomerScreen(),
        // CustomerScreen.routeName: (BuildContext context) => Text('Üye Girişi'),
        ProductScreen.routeName: (BuildContext context) => new ProductScreen(),
        ContactScreen.routeName: (BuildContext context) => new ContactScreen(),
        MainMenu.routeName: (BuildContext context) => new MainMenu(),
        UyeOlScreen.routeName: (BuildContext context) => new UyeOlScreen(),
        // Home.routeName: (BuildContext context) => new Home(),

        SatilikScreen.routeName: (BuildContext context) => new SatilikScreen(),
        KiralikScreen.routeName: (BuildContext context) => new KiralikScreen(),
        SpokeScreen.routeName: (BuildContext context) => new SpokeScreen(),
        PhoneChangeScreen.routeName: (BuildContext context) =>
            new PhoneChangeScreen(),
        SifreDegisScreen.routeName: (BuildContext context) =>
            new SifreDegisScreen(),
        AramalarScreen.routeName: (BuildContext context) =>
            new AramalarScreen(),
        FavorilerimScreen.routeName: (BuildContext context) =>
            new FavorilerimScreen(),
        ProfilimScreen.routeName: (BuildContext context) =>
            new ProfilimScreen(),
        BildirimAyarlariScreen.routeName: (BuildContext context) =>
            new BildirimAyarlariScreen(),
        SifremiUnuttumScreen.routeName: (BuildContext context) =>
            new SifremiUnuttumScreen(),
        FiltrelemeScreen.routeName: (BuildContext context) =>
            new FiltrelemeScreen(),
        ProjelerScreen.routeName: (BuildContext context) =>
            new ProjelerScreen(),
        ProjeScreen.routeName: (BuildContext context) => new ProjeScreen(),
        KiraGetirilerimScreen.routeName: (BuildContext context) =>
            new KiraGetirilerimScreen(),
        SatiliklarScreen.routeName: (BuildContext context) =>
            new SatiliklarScreen(),
      },
    );
  }
}
