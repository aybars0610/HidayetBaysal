// import 'dart:html';
import 'dart:convert';
import 'dart:ui';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:ilk_projem/Data/AramaList.dart';
import 'package:ilk_projem/Data/EmlakData.dart';
// import 'package:ilk_projem/Data/User.dart';
import 'package:ilk_projem/screens/main_menu.dart';
import 'package:ilk_projem/screens/projeler_screen.dart';
// import 'package:url_launcher/url_launcher.dart';

import 'contact.dart';
import 'customer_screen.dart';
// import 'package:tckimlikno/tckimlikno.dart';

class AramalarScreen extends StatefulWidget {
  static const String routeName = "/aramalar";
  static String arama = "";
  String result;
  AramalarScreen({this.result});

  @override
  _AramalarScreenState createState() => _AramalarScreenState();
}

class Routes {
  static const String contacts = ContactScreen.routeName;
  static const String customer = CustomerScreen.routeName;
  static const String anasayfa = MainMenu.routeName;
  static const String projeler = ProjelerScreen.routeName;
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

class _AramalarScreenState extends State<AramalarScreen> {
  String _arama;

  List<EmlakData> _aramaListe = [];

  // Future<List<AramaList>> fetchAramaListe() async {
  //   // var url =
  //   //     "file:///C:/Users/oozge/OneDrive/Masa%C3%BCst%C3%BC/emlakexample.json";
  //   // var response = await http.get(url);
  //   List<AramaList> aramaListe = [];

  //   var response =
  //       """[{"ID":2,"Title":"2+1"},{"ID":1,"Title":"3+1"},{"ID":0,"Title":"Kiralık"}]"""; // Arama

  //   // if (response.statusCode == 200) {
  //   // var emlakListeJson = json.decode(response.body);
  //   var aramaListeJson = json.decode(response);

  //   for (var aramaJson in aramaListeJson) {
  //     aramaListe.add(AramaList.fromJson(aramaJson));
  //   }
  //   // }
  //   // var order = await emlakListe.length != 0;
  //   return
  //   aramaListe;
  // }

  void _onPresseddd() {
    // setState(() {
    //   _aramaListe = [];
    //   fetchAramaListe().then((value) {
    //     setState(() {
    //       _aramaListe.addAll(value);
    //     });
    //   });
    // });
    ProjelerScreen.aramaMetni = AramalarScreen.arama;
    Navigator.pushNamed(context, Routes.projeler);
    // Navigator.pop(context, true);
  }

  // @override
  // void initState() {
  //   fetchAramaListe().then((value) {
  //     setState(() {
  //       _aramaListe.addAll(value);
  //     });
  //   });

  //   super.initState();
  // }

  TextEditingController searchTextEditingController = TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  // Widget _buildArama() {
  //   return TextFormField(
  //     decoration: InputDecoration(
  //       labelText: '',
  //       contentPadding: const EdgeInsets.symmetric(horizontal: 26.0),
  //     ),
  //     // maxLength: 25,
  //     validator: (String value) {
  //       return null;
  //     },
  //     onSaved: (String value) {
  //       if (widget.result != null) {
  //         value = widget.result;
  //       }

  //       _arama = value;
  //     },
  //   );
  // }

