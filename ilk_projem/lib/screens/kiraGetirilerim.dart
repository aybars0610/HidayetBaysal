import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:ilk_projem/Data/AylikBorc.dart';
import 'package:ilk_projem/Data/User.dart';
import 'package:ilk_projem/Data/kira.dart';
import 'package:ilk_projem/screens/phoneChange.dart';

import 'package:ilk_projem/screens/sifreDegis.dart';

import 'contact.dart';
import 'customer_screen.dart';
import 'main_menu.dart';
//import 'package:ilk_projem/screens/main_menu.dart';

//import 'contact.dart';

class KiraGetirilerimScreen extends StatefulWidget {
  static const String routeName = "/kira";
  // static String userName = "";
  // static String password = "";
  // static String userId = "";
  // static String ad = "";
  // static String soyad = "";
  // static String mail = "";
  // static String tcKimlik = "";
  // static String role = "";
  // static String phoneNumber = "";
  // static String newPassword = "";
  // static String newPasswordConfirm = "";

  @override
  _KiraGetirilerimScreenState createState() => _KiraGetirilerimScreenState();
}

class Routes {
  static const String contacts = ContactScreen.routeName;
  static const String customer = CustomerScreen.routeName;
  static const String anasayfa = MainMenu.routeName;
  static const String sifreDegis = SifreDegisScreen.routeName;
  static const String cepDegis = PhoneChangeScreen.routeName;
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

class _KiraGetirilerimScreenState extends State<KiraGetirilerimScreen> {
  // String _name;
  // String _surname;
  // String _email;
  // String _phone;
  // User _userDetay = User();

  // String phoneIsoCode;
  // bool visible = false;
  // String confirmedNumber = '';

  List<Kira> _kiraListe = [];

  Future<List<Kira>> fetchKiraListe() async {
    // var url =
    //     "file:///C:/Users/oozge/OneDrive/Masa%C3%BCst%C3%BC/emlakexample.json";
    // var response = await http.get(url);
    List<Kira> kiraListe = [];

    var response =
        """[{"userId":0,"name":"Özge","surname":"Kazan","siteAdi":"Kazan Sitesi","tcKimlik":"28466496656","role":"Kiracı","borc":"100.000 TL","daireNo":"5","kat":"3","odemeDurumu":false},{"userId":1,"name":"Yunus Emre","surname":"Kazan","siteAdi":"Kazan Sitesi","tcKimlik":"21565325278","role":"Kiracı","borc":"10.000 TL","daireNo":"7","kat":"4","odemeDurumu":true}]"""; // Eşya

    // if (response.statusCode == 200) {
    // var emlakListeJson = json.decode(response.body);
    var kiraListeJson = json.decode(response);

    for (var kiraJson in kiraListeJson) {
      kiraListe.add(Kira.fromJson(kiraJson));
    }
    // }
    // var order = await emlakListe.length != 0;
    return kiraListe;
  }

  List<AylikBorc> _borcListe = [];

  Future<List<AylikBorc>> fetchBorcListe() async {
    // var url =
    //     "file:///C:/Users/oozge/OneDrive/Masa%C3%BCst%C3%BC/emlakexample.json";
    // var response = await http.get(url);
    List<AylikBorc> borcListe = [];

    var response =
        """[{"userId":0,"name":"Özge","surname":"Kazan","aylikGelir":"20.000 TL","toplamBorc":"110.000 TL","role":"EvSahibi"}]""";

    // if (response.statusCode == 200) {
    // var emlakListeJson = json.decode(response.body);
    var borcListeJson = json.decode(response);

    for (var borcJson in borcListeJson) {
      borcListe.add(AylikBorc.fromJson(borcJson));
    }
    // }
    // var order = await emlakListe.length != 0;
    return borcListe;
  }

