// import 'dart:html';
// import 'dart:io';

// import 'dart:io';

import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:flutter_restart/flutter_restart.dart';
import 'package:ilk_projem/main.dart';
import 'package:ilk_projem/screens/bildirimAyarlari.dart';

import 'package:ilk_projem/screens/contact.dart';
import 'package:ilk_projem/screens/customer_screen.dart';
import 'package:ilk_projem/screens/favorilerim_screen.dart';
import 'package:ilk_projem/screens/home.dart';
import 'package:ilk_projem/screens/kiraGetirilerim.dart';
import 'package:ilk_projem/screens/kiraliklar.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import 'package:ilk_projem/screens/profilim_screen.dart';
import 'package:ilk_projem/screens/proje_screen.dart';
import 'package:ilk_projem/screens/projeler_screen.dart';
import 'package:ilk_projem/screens/satilik_screen.dart';
import 'package:ilk_projem/screens/satiliklar.dart';
import 'package:url_launcher/url_launcher.dart';
//import 'package:ilk_projem/screens/product_screen.dart';

import 'anasayfa_arayuz.dart';

final storage = FlutterSecureStorage();

class MainMenu extends StatefulWidget {
  static const String routeName = "/menu";
  @override
  State<StatefulWidget> createState() => new MainMenuState();
}

class Routes {
  static const String contacts = ContactScreen.routeName;
  static const String customer = CustomerScreen.routeName;
  static const String satilik = SatilikScreen.routeName;
  static const String kiralik = KiralikScreen.routeName;
  static const String projeler = ProjelerScreen.routeName;
  static const String satiliklar = SatiliklarScreen.routeName;
  static const String home = Home.routeName;
  static const String bildirimAyarlari = BildirimAyarlariScreen.routeName;
  static const String menu = MainMenu.routeName;

  // static const String notes = NotesPage.routeName;
}

void _restartApp() async {
  FlutterRestart.restartApp();
}

class MainMenuState extends State {
  // int _currentIndex = 0;
  @override
  Widget build(BuildContext context) {
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
    //final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;
    return Scaffold(
      appBar: AppBar(
          flexibleSpace: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Image.asset(
                'assets/logo/hblogopng.png',
                fit: BoxFit.cover,
                width: 40,
                height: 40,
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 38),
              ),
            ],
          ),
          elevation: 30.0,
          brightness: Brightness.light,

          // AppBar(
          //     flexibleSpace: Row(
          //       mainAxisAlignment: MainAxisAlignment.center,
          //       crossAxisAlignment: CrossAxisAlignment.end,
          //       children: [
          //         Image.asset(
          //           'assets/logo/hblogopng.png',
          //           fit: BoxFit.cover,
          //           width: 40,
          //           height: 40,
          //         ),
          //         Padding(
          //           padding: EdgeInsets.symmetric(vertical: 35),
          //         ),
          //       ],
          //     ),
          //     elevation: 30.0,
          //     brightness: Brightness.light,
          actions: [
            // Icon(Icons.account_circle),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: IconButton(
                icon: Icon(Icons.notifications),
                //color: Colors.white,
                onPressed: () {
                  //Navigator.pushNamed(context, CustomerScreen.routeName);
                },
              ),

