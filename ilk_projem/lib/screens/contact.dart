import 'package:flutter/material.dart';

// import 'package:ilk_projem/screens/home.dart';
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

class ContactScreen extends StatelessWidget {
  static const String routeName = "/contact";

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    // Color c = const Color(0xFFa90600);
    return Scaffold(
        appBar: AppBar(
          // flexibleSpace: Row(
          //   mainAxisAlignment: MainAxisAlignment.center,
          //   // crossAxisAlignment: CrossAxisAlignment.end,
          //   children: [
          //     Text(
          //       "İletişim Bilgileri",
          //       style: TextStyle(
          //           fontWeight: FontWeight.bold,
          //           color: Colors.white,
          //           fontSize: 20),
          //     ),
          //     Padding(
          //       padding: EdgeInsets.symmetric(vertical: 35),
          //     ),
          //   ],
          // ),
          title: Text("İletişim Bilgileri"),
        ),
        // appBar: AppBar(
        //   title: Text("İletişim Bilgileri"),
        //   backgroundColor: c,
        // ),
        // drawer: Home(),
        body: Center(
          child: Container(
              margin: EdgeInsets.only(
                left: 2.0,
                top: 25.0,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Image.asset(
                    'assets/logo/hbgri.png',
                    fit: BoxFit.cover,
                    width: 300,
                    height: 80,
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 35),
                  ),
                  // Row(
                  //   // margin: EdgeInsets.only(top: 25.0),
                  //   children: <Widget>[

                  Text(
                    "TELEFON:",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
                  ),
                  Text(
                    "(0332)-261-23-33",
                    style: TextStyle(
                      fontSize: 20,
                    ),
                  ),
                  //   ],
                  // ),
                  // Row(
                  //   // margin: EdgeInsets.only(top: 25.0),
                  //   children: <Widget>[
                  Text(
                    "E-POSTA:",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
                  ),
                  Text(
                    "info@hidayetbaysal.com",
                    style: TextStyle(
                      fontSize: 20,
                    ),
                  ),
                  //   ],
                  // ),
                  // Row(
                  //   // margin: EdgeInsets.only(top: 25.0),
                  //   children: <Widget>[
                  Text(
                    "ADRES:",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
                  ),
                  // Column(children: <Widget>[
                  Text(
                    "Yazır Mahallesi Ulusal Sokak",
                    style: TextStyle(
                      fontSize: 20,
                    ),
                  ),
                  Text(
                    "No: 93-B (Japon Parkı Karşısı)",
                    style: TextStyle(
                      fontSize: 20,
                    ),
                  ),
                  Text(
                    "(Selçuklu/KONYA)",
                    style: TextStyle(
                      fontSize: 20,
                    ),
                  ),
                  //   ]),
                  // ],
                  // )
                ],
              )),
        ));
  }
}