  @override
  void initState() {
    fetchKiraListe().then((value) {
      setState(() {
        _kiraListe.addAll(value);
      });
    });

    fetchBorcListe().then((value) {
      setState(() {
        _borcListe = value;
      });
    });

    super.initState();

    // WidgetsBinding.instance.addObserver(LifecycleEventHandler(
    //     resumeCallBack: () async => setState(() {
    //           // do something
    //           ilcelerText = FiltrelemeScreen.ilcelerText;
    //         })));
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
    return Scaffold(
        appBar: AppBar(title: Text("Kira Getirilerim")
            //   ],
            // ),
            ),
        body: Container(
            margin: EdgeInsets.all(25.0),
            child: Column(
              children: <Widget>[
                Expanded(
                  child: ListView.builder(
                    itemCount: _kiraListe.length,
                    itemBuilder: (BuildContext context, int index) {
                      return SingleChildScrollView(
                          child: Container(
                              // height: 100,
                              child: new Card(
                        child: ListTile(
                          title: Column(children: <Widget>[
                            Row(children: <Widget>[
                              Text(
                                _kiraListe[index].name,
                                // style: TextStyle(fontSize: 12.0),
                              ),
                              SizedBox(width: 5),
                              Text(
                                _kiraListe[index].surname,
                                // style: TextStyle(fontSize: 12.0),
                              ),
                            ]),
                            // Text(
                            //   _kiraListe[index].tcKimlik,
                            //   // style: TextStyle(fontSize: 12.0),
                            // ),
                            Text(
                              _kiraListe[index].siteAdi,
                              // style: TextStyle(fontSize: 12.0),
                            ),
                            Row(children: <Widget>[
                              Text("Kat:"),
                              Text(
                                _kiraListe[index].kat,
                                // style: TextStyle(fontSize: 12.0),
                              ),
                              SizedBox(width: 15),
                              Text("Daire:"),
                              Text(
                                _kiraListe[index].daireNo,
                                // style: TextStyle(fontSize: 12.0),
                              ),
                            ]),
                            Text(
                              _kiraListe[index].borc,
                              textAlign: TextAlign.left,
                              // style: TextStyle(fontSize: 12.0),
                            ),
                            _kiraListe[index].odemeDurumu == true
                                ? Row(children: <Widget>[
                                    Text(
                                      "Ödendi",
                                      style: TextStyle(color: Colors.green),
                                      // style: TextStyle(fontSize: 12.0),
                                    ),
                                    // Icon(
                                    //   Icons.audiotrack,
                                    //   color: Colors.green,
                                    //   size: 30.0,
                                    // )
                                  ])
                                : Row(children: <Widget>[
                                    Text(
                                      "Ödenmedi",
                                      style: TextStyle(color: Colors.red),
                                    ),
                                    //       Icon(
                                    //   Icons.tick,
                                    //   color: Colors.green,
                                    //   size: 30.0,
                                    // )
                                  ])
                          ]),
                        ),
                      )));
                    },
                  ),
                ),
              ],
            )),
        bottomNavigationBar: Container(
          height: kToolbarHeight,
          child: Container(
              color: hbRed,
              child:
                  // AppBar(
                  //     title:
                  Row(
                children: <Widget>[
                  Text(
                    " Aylık Gelir: ",
                    style: TextStyle(
                        color: Colors.blue[200], fontWeight: FontWeight.bold),
                  ),
                  SizedBox(width: 1),
                  Text(
                    _borcListe[0].aylikGelir,
                    style: TextStyle(color: Colors.white),
                  ),
                  SizedBox(width: 15),
                  Text(
                    "Toplam Borç: ",
                    style: TextStyle(
                        color: Colors.blue[200], fontWeight: FontWeight.bold),
                  ),
                  SizedBox(width: 1),
                  Text(
                    _borcListe[0].toplamBorc,
                    style: TextStyle(color: Colors.white),
                  ),
                ],
              )),
        )
        // ),
        );

    // child: SingleChildScrollView(
    //     );
  }
}
