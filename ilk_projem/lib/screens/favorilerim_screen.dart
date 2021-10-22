import 'dart:convert';
import 'dart:ui';
// import 'package:sizer/sizer.dart';
//import 'dart:io';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:ilk_projem/Data/Favori.dart';

import 'package:ilk_projem/screens/Filtreleme.dart';

import 'package:ilk_projem/screens/contact.dart';
import 'package:ilk_projem/screens/customer_screen.dart';
import 'package:ilk_projem/screens/kiraliklar.dart';
import 'package:ilk_projem/screens/profilim_screen.dart';
import 'package:ilk_projem/screens/projeler_screen.dart';
import 'package:ilk_projem/screens/satilik_screen.dart';
//import 'package:ilk_projem/screens/main_menu.dart';

import 'package:ilk_projem/screens/satiliklar.dart';

//import 'package:share/share.dart';
//import "package:pagination/pagination.dart";
// import "package:path/path.dart"

//import 'package:url_launcher/url_launcher.dart';
//import 'package:ilk_projem/screens/product_screen.dart';
//import 'package:http/http.dart' as http;

class FavorilerimScreen extends StatefulWidget {
  static bool a = false;

  static const String routeName = "/favorilerim";

  static bool b = false;

  // final String title;
  @override
  _FavorilerimScreenState createState() => _FavorilerimScreenState();
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

class _FavorilerimScreenState extends State<FavorilerimScreen> {
  get pageFetch => null;
  int page = 1;
  bool yayindakiler = false;

  int pageIndex = 0;

  PageController _pageController = PageController(initialPage: 0);

  List<Favori> _emlakListe = [];

  Future<List<Favori>> fetchEmlakListe() async {
    String url = 'IlanBilgileri/GetFavoriler';
    Map map = {
      'UserName': ProfilimScreen.userName,
      'Password': ProfilimScreen.password
    };

    var response = await apiRequest(url, map);
    // var url =
    //     "file:///C:/Users/oozge/OneDrive/Masa%C3%BCst%C3%BC/emlakexample.json";
    // var response = await http.get(url);
    List<Favori> emlakListe = [];

    // var response =
    //     """[{"ID":1,"Title":"YALÇINKAYA EMLAK KIRALIYOR","Price":"950","Picture":"https://i0.shbdn.com/photos/26/75/19/lthmb_8772675197x4.jpg","Favorite":true,"Yayin":true},{"ID":2,"Title":"OTOGARDA 2+1 KIRALIK DAIRE","Price":"800","Picture":"https://i0.shbdn.com/photos/46/77/16/lthmb_8804677168vc.jpg","Favorite":true,"Yayin":false}]""";
    // {"ID":1,"Title":"YALÇINKAYA EMLAK KIRALIYOR","Price":"950","Picture":"https://i0.shbdn.com/photos/26/75/19/lthmb_8772675197x4.jpg","Favorite":true,"Yayin":true,"OldPrice":"1000"}

    // if (response.statusCode == 200) {
    // var emlakListeJson = json.decode(response.body);
    var emlakListeJson = json.decode(response);

    for (var emlakJson in emlakListeJson) {
      emlakListe.add(Favori.fromJson(emlakJson));
    }
    // }
    // var order = await emlakListe.length != 0;
    return emlakListe;
  }

  @override
  void initState() {
    fetchEmlakListe().then((value) {
      setState(() {
        _emlakListe.addAll(value);
      });
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);

    /*...*/
    return Scaffold(
        appBar: AppBar(
          title: Text("Favorilerim"),
          // flexibleSpace: Row(
          //   mainAxisAlignment: MainAxisAlignment.center,
          //   // crossAxisAlignment: CrossAxisAlignment.end,

          //   children: [
          //     Text(
          //       "Favorilerim",
          //       style: TextStyle(
          //           fontWeight: FontWeight.bold,
          //           color: Colors.white,
          //           fontSize: 20),
          //     ),
          //     Padding(
          //       padding: EdgeInsets.symmetric(vertical: 100),
          //     ),
          //   ],
          // ),
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
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        const Text("Yayındakiler"),
                        Checkbox(
                          value: yayindakiler,
                          onChanged: (value) {
                            setState(() {
                              yayindakiler = value;
                            });
                          },
                        ),
                      ],
                    ),
                    Divider(),
                    Expanded(
                      child: ListView.builder(
                        itemCount: _emlakListe.length,
                        itemBuilder: (BuildContext context, int index) {
                          return Card(
                            child: ListTile(
                              title: Row(children: <Widget>[
                                Expanded(
                                  child: Text(
                                    _emlakListe[index].title,
                                    style: TextStyle(fontSize: 12.0),
                                  ),
                                ),
                                Spacer(),
                                // IconButton(
                                //     icon: Icon(Icons.delete),
                                //     onPressed: () {
                                //       _emlakListe.removeAt(index);
                                //       setState(() {
                                //         _emlakListe[index].favorite = false;
                                //       });
                                //     })
                              ]),
                              subtitle: Column(
                                children: <Widget>[
                                  Row(
                                    children: <Widget>[
                                      _emlakListe[index].yayin
                                          ? Text(
                                              "Yayında",
                                              textAlign: TextAlign.left,
                                              style: TextStyle(
                                                  color: Colors.green),
                                            )
                                          : Text(
                                              "Yayında Değil",
                                              textAlign: TextAlign.left,
                                              style:
                                                  TextStyle(color: Colors.red),
                                            ),
                                      // Text(" "),
                                      Spacer(),

                                      Text(
                                        _emlakListe[index].price,
                                        textAlign: TextAlign.right,
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold),
                                      ),
                                      // Text(
                                      //   "TL",
                                      //   textAlign: TextAlign.right,
                                      //   style: TextStyle(
                                      //       fontWeight: FontWeight.bold),
                                      // ),
                                      // IconButton(
                                      //     icon: Icon(Icons.access_time),
                                      //     onPressed: () {
                                      //       Navigator.push(
                                      //           context,
                                      //           MaterialPageRoute(
                                      //               builder: (context) =>
                                      //                   FavorilerimFiyatScreen(
                                      //                     eskiFiyat:
                                      //                         _emlakListe[index]
                                      //                             .oldPrice,
                                      //                     fiyat:
                                      //                         _emlakListe[index]
                                      //                             .price,
                                      //                   )));
                                      //     })
                                    ],
                                  ),
                                ],
                              ),
                              leading: IconButton(
                                icon: Image.network(_emlakListe[index].picture),
                                onPressed: () {},
                              ),
                              onTap: () {
                                Navigator.pushNamed(
                                    context, ProjelerScreen.routeName);
                              },
                            ),
                          );
                        },
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
