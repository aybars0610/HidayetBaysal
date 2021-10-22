import 'dart:convert';
import 'dart:ui';
// import 'package:sizer/sizer.dart';
import 'dart:io';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
// import 'package:simple_html_css/simple_html_css.dart';
import 'package:flutter_html/flutter_html.dart';
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
import 'package:ilk_projem/screens/projeler_screen.dart';
import 'package:ilk_projem/screens/satilik_screen.dart';
//import 'package:ilk_projem/screens/main_menu.dart';

import 'package:ilk_projem/screens/satiliklar.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

import 'package:url_launcher/url_launcher.dart';
//import 'package:ilk_projem/screens/product_screen.dart';
//import 'package:http/http.dart' as http;

import 'package:flutter/foundation.dart';

class ProjeScreen extends StatefulWidget {
  // static bool a = false;
  // static int ilanTuru = 0;
  // static String ilanTurAdi = "";
  // static int ilanTipi = 0;
  // static String ilanTipAdi = "";
  // static String fiyatText = "Tümü";
  // static String userName = "";
  // static String password = "";
  // static int ilId = 0;
  // static String ilceId = "";
  // static String mahalleId = "";
  // static String odaSayisiIdleri = "";
  // static String bulunduguKatIdleri = "";
  // static double enAzFiyat = 0;
  // static double enCokFiyat = 0;
  // static int esyaliId = 0;
  // static String siteAdi = "";
  // static String aramaMetni = "";
  // static int siralama = 0;
  static const String routeName = "/proje";

  static bool b = false;

  // final String title;
  @override
  _ProjeScreenState createState() => _ProjeScreenState();
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

class _ProjeScreenState extends State<ProjeScreen> {
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
    ProjelerScreen.ilceId = "";
    ProjelerScreen.mahalleId = "";
    ProjelerScreen.odaSayisiIdleri = "";
    ProjelerScreen.bulunduguKatIdleri = "";
    ProjelerScreen.enAzFiyat = 0;
    ProjelerScreen.enCokFiyat = 0;
    ProjelerScreen.esyaliId = 0;
    ProjelerScreen.siteAdi = "";
    //ProjeScreen.aramaMetni = "";
    ProjelerScreen.siralama = 0;
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

