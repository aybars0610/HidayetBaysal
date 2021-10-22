import 'dart:convert';
import 'dart:ui';
// import 'package:sizer/sizer.dart';
import 'dart:io';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ilk_projem/Data/EmlakData.dart';
import 'package:ilk_projem/Data/FiltreData.dart';

import 'package:ilk_projem/screens/Filtreleme.dart';
import 'package:ilk_projem/screens/aramalar_screen.dart';

import 'package:ilk_projem/screens/contact.dart';
import 'package:ilk_projem/screens/customer_screen.dart';
import 'package:ilk_projem/screens/kiraliklar.dart';
import 'package:ilk_projem/screens/satilik_screen.dart';
//import 'package:ilk_projem/screens/main_menu.dart';

import 'package:ilk_projem/screens/satiliklar.dart';

//import 'package:share/share.dart';
//import "package:pagination/pagination.dart";
// import "package:path/path.dart"

import 'package:url_launcher/url_launcher.dart';
//import 'package:ilk_projem/screens/product_screen.dart';
//import 'package:http/http.dart' as http;

import 'package:flutter/foundation.dart';

class ProjelerScreen extends StatefulWidget {
  static bool a = false;
  static int ilanTuru = 0;
  static String ilanTurAdi = "";
  static int ilanTipi = 0;
  static String ilanTipAdi = "";
  static String fiyatText = "Tümü";
  static String userName = "";
  static String password = "";
  static int ilId = 0;
  static String ilceId = "";
  static String mahalleId = "";
  static String odaSayisiIdleri = "";
  static String bulunduguKatIdleri = "";
  static double enAzFiyat = 0;
  static double enCokFiyat = 0;
  static int esyaliId = 0;
  static String siteAdi = "";
  static String aramaMetni = "";
  static int siralama = 0;
  static const String routeName = "/projeler";

  static bool b = false;

  // final String title;
  @override
  _ProjelerScreenState createState() => _ProjelerScreenState();
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
  static const String projeler = ProjelerScreen.routeName;
  static const String detayliGorunum = SatiliklarScreen.routeName;
  static const String filtre = FiltrelemeScreen.routeName;

  // static const String notes = NotesPage.routeName;
}

enum SingingCharacter { zero, one, two, three, four }
enum EsyaCharacter { zero, one, two }
enum GorunumCharacter { zero, one }

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

Map<dynamic, dynamic> getIlanForm(
    [String username = "",
    String password = "",
    int ilanTuruID = 0,
    int ilanTipiID = 0,
    int ilId = 0,
    String ilceIdleri = "",
    String mahalleIdleri = "",
    String odaSayisiIdleri = "",
    String bulunduguKatIdleri = "",
    double enAzFiyat = 0,
    double enCokFiyat = 0,
    int esyaliID = 0,
    String siteAdi = "",
    String aramaMetni = "",
    int siralama = 0]) {
  Map<dynamic, dynamic> map = {
    'UserName': username,
    'Password': password,
    'IlanTuruID': ilanTuruID,
    'IlanTipiID': ilanTipiID,
    'IlId': ilId,
    'IlceIdleri': ilceIdleri,
    'MahalleIdleri': mahalleIdleri,
    'OdaSayisiIdleri': odaSayisiIdleri,
    'BulunduguKatIdleri': bulunduguKatIdleri,
    'EnAzFiyat': enAzFiyat,
    'EnCokFiyat': enCokFiyat,
    'EsyaliID': esyaliID,
    'SiteAdi': siteAdi,
    'AramaMetni': aramaMetni,
    'Siralama': siralama
  };
  return map;
}

Future<String> apiRequest(String url, Map jsonMap,
    [String method = "Get"]) async {
  HttpClient httpClient = new HttpClient();
  HttpClientRequest request = null;
  if (method == "Get") {
    request =
        // await httpClient.getUrl(Uri.parse("http://192.168.1.106/api/" + url));
        await httpClient
            .getUrl(Uri.parse("http://api.hidayetbaysal.net/api/" + url));
  } else {
    request =
        // await httpClient.postUrl(Uri.parse("http://192.168.1.106/api/" + url));
        await httpClient
            .postUrl(Uri.parse("http://api.hidayetbaysal.net/api/" + url));
  }
  request.headers.set('content-type', 'application/json');
  request.headers.contentLength = utf8.encode(json.encode(jsonMap)).length;
  request.add(utf8.encode(json.encode(jsonMap)));
  HttpClientResponse response = await request.close();
  // todo - you should check the response.statusCode
  String reply = "";
  if (response.statusCode == 200) {
    reply = await response.transform(utf8.decoder).join();
  }
  httpClient.close();
  return reply;
}

class _ProjelerScreenState extends State<ProjelerScreen> {
  // SingingCharacter _character = SingingCharacter.lafayette;
  get pageFetch => null;
  int page = 1;
  //bool visibilityObs = false;

  // void _changed(bool visibility, String field) {
  //   setState(() {
  //     if (a) {
  //       a = false;
  //       // ignore: missing_required_param
  //       ListView.builder(
  //         itemCount: _emlakListe.length,
  //       );
  //     } else {
  //       a = true;
  //       // ignore: missing_required_param
  //       ListView.builder(
  //         itemCount: _emlakListe.length,
  //       );
  //       // mText = "Press to hide";
  //     }
  //   });
  // }
  String odaSayisiText = "Tümü";
  String bulunduguKatText = "Tümü";
  String esyaText = "Tümü";
  String esyaText1 = "";
  int pageIndex = 0;
  String enAz = "";
  String enCok = "";
  String fiyatText = "Tümü";
  String siteAdi = "";
  String ilcelerText = "Tümü";

  PageController _pageController = PageController(initialPage: 0);

  SingingCharacter _character = SingingCharacter.zero;
  EsyaCharacter _esyacharacter = EsyaCharacter.zero;
  GorunumCharacter _characterr =
      ProjelerScreen.a == true ? GorunumCharacter.one : GorunumCharacter.zero;

  List<Esya> _esyaListe = [];

  Future<List<Esya>> fetchEsyaListe() async {
    // var url =
    //     "file:///C:/Users/oozge/OneDrive/Masa%C3%BCst%C3%BC/emlakexample.json";
    // var response = await http.get(url);
    List<Esya> esyaListe = [];

    var response =
        """[{"ID":0,"EsyaAdi":"Tümü"},{"ID":1,"EsyaAdi":"Eşyalı"},{"ID":2,"EsyaAdi":"Eşyasız"}]"""; // Eşya

    // if (response.statusCode == 200) {
    // var emlakListeJson = json.decode(response.body);
    var esyaListeJson = json.decode(response);

    for (var esyaJson in esyaListeJson) {
      esyaListe.add(Esya.fromJson(esyaJson));
    }
    // }
    // var order = await emlakListe.length != 0;
    return esyaListe;
  }

  List<OdaSayisi> _odaListe = [];

  Future<List<OdaSayisi>> fetchOdaListe() async {
    // var url =
    //     "file:///C:/Users/oozge/OneDrive/Masa%C3%BCst%C3%BC/emlakexample.json";
    // var response = await http.get(url);
    //
    String url = 'IlanBilgileri/GetOdaSayisi';
    Map map = {'UserName': '', 'Password': ''};

    var response = await apiRequest(url, map);

    List<OdaSayisi> odaListe = [];

    var odaListeJson = json.decode(response);

    for (var odaJson in odaListeJson) {
      odaListe.add(OdaSayisi.fromJson(odaJson));
    }
    // }
    // var order = await emlakListe.length != 0;
    return odaListe;
  }

  List<BulunduguKat> _bulunduguKatListe = [];

  Future<List<BulunduguKat>> fetchKat() async {
    // var queryParameters = "{'UserName': 'emre', 'Password': '123456'}";
    // var uri = Uri(
    //     scheme: 'https',
    //     host: '192.168.1.121',
    //     path: '/IlanBilgileri/GetKatTurleri',
    //     // fragment: 'baz',
    //     query: queryParameters);
    // // var uri = Uri.http(
    // // '192.168.1.121', '/IlanBilgileri/GetKatTurleri', queryParameters);
    // var headers = {HttpHeaders.contentTypeHeader: 'application/json'};
    // var response = await http.get(uri, headers: headers);

    String url = 'IlanBilgileri/GetKatTurleri';
    Map map = {'UserName': '', 'Password': ''};

    var response = await apiRequest(url, map);

    List<BulunduguKat> bulunduguKatListe = [];

    var bulunduguKatListeJson = json.decode(response);

    for (var bulunduguKatJson in bulunduguKatListeJson) {
      bulunduguKatListe.add(BulunduguKat.fromJson(bulunduguKatJson));
    }
    // }
    // var order = await emlakListe.length != 0;
    return bulunduguKatListe;
  }

  List<EmlakData> _emlakListe = [];