  homePageHeader() {
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
    return AppBar(
      // automaticallyImplyLeading: false, // remove the back button
      actions: <Widget>[
        IconButton(
            icon: Icon(
              Icons.search,
              size: 30.0,
              color: Colors.white,
            ),
            onPressed: () {
              _onPresseddd();
              if (!_formKey.currentState.validate()) {
                return null;
              }
              _formKey.currentState.save();
            }),
      ],
      backgroundColor: hbRed,
      title: Container(
        margin: new EdgeInsets.only(bottom: 4.0),
        child: Form(
          key: _formKey,
          child: TextFormField(
            style: TextStyle(fontSize: 18.0, color: Colors.white),
            controller: searchTextEditingController,
            decoration: InputDecoration(
              hintText: "En az 3 karakter giriniz",
              hintStyle: TextStyle(color: Colors.white),
              enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey)),
              focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.white)),
              filled: true,
            ),
            validator: (String value) {
              if (value.length < 3) {
                return '*En az 3 karakter giriniz.';
              }

              return null;
            },
            onChanged: (String value) {
              _arama = value.trim();
              AramalarScreen.arama = _arama;
            },
          ),
        ),
      ),
    );
  }

  // Map<AramaList, String> map = Map.fromIterables(aramaListe, _aramaList);

  //  List<AramaList> personList =[];
  // final String localJsonPath = 'lib\Data\AramaList.dart';

  // Future<void> loadLocalJson() async {
  //   var dummyData = await rootBundle.loadString(localJsonPath);
  //   List<dynamic> decodedJson = json.decode(dummyData);
  //   aramaListe = decodedJson.map((title) => AramaList.fromMap(title)).toList();
  //   setState(() {
  //     return aramaListe;
  //   });
  // }

  // @override
  // void initState() {
  //   super.initState();
  //   loadLocalJson();
  // }

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
        appBar: homePageHeader(),
        body: SingleChildScrollView(
            child: Container(
          child: Column(
            children: <Widget>[
              // ButtonTheme(
              //     minWidth: SizeConfig.safeBlockHorizontal * 33,
              //     height: SizeConfig.safeBlockVertical * 7,
              //     child: MaterialButton(
              //       onPressed: () {
              //         //print("a");
              //       },
              //       child: Column(children: <Widget>[
              //         // Image.asset(
              //         //   'assets/a/sort.png',
              //         //   fit: BoxFit.cover,
              //         // width: 24,
              //         // height: 24,
              //         // ),
              //         Icon(
              //           Icons.keyboard_voice,
              //           // size:SizeConfig.safeBlockHorizontal * 50,
              //         ),
              //         // height:
              //         //     SizeConfig.safeBlockVertical * 10, //10 for example
              //         // width:SizeConfig.safeBlockHorizontal * 50,

              //         Text(
              //           "Sesli  Arama",
              //           style: TextStyle(fontSize: SizeConfig.fontSize),
              //         ),
              //       ]),
              //       // style: TextButton.styleFrom(
              //       //   primary: Colors.grey,
              //       // ),
              //     )),
              // Divider(),
              Row(
                children: [
                  Text(
                    " FAVORİ ARAMALAR",
                    style: TextStyle(
                      color: Colors.yellow[900],
                    ),
                  ),
                  Spacer(),
                  Flexible(
                      child: RichText(
                          text: TextSpan(children: [
                    new TextSpan(
                      text: 'Tümünü Temizle',
                      style: new TextStyle(color: Colors.blue),
                      recognizer: new TapGestureRecognizer()
                        ..onTap = () {
                          _aramaListe.clear();
                        },
                    ),
                  ])))
                ],
              ),
              Divider(
                color: Colors.yellow,
              ),
              // _aramaListe.length != 0
              _arama != null
                  ? Container(
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          Expanded(
                            child: ListView.builder(
                              itemCount: _aramaListe.length,
                              itemBuilder: (BuildContext context, int index) {
                                return Card(
                                  child: ListTile(
                                    title: Text(_aramaListe[index].title),
                                    onTap: () {
                                      Navigator.pushNamed(
                                          context, ProjelerScreen.routeName);
                                    },
                                  ),
                                );
                              },
                            ),
                          ),

                          // Expanded(
                          //     child: ListView.builder(
                          //         // scrollDirection: Axis.horizontal,
                          //         itemCount: _aramaListe.length,
                          //         itemBuilder:
                          //             (BuildContext context, int index) {
                          //           return new Card(
                          //               child: new Container(
                          //             // alignment: Alignment.center,
                          //             // padding: EdgeInsets.all(0.0),
                          //             // padding: new EdgeInsets.all(10.0),
                          //             child: Column(
                          //               // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          //               children: <Widget>[
                          //                 Text(_aramaListe[index].title),
                          //               ],
                          //             ),
                          //           ));
                          //         })),
                        ],
                      ))
                  : Row(),

              // Container(
              //     child: ListView.builder(
              //       itemCount: _aramaListe.length,
              //       scrollDirection: Axis.horizontal,
              //       itemBuilder: (BuildContext context, int index) {
              //         return new GestureDetector(
              //           onTap: null,
              //           child: Container(
              //               height: 45.0,
              //               decoration: BoxDecoration(),
              //               child: new Column(
              //                 children: <Widget>[
              //                   Container(
              //                     padding: EdgeInsets.only(
              //                         left: 15.0, right: 15.0),
              //                     child: new Row(
              //                       mainAxisAlignment:
              //                           MainAxisAlignment.spaceBetween,
              //                       children: <Widget>[
              //                         new Container(
              //                           child: Text(
              //                             _aramaListe[index].title,
              //                             textAlign: TextAlign.left,
              //                             // style: TextStyle(
              //                             //     fontSize: AppSetting.appFontSize),
              //                           ),
              //                           // decoration: BoxDecoration(
              //                           //     borderRadius:
              //                           //         BorderRadius.only(
              //                           //             topLeft:
              //                           //                 Radius.circular(
              //                           //                     10.0),
              //                           //             topRight:
              //                           //                 Radius.circular(
              //                           //                     10.0))),
              //                         ),
              //                       ],
              //                     ),
              //                   ),
              //                 ],
              //               )),
              //         );
              //       },
              //     ),
              //   )
            ],
          ),
        ))
        // ]
        // )
        );
    // ]

    // ),
  }
}
