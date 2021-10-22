import 'package:flutter/material.dart';
import 'package:ilk_projem/screens/projeler_screen.dart';
//import 'package:ilk_projem/screens/main_menu.dart';

//import 'contact.dart';

class KiralikScreen extends StatefulWidget {
  static const String routeName = "/kiraliklar";

  @override
  _KiralikState createState() => _KiralikState();
}

// class Routes {
//   static const String contacts = ContactScreen.routeName;
//   static const String customer = CustomerScreen.routeName;
//   static const String anasayfa = MainMenu.routeName;
//   // static const String notes = NotesPage.routeName;
// }

class _KiralikState extends State<KiralikScreen> {
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

          // ]
        ),
        // AppBar(
        //   flexibleSpace: Row(
        //     mainAxisAlignment: MainAxisAlignment.center,
        //     crossAxisAlignment: CrossAxisAlignment.end,
        //     children: [
        //       Image.asset(
        //         'assets/logo/hblogopng.png',
        //         fit: BoxFit.cover,
        //         width: 40,
        //         height: 40,
        //       ),
        //       Padding(
        //         padding: EdgeInsets.symmetric(vertical: 35),
        //       ),
        //     ],
        //   ),
        // ),
        body: Padding(
            padding: EdgeInsets.all(10),
            child: Container(
              margin: EdgeInsets.all(25.0),
              child: Form(
                child: Column(
                  children: <Widget>[
                    Text(
                      "Kiralıklar",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: hbRed,
                      ),
                    ),
                    Divider(
                      color: Colors.grey[300],
                      height: 20,
                      thickness: 5,
                      indent: 0,
                      endIndent: 0,
                    ),
                    TumKiralik(),
                    Divider(
                      color: Colors.grey[300],
                      height: 20,
                      thickness: 2,
                      indent: 0,
                      endIndent: 0,
                    ),
                    DairelerKiralikButton(),
                    Divider(
                      color: Colors.grey[300],
                      height: 20,
                      thickness: 2,
                      indent: 0,
                      endIndent: 0,
                    ),
                    DukkanlarKiralikButton(),
                    Divider(
                      color: Colors.grey[300],
                      height: 20,
                      thickness: 2,
                      indent: 0,
                      endIndent: 0,
                    ),
                    // AcilButton(),
                  ],
                ),
              ),
            )));
  }
}