  Future<List<EmlakData>> fetchEmlakListe() async {
    // var url =
    //     "file:///C:/Users/oozge/OneDrive/Masa%C3%BCst%C3%BC/emlakexample.json";
    // var response = await http.get(url);
    List<EmlakData> emlakListe = [];

    String url = 'IlanBilgileri/GetIlanlar';
    Map map = getIlanForm(
        "",
        "",
        ProjelerScreen.ilanTuru,
        ProjelerScreen.ilanTipi,
        null,
        ProjelerScreen.ilceId,
        ProjelerScreen.mahalleId,
        ProjelerScreen.odaSayisiIdleri,
        ProjelerScreen.bulunduguKatIdleri,
        ProjelerScreen.enAzFiyat,
        ProjelerScreen.enCokFiyat,
        ProjelerScreen.esyaliId,
        ProjelerScreen.siteAdi,
        ProjelerScreen.aramaMetni,
        ProjelerScreen.siralama); //{'UserName': '', 'Password': ''};

    var response = await apiRequest(url, map);
    if (response != "") {
      var emlakListeJson = json.decode(response);

      for (var emlakJson in emlakListeJson) {
        emlakListe.add(EmlakData.fromJson(emlakJson));
      }
      // }
      // var order = await emlakListe.length != 0;
      ProjelerScreen.aramaMetni = "";
      return emlakListe;
    }
  }

  @override
  void initState() {
    // ProjelerScreen.ilceId = "";
    // ProjelerScreen.mahalleId = "";
    // ProjelerScreen.odaSayisiIdleri = "";
    // ProjelerScreen.bulunduguKatIdleri = "";
    // ProjelerScreen.enAzFiyat = 0;
    // ProjelerScreen.enCokFiyat = 0;
    // ProjelerScreen.esyaliId = 0;
    // ProjelerScreen.siteAdi = "";
    // ProjelerScreen.aramaMetni = "";
    // ProjelerScreen.siralama = 0;
    fetchEmlakListe().then((value) {
      setState(() {
        _emlakListe.addAll(value);
      });
    });
    // fetchSemt().then((value) {
    //   setState(() {
    //     _semtListe.addAll(value);
    //   });
    // });

    // fetchEsyaListe().then((value) {
    //   setState(() {
    //     _esyaListe.addAll(value);
    //   });
    // });
    fetchOdaListe().then((value) {
      setState(() {
        _odaListe.addAll(value);
      });
    });
    // fetchSite().then((value) {
    //   setState(() {
    //     _siteListe.addAll(value);
    //   });
    // });
    fetchKat().then((value) {
      setState(() {
        _bulunduguKatListe.addAll(value);
      });
    });
    // fetchIlceListe().then((value) {
    //   setState(() {
    //     _ilceListe.addAll(value);
    //   });
    // });

    // fetchIlceListe
    super.initState();

    // WidgetsBinding.instance.addObserver(LifecycleEventHandler(
    //     resumeCallBack: () async => setState(() {
    //           // do something
    //           ilcelerText = FiltrelemeScreen.ilcelerText;
    //         })));
  }

