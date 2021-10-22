import 'dart:convert';
import 'dart:io';
import 'dart:ui';
// import 'package:sizer/sizer.dart';
//import 'dart:io';
import 'package:flutter/widgets.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
// import 'package:http/http.dart';

import 'package:ilk_projem/Data/FiltreData.dart';

import 'package:ilk_projem/screens/contact.dart';
import 'package:ilk_projem/screens/customer_screen.dart';
import 'package:ilk_projem/screens/kiraliklar.dart';
import 'package:ilk_projem/screens/projeler_screen.dart';
import 'package:ilk_projem/screens/satilik_screen.dart';
//import 'package:ilk_projem/screens/main_menu.dart';

import 'package:ilk_projem/screens/satiliklar.dart';

class FiltrelemeScreen extends StatefulWidget {
  static bool a = false;

  static String ilceIdleri = "";
  static String mahalleIdleri = "";
  static String ilcelerText = "Tüm İlçeler";
  static String semtlerText = "Tüm Semtler";

  static const String routeName = "/filtreleme";

  // final String title;
  @override
  _FiltrelemeScreenState createState() => _FiltrelemeScreenState();
}

class MyItem {
  MyItem({this.isExpanded: false, this.header, this.body});

  bool isExpanded;
  final String header;
  final Mahalle body;
}

class Routes {
  static const String contacts = ContactScreen.routeName;
  static const String customer = CustomerScreen.routeName;
  static const String satilik = SatilikScreen.routeName;
  static const String kiralik = KiralikScreen.routeName;
  static const String projeler = ProjelerScreen.routeName;
  static const String detayliGorunum = SatiliklarScreen.routeName;

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

// Future<String> apiRequest(String url, Map jsonMap,
//     [String method = "Get"]) async {
//   HttpClient httpClient = new HttpClient();
//   HttpClientRequest request = null;
//   if (method == "Get") {
//     request = await httpClient.getUrl(Uri.parse(url));
//   } else {
//     request = await httpClient.postUrl(Uri.parse(url));
//   }
//   request.headers.set('content-type', 'application/json');
//   request.headers.contentLength = utf8.encode(json.encode(jsonMap)).length;
//   request.add(utf8.encode(json.encode(jsonMap)));
//   HttpClientResponse response = await request.close();
//   // todo - you should check the response.statusCode
//   String reply = "";
//   if (response.statusCode == 200) {
//     reply = await response.transform(utf8.decoder).join();
//   }
//   httpClient.close();
//   return reply;
// }

class _FiltrelemeScreenState extends State<FiltrelemeScreen> {
  // SingingCharacter _character = SingingCharacter.lafayette;
  get pageFetch => null;
  int page = 1;

  bool checkBoxValue = false;
  int countIlce = 0;
  int countSemt = 0;

  List<MyItem> _data = [];

  List<String> ilceGoster = [];

  List<Ilce> _ilceListe = [];
  // List<MyItem> _items = [];

  Future<List<Ilce>> fetchIlceListe() async {
    // var url =
    //     "file:///C:/Users/oozge/OneDrive/Masa%C3%BCst%C3%BC/emlakexample.json";
    // var response = await http.get(url);

    String url = 'IlanBilgileri/GetIlceler';
    Map map = {'UserName': '', 'Password': ''};

    var response = await apiRequest(url, map);
    List<Ilce> ilceListe = [];
    _ilceListe = [];

    var ilceListeJson = json.decode(response);

    for (var ilceJson in ilceListeJson) {
      ilceListe.add(Ilce.fromJson(ilceJson));
    }
    // }
    // var order = await emlakListe.length != 0;
    return ilceListe;
  }

  List<Mahalle> _semtListe = [];

  Future<List<Mahalle>> fetchSemt(String ilceIds) async {
    // var url =
    //     "file:///C:/Users/oozge/OneDrive/Masa%C3%BCst%C3%BC/emlakexample.json";
    // var response = await http.get(url);

    String url = 'IlanBilgileri/GetMahalleler';
    Map map = {'UserName': '', 'Password': '', 'IlceIds': ilceIds};

    var response = await apiRequest(url, map);

    List<Mahalle> semtListe = [];
    _semtListe = [];

    var semtListeJson = [];
    if (response != "") {
      semtListeJson = json.decode(response);
    }

    for (var semtJson in semtListeJson) {
      var abc = Mahalle.fromJson(semtJson);
      semtListe.add(abc);
    }
    // }
    // var order = await emlakListe.length != 0;
    return semtListe;
  }