class TumKiralik extends StatelessWidget {
  const TumKiralik({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const MaterialColor hbBlue = const MaterialColor(
      0xFF122a74,
      const <int, Color>{
        50: const Color(0xFF122a74),
        100: const Color(0xFF122a74),
        200: const Color(0xFF122a74),
        300: const Color(0xFF122a74),
        400: const Color(0xFF122a74),
        500: const Color(0xFF122a74),
        600: const Color(0xFF122a74),
        700: const Color(0xFF122a74),
        800: const Color(0xFF122a74),
        900: const Color(0xFF122a74),
      },
    );

    return TextButton(
      style: ButtonStyle(
        shadowColor: MaterialStateColor.resolveWith((states) => Colors.black),
        overlayColor: MaterialStateColor.resolveWith((states) => hbBlue),
        backgroundColor:
            MaterialStateColor.resolveWith((states) => Colors.white),
        foregroundColor:
            MaterialStateColor.resolveWith((states) => Colors.black),
        padding:
            MaterialStateProperty.resolveWith((states) => EdgeInsets.all(6.0)),
      ),
      // color: Colors.white,
      // textColor: Colors.black,
      // disabledColor: Colors.grey,
      // disabledTextColor: Colors.black,
      // padding: EdgeInsets.all(6.0),
      // splashColor: hbBlue,
      onPressed: () {
        ProjelerScreen.ilanTuru = 2;
        ProjelerScreen.ilanTipi = 0;
        ProjelerScreen.ilanTurAdi = "Kiralık";
        Navigator.pushNamed(context, ProjelerScreen.routeName);
        /*...*/
      },
      child: Row(
        // mainAxisAlignment: MainAxisAlignment.center,
        // Yukarıdan-Aşağıya Hizalama
        crossAxisAlignment: CrossAxisAlignment.start,
        //  Row içerisine eklenen diğer widgetların listesi
        children: <Widget>[
          Column(
            children: <Widget>[
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Tüm " "Kiralık" " İlanları",
                  textAlign: TextAlign.left,
                  style: TextStyle(fontSize: 18.0),
                  // maxLines: 10,ı
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class DairelerKiralikButton extends StatelessWidget {
  const DairelerKiralikButton({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const MaterialColor hbBlue = const MaterialColor(
      0xFF122a74,
      const <int, Color>{
        50: const Color(0xFF122a74),
        100: const Color(0xFF122a74),
        200: const Color(0xFF122a74),
        300: const Color(0xFF122a74),
        400: const Color(0xFF122a74),
        500: const Color(0xFF122a74),
        600: const Color(0xFF122a74),
        700: const Color(0xFF122a74),
        800: const Color(0xFF122a74),
        900: const Color(0xFF122a74),
      },
    );

    return TextButton(
      style: ButtonStyle(
        shadowColor: MaterialStateColor.resolveWith((states) => Colors.black),
        overlayColor: MaterialStateColor.resolveWith((states) => hbBlue),
        backgroundColor:
            MaterialStateColor.resolveWith((states) => Colors.white),
        foregroundColor:
            MaterialStateColor.resolveWith((states) => Colors.black),
        padding:
            MaterialStateProperty.resolveWith((states) => EdgeInsets.all(6.0)),
      ),
      // color: Colors.white,
      // textColor: Colors.black,
      // disabledColor: Colors.grey,
      // disabledTextColor: Colors.black,
      // padding: EdgeInsets.all(6.0),
      // splashColor: hbBlue,
      onPressed: () {
        ProjelerScreen.ilanTuru = 2;
        ProjelerScreen.ilanTipi = 1;
        ProjelerScreen.ilanTurAdi = "Kiralık";
        Navigator.pushNamed(context, ProjelerScreen.routeName);
        /*...*/
      },
      child: Row(
        // mainAxisAlignment: MainAxisAlignment.center,
        // Yukarıdan-Aşağıya Hizalama
        crossAxisAlignment: CrossAxisAlignment.start,
        //  Row içerisine eklenen diğer widgetların listesi
        children: <Widget>[
          Column(
            children: <Widget>[
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Daireler",
                  textAlign: TextAlign.left,
                  style: TextStyle(fontSize: 15.0),
                  // maxLines: 10,ı
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class DukkanlarKiralikButton extends StatelessWidget {
  const DukkanlarKiralikButton({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const MaterialColor hbBlue = const MaterialColor(
      0xFF122a74,
      const <int, Color>{
        50: const Color(0xFF122a74),
        100: const Color(0xFF122a74),
        200: const Color(0xFF122a74),
        300: const Color(0xFF122a74),
        400: const Color(0xFF122a74),
        500: const Color(0xFF122a74),
        600: const Color(0xFF122a74),
        700: const Color(0xFF122a74),
        800: const Color(0xFF122a74),
        900: const Color(0xFF122a74),
      },
    );

    return TextButton(
      style: ButtonStyle(
        shadowColor: MaterialStateColor.resolveWith((states) => Colors.black),
        overlayColor: MaterialStateColor.resolveWith((states) => hbBlue),
        backgroundColor:
            MaterialStateColor.resolveWith((states) => Colors.white),
        foregroundColor:
            MaterialStateColor.resolveWith((states) => Colors.black),
        padding:
            MaterialStateProperty.resolveWith((states) => EdgeInsets.all(6.0)),
      ),
      // color: Colors.white,
      // textColor: Colors.black,
      // disabledColor: Colors.grey,
      // disabledTextColor: Colors.black,
      // padding: EdgeInsets.all(6.0),
      // splashColor: hbBlue,
      onPressed: () {
        ProjelerScreen.ilanTuru = 2;
        ProjelerScreen.ilanTipi = 2;
        ProjelerScreen.ilanTurAdi = "Kiralık";
        Navigator.pushNamed(context, ProjelerScreen.routeName);
        /*...*/
      },
      child: Row(
        // mainAxisAlignment: MainAxisAlignment.center,
        // Yukarıdan-Aşağıya Hizalama
        crossAxisAlignment: CrossAxisAlignment.start,
        //  Row içerisine eklenen diğer widgetların listesi
        children: <Widget>[
          Column(
            children: <Widget>[
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Dükkanlar",
                  textAlign: TextAlign.left,
                  style: TextStyle(fontSize: 15.0),
                  // maxLines: 10,ı
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