    // fetchSite().then((value) {
    //   setState(() {
    //     _siteListe.addAll(value);
    //   });
    // });

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
      ProjeScreen.b = false;
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
                    // PageView(
                    //   scrollDirection: Axis.vertical,
                    //   pageSnapping: false,
                    //   physics: ClampingScrollPhysics(),
                    //   children: <Widget>[
                    Expanded(
                      child: ListView.builder(
                        itemCount: _emlakListe.length,
                        itemBuilder: (BuildContext context, int index) {
                          return Card(
                              child: ListTile(
                                  title: Stack(
                                    children: <Widget>[
                                      ClipRRect(
                                        borderRadius:
                                            BorderRadius.circular(8.0),
                                        child: new Image.network(
                                            _emlakListe[index].picture != null
                                                ? _emlakListe[index].picture
                                                : ''),
                                      ),
                                      // Center(child: Text(_emlakListe[index].title,)),
                                      // Container(
                                      //   alignment: Alignment.bottomRight,
                                      //   // color: Colors.blue,
                                      //   color: const Color.fromRGBO(0, 0, 0, 0.5),

                                      //   child: Text(
                                      //     _emlakListe[index].title,
                                      //     style: TextStyle(
                                      //       color: Colors.white,
                                      //       fontWeight: FontWeight.bold,
                                      //       fontSize: 25,
                                      //     ),
                                      //   ),
                                      // ),
                                    ],
                                  ),
                                  onTap: () {
                                    showDialog(
                                        context: context,
                                        builder: (context) {
                                          return AlertDialog(
                                            backgroundColor: hbRed,
                                            // title: "",
                                            content: Container(
                                              child: SingleChildScrollView(
                                                child: Column(
                                                  children: <Widget>[
                                                    ClipRRect(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              8.0),
                                                      child: Image.network(
                                                          _emlakListe[index]
                                                                      .picture !=
                                                                  null
                                                              ? _emlakListe[
                                                                      index]
                                                                  .picture
                                                              : ''),
                                                    ),
                                                    // RichText(
                                                    //   text: HTML.toTextSpan(
                                                    //     context,
                                                    //     _emlakListe[index]
                                                    //                 .detail !=
                                                    //             null
                                                    //         ? _emlakListe[index]
                                                    //             .detail
                                                    //         : '',
                                                    //     defaultTextStyle:
                                                    //         TextStyle(
                                                    //             fontSize: 12,
                                                    //             color: Colors
                                                    //                 .white,
                                                    //             fontStyle:
                                                    //                 FontStyle
                                                    //                     .italic),

                                                    //     // softWrap: true,
                                                    //     // overflow: TextOverflow.clip,
                                                    //   ),
                                                    // ),
                                                    Html(
                                                        data: _emlakListe[index]
                                                                    .detail !=
                                                                null
                                                            ? _emlakListe[index]
                                                                .detail
                                                            : '',
                                                        style: {
                                                          "body": Style(
                                                              fontSize:
                                                                  FontSize(
                                                                      12.0),
                                                              color:
                                                                  Colors.white,
                                                              fontStyle:
                                                                  FontStyle
                                                                      .italic),
                                                        }
                                                        // TextStyle(
                                                        //     fontSize: 12,
                                                        //     color:
                                                        //         Colors.white,
                                                        //     fontStyle:
                                                        //         FontStyle
                                                        //             .italic),

                                                        // softWrap: true,
                                                        // overflow: TextOverflow.clip,
                                                        ),

                                                    // Text(
                                                    //   _emlakListe[index].detail !=
                                                    //           null
                                                    //       ? _emlakListe[index]
                                                    //           .detail
                                                    //       : '',
                                                    //   style: TextStyle(
                                                    //       color: Colors.white,
                                                    //       fontSize: 13.0),
                                                    // ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                            actions: [
                                              DialogButton(
                                                color: Colors.white,
                                                onPressed: () {
                                                  ProjelerScreen.siteAdi =
                                                      _emlakListe[index].title;
                                                  ProjelerScreen.ilanTuru = 0;
                                                  ProjelerScreen.ilanTipi = 0;
                                                  ProjelerScreen.ilanTurAdi =
                                                      "İlgili İlanlar";

                                                  Navigator.pushNamed(context,
                                                      ProjelerScreen.routeName);
                                                },
                                                child: Text(
                                                  "İlanlarına Git",
                                                  style: TextStyle(
                                                      color: hbRed,
                                                      fontSize: 20),
                                                ),
                                              )
                                            ],
                                          );

                                          // Alert(
                                          //     context: context,
                                          //     title: "",
                                          //     content: Column(
                                          //       children: <Widget>[
                                          //         Image.network(
                                          //             _emlakListe[index].picture != null
                                          //                 ? _emlakListe[index].picture
                                          //                 : ''),
                                          //         Text(_emlakListe[index].detail != null
                                          //             ? _emlakListe[index].detail
                                          //             : ''),
                                          //       ],
                                          //     ),
                                          //     buttons: [
                                          //       DialogButton(
                                          //         onPressed: () {
                                          //           ProjelerScreen.aramaMetni =
                                          //               _emlakListe[index].title;
                                          //           ProjelerScreen.ilanTuru = 0;
                                          //           ProjelerScreen.ilanTipi = 0;
                                          //           ProjelerScreen.ilanTurAdi =
                                          //               "İlgili İlanlar";

                                          //           Navigator.pushNamed(
                                          //               context, ProjelerScreen.routeName);
                                          //         },
                                          //         child: Text(
                                          //           "İlanlarına Git",
                                          //           style: TextStyle(
                                          //               color: Colors.white, fontSize: 20),
                                          //         ),
                                          //       )
                                          //     ]).show();

                                          // var alertStyle = AlertStyle(
                                          //   // overlayColor: Colors.blue[400],
                                          //   animationType: AnimationType.fromTop,
                                          //   isCloseButton: false,
                                          //   isOverlayTapDismiss: false,
                                          //   descStyle:
                                          //       TextStyle(fontWeight: FontWeight.bold),
                                          //   animationDuration: Duration(milliseconds: 400),
                                          //   alertBorder: RoundedRectangleBorder(
                                          //     borderRadius: BorderRadius.circular(50.0),
                                          //     side: BorderSide(
                                          //       color: Colors.grey,
                                          //     ),
                                          //   ),
                                          //   titleStyle: TextStyle(
                                          //     color: Color.fromRGBO(91, 55, 185, 1.0),
                                          //   ),
                                          // );

                                          // Alert(
                                          //   context: context,
                                          //   style: alertStyle,
                                          //   type: Image.network(
                                          //         _emlakListe[index].picture != null
                                          //             ? _emlakListe[index].picture
                                          //             : ''),
                                          //   title: "",
                                          //   desc: _emlakListe[index].detail,
                                          //   buttons: [
                                          //     DialogButton(
                                          //       child: Text(
                                          //         "İlanlarına Git",
                                          //         style: TextStyle(
                                          //             color: Colors.white, fontSize: 20),
                                          //       ),
                                          //       onPressed: () {
                                          //         // SatiliklarScreen.ilanId = _emlakListe[index].id;
                                          //         ProjelerScreen.aramaMetni =
                                          //             _emlakListe[index].title;
                                          //         ProjelerScreen.ilanTuru = 0;
                                          //         ProjelerScreen.ilanTipi = 0;
                                          //         ProjelerScreen.ilanTurAdi =
                                          //             "İlgili İlanlar";

                                          //         Navigator.pushNamed(
                                          //             context, ProjelerScreen.routeName);
                                          //       },
                                          //       // color: Color.fromRGBO(91, 55, 185, 1.0),
                                          //       radius: BorderRadius.circular(10.0),
                                          //     ),
                                          //   ],
                                          // ).show();
                                          // SatiliklarScreen.ilanId = _emlakListe[index].id;
                                          // Navigator.pushNamed(
                                          //     context, SatiliklarScreen.routeName);
                                        });
                                  }));
                          // return Card(
                          //   child: ListTile(
                          //     title: Image.network(
                          //         _emlakListe[index].picture != null
                          //             ? _emlakListe[index].picture
                          //             : ''),
                          //     subtitle: Column(
                          //       children: <Widget>[
                          //         Row(
                          //           children: <Widget>[
                          //             Text(
                          //               _emlakListe[index].title != null
                          //                   ? _emlakListe[index].title
                          //                   : '',
                          //               textAlign: TextAlign.left,
                          //               style: TextStyle(
                          //                 fontWeight: FontWeight.bold,
                          //                 fontSize: 15,
                          //               ),
                          //             ),
                          //           ],
                          //         ),
                          //         // Align(
                          //         //   alignment: Alignment.centerRight,

                          //         //   child: Text(_emlakListe[index].price),
                          //         // ),
                          //       ],
                          //     ),
                          //     onTap: () {
                          //       SatiliklarScreen.ilanId = _emlakListe[index].id;
                          //       Navigator.pushNamed(
                          //           context, SatiliklarScreen.routeName);
                          //     },
                          //   ),
                          // );
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
