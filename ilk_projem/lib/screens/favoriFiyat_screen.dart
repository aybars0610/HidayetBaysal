// import 'dart:convert';
// import 'dart:ffi';
import 'dart:ui';
// import 'package:sizer/sizer.dart';
//import 'dart:io';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

// import 'package:ilk_projem/Data/Favori.dart';

import 'package:ilk_projem/screens/Filtreleme.dart';

import 'package:ilk_projem/screens/contact.dart';
import 'package:ilk_projem/screens/customer_screen.dart';
import 'package:ilk_projem/screens/kiraliklar.dart';
import 'package:ilk_projem/screens/satilik_screen.dart';
//import 'package:ilk_projem/screens/main_menu.dart';

import 'package:ilk_projem/screens/satiliklar.dart';

//import 'package:share/share.dart';
//import "package:pagination/pagination.dart";
// import "package:path/path.dart"

//import 'package:url_launcher/url_launcher.dart';
//import 'package:ilk_projem/screens/product_screen.dart';
//import 'package:http/http.dart' as http;

// ignore: must_be_immutable
class FavorilerimFiyatScreen extends StatefulWidget {
  static const String routeName = "/favorilerimFiyat";
  String fiyat;
  String eskiFiyat;
  FavorilerimFiyatScreen({this.fiyat, this.eskiFiyat});

  // final String title;
  @override
  _FavorilerimFiyatScreenState createState() => _FavorilerimFiyatScreenState();
}

// enum Siralama {
//   Gelismis, //sıralama,
//   Fiyata, // göre(Önce en yüksek),
//   banana,
// }

class Routes {
  static const String contacts = ContactScreen.routeName;
  static const String customer = CustomerScreen.routeName;
  static const String satilik = SatilikScreen.routeName;
  static const String kiralik = KiralikScreen.routeName;
  // static const String projeler = ProjelerScreen.routeName;
  static const String detayliGorunum = SatiliklarScreen.routeName;
  static const String filtre = FiltrelemeScreen.routeName;

  // static const String notes = NotesPage.routeName;
}

int iD = 2;

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

class _FavorilerimFiyatScreenState extends State<FavorilerimFiyatScreen> {
  get pageFetch => null;
  int page = 1;
  int pageIndex = 0;
  // int fiyat1 = int?.parse('eskiFiyat');
  PageController _pageController = PageController(initialPage: 0);

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);

    /*...*/
    return Scaffold(
        appBar: AppBar(
          flexibleSpace: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            // crossAxisAlignment: CrossAxisAlignment.end,

            children: [
              Text(
                "İlan Tarihçesi",
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    fontSize: 20),
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 100),
              ),
            ],
          ),
        ),
        body: PageView(
            scrollDirection: Axis.vertical,
            // reverse: true,
            // physics: (),
            controller: _pageController,
            pageSnapping: false,
            onPageChanged: (page) {
              setState(() {
                pageIndex = page;
              });
            },
            children: <Widget>[
              Container(
                child: Column(
                  //mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Text("FAVORİYE EKLEME SONRASI DEĞİŞİKLİKLER"),
                    Container(
                      child: Row(
                        children: <Widget>[
                          Column(children: <Widget>[
                            Text("Favoriye"),
                            Text("Eklendiğindeki Fiyat"),
                            Row(children: <Widget>[
                              Text(widget.eskiFiyat),
                              Text("TL"),
                            ])
                          ]),
                          Icon(Icons.arrow_right_alt_outlined),
                          Column(children: <Widget>[
                            Text("İlanın Şu Anki"),
                            Text("Fiyatı"),
                            Row(children: <Widget>[
                              Text(widget.fiyat),
                              Text("TL"),
                            ])
                          ]),
                        ],
                      ),
                    ),

                    //],
                    //),
                  ],
                ),
              ),
            ]));
  }
}
