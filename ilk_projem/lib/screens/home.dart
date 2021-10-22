import 'dart:convert';
import 'dart:ffi';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ilk_projem/Data/User.dart';
//import 'package:ilk_projem/screens/CallPhone.dart';

import 'package:ilk_projem/screens/contact.dart';
import 'package:ilk_projem/screens/customer_screen.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

//import 'package:ilk_projem/screens/product_screen.dart';

import 'anasayfa_arayuz.dart';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import 'main_menu.dart';
import 'profilim_screen.dart';

final storage = FlutterSecureStorage();
String jwtValue = "";

Future<String> jwt() async {
  return await storage.read(key: "jwt");
}
//import 'package:url_launcher/url_launcher.dart';

class Home extends StatefulWidget {
  static const String routeName = "/home";
  @override
  State<StatefulWidget> createState() => new HomeState();
}

class Routes {
  static const String contacts = ContactScreen.routeName;
  static const String customer = CustomerScreen.routeName;
  // static const String notes = NotesPage.routeName;
}

class SizeConfig {
  static MediaQueryData _mediaQueryData;
  static double screenWidth;
  static double screenHeight;
  static double blockSizeHorizontal;
  static double blockSizeVertical;
  static double _safeAreaHorizontal;
  static double _safeAreaVertical;
  static double safeBlockHorizontal;
  static double safeBlockVertical;
  static double fontSize;
  static double screenWidthWithoutSafeArea;

  void init(BuildContext context) {
    _mediaQueryData = MediaQuery.of(context);
    screenWidth = _mediaQueryData.size.width;
    screenHeight = _mediaQueryData.size.height;
    blockSizeHorizontal = screenWidth / 100;
    blockSizeVertical = screenHeight / 100;
    _safeAreaHorizontal =
        _mediaQueryData.padding.left + _mediaQueryData.padding.right;
    _safeAreaVertical =
        _mediaQueryData.padding.top + _mediaQueryData.padding.bottom;
    safeBlockHorizontal = (screenWidth - _safeAreaHorizontal) / 100;
    safeBlockVertical = (screenHeight - _safeAreaVertical) / 100;
    fontSize = blockSizeHorizontal * 3;
    screenWidthWithoutSafeArea = screenWidth - _safeAreaHorizontal;
  }
}

class HomeState extends State {
//  int _currentIndex = 0;
//
  static final String oneSignalAppId = "e8002b05-ee0e-44ff-be6c-f89e29ddda0f";

  @override
  void initState() {
    super.initState();
    initPlatformState();
    Future.delayed(new Duration(milliseconds: 500), () {
      jwt().then((value) {
        if (value != null) {
          // var sonuc = User();
          var register = json.decode(value);
          // sonuc = User.fromJson(register);
          var sonuc = User.fromJson(register);
          ProfilimScreen.userName = sonuc.userName;
          ProfilimScreen.password = sonuc.password;
          ProfilimScreen.userId = sonuc.userId;
          ProfilimScreen.ad = sonuc.name;
          ProfilimScreen.soyad = sonuc.surname;
          ProfilimScreen.mail = sonuc.email;
          ProfilimScreen.tcKimlik = sonuc.tcKimlik;
          ProfilimScreen.role = sonuc.role;
          ProfilimScreen.phoneNumber = sonuc.phone;

          Navigator.popAndPushNamed(context, MainMenu.routeName);
          // Navigator.push(
          //     context,
          //     MaterialPageRoute(
          //         builder: (context) =>
          //             Routes.anasayfa.fromBase64(jwt)));
        }
      });
    });
  }

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
    // final routess = [CustomerScreen.routeName];
    SizeConfig().init(context);
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
        // actions: [
        //   // Icon(Icons.account_circle),
        //   Padding(
        //     padding: EdgeInsets.symmetric(horizontal: 16),
        //     child: IconButton(
        //       icon: Icon(Icons.account_circle),
        //       //color: Colors.white,
        //       onPressed: () {
        //         Navigator.pushNamed(context, CustomerScreen.routeName);
        //       },
        //     ),