  // }

  @override
  void initState() {
    fetchIlceListe().then((value) {
      setState(() {
        _ilceListe.addAll(value);
      });

      // fetchSemt(ilcelerIdleri).then((value) {
      //   setState(() {
      //     _semtListe.addAll(value);
      //   });
      // });
    });

    // fetchKat
    super.initState();
  }

  PageController pageController = PageController(initialPage: 0);

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    showAlertDialogg(BuildContext context) {
      // int _radioValue1 = 0;
      // set up the button
      Widget iptalButton = TextButton(
        child: Text("VAZGEÇ"),
        onPressed: () => Navigator.pop(context, true),
      );
      Widget okButton = TextButton(
        onPressed: () {
          setState(() {
            FiltrelemeScreen.ilceIdleri = "";
            FiltrelemeScreen.ilcelerText = "";
            _data = [];
            countIlce = 0;
            for (var i = 0; i < _ilceListe.length; i++) {
              if ((_ilceListe[i].isChecked ?? false) == true) {
                // _data.add(new MyItem(
                //     body: new Mahalle(),
                //     header: _ilceListe[i].ilceAdi ?? "",
                //     isExpanded: false));
                countIlce = countIlce + 1;
                if (FiltrelemeScreen.ilceIdleri == "") {
                  FiltrelemeScreen.ilceIdleri =
                      (_ilceListe[i].iD ?? "0").toString();
                } else {
                  FiltrelemeScreen.ilceIdleri +=
                      "," + (_ilceListe[i].iD ?? "0").toString();
                }
                if (FiltrelemeScreen.ilcelerText.length > 0) {
                  FiltrelemeScreen.ilcelerText += " - ";
                  // FiltrelemeScreen.ilceIdleri += ",";
                }
                // FiltrelemeScreen.ilceIdleri += (_ilceListe[i].iD ?? "").toString();
                if (countIlce <= 4) {
                  FiltrelemeScreen.ilcelerText += _ilceListe[i].ilceAdi ?? "";
                } else {
                  FiltrelemeScreen.ilcelerText = "$countIlce" + " " + "ilçe";
                }
              }
            }
            ProjelerScreen.ilceId = FiltrelemeScreen.ilceIdleri;
            if (0 < countIlce && countIlce < 2) {
              ilceGoster = FiltrelemeScreen.ilcelerText.split("");
            } else {
              ilceGoster = FiltrelemeScreen.ilcelerText.split("-");
            }
            // List<String> ilceId = [];
            // if (countIlce == 1 && countIlce > 0) {
            //   ilceId = ilcelerIdleri;
            // } else {
            //   ilceId = ilcelerIdleri.split(",");
            // }
            // for (var i = 0; i < ilceId.length; i++) {
            //   fetchSemt(ilceId[i]).then((value) {
            //     setState(() {
            //       _semtListe.addAll(value);
            //     });
            //   });
            // }
            fetchSemt(FiltrelemeScreen.ilceIdleri ?? "").then((value) {
              setState(() {
                _semtListe.addAll(value);
              });
            });
            Navigator.pop(context, false);
          });
        },
        child: Text("TAMAM"),
      );

      showDialog(
          context: context,
          builder: (BuildContext context) {
            return StatefulBuilder(
              builder: (context, setState) {
                return AlertDialog(
                  title: Text("İLÇELER"),
                  content: Container(
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height,
                      child: Column(mainAxisSize: MainAxisSize.min, children: <
                          Widget>[
                        Expanded(
                          child: ListView.builder(
                              scrollDirection: Axis.vertical,
                              shrinkWrap: true, // new line
                              // physics: NeverScrollableScrollPhysics(),
                              // scrollDirection: Axis.horizontal,
                              itemCount: _ilceListe.length,
                              itemBuilder: (BuildContext context, int index) {
                                return new Card(
                                  child: new Container(
                                    // alignment: Alignment.center,
                                    // padding: EdgeInsets.all(0.0),
                                    // padding: new EdgeInsets.all(10.0),
                                    child: Column(
                                      // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: <Widget>[
                                        new CheckboxListTile(
                                            activeColor: Colors.pink[300],
                                            dense: true,
                                            //font change
                                            title: new Text(
                                              _ilceListe[index].ilceAdi ?? "",
                                              style: TextStyle(
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.w600,
                                                  letterSpacing: 0.5),
                                            ),
                                            value:
                                                _ilceListe[index].isChecked ??
                                                    false,
                                            onChanged: (bool val) {
                                              // itemChange(val, index);
                                              setState(() {
                                                _ilceListe[index].isChecked =
                                                    val;
                                              });
                                            })
                                      ],
                                    ),
                                  ),
                                );
                              }),
                        )
                      ])),
                  actions: [
                    okButton,
                    iptalButton,
                  ],
                  //);
                  // }
                );
              },
            );
          });
    }