  void _onPresseddd() {
    setState(() {
      ProjelerScreen.b = false;
      _emlakListe = [];
      fetchEmlakListe().then((value) {
        setState(() {
          _emlakListe.addAll(value);
        });
      });
    });
    Navigator.pop(context, true);
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    // showAlertDialogOda(BuildContext context) {
    //   // int _radioValue1 = 0;
    //   // set up the button
    //   Widget iptalButton = TextButton(
    //     child: Text("VAZGEÇ"),
    //     onPressed: () => Navigator.pop(context, true),
    //   );
    //   Widget okButton = TextButton(
    //     onPressed: () {
    //       Navigator.pop(context, false);
    //       setState(() {
    //         String odaIdleri = "";
    //         odaSayisiText = "";
    //         // countIlce = 0;
    //         for (var i = 0; i < _odaListe.length; i++) {
    //           if (_odaListe[i].isCheck == true) {
    //             if (odaSayisiText.length > 0) {
    //               odaSayisiText += ", ";
    //               odaIdleri += ",";
    //             }
    //             odaIdleri += _odaListe[i].iD.toString();
    //             if (odaSayisiText.length <= 39) {
    //               odaSayisiText += _odaListe[i].ad;
    //             } else {
    //               odaSayisiText = odaSayisiText + "...";
    //             }
    //           }
    //         }
    //       });
    //     },
    //     child: Text("TAMAM"),
    //   );

    //   showDialog(
    //       context: context,
    //       builder: (BuildContext context) {
    //         return StatefulBuilder(
    //           builder: (context, setState) {
    //             return AlertDialog(
    //               title: Text("ODA SAYISI"),
    //               content: Container(
    //                   width: MediaQuery.of(context).size.width,
    //                   height: MediaQuery.of(context).size.height,
    //                   child: Column(mainAxisSize: MainAxisSize.min, children: <
    //                       Widget>[
    //                     Expanded(
    //                       child: ListView.builder(
    //                           // scrollDirection: Axis.horizontal,
    //                           itemCount: _odaListe.length,
    //                           itemBuilder: (BuildContext context, int index) {
    //                             return new Card(
    //                               child: new Container(
    //                                 // alignment: Alignment.center,
    //                                 // padding: EdgeInsets.all(0.0),
    //                                 // padding: new EdgeInsets.all(10.0),
    //                                 child: Column(
    //                                   // mainAxisAlignment: MainAxisAlignment.spaceBetween,
    //                                   children: <Widget>[
    //                                     new CheckboxListTile(
    //                                         activeColor: Colors.pink[300],
    //                                         dense: true,
    //                                         //font change
    //                                         title: new Text(
    //                                           _odaListe[index].ad,
    //                                           style: TextStyle(
    //                                               fontSize: 14,
    //                                               fontWeight: FontWeight.w600,
    //                                               letterSpacing: 0.5),
    //                                         ),
    //                                         value: _odaListe[index].isCheck,
    //                                         onChanged: (bool val) {
    //                                           // itemChange(val, index);
    //                                           setState(() {
    //                                             _odaListe[index].isCheck = val;
    //                                           });
    //                                         })
    //                                   ],
    //                                 ),
    //                               ),
    //                             );
    //                           }),
    //                     )
    //                   ])),
    //               actions: [
    //                 okButton,
    //                 iptalButton,
    //               ],
    //               //);
    //               // }
    //             );
    //           },
    //         );
    //       }).then((_) => setState(() {}));
    // }

    ///
    // showAlertDialogBulunduguKat(BuildContext context) {
    //   // int _radioValue1 = 0;
    //   // set up the button
    //   Widget iptalButton = TextButton(
    //     child: Text("VAZGEÇ"),
    //     onPressed: () => Navigator.pop(context, true),
    //   );
    //   Widget okButton = TextButton(
    //     onPressed: () {
    //       Navigator.pop(context, false);
    //       setState(() {
    //         String bulunduguKatIdleri = "";
    //         bulunduguKatText = "";
    //         // countIlce = 0;
    //         for (var i = 0; i < _bulunduguKatListe.length; i++) {
    //           if (_bulunduguKatListe[i].isCheck == true) {
    //             if (bulunduguKatText.length > 0) {
    //               bulunduguKatText += ", ";
    //               bulunduguKatIdleri += ",";
    //             }
    //             bulunduguKatIdleri += _bulunduguKatListe[i].iD.toString();
    //             if (bulunduguKatText.length <= 39) {
    //               bulunduguKatText += _bulunduguKatListe[i].ad;
    //             } else {
    //               bulunduguKatText = bulunduguKatText + "...";
    //             }
    //           }
    //         }
    //       });
    //     },
    //     child: Text("TAMAM"),
    //   );

    //   showDialog(
    //       context: context,
    //       builder: (BuildContext context) {
    //         return StatefulBuilder(
    //           builder: (context, setState) {
    //             return AlertDialog(
    //               title: Text("BULUNDUĞU KAT"),
    //               content: Container(
    //                   width: MediaQuery.of(context).size.width,
    //                   height: MediaQuery.of(context).size.height,
    //                   child: Column(mainAxisSize: MainAxisSize.min, children: <
    //                       Widget>[
    //                     Expanded(
    //                       child: ListView.builder(
    //                           // scrollDirection: Axis.horizontal,
    //                           itemCount: _bulunduguKatListe.length,
    //                           itemBuilder: (BuildContext context, int index) {
    //                             return new Card(
    //                               child: new Container(
    //                                 // alignment: Alignment.center,
    //                                 // padding: EdgeInsets.all(0.0),
    //                                 // padding: new EdgeInsets.all(10.0),
    //                                 child: Column(
    //                                   // mainAxisAlignment: MainAxisAlignment.spaceBetween,
    //                                   children: <Widget>[
    //                                     new CheckboxListTile(
    //                                         activeColor: Colors.pink[300],
    //                                         dense: true,
    //                                         //font change
    //                                         title: new Text(
    //                                           _bulunduguKatListe[index].ad,
    //                                           style: TextStyle(
    //                                               fontSize: 14,
    //                                               fontWeight: FontWeight.w600,
    //                                               letterSpacing: 0.5),
    //                                         ),
    //                                         value: _bulunduguKatListe[index]
    //                                             .isCheck,
    //                                         onChanged: (bool val) {
    //                                           // itemChange(val, index);
    //                                           setState(() {
    //                                             _bulunduguKatListe[index]
    //                                                 .isCheck = val;
    //                                           });
    //                                         })
    //                                   ],
    //                                 ),
    //                               ),
    //                             );
    //                           }),
    //                     )
    //                   ])),
    //               actions: [
    //                 okButton,
    //                 iptalButton,
    //               ],
    //               //);
    //               // }
    //             );
    //           },
    //         );
    //       }).then((_) => setState(() {}));
    // }

    ///

    ///
    showAlertDialogg(BuildContext context) {
      int _radioValue1 = 0;
      // set up the button
      Widget okButtonn = TextButton(
        child: Text("VAZGEÇ"),
        onPressed: () => Navigator.pop(context, true),
      );

      showDialog(
        context: context,
        builder: (BuildContext context) {
          return StatefulBuilder(builder: (context, setState) {
            return AlertDialog(
              title: Text("Görünüm Tercihi"),
              content: Container(
                child: new Column(
                  children: <Widget>[
                    RadioListTile<GorunumCharacter>(
                      title: const Text('Liste'),
                      value: GorunumCharacter.zero,
                      groupValue: _characterr,
                      onChanged: (GorunumCharacter value) {
                        setState(() {
                          _radioValue1 = value.index;
                          ProjelerScreen.a = false;
                          // _changed(false, "a");

                          print(_radioValue1);
                          _characterr = value;
                          Navigator.pop(context, true);
                          // Navigator.restorablePopAndPushNamed(
                          //     context, ProjelerScreen.routeName);

                          // Navigator.popAndPushNamed(
                          //     context, ProjelerScreen.routeName);
                        });
                      },
                    ),
                    RadioListTile<GorunumCharacter>(
                      title: const Text('Detaylı Liste'),
                      value: GorunumCharacter.one,
                      groupValue: _characterr,
                      onChanged: (GorunumCharacter value) {
                        setState(() {
                          _radioValue1 = value.index;
                          ProjelerScreen.a = true;
                          print(_radioValue1);
                          _characterr = value;
                          Navigator.pop(context, true);
                          //_changed(true, "a");
                          // Navigator.restorablePopAndPushNamed(
                          //     context, ProjelerScreen.routeName);
                          // Navigator.popAndPushNamed(
                          //     context, ProjelerScreen.routeName);
                        });
                      },
                    ),
                    // ProjelerScreen.a == true
                    //     ? RadioListTile<GorunumCharacter>(
                    //         title: const Text('Liste'),
                    //         value: GorunumCharacter.zero,
                    //         groupValue: _characterr,
                    //         selected: false,
                    //         onChanged: (GorunumCharacter value) {
                    //           setState(() {
                    //             _radioValue1 = value.index;
                    //             ProjelerScreen.a = false;
                    //             // _changed(false, "a");

                    //             print(_radioValue1);
                    //             _characterr = value;

                    //             Navigator.popAndPushNamed(
                    //                 context, ProjelerScreen.routeName);
                    //           });
                    //         },
                    //       )
                    //     : RadioListTile<GorunumCharacter>(
                    //         title: const Text('Liste'),
                    //         value: GorunumCharacter.zero,
                    //         groupValue: _characterr,
                    //         selected: true,
                    //         onChanged: (GorunumCharacter value) {
                    //           setState(() {
                    //             _radioValue1 = value.index;
                    //             ProjelerScreen.a = false;
                    //             // _changed(false, "a");

                    //             print(_radioValue1);
                    //             _characterr = value;

                    //             Navigator.popAndPushNamed(
                    //                 context, ProjelerScreen.routeName);
                    //           });
                    //         },
                    //       ),
                    // ProjelerScreen.a == true
                    //     ? RadioListTile<GorunumCharacter>(
                    //         title: const Text('Detaylı Liste'),
                    //         value: GorunumCharacter.one,
                    //         groupValue: _characterr,
                    //         selected: true,
                    //         onChanged: (GorunumCharacter value) {
                    //           setState(() {
                    //             _radioValue1 = value.index;
                    //             ProjelerScreen.a = true;
                    //             print(_radioValue1);
                    //             _characterr = value;
                    //             //_changed(true, "a");

                    //             Navigator.popAndPushNamed(
                    //                 context, ProjelerScreen.routeName);
                    //           });
                    //         },
                    //       )
                    //     : RadioListTile<GorunumCharacter>(
                    //         title: const Text('Detaylı Liste'),
                    //         value: GorunumCharacter.one,
                    //         groupValue: _characterr,
                    //         selected: false,
                    //         onChanged: (GorunumCharacter value) {
                    //           setState(() {
                    //             _radioValue1 = value.index;
                    //             ProjelerScreen.a = true;
                    //             print(_radioValue1);
                    //             _characterr = value;
                    //             //_changed(true, "a");

                    //             Navigator.popAndPushNamed(
                    //                 context, ProjelerScreen.routeName);
                    //           });
                    //         },
                    //       ),
                  ],
                ),
              ),
              actions: [
                okButtonn,
              ],
            );
          });
        },
      ).then((_) => setState(() {}));
    }

    /////
    // showAlertDialogEsya(BuildContext context) {
    //   // ValueNotifier<Siralama> _selectedItem =
    //   //     new ValueNotifier<Siralama>(Siralama.Gelismis);
    //   // int index = 0;
    //   int _radioValue1 = 0;

    //   // int _handleRadioValueChange1 = 0;
    //   // set up the button
    //   Widget iptalButton = TextButton(
    //     child: Text("VAZGEÇ"),
    //     onPressed: () => Navigator.pop(context, true),
    //   );
    //   Widget okButton = TextButton(
    //     onPressed: () {
    //       Navigator.pop(context, false);
    //       setState(() {
    //         String esyaId = "$iD";
    //         esyaText = esyaText1;
    //         // countIlce = 0;
    //         // for (var i = 0; i < _bulunduguKatListe.length; i++) {
    //         //   if (_bulunduguKatListe[i].isCheck == true) {
    //         //     if (bulunduguKatText.length > 0) {
    //         //       bulunduguKatText += ", ";
    //         //       bulunduguKatIdleri += ",";
    //         //     }
    //         //     bulunduguKatIdleri += _bulunduguKatListe[i].iD.toString();
    //         //     if (bulunduguKatText.length <= 39) {
    //         //       bulunduguKatText += _bulunduguKatListe[i].ad;
    //         //     } else {
    //         //       bulunduguKatText = bulunduguKatText + "...";
    //         //     }
    //         //   }
    //         // }
    //       });
    //     },
    //     child: Text("TAMAM"),
    //   );

    //   showDialog(
    //     context: context,
    //     builder: (BuildContext context) {
    //       return StatefulBuilder(builder: (context, setState) {
    //         return AlertDialog(
    //           title: Text("EŞYA DURUMU"),
    //           content: Container(
    //             child: new Column(
    //               children: <Widget>[
    //                 RadioListTile<EsyaCharacter>(
    //                   title: const Text('Tümü'),
    //                   value: EsyaCharacter.zero,
    //                   groupValue: _esyacharacter,
    //                   onChanged: (EsyaCharacter value) {
    //                     esyaText1 = "";
    //                     setState(() {
    //                       _radioValue1 = value.index;
    //                       // print(_radioValue1);
    //                       _esyacharacter = value;
    //                       esyaText1 = "Tümü";
    //                       iD = 2;
    //                     });
    //                   },
    //                 ),
    //                 RadioListTile<EsyaCharacter>(
    //                   title: const Text('Eşyalı'),
    //                   value: EsyaCharacter.one,
    //                   groupValue: _esyacharacter,
    //                   onChanged: (EsyaCharacter value) {
    //                     esyaText1 = "";
    //                     setState(() {
    //                       _radioValue1 = value.index;
    //                       // print(_radioValue1);
    //                       _esyacharacter = value;
    //                       iD = 1;
    //                       esyaText1 = "Eşyalı";
    //                     });
    //                   },
    //                 ),
    //                 RadioListTile<EsyaCharacter>(
    //                   title: const Text('Eşyasız'),
    //                   value: EsyaCharacter.two,
    //                   groupValue: _esyacharacter,
    //                   onChanged: (EsyaCharacter value) {
    //                     esyaText1 = "";
    //                     setState(() {
    //                       _radioValue1 = value.index;
    //                       // print(_radioValue1);
    //                       _esyacharacter = value;
    //                       esyaText1 = "Eşyasız";
    //                       iD = 0;
    //                     });
    //                   },
    //                 ),
    //               ],
    //             ),
    //           ),
    //           actions: [okButton, iptalButton],
    //         );
    //       });
    //     },
    //   ).then((_) => setState(() {}));
    // }

//////
    showAlertDialog(BuildContext context) {
      // ValueNotifier<Siralama> _selectedItem =
      //     new ValueNotifier<Siralama>(Siralama.Gelismis);
      // int index = 0;
      int _radioValue1 = 0;

      // int _handleRadioValueChange1 = 0;
      // set up the button
      Widget okButton = TextButton(
        child: Text("VAZGEÇ"),
        onPressed: () => Navigator.pop(context, true),
      );

      showDialog(
        context: context,
        builder: (BuildContext context) {
          return StatefulBuilder(builder: (context, setState) {
            return AlertDialog(
              title: Text("Sıralama"),
              content: Container(
                child: SingleChildScrollView(
                  child: new Column(
                    children: <Widget>[
                      RadioListTile<SingingCharacter>(
                        title: const Text('Gelişmiş Sıralama'),
                        value: SingingCharacter.zero,
                        groupValue: _character,
                        onChanged: (SingingCharacter value) {
                          setState(() {
                            _radioValue1 = value.index;
                            ProjelerScreen.siralama = 0;
                            print(_radioValue1);
                            _character = value;
                            _onPresseddd();
                          });
                        },
                      ),
                      RadioListTile<SingingCharacter>(
                        title: const Text('Fiyata göre(Önce en yüksek)'),
                        value: SingingCharacter.one,
                        groupValue: _character,
                        onChanged: (SingingCharacter value) {
                          setState(() {
                            _radioValue1 = value.index;
                            ProjelerScreen.siralama = 1;
                            print(_radioValue1);
                            _character = value;
                            _onPresseddd();
                          });
                        },
                      ),
                      RadioListTile<SingingCharacter>(
                        title: const Text('Fiyata göre(Önce en düşük)'),
                        value: SingingCharacter.two,
                        groupValue: _character,
                        onChanged: (SingingCharacter value) {
                          setState(() {
                            _radioValue1 = value.index;
                            ProjelerScreen.siralama = 2;
                            print(_radioValue1);
                            _character = value;
                            _onPresseddd();
                          });
                        },
                      ),
                      RadioListTile<SingingCharacter>(
                        title: const Text('Tarihe göre(Önce en yeni ilan)'),
                        value: SingingCharacter.three,
                        groupValue: _character,
                        onChanged: (SingingCharacter value) {
                          setState(() {
                            _radioValue1 = value.index;
                            ProjelerScreen.siralama = 3;
                            print(_radioValue1);
                            _character = value;
                            _onPresseddd();
                          });
                        },
                      ),
                      RadioListTile<SingingCharacter>(
                        title: const Text('Tarihe göre(Önce en eski ilan)'),
                        value: SingingCharacter.four,
                        groupValue: _character,
                        onChanged: (SingingCharacter value) {
                          setState(() {
                            _radioValue1 = value.index;
                            ProjelerScreen.siralama = 4;
                            print(_radioValue1);
                            _character = value;
                            _onPresseddd();
                          });
                        },
                      ),
                    ],
                  ),
                ),
              ),
              actions: [
                okButton,
              ],
            );
          });
        },
      ).then((_) => setState(() {}));
    }

    rakamMi(String str) {
      RegExp _numeric = new RegExp(r'^-?[0-9]+$');

      return _numeric.hasMatch(str);
    }

    Widget _buildFiyatEnCok() {
      return TextFormField(
        decoration: InputDecoration(labelText: 'En Çok'),
        keyboardType: TextInputType.number,
        initialValue: enCok,
        // validator: (String value) {
        //   // if (value.isEmpty || RakamMi(value) == true || value == null) {
        //   //   return null;
        //   // }
        // },
        onChanged: (String value) {
          enCok = value;
          ProjelerScreen.enCokFiyat = double.parse(value ?? "0");
        },
      );
    }

    Widget _buildSiteAdi() {
      return TextFormField(
        decoration: InputDecoration(
            labelText: 'Site Adı', labelStyle: TextStyle(color: Colors.grey)),
        onChanged: (String value) {
          value = value?.trim();
          siteAdi = value;
          ProjelerScreen.siteAdi = siteAdi;
        },
      );
    }

    Widget _buildFiyatEnAz() {
      return TextFormField(
        decoration: InputDecoration(labelText: 'En Az'),
        keyboardType: TextInputType.number,
        initialValue: enAz,
        // validator: (String value) {
        //   // if (value.isEmpty == true ||
        //   //     RakamMi(value) == true ||
        //   //     value == null) {
        //   //   return null;
        //   // }
        // },
        onChanged: (String value) {
          enAz = value;
          ProjelerScreen.enAzFiyat = double.parse(value ?? "0");
        },
      );
    }

    // showAlertDialogFiyat(BuildContext context) {
    //   // int _radioValue1 = 0;
    //   // set up the button
    //   Widget iptalButton = TextButton(
    //     child: Text("VAZGEÇ"),
    //     onPressed: () => Navigator.pop(context, true),
    //   );
    //   Widget okButton = TextButton(
    //     onPressed: () {
    //       setState(() {
    //         fiyatText = "";
    //         print("$enAz" + " en Az");
    //         print("$enCok" + " en çok");

    //         if (enAz == "" && enCok != "") {
    //           fiyatText = ("En çok " + "$enCok" + " TL");
    //         } else if (enAz != "" && enCok == "") {
    //           fiyatText = ("En az " + "$enAz" + " TL");
    //         } else if (enAz != "" && enCok != "") {
    //           fiyatText = ("$enAz" + " TL - " + "$enCok" + " TL arası");
    //         }
    //         // if ((enCok.isEmpty == true || enCok == null) &&
    //         //     enAz.isNotEmpty == true) {
    //         //   fiyatText = ("En az" + " " + "$enAz" + " " + "TL");
    //         // }
    //         // if (enAz.isNotEmpty == true && enCok.isNotEmpty == true) {
    //         //   fiyatText = ("$enAz" +
    //         //       " " +
    //         //       "TL" +
    //         //       " " +
    //         //       "-" +
    //         //       "$enCok" +
    //         //       " " +
    //         //       "TL arası");
    //         // }

    //         // fiyatText = "";
    //         // print(enAz);
    //         // print(enCok);
    //         // if ((enAz.isEmpty == true || enAz == null) &&
    //         //     enCok.isNotEmpty == true) {
    //         //   fiyatText = ("En çok" + " " + "$enCok" + " " + "TL");
    //         // }
    //         // if ((enCok.isEmpty == true || enCok == null) &&
    //         //     enAz.isNotEmpty == true) {
    //         //   fiyatText = ("En az" + " " + "$enAz" + " " + "TL");
    //         // }
    //         // if (enAz.isNotEmpty == true && enCok.isNotEmpty == true) {
    //         //   fiyatText = ("$enAz" +
    //         //       " " +
    //         //       "TL" +
    //         //       " " +
    //         //       "-" +
    //         //       "$enCok" +
    //         //       " " +
    //         //       "TL arası");
    //         // }

    //         Navigator.pop(context, false);
    //       });
    //     },
    //     child: Text("TAMAM"),
    //   );

    //   showDialog(
    //       context: context,
    //       builder: (BuildContext context) {
    //         return StatefulBuilder(
    //           builder: (context, setState) {
    //             return AlertDialog(
    //               title: Text("FİYAT"),
    //               content: Container(
    //                   width: MediaQuery.of(context).size.width,
    //                   height: MediaQuery.of(context).size.height,
    //                   child: Column(
    //                       mainAxisSize: MainAxisSize.min,
    //                       children: <Widget>[
    //                         _buildFiyatEnAz(),
    //                         _buildFiyatEnCok(),
    //                       ])),
    //               actions: [
    //                 okButton,
    //                 iptalButton,
    //               ],
    //               //);
    //               // }
    //             );
    //           },
    //         );
    //       }).then((_) => setState(() {}));
    // }

    showAlertDialogFiltre(BuildContext context) {
      // int _radioValue1 = 0;
      // set up the button
      // Widget iptalButton = FlatButton(
      //   child: Text("VAZGEÇ"),
      //   onPressed: () => Navigator.pop(context, true),
      // );
      // Widget okButton = FlatButton(
      //   onPressed: () {
      //     Navigator.pop(context, false);
      //     setState(() {});
      //   },
      //   child: Text("TAMAM"),
      // );

      showDialog(
          context: context,
          builder: (BuildContext context) {
            // var height = MediaQuery.of(context).size.height;
            // var width = MediaQuery.of(context).size.width;
            return StatefulBuilder(
              builder: (context, setState) {
                return AlertDialog(
                  content: Container(
                      // height: height - 100,
                      // width: width,
                      child: SingleChildScrollView(
                          child: Column(children: [
                    // Expanded(
                    // child:
                    Container(
                      // color: Colors.grey,
                      child: Column(children: <Widget>[
                        Text(
                          "SEÇENEKLER",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 20),
                        ),
                        Divider(),
                        TextButton(
                            onPressed: () async {
                              var received = await Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (_) => FiltrelemeScreen()));
                              // Navigator.pushNamed(context, FiltrelemeScreen.routeName);
                              setState(() {
                                ilcelerText = FiltrelemeScreen.ilcelerText;
                              });
                            },
                            child: Column(children: <Widget>[
                              Text("Adres",
                                  style: TextStyle(
                                    fontSize: 20,
                                    color: Colors.black,
                                  )),
                              Row(children: <Widget>[
                                Flexible(
                                  child: RichText(
                                    overflow: TextOverflow.ellipsis,
                                    strutStyle: StrutStyle(fontSize: 15.0),
                                    text: TextSpan(
                                        style: TextStyle(color: Colors.grey),
                                        text: '$ilcelerText'),
                                  ),
                                ),
                                // Text('$ilcelerText',
                                //     style: TextStyle(
                                //       fontSize: 15,
                                //       color: Colors.grey,
                                //     )),
                                // Spacer(),
                                // Icon(
                                //   Icons.crop_din_outlined,
                                //   size: 6.0,
                                //   color: Colors.grey,
                                // ),
                                // Icon(
                                //   Icons.crop_din_outlined,
                                //   size: 6.0,
                                //   color: Colors.grey,
                                // ),
                                // Icon(
                                //   Icons.crop_din_outlined,
                                //   size: 6.0,
                                //   color: Colors.grey,
                                // ),
                              ])
                            ])),
                        TextButton(
                            onPressed: () {
                              // showAlertDialogFiyat(context);
                              showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return StatefulBuilder(
                                      builder: (context, setState) {
                                        return AlertDialog(
                                          title: Text("FİYAT"),
                                          content: Container(
                                              width: MediaQuery.of(context)
                                                  .size
                                                  .width,
                                              height: MediaQuery.of(context)
                                                  .size
                                                  .height,
                                              child: Column(
                                                  mainAxisSize:
                                                      MainAxisSize.min,
                                                  children: <Widget>[
                                                    _buildFiyatEnAz(),
                                                    _buildFiyatEnCok(),
                                                  ])),
                                          actions: [
                                            TextButton(
                                              onPressed: () {
                                                setState(() {
                                                  fiyatText = "";
                                                  print("$enAz" + " en Az");
                                                  print("$enCok" + " en çok");

                                                  if (enAz == "" &&
                                                      enCok != "") {
                                                    fiyatText = ("En çok " +
                                                        "$enCok" +
                                                        " TL");
                                                  } else if (enAz != "" &&
                                                      enCok == "") {
                                                    fiyatText = ("En az " +
                                                        "$enAz" +
                                                        " TL");
                                                  } else if (enAz != "" &&
                                                      enCok != "") {
                                                    fiyatText = ("$enAz" +
                                                        " TL - " +
                                                        "$enCok" +
                                                        " TL arası");
                                                  }
                                                  // if ((enCok.isEmpty == true || enCok == null) &&
                                                  //     enAz.isNotEmpty == true) {
                                                  //   fiyatText = ("En az" + " " + "$enAz" + " " + "TL");
                                                  // }
                                                  // if (enAz.isNotEmpty == true && enCok.isNotEmpty == true) {
                                                  //   fiyatText = ("$enAz" +
                                                  //       " " +
                                                  //       "TL" +
                                                  //       " " +
                                                  //       "-" +
                                                  //       "$enCok" +
                                                  //       " " +
                                                  //       "TL arası");
                                                  // }

                                                  // fiyatText = "";
                                                  // print(enAz);
                                                  // print(enCok);
                                                  // if ((enAz.isEmpty == true || enAz == null) &&
                                                  //     enCok.isNotEmpty == true) {
                                                  //   fiyatText = ("En çok" + " " + "$enCok" + " " + "TL");
                                                  // }
                                                  // if ((enCok.isEmpty == true || enCok == null) &&
                                                  //     enAz.isNotEmpty == true) {
                                                  //   fiyatText = ("En az" + " " + "$enAz" + " " + "TL");
                                                  // }
                                                  // if (enAz.isNotEmpty == true && enCok.isNotEmpty == true) {
                                                  //   fiyatText = ("$enAz" +
                                                  //       " " +
                                                  //       "TL" +
                                                  //       " " +
                                                  //       "-" +
                                                  //       "$enCok" +
                                                  //       " " +
                                                  //       "TL arası");
                                                  // }

                                                  Navigator.pop(context, false);
                                                });
                                              },
                                              child: Text("TAMAM"),
                                            ),
                                            TextButton(
                                              child: Text("VAZGEÇ"),
                                              onPressed: () =>
                                                  Navigator.pop(context, true),
                                            ),
                                          ],
                                          //);
                                          // }
                                        );
                                      },
                                    );
                                  }).then((_) => setState(() {}));
                            },
                            child: Column(children: <Widget>[
                              Text("Fiyat",
                                  style: TextStyle(
                                    fontSize: 20,
                                    color: Colors.black,
                                  )),
                              Row(children: <Widget>[
                                Text('$fiyatText',
                                    softWrap: true,
                                    overflow: TextOverflow.clip,
                                    style: TextStyle(
                                      fontSize: 15,
                                      color: Colors.grey,
                                    )),
                                // Spacer(),
                                // Icon(
                                //   Icons.crop_din_outlined,
                                //   size: 6.0,
                                //   color: Colors.grey,
                                // ),
                                // Icon(
                                //   Icons.crop_din_outlined,
                                //   size: 6.0,
                                //   color: Colors.grey,
                                // ),
                                // Icon(
                                //   Icons.crop_din_outlined,
                                //   size: 6.0,
                                //   color: Colors.grey,
                                // ),
                              ])
                            ])),
                        Text(""),
                        Text(
                          "İLAN BİLGİLERİ",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 20),
                        ),
                        Divider(),
                        TextButton(
                            onPressed: () {
                              // showAlertDialogOda(context);
                              showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return StatefulBuilder(
                                      builder: (context, setState) {
                                        return AlertDialog(
                                          title: Text("ODA SAYISI"),
                                          content: Container(
                                              width: MediaQuery.of(context)
                                                  .size
                                                  .width,
                                              height: MediaQuery.of(context)
                                                  .size
                                                  .height,
                                              child: Column(
                                                  mainAxisSize:
                                                      MainAxisSize.min,
                                                  children: <Widget>[
                                                    Expanded(
                                                      child: ListView.builder(
                                                          // scrollDirection: Axis.horizontal,
                                                          itemCount:
                                                              _odaListe.length,
                                                          itemBuilder:
                                                              (BuildContext
                                                                      context,
                                                                  int index) {
                                                            return new Card(
                                                              child:
                                                                  new Container(
                                                                // alignment: Alignment.center,
                                                                // padding: EdgeInsets.all(0.0),
                                                                // padding: new EdgeInsets.all(10.0),
                                                                child: Column(
                                                                  // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                  children: <
                                                                      Widget>[
                                                                    new CheckboxListTile(
                                                                        activeColor:
                                                                            Colors.pink[
                                                                                300],
                                                                        dense:
                                                                            true,
                                                                        //font change
                                                                        title:
                                                                            new Text(
                                                                          _odaListe[index]
                                                                              .ad,
                                                                          style: TextStyle(
                                                                              fontSize: 14,
                                                                              fontWeight: FontWeight.w600,
                                                                              letterSpacing: 0.5),
                                                                        ),
                                                                        value: _odaListe[index]
                                                                            .isCheck,
                                                                        onChanged:
                                                                            (bool
                                                                                val) {
                                                                          // itemChange(val, index);
                                                                          setState(
                                                                              () {
                                                                            _odaListe[index].isCheck =
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
                                            TextButton(
                                              onPressed: () {
                                                setState(() {
                                                  String odaIdleri = "";
                                                  odaSayisiText = "";
                                                  // countIlce = 0;
                                                  for (var i = 0;
                                                      i < _odaListe.length;
                                                      i++) {
                                                    if (_odaListe[i].isCheck ==
                                                        true) {
                                                      if (odaIdleri == "") {
                                                        odaIdleri =
                                                            (_odaListe[i].iD ??
                                                                    "0")
                                                                .toString();
                                                      } else {
                                                        odaIdleri += "," +
                                                            (_odaListe[i].iD ??
                                                                    "0")
                                                                .toString();
                                                      }
                                                      if (odaSayisiText.length >
                                                          0) {
                                                        odaSayisiText += ", ";
                                                        // odaIdleri += ",";
                                                      }
                                                      // odaIdleri += _odaListe[i]
                                                      //     .iD
                                                      //     .toString();
                                                      if (odaSayisiText
                                                              .length <=
                                                          39) {
                                                        odaSayisiText +=
                                                            _odaListe[i].ad;
                                                      } else {
                                                        odaSayisiText =
                                                            odaSayisiText +
                                                                "...";
                                                      }
                                                    }
                                                  }
                                                  ProjelerScreen
                                                          .odaSayisiIdleri =
                                                      odaIdleri;
                                                });

                                                Navigator.pop(context, false);
                                              },
                                              child: Text("TAMAM"),
                                            ),
                                            TextButton(
                                              child: Text("VAZGEÇ"),
                                              onPressed: () =>
                                                  Navigator.pop(context, true),
                                            ),
                                          ],
                                          //);
                                          // }
                                        );
                                      },
                                    );
                                  }).then((_) => setState(() {}));
                            },
                            child: Column(children: <Widget>[
                              Text("Oda Sayısı",
                                  style: TextStyle(
                                    fontSize: 20,
                                    color: Colors.black,
                                  )),
                              Row(children: <Widget>[
                                Flexible(
                                  child: RichText(
                                    overflow: TextOverflow.ellipsis,
                                    strutStyle: StrutStyle(fontSize: 15.0),
                                    text: TextSpan(
                                        style: TextStyle(color: Colors.grey),
                                        text: '$odaSayisiText'),
                                  ),
                                ),
                                // Text("$odaSayisiText",
                                //     style: TextStyle(
                                //       fontSize: 15,
                                //       color: Colors.grey,
                                //     )),
                                // Spacer(),
                                // Icon(
                                //   Icons.crop_din_outlined,
                                //   size: 6.0,
                                //   color: Colors.grey,
                                // ),
                                // Icon(
                                //   Icons.crop_din_outlined,
                                //   size: 6.0,
                                //   color: Colors.grey,
                                // ),
                                // Icon(
                                //   Icons.crop_din_outlined,
                                //   size: 6.0,
                                //   color: Colors.grey,
                                // ),
                              ])
                            ])),
                        TextButton(
                            onPressed: () {
                              // showAlertDialogBulunduguKat(context);
                              showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return StatefulBuilder(
                                      builder: (context, setState) {
                                        return AlertDialog(
                                          title: Text("BULUNDUĞU KAT"),
                                          content: Container(
                                              width: MediaQuery.of(context)
                                                  .size
                                                  .width,
                                              height: MediaQuery.of(context)
                                                  .size
                                                  .height,
                                              child: Column(
                                                  mainAxisSize:
                                                      MainAxisSize.min,
                                                  children: <Widget>[
                                                    Expanded(
                                                      child: ListView.builder(
                                                          // scrollDirection: Axis.horizontal,
                                                          itemCount:
                                                              _bulunduguKatListe
                                                                  .length,
                                                          itemBuilder:
                                                              (BuildContext
                                                                      context,
                                                                  int index) {
                                                            return new Card(
                                                              child:
                                                                  new Container(
                                                                // alignment: Alignment.center,
                                                                // padding: EdgeInsets.all(0.0),
                                                                // padding: new EdgeInsets.all(10.0),
                                                                child: Column(
                                                                  // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                  children: <
                                                                      Widget>[
                                                                    new CheckboxListTile(
                                                                        activeColor:
                                                                            Colors.pink[
                                                                                300],
                                                                        dense:
                                                                            true,
                                                                        //font change
                                                                        title:
                                                                            new Text(
                                                                          _bulunduguKatListe[index]
                                                                              .ad,
                                                                          style: TextStyle(
                                                                              fontSize: 14,
                                                                              fontWeight: FontWeight.w600,
                                                                              letterSpacing: 0.5),
                                                                        ),
                                                                        value: _bulunduguKatListe[index]
                                                                            .isCheck,
                                                                        onChanged:
                                                                            (bool
                                                                                val) {
                                                                          // itemChange(val, index);
                                                                          setState(
                                                                              () {
                                                                            _bulunduguKatListe[index].isCheck =
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
                                            TextButton(
                                              onPressed: () {
                                                setState(() {
                                                  String bulunduguKatIdleri =
                                                      "";
                                                  bulunduguKatText = "";
                                                  // countIlce = 0;
                                                  for (var i = 0;
                                                      i <
                                                          _bulunduguKatListe
                                                              .length;
                                                      i++) {
                                                    if (_bulunduguKatListe[i]
                                                            .isCheck ==
                                                        true) {
                                                      if (bulunduguKatIdleri ==
                                                          "") {
                                                        bulunduguKatIdleri =
                                                            (_bulunduguKatListe[
                                                                            i]
                                                                        .iD ??
                                                                    "0")
                                                                .toString();
                                                      } else {
                                                        bulunduguKatIdleri += "," +
                                                            (_bulunduguKatListe[
                                                                            i]
                                                                        .iD ??
                                                                    "0")
                                                                .toString();
                                                      }
                                                      if (bulunduguKatText
                                                              .length >
                                                          0) {
                                                        bulunduguKatText +=
                                                            ", ";
                                                        // bulunduguKatIdleri += ",";
                                                      }
                                                      // bulunduguKatIdleri +=
                                                      //     _bulunduguKatListe[i]
                                                      //         .iD
                                                      //         .toString();
                                                      if (bulunduguKatText
                                                              .length <=
                                                          39) {
                                                        bulunduguKatText +=
                                                            _bulunduguKatListe[
                                                                    i]
                                                                .ad;
                                                      } else {
                                                        bulunduguKatText =
                                                            bulunduguKatText +
                                                                "...";
                                                      }
                                                    }
                                                  }
                                                  ProjelerScreen
                                                          .bulunduguKatIdleri =
                                                      bulunduguKatIdleri;
                                                });
                                                Navigator.pop(context, false);
                                              },
                                              child: Text("TAMAM"),
                                            ),
                                            TextButton(
                                              child: Text("VAZGEÇ"),
                                              onPressed: () =>
                                                  Navigator.pop(context, true),
                                            ),
                                          ],
                                          //);
                                          // }
                                        );
                                      },
                                    );
                                  }).then((_) => setState(() {}));
                            },
                            child: Column(children: <Widget>[
                              Text("Bulunduğu Kat",
                                  style: TextStyle(
                                    fontSize: 20,
                                    color: Colors.black,
                                  )),
                              Row(children: <Widget>[
                                Flexible(
                                  child: RichText(
                                    overflow: TextOverflow.ellipsis,
                                    strutStyle: StrutStyle(fontSize: 15.0),
                                    text: TextSpan(
                                        style: TextStyle(color: Colors.grey),
                                        text: '$bulunduguKatText'),
                                  ),
                                ),
                                // Text("$bulunduguKatText",
                                //     style: TextStyle(
                                //       fontSize: 15,
                                //       color: Colors.grey,
                                //     )),
                                // Spacer(),
                                // Icon(
                                //   Icons.crop_din_outlined,
                                //   size: 6.0,
                                //   color: Colors.grey,
                                // ),
                                // Icon(
                                //   Icons.crop_din_outlined,
                                //   size: 6.0,
                                //   color: Colors.grey,
                                // ),
                                // Icon(
                                //   Icons.crop_din_outlined,
                                //   size: 6.0,
                                //   color: Colors.grey,
                                // ),
                              ])
                            ])),
                        TextButton(
                            onPressed: () {
                              // showAlertDialogEsya(context);
                              int _radioValue1 = 0;
                              showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return StatefulBuilder(
                                      builder: (context, setState) {
                                    return AlertDialog(
                                      title: Text("EŞYA DURUMU"),
                                      content: Container(
                                        child: new Column(
                                          children: <Widget>[
                                            RadioListTile<EsyaCharacter>(
                                              title: const Text('Tümü'),
                                              value: EsyaCharacter.zero,
                                              groupValue: _esyacharacter,
                                              onChanged: (EsyaCharacter value) {
                                                esyaText1 = "";
                                                setState(() {
                                                  _radioValue1 = value.index;
                                                  ProjelerScreen.esyaliId = 0;
                                                  // print(_radioValue1);
                                                  _esyacharacter = value;
                                                  esyaText1 = "Tümü";
                                                  iD = 0;
                                                });
                                              },
                                            ),
                                            RadioListTile<EsyaCharacter>(
                                              title: const Text('Eşyalı'),
                                              value: EsyaCharacter.one,
                                              groupValue: _esyacharacter,
                                              onChanged: (EsyaCharacter value) {
                                                esyaText1 = "";
                                                setState(() {
                                                  _radioValue1 = value.index;
                                                  // print(_radioValue1);
                                                  _esyacharacter = value;
                                                  ProjelerScreen.esyaliId = 1;
                                                  iD = 1;
                                                  esyaText1 = "Eşyalı";
                                                });
                                              },
                                            ),
                                            RadioListTile<EsyaCharacter>(
                                              title: const Text('Eşyasız'),
                                              value: EsyaCharacter.two,
                                              groupValue: _esyacharacter,
                                              onChanged: (EsyaCharacter value) {
                                                esyaText1 = "";
                                                setState(() {
                                                  _radioValue1 = value.index;
                                                  ProjelerScreen.esyaliId = 2;
                                                  // print(_radioValue1);
                                                  _esyacharacter = value;
                                                  esyaText1 = "Eşyasız";
                                                  iD = 2;
                                                });
                                              },
                                            ),
                                          ],
                                        ),
                                      ),
                                      actions: [
                                        TextButton(
                                          onPressed: () {
                                            setState(() {
                                              String esyaId = "$iD";
                                              esyaText = esyaText1;
                                              // countIlce = 0;
                                              // for (var i = 0; i < _bulunduguKatListe.length; i++) {
                                              //   if (_bulunduguKatListe[i].isCheck == true) {
                                              //     if (bulunduguKatText.length > 0) {
                                              //       bulunduguKatText += ", ";
                                              //       bulunduguKatIdleri += ",";
                                              //     }
                                              //     bulunduguKatIdleri += _bulunduguKatListe[i].iD.toString();
                                              //     if (bulunduguKatText.length <= 39) {
                                              //       bulunduguKatText += _bulunduguKatListe[i].ad;
                                              //     } else {
                                              //       bulunduguKatText = bulunduguKatText + "...";
                                              //     }
                                              //   }
                                              // }
                                            });

                                            Navigator.pop(context, false);
                                          },
                                          child: Text("TAMAM"),
                                        ),
                                        TextButton(
                                          child: Text("VAZGEÇ"),
                                          onPressed: () =>
                                              Navigator.pop(context, true),
                                        )
                                      ],
                                    );
                                  });
                                },
                              ).then((_) => setState(() {}));
                            },
                            child: Column(children: <Widget>[
                              Text("Eşya Durumu",
                                  style: TextStyle(
                                    fontSize: 20,
                                    color: Colors.black,
                                  )),
                              Row(children: <Widget>[
                                Text("$esyaText",
                                    style: TextStyle(
                                      fontSize: 15,
                                      color: Colors.grey,
                                    )),
                                // Spacer(),
                                // Icon(
                                //   Icons.crop_din_outlined,
                                //   size: 6.0,
                                //   color: Colors.grey,
                                // ),
                                // Icon(
                                //   Icons.crop_din_outlined,
                                //   size: 6.0,
                                //   color: Colors.grey,
                                // ),
                                // Icon(
                                //   Icons.crop_din_outlined,
                                //   size: 6.0,
                                //   color: Colors.grey,
                                // ),
                              ])
                            ])),
                        Text("Site Adı",
                            style: TextStyle(
                              fontSize: 20,
                              color: Colors.black,
                            )),
                        _buildSiteAdi(),
                        // TextButton(
                        //   onPressed: () {
                        //     SearchField();
                        //   },
                        //   child: null,
                        //   style: TextButton.styleFrom(
                        //     primary: Colors.blue,
                        //   ),
                        // ),
                        SizedBox(
                          height: 20,
                        ),
                        TextButton(
                          onPressed: _onPresseddd,
                          child: Text("Sonuçları Göster"),
                          // color: Colors.blue,
                          style: TextButton.styleFrom(
                              primary: Colors.white,
                              backgroundColor: Colors.blue),
                        )
                      ]),
                      // color: Colors.blue,
                    )
                    // )
                  ]))),

                  // actions: [
                  //   okButton,
                  //   iptalButton,
                  // ],
                  //);
                  // }
                );
              },
            );
          }).then((_) => setState(() {}));
    }

    /*...*/
    return Scaffold(
        appBar: AppBar(
          title: Text(ProjelerScreen.ilanTurAdi),
          // flexibleSpace: Row(
          //   mainAxisAlignment: MainAxisAlignment.center,
          //   // crossAxisAlignment: CrossAxisAlignment.end,

          //   children: [
          //     Text(
          //       "Projeler",
          //       style: TextStyle(
          //           fontWeight: FontWeight.bold,
          //           color: Colors.white,
          //           fontSize: 20),
          //     ),
          //     Padding(
          //       padding: EdgeInsets.symmetric(
          //         vertical: 200,
          //       ),
          //     ),
          //   ],
          // ),
          actions: <Widget>[
            Padding(
                padding: EdgeInsets.only(right: 10.0),
                child: GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(context, AramalarScreen.routeName);
                  },
                  child: Icon(
                    Icons.search,
                    size: 26.0,
                  ),
                )),
            // Padding(
            //     padding: EdgeInsets.only(right: 24.0),
            //     child: GestureDetector(
            //       onTap: () {
            //         //   Share.share("hidayetbaysal.com'da incelediğim arama sonucunu sizinle paylaşmak istiyorum");
            //       },
            //       child: Icon(Icons.share),
            //     )),
          ],
        ),

        // Padding(
        //     padding: EdgeInsets.only(right: 24.0),
        //     child: GestureDetector(
        //       onTap: () {},
        //       child: Icon(Icons.map),
        //     )),

        // appBar: AppBar(
        //   title: Text("Projeler"),
        //   leading: GestureDetector(
        //     onTap: () {
        //       // Navigator.pushNamed(context, MainMenu.routeName);
        //     },
        //     // child: Icon(
        //     //   Icons.menu, // add custom icons also
        //     // ),
        //   ),
        //   actions: <Widget>[
        //     Padding(
        //         padding: EdgeInsets.only(right: 10.0),
        //         child: GestureDetector(
        //           onTap: () {},
        //           child: Icon(
        //             Icons.search,
        //             size: 26.0,
        //           ),
        //         )),
        //     Padding(
        //         padding: EdgeInsets.only(right: 24.0),
        //         child: GestureDetector(
        //           onTap: () {
        //             //   Share.share("hidayetbaysal.com'da incelediğim arama sonucunu sizinle paylaşmak istiyorum");
        //           },
        //           child: Icon(Icons.share),
        //         )),
        //     // Padding(
        //     //     padding: EdgeInsets.only(right: 24.0),
        //     //     child: GestureDetector(
        //     //       onTap: () {},
        //     //       child: Icon(Icons.map),
        //     //     )),
        //   ],
        // ),

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
                    Container(
                      // height: SizeConfig.safeBlockVertical * 10, //10 for example
                      //  width:SizeConfig.safeBlockHorizontal * 50,
                      width: SizeConfig.screenWidthWithoutSafeArea,

                      // transform: Matrix4.translationValues(0.0, -30.0, 0.0),
                      // height: double.INFINITY,
                      // width: double.INFINITY,
                      child: new Row(
                        children: <Widget>[
                          ButtonTheme(
                              minWidth: SizeConfig.safeBlockHorizontal * 33,
                              height: SizeConfig.safeBlockVertical * 7,
                              child: MaterialButton(
                                onPressed: () {
                                  showAlertDialogFiltre(context);

                                  setState(() {
                                    ProjelerScreen.b = true;
                                  });
                                  /*...*/
                                },
                                child: Column(children: <Widget>[
                                  Image.asset(
                                    'assets/a/filter.png',
                                    fit: BoxFit.cover,
                                    width: 22,
                                    height: 24,
                                    // height:
                                    //     SizeConfig.safeBlockVertical * 10, //10 for example
                                    // width:SizeConfig.safeBlockHorizontal * 50,
                                  ),
                                  Text(
                                    "Filtrele",
                                    style: TextStyle(
                                        color: Colors.grey,
                                        fontSize: SizeConfig.fontSize),
                                  ),
                                ]),
                                // style: ButtonStyle(
                                //   shadowColor: MaterialStateColor.resolveWith(
                                //       (states) => Colors.grey),
                                // ),
                              )),
                          ButtonTheme(
                              minWidth: SizeConfig.safeBlockHorizontal * 33,
                              height: SizeConfig.safeBlockVertical * 7,
                              child: MaterialButton(
                                // height:
                                //     SizeConfig.safeBlockVertical * 10, //10 for example

                                onPressed: () {
                                  showAlertDialog(context);
                                },
                                child: Column(children: <Widget>[
                                  Image.asset(
                                    'assets/a/sort.png',
                                    fit: BoxFit.cover,
                                    width: 22,
                                    height: 24,
                                    // height:
                                    //     SizeConfig.safeBlockVertical * 10, //10 for example
                                    // width:SizeConfig.safeBlockHorizontal * 50,
                                  ),
                                  Text(
                                    "Sırala",
                                    style: TextStyle(
                                        fontSize: SizeConfig.fontSize),
                                  ),
                                ]),
                                // style: TextButton.styleFrom(
                                //   primary: Colors.grey,
                                // ),
                              )),
                          ButtonTheme(
                              minWidth: SizeConfig.safeBlockHorizontal * 33,
                              height: SizeConfig.safeBlockVertical * 7,
                              child: MaterialButton(
                                onPressed: () {
                                  showAlertDialogg(context);

                                  //print("a");
                                },
                                child: Column(children: <Widget>[
                                  // Image.asset(
                                  //   'assets/a/sort.png',
                                  //   fit: BoxFit.cover,
                                  // width: 24,
                                  // height: 24,
                                  // ),
                                  Icon(
                                    Icons.view_module,
                                    // size:SizeConfig.safeBlockHorizontal * 50,
                                  ),
                                  // height:
                                  //     SizeConfig.safeBlockVertical * 10, //10 for example
                                  // width:SizeConfig.safeBlockHorizontal * 50,

                                  Text(
                                    "Görünüm",
                                    style: TextStyle(
                                        fontSize: SizeConfig.fontSize),
                                  ),
                                ]),
                                // style: TextButton.styleFrom(
                                //   primary: Colors.grey,
                                // ),
                              )),
                          // ButtonTheme(
                          //     minWidth: SizeConfig.safeBlockHorizontal * 25,
                          //     height: SizeConfig.safeBlockVertical * 7,
                          //     child: MaterialButton(
                          //       onPressed: () {},
                          //       child: Column(children: <Widget>[
                          //         // Image.asset(
                          //         //   'assets/a/sort.png',
                          //         //   fit: BoxFit.cover,
                          //         //   width: 24,
                          //         //   height: 24,
                          //         // ),
                          //         Icon(
                          //           Icons.add_alert,
                          //           // size:SizeConfig.safeBlockHorizontal * 50,
                          //         ),
                          //         Text(
                          //           "Kaydet",
                          //           style: TextStyle(
                          //               fontSize: SizeConfig.fontSize),
                          //         ),
                          //       ]),
                          //       // style: TextButton.styleFrom(
                          //       //   primary: Colors.grey,
                          //       // ),
                          //     )),
                        ],
                      ),
                    ),
                    // PageView(
                    //   scrollDirection: Axis.vertical,
                    //   pageSnapping: false,
                    //   physics: ClampingScrollPhysics(),
                    //   children: <Widget>[
                    Expanded(
                      child: ListView.builder(
                        itemCount: _emlakListe.length,
                        itemBuilder: (BuildContext context, int index) {
                          return Container(
                            height: 100,
                            child: Card(
                              child: ListTile(
                                title: Text(
                                  _emlakListe[index].title != null
                                      ? _emlakListe[index].title
                                      : '',
                                  style: TextStyle(fontSize: 12),
                                ),
                                subtitle: Column(
                                  children: <Widget>[
                                    Row(
                                      children: <Widget>[
                                        Icon(Icons.location_on),
                                        // Text(_emlakListe[index].district),
                                        Text(
                                          _emlakListe[index].district != null
                                              ? _emlakListe[index].district
                                              : '',
                                          textAlign: TextAlign.left,
                                          style: TextStyle(fontSize: 10),
                                        ),
                                        //  Text("          "),
                                        Spacer(),
                                        Text(
                                          _emlakListe[index].price != null
                                              ? _emlakListe[index].price
                                              : '',
                                          textAlign: TextAlign.right,
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 12),
                                        ),
                                      ],
                                    ),
                                    // Align(
                                    //   alignment: Alignment.centerRight,

                                    //   child: Text(_emlakListe[index].price),
                                    // ),

                                    ProjelerScreen.a == true
                                        ? Row(children: <Widget>[
                                            Text("."),
                                            Text(_emlakListe[index]
                                                        .numberOfRooms !=
                                                    null
                                                ? _emlakListe[index]
                                                    .numberOfRooms
                                                : ''),
                                            Text(" "),
                                            Text("."),
                                            Text(_emlakListe[index]
                                                        .area
                                                        .toString() !=
                                                    null
                                                ? _emlakListe[index]
                                                    .area
                                                    .toString()
                                                : ''),
                                            Text("m2(Brüt)"),
                                            Text(" "),
                                            Text("."),
                                            Text(
                                                _emlakListe[index].floor != null
                                                    ? _emlakListe[index].floor
                                                    : ''),
                                            // Text(".kat"),
                                          ])
                                        : Row(),
                                  ],
                                ),
                                leading: ClipRRect(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(4.0)),
                                  child: Image.network(
                                    _emlakListe[index].picture != null
                                        ? _emlakListe[index].picture
                                        : '',
                                    width: 100.0,
                                    height: 250.0,
                                    fit: BoxFit.cover,
                                  ),

                                  // child: Image.network(
                                  //     _emlakListe[index].picture != null
                                  //         ? _emlakListe[index].picture
                                  //         : ''),
                                  // child: IconButton(
                                  //   icon: Image.network(
                                  //       _emlakListe[index].picture != null
                                  //           ? _emlakListe[index].picture
                                  //           : ''),
                                  //   onPressed: () {
                                  //     SatiliklarScreen.ilanId =
                                  //         _emlakListe[index].id;
                                  //     Navigator.pushNamed(
                                  //         context, SatiliklarScreen.routeName);
                                  //   },
                                  // ),
                                ),
                                //  IconButton(
                                //   icon: Image.network(
                                //       _emlakListe[index].picture != null
                                //           ? _emlakListe[index].picture
                                //           : ''),

                                //   onPressed: () {
                                //     SatiliklarScreen.ilanId =
                                //         _emlakListe[index].id;
                                //     Navigator.pushNamed(
                                //         context, SatiliklarScreen.routeName);
                                //   },
                                // ),
                                onTap: () {
                                  SatiliklarScreen.ilanId =
                                      _emlakListe[index].id;
                                  Navigator.pushNamed(
                                      context, SatiliklarScreen.routeName);
                                },
                              ),
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
              // Container(
              //   child:
              // ProjelerScreen.b == true
              //     ? Column(children: [
              //         Expanded(
              //             child: Container(
              //           color: Colors.grey,
              //           child: Column(children: <Widget>[
              //             Text(
              //               "SEÇENEKLER",
              //               style: TextStyle(
              //                   fontWeight: FontWeight.bold, fontSize: 20),
              //             ),
              //             Divider(),
              //             FlatButton(
              //                 onPressed: () {
              //                   Navigator.pushNamed(
              //                       context, FiltrelemeScreen.routeName);
              //                 },
              //                 child: Column(children: <Widget>[
              //                   Text("Adres", style: TextStyle(fontSize: 20)),
              //                   Row(children: <Widget>[
              //                     Text("Türkiye",
              //                         style: TextStyle(fontSize: 15)),
              //                     Spacer(),
              //                     Icon(Icons.crop_din_outlined, size: 6.0),
              //                     Icon(Icons.crop_din_outlined, size: 6.0),
              //                     Icon(Icons.crop_din_outlined, size: 6.0),
              //                   ])
              //                 ])),
              //             Text(""),
              //             Text(
              //               "İLAN BİLGİLERİ",
              //               style: TextStyle(
              //                   fontWeight: FontWeight.bold, fontSize: 20),
              //             ),
              //             Divider(),
              //             FlatButton(
              //                 onPressed: () {
              //                   showAlertDialogOda(context);
              //                 },
              //                 child: Column(children: <Widget>[
              //                   Text("Oda Sayısı",
              //                       style: TextStyle(fontSize: 20)),
              //                   Row(children: <Widget>[
              //                     Text("$odaSayisiText",
              //                         style: TextStyle(fontSize: 15)),
              //                     Spacer(),
              //                     Icon(Icons.crop_din_outlined, size: 6.0),
              //                     Icon(Icons.crop_din_outlined, size: 6.0),
              //                     Icon(Icons.crop_din_outlined, size: 6.0),
              //                   ])
              //                 ])),
              //             FlatButton(
              //                 onPressed: () {
              //                   showAlertDialogBulunduguKat(context);
              //                 },
              //                 child: Column(children: <Widget>[
              //                   Text("Bulunduğu Kat",
              //                       style: TextStyle(fontSize: 20)),
              //                   Row(children: <Widget>[
              //                     Text("$bulunduguKatText",
              //                         style: TextStyle(fontSize: 15)),
              //                     Spacer(),
              //                     Icon(Icons.crop_din_outlined, size: 6.0),
              //                     Icon(Icons.crop_din_outlined, size: 6.0),
              //                     Icon(Icons.crop_din_outlined, size: 6.0),
              //                   ])
              //                 ])),
              //             FlatButton(
              //                 onPressed: () {
              //                   showAlertDialogEsya(context);
              //                 },
              //                 child: Column(children: <Widget>[
              //                   Text("Eşya Durumu",
              //                       style: TextStyle(fontSize: 20)),
              //                   Row(children: <Widget>[
              //                     Text("$esyaText",
              //                         style: TextStyle(fontSize: 15)),
              //                     Spacer(),
              //                     Icon(Icons.crop_din_outlined, size: 6.0),
              //                     Icon(Icons.crop_din_outlined, size: 6.0),
              //                     Icon(Icons.crop_din_outlined, size: 6.0),
              //                   ])
              //                 ])),
              //             Text("Site Adı", style: TextStyle(fontSize: 20)),
              //             FlatButton(
              //               onPressed: () {
              //                 SearchField();
              //               },
              //               child: null,
              //               color: Colors.blue,
              //             ),
              //             FlatButton(
              //               onPressed: _onPresseddd,
              //               child: Text("Sonuçları Göster"),
              //               color: Colors.blue,
              //             )
              //           ]),
              //           // color: Colors.blue,
              //         ))
              //       ])
              //     : Row(),
              // )
            ]));
  }
  //  @override _handleRadioValueChange1(){
  //   // print(T);
  //   setState(() {
  //  // _radioValue1=_handleRadioValueChange1;
  //   });
  // }
}

class SearchField extends StatelessWidget {
  // TextEditingController _controller = TextEditingController();
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
    return TextField(
        style: TextStyle(
          fontSize: 15.0,
          color: hbRed,
        ),
        decoration: InputDecoration(
            contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
            hintText: "Site Adı Ara",
            hintStyle: TextStyle(fontSize: 12),
            prefixIcon: Icon(
              Icons.search,
              color: hbRed,
            ),
            suffixIcon: Icon(
              Icons.keyboard_voice,
              color: hbRed,
            ),
            border: OutlineInputBorder(
                borderSide: BorderSide(color: hbRed, width: 32.0)),
            //borderRadius: BorderRadius.circular(25.0)),
            focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.white, width: 32.0))));
    //borderRadius: BorderRadius.circular(25.0))));
  }
}