              // onTap: () {
              //   Navigator.of(context)
              //       .pushNamedAndRemoveUntil(routess[0], (route) => false);
              // },
            ),
          ]
          // actions: [
          //   Icon(Icons.account_circle),
          //   Padding(
          //     padding: EdgeInsets.symmetric(horizontal: 16),
          //   ),
          //]
          ),
      body: Container(
        child: Center(
          child: AnasayfaScreen(),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        // fixedColor: hbRed,
        currentIndex: seciliSayfa,
        onTap: sayfaDegistir,
        backgroundColor: hbRed,
        selectedItemColor: Colors.white,
        //unselectedItemColor: colorScheme.onSurface.withOpacity(.60),
        unselectedItemColor: Colors.white,
        selectedLabelStyle: textTheme.caption,
        unselectedLabelStyle: textTheme.caption,

        items: [
          BottomNavigationBarItem(
            label: 'İletişim',
            icon: Icon(Icons.phone),
          ),
          BottomNavigationBarItem(
            label: 'Canlı Destek',
            icon: Icon(Icons.message),
          ),
          BottomNavigationBarItem(
            label: 'Konum',
            icon: Icon(Icons.location_on),
          ),
          BottomNavigationBarItem(
            label: 'Profilim',
            icon: Icon(Icons.account_circle),
          ),
        ],
      ),
      drawer: buildDrawer(context),
    );
  }

  buildDrawer(BuildContext context) {
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
    return new Drawer(
      // child: createMenuItems(context),
      child: ListView(
        children: <Widget>[
          DrawerHeader(
            child: Align(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Image.asset(
                    'assets/logo/hblogopng.png',
                    fit: BoxFit.cover,
                    width: 50,
                    height: 50,
                  ),
                  Text(" "),
                  Text(
                    "Hidayet Baysal Emlak",
                    style: TextStyle(color: Colors.white, fontSize: 25.0),
                  ),
                ],
              ),
            ),
            decoration: BoxDecoration(
              color: hbRed,
            ),
          ),
          ListTile(
            leading: Icon(Icons.home),
            title: Text('Anasayfa'),
            // trailing: Icon(Icons.arrow_right),
            onTap: () {
              Navigator.pushNamed(context, MainMenu.routeName);
            },
          ),
          Divider(),
          ListTile(
            leading: Image.asset(
              'assets/a/building.png',
              fit: BoxFit.cover,
              width: 20,
              height: 20,
            ),
            title: Text('Projeler'),
            // trailing: Icon(Icons.arrow_right),
            onTap: () {
              ProjelerScreen.ilanTuru = 3;
              ProjelerScreen.ilanTipi = 0;
              ProjelerScreen.siteAdi = "";
              ProjelerScreen.ilanTurAdi = "Projeler";
              Navigator.pushNamed(context, ProjeScreen.routeName);
            },
          ),
          Divider(),
          ListTile(
            leading: Image.asset(
              'assets/a/house.png',
              fit: BoxFit.cover,
              width: 20,
              height: 20,
            ),
            title: Text('Satılıklar'),
            // trailing: Icon(Icons.arrow_right),
            onTap: () {
              Navigator.pushNamed(context, SatilikScreen.routeName);
            },
          ),
          Divider(),
          ListTile(
            leading: Image.asset(
              'assets/a/house.png',
              fit: BoxFit.cover,
              width: 20,
              height: 20,
            ),
            title: Text('Kiralıklar'),
            // trailing: Icon(Icons.arrow_right),
            onTap: () {
              Navigator.pushNamed(context, KiralikScreen.routeName);
            },
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.error),
            title: Text('Acil vitrin'),
            // trailing: Icon(Icons.arrow_right),
            onTap: () {
              ProjelerScreen.ilanTuru = 4;
              ProjelerScreen.ilanTipi = 0;
              ProjelerScreen.siteAdi = "";
              ProjelerScreen.ilanTurAdi = "Acil";
              Navigator.pushNamed(context, ProjelerScreen.routeName);
            },
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.favorite),
            title: Text('Favorilerim'),
            // trailing: Icon(Icons.arrow_right),
            onTap: () {
              Navigator.pushNamed(context, FavorilerimScreen.routeName);
            },
          ),
          Divider(),
          ListTile(
            leading: Image.asset(
              'assets/a/turkish.png',
              fit: BoxFit.cover,
              width: 20,
              height: 20,
            ),
            title: Text('Kira Getirilerim'),
            // trailing: Icon(Icons.arrow_right),
            onTap: () {
              Navigator.pushNamed(context, KiraGetirilerimScreen.routeName);
            },
          ),
          // if()
          //      ListTile(
          //   leading: Icon(Icons.favorite),
          //   title: Text('Kira Getirilerim'),
          //   // trailing: Icon(Icons.arrow_right),
          //   onTap: () {
          //     Navigator.pushNamed(context, FavorilerimScreen.routeName);
          //   },
          // ),
          Divider(),
          // ListTile(
          //   leading: Icon(Icons.notifications),
          //   title: Text('Bildirim ayarları'),
          //   // trailing: Icon(Icons.arrow_right),
          //   onTap: () {
          //     Navigator.pushNamed(context, BildirimAyarlariScreen.routeName);
          //   },
          // ),
          // Divider(),
          ListTile(
            leading: Icon(Icons.star),
            title: Text('Bizi değerlendirin'),
            // trailing: Icon(Icons.arrow_right),
            onTap: () {
              Platform.isAndroid
                  ? launch(
                      'https://play.google.com/store/apps/details?id=com.hidayet_baysal_insaat')
                  : Text("Platform hatalı!");
              //  _urlAc(Platform.isAndroid ? "" : "");
            },
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.exit_to_app),
            title: Text('Çıkış Yap'),
            // trailing: Icon(Icons.arrow_right),
            onTap: () {
              storage.delete(key: "jwt");

              // Navigator.pushNamedAndRemoveUntil(
              //     context, '/uyegirisi', (_) => false);

              Phoenix.rebirth(context);
            },
          ),
          Divider(),
        ],
      ),
    );
  }

  int seciliSayfa = 0;
  void sayfaDegistir(int index) {
    setState(() {
      seciliSayfa = index;
    });
    if (seciliSayfa == 0) {
      // CallPhone();
      // final String phone = 'tel:05543802228';

      // _callPhone() async {
      //   if (await canLaunch(phone)) {
      //     await launch(phone);
      //   } else {
      //     throw 'Could not Call Phone';
      //   }
      // }

      launch('tel://03322612333');
    } else if (seciliSayfa == 1) {
      launch('https://api.whatsapp.com/send?phone=903322612333');
      // launch('whatsapp://wa.me/905543802228');
    } else if (seciliSayfa == 2) {
      launch('https://maps.app.goo.gl/68HDbFV6LpP5eU367');
    } else if (seciliSayfa == 3) {
      // final routes = [ProfilimScreen.routeName];

      Navigator.pushNamed(context, ProfilimScreen.routeName);
    }
  }
}

// Future _urlAc(String link) async {
//   if (await canLaunch(link)) {
//     await launch(link);
//   } else {
//     debugPrint('gönderdiğiniz linki açamıyorum');
//   }
// }