        //     // onTap: () {
        //     //   Navigator.of(context)
        //     //       .pushNamedAndRemoveUntil(routess[0], (route) => false);
        //     // },
        //   ),
        // ]
      ),
      body: Container(
        child: Center(
          child: AnasayfaScreen(),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: seciliSayfa,
        onTap: sayfaDegistir,
        // fixedColor: hbRed,
        //currentIndex: _currentIndex,
        // onTap: (newIndex) => setState(() {
        //   _currentIndex = newIndex;
        // }),
        backgroundColor: hbRed,
        selectedItemColor: Colors.white,
        //unselectedItemColor: colorScheme.onSurface.withOpacity(.60),
        unselectedItemColor: Colors.white,
        selectedLabelStyle: textTheme.caption,
        unselectedLabelStyle: textTheme.caption,
        // onTap: (value) {
        //   // Respond to item press.
        //   setState(() => _currentIndex = value);
        // },
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
            label: 'Üye Girişi',
            icon: Icon(Icons.account_circle),
          ),
        ],
      ),
      drawer: buildDrawer(context),
    );
  }

  // Drawer createMenuItems(BuildContext context) {
  //   createNavigationItem(String page, String routeName) {
  //     return ListTile(
  //       // leading: Icon(icon),
  //       title: Text(page),

  //       onTap: () {
  //         setState(() {
  //           Navigator.of(context).pop();
  //           Navigator.of(context).pushNamed(routeName);
  //         });
  //       },
  //     );
  //   }

  //   var navigationList = [
  //     createNavigationItem("Üye Girişi", CustomerScreen.routeName),
  //     createNavigationItem("Favorilerim", CustomerScreen.routeName),
  //     createNavigationItem("Bizi Değerlendirin", CustomerScreen.routeName),
  //     createNavigationItem("İletişim", ContactScreen.routeName),
  //     createNavigationItem("Bildirim ayarları", ContactScreen.routeName),
  //   ];

  //   ListView menuItems = new ListView(
  //     children: navigationList,
  //   );

  //   return Drawer(
  //     child: menuItems,
  //   );
  // }

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
                    "Hidayet Baysal İnşaat",
                    style: TextStyle(color: Colors.white, fontSize: 20.0),
                  ),
                ],
              ),
            ),
            decoration: BoxDecoration(
              color: hbRed,
            ),
          ),
          ListTile(
            leading: Icon(Icons.account_circle),
            title: Text('Üye Girişi'),
            // trailing: Icon(Icons.arrow_right),
            onTap: () {
              Navigator.pushNamed(context, CustomerScreen.routeName);
            },
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.favorite),
            title: Text('Favorilerim'),
            // trailing: Icon(Icons.arrow_right),
            onTap: () {
              Navigator.pushNamed(context, CustomerScreen.routeName);
            },
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.star),
            title: Text('Bizi Değerlendirin'),
            // trailing: Icon(Icons.arrow_right),
            onTap: () {
              //Navigator.pushNamed(context, CustomerScreen.routeName);
              Platform.isAndroid
                  ? launch(
                      'https://play.google.com/store/apps/details?id=com.hidayet_baysal_insaat')
                  : Text("Platform hatalı!");
            },
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.phone),
            title: Text('İletişim'),
            // trailing: Icon(Icons.arrow_right),
            onTap: () {
              Navigator.pushNamed(context, ContactScreen.routeName);
            },
          ),
          Divider(),
          // ListTile(
          //   leading: Icon(Icons.notifications),
          //   title: Text('Bildirim ayarları'),
          //   // trailing: Icon(Icons.arrow_right),
          //   onTap: () {
          //     Navigator.pushNamed(context, ContactScreen.routeName);
          //   },
          // ),
          // Divider(),
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
      Navigator.pushNamed(context, CustomerScreen.routeName);
      // final routes = [CustomerScreen.routeName];

      // Navigator.of(context)
      //     .pushNamedAndRemoveUntil(routes[0], (route) => false);
    }
  }

  // sayfaGoster(int seciliSayfa) {
  //   if (seciliSayfa == 0) {
  //     return CallPhone();
  //   }
  // }

  Future<void> initPlatformState() async {
    OneSignal.shared.init(
      oneSignalAppId,
    );

    OneSignal.shared
        .setInFocusDisplayType(OSNotificationDisplayType.notification);
  }
}

// Future _urlAc(String link) async {
//   if (await canLaunch(link)) {

//   } else {
//   }

// }