    // for (var i = 0; i < ilceGoster.length; i++) {
    //   MyItem tempItem = new MyItem(header: ilceGoster[i], body: _semtListe);
    //   _items.add(tempItem);
    // }
    // List<MyItem> _items = <MyItem>[
    //   MyItem(header: ilceGoster, body: _semtListe)
    // ];
    List<MyItem> _items(int numberOfItems) {
      return List.generate(numberOfItems, (index) {
        return MyItem(
          header: ilceGoster[index] ?? "",
          body: _semtListe[index] ?? new Mahalle(),
        );
      });
    }

    // _data = _items(_semtListe.length);
    _data = _items(_data.length);

    // List<String> ikiBoyut = [ilceGoster];

    showAlertDialogSemt(BuildContext context) {
      // int _radioValue1 = 0;
      // set up the button
      Widget iptalButton = TextButton(
        child: Text("VAZGEÇ"),
        onPressed: () => Navigator.pop(context, true),
      );
      Widget okButton = TextButton(
        onPressed: () {
          setState(() {
            FiltrelemeScreen.mahalleIdleri = "";
            FiltrelemeScreen.semtlerText = "";
            countSemt = 0;
            for (var i = 0; i < _semtListe.length; i++) {
              if ((_semtListe[i].isChecked ?? false) == true) {
                countSemt = countSemt + 1;
                if (FiltrelemeScreen.mahalleIdleri == "") {
                  FiltrelemeScreen.mahalleIdleri =
                      (_semtListe[i].iD ?? "0").toString();
                } else {
                  FiltrelemeScreen.mahalleIdleri +=
                      "," + (_semtListe[i].iD ?? "0").toString();
                }
                if (FiltrelemeScreen.semtlerText.length > 0) {
                  FiltrelemeScreen.semtlerText += " - ";
                  // FiltrelemeScreen.mahalleIdleri += ",";
                }
                FiltrelemeScreen.mahalleIdleri +=
                    (_semtListe[i].iD ?? "").toString();
                if (countSemt <= 2) {
                  FiltrelemeScreen.semtlerText +=
                      _semtListe[i].mahalleAdi ?? "";
                } else {
                  FiltrelemeScreen.semtlerText = "$countSemt" + " " + "mahalle";
                }
              }
            }
            ProjelerScreen.mahalleId = FiltrelemeScreen.mahalleIdleri;
            // fetchSemt(ilcelerIdleri).then((value) {
            //   setState(() {
            //     _semtListe.addAll(value);
            //   });
            // });
            Navigator.pop(context, false);
          });
        },
        child: Text("TAMAM"),
      );

      showDialog(
          context: context,
          builder: (BuildContext context) {
            return StatefulBuilder(
              builder: (context, setState) {
                return AlertDialog(
                  title: Text("MAHALLELER"),
                  content: Container(
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height,
                      child: Column(mainAxisSize: MainAxisSize.min, children: <
                          Widget>[
                        Expanded(
                          child: ListView.builder(
                              scrollDirection: Axis.vertical,
                              shrinkWrap: true, // new line
                              // physics: NeverScrollableScrollPhysics(),
                              // scrollDirection: Axis.horizontal,
                              itemCount: _semtListe.length,
                              itemBuilder: (BuildContext context, int index) {
                                return new Card(
                                  child: new Container(
                                    // alignment: Alignment.center,
                                    // padding: EdgeInsets.all(0.0),
                                    // padding: new EdgeInsets.all(10.0),
                                    child: Column(
                                      // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: <Widget>[
                                        new CheckboxListTile(
                                            activeColor: Colors.pink[300],
                                            dense: true,
                                            //font change
                                            title: new Text(
                                              _semtListe[index].mahalleAdi ??
                                                  "",
                                              style: TextStyle(
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.w600,
                                                  letterSpacing: 0.5),
                                            ),
                                            value:
                                                _semtListe[index].isChecked ??
                                                    false,
                                            onChanged: (bool val) {
                                              // itemChange(val, index);
                                              setState(() {
                                                _semtListe[index].isChecked =
                                                    val;
                                              });
                                            })
                                      ],
                                    ),
                                  ),
                                );
                              }),
                        )
                      ])),
                  actions: [
                    okButton,
                    iptalButton,
                  ],
                  //);
                  // }
                );
              },
            );
          });
    }

    /*...*/
    return Scaffold(
      appBar: AppBar(
        title: Text("KONUM SEÇİMİ"),
        // flexibleSpace: Row(
        //   mainAxisAlignment: MainAxisAlignment.center,
        //   // crossAxisAlignment: CrossAxisAlignment.end,

        //   children: [
        //     Text(
        //       "KONUM SEÇİMİ",
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
      ),
      body: PageView(
        scrollDirection: Axis.horizontal,
        pageSnapping: true,
        controller: pageController,
        children: [
          Container(
            child: Column(
              children: <Widget>[
                Text(
                  "ÜLKE",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                Text("Türkiye"),
                Divider(),
                Text(
                  "ŞEHİR",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                Text("Konya"),
                Divider(),
                // Text(
                //   "İLÇE",
                //   style: TextStyle(fontWeight: FontWeight.bold),
                // ),
                TextButton(
                    onPressed: () {
                      showAlertDialogg(context);

                      //print("a");
                    },
                    child: Column(
                      children: <Widget>[
                        Text(
                          "İLÇE",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, color: Colors.black),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Text(
                              FiltrelemeScreen.ilcelerText,
                              // textDirection: TextDirection.ltr,
                              textAlign: TextAlign.right,
                              softWrap: true,
                              overflow: TextOverflow.clip,
                              style: TextStyle(
                                color: Colors.black,
                              ),
                            ),
                            // Spacer(),
                            Icon(
                              Icons.arrow_drop_down,
                              color: Colors.black,
                            ),
                          ],
                        ),
                      ],
                    )),
                TextButton(
                    onPressed: () {
                      showAlertDialogSemt(context);
                    },
                    child: Column(
                      children: <Widget>[
                        Text(
                          "SEMT/MAHALLE",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Text(
                              FiltrelemeScreen.semtlerText,
                              // textDirection: TextDirection.ltr,
                              textAlign: TextAlign.right,
                              softWrap: true,
                              overflow: TextOverflow.clip,
                              style: TextStyle(
                                color: Colors.black,
                              ),
                            ),
                            // Spacer(),
                            Icon(
                              Icons.arrow_drop_down,
                              color: Colors.black,
                            ),
                          ],
                        ),
                      ],
                    )),

                TextButton(
                  onPressed: () {
                    setState(() {
                      Navigator.pop(context);
                    });
                    //Navigator.pushNamed(context, ProjelerScreen.routeName);
                  },
                  child: Text("TAMAM"),
                  // color: Colors.blue,
                  style: TextButton.styleFrom(
                      primary: Colors.white, backgroundColor: Colors.blue),
                )
              ],
            ),
          ),
          Container(
            color: Colors.blue,
          ),
          Container(
            color: Colors.yellow,
          ),
        ],
      ),
    );
  }

  void itemChange(bool val, int index) {
    setState(() {
      _ilceListe[index].isChecked = val;
    });
  }
}
