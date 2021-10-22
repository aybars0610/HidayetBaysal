import 'dart:convert';

import 'package:carousel_slider/carousel_controller.dart';
import 'package:ilk_projem/screens/proje_screen.dart';
import 'package:ilk_projem/screens/satilik_screen.dart';
// import 'package:ilk_projem/screens/speech_screen.dart';
// import 'package:speech_recognition/speech_recognition.dart' as stt;
import 'package:speech_to_text/speech_to_text.dart' as stt;
import 'package:highlight_text/highlight_text.dart';
import 'package:avatar_glow/avatar_glow.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:ilk_projem/Data/AnasayfaSlider.dart';
import 'package:ilk_projem/screens/aramalar_screen.dart';
import 'package:ilk_projem/screens/kiraliklar.dart';
import 'package:ilk_projem/screens/projeler_screen.dart';
import 'package:ilk_projem/screens/satiliklar.dart';
// import 'package:avatar_glow/avatar_glow.dart';

// import 'package:highlight_text/highlight_text.dart';
// import 'package:speech_to_text/speech_to_text.dart' as stt;
//import 'package:ilk_projem/screens/product_screen.dart';

class AnasayfaScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => AnasayfaScreenState();
}

class Routes {
  static const String satilik = SatilikScreen.routeName;
  static const String kiralik = KiralikScreen.routeName;
  // static const String customer = CustomerScreen.routeName;
  // static const String anasayfa = MainMenu.routeName;
  // static const String notes = NotesPage.routeName;

}

class AnasayfaScreenState extends State {
  final CarouselController _controller = CarouselController();

  // SingingCharacter _character = SingingCharacter.lafayette;
  get pageFetch => null;
  int page = 1;

  List<AnasayfaSlider> _anasayfaSlider = [];
  List<String> _imgList = [];
  List<Widget> imageSliders = [];

  Future<List<AnasayfaSlider>> fetcheanasayfaSlider() async {
    String url = 'IlanBilgileri/GetSliderFotolar';
    Map map = {'UserName': "", 'Password': ""};

    var response = await apiRequest(url, map);
    // var url =
    //     "file:///C:/Users/oozge/OneDrive/Masa%C3%BCst%C3%BC/emlakexample.json";
    // var response = await http.get(url);
    List<AnasayfaSlider> anasayfaSlider = [];

    // var response =
    //     """[{"Fotograflar":[{"Name":"https://i0.shbdn.com/photos/45/93/00/x5_891459300xn3.jpg"},{"Name":"https://i0.shbdn.com/photos/45/93/00/x5_891459300b8t.jpg"}],"Isim":"Çatalca/İstanbul"},{"Fotograflar":[{"Name":"https://s0.shbdn.com/projeler/media/photos/Project/2020/04/dd4caaf3e25495ac/ProjectPhoto/80f7b806ab0fe025.jpg"},{"Name":"https://s0.shbdn.com/projeler/media/photos/Project/2020/04/dd4caaf3e25495ac/ProjectPhoto/63d9937fd5f11405.jpg"}],"Isim":"Kuzey"}]""";

    // if (response.statusCode == 200) {
    // var emlakDetayListeJson = json.decode(response.body);
    // var emlakDetayListeJson = json.decode(response);
    try {
      // emlakDetay = json.decode(response);
      List<dynamic> jsonresponses = json.decode(response);
      for (var jsonresponse in jsonresponses) {
        anasayfaSlider.add(AnasayfaSlider.fromJson(jsonresponse));
      }
      // anasayfaSlider = AnasayfaSlider.fromJson(jsonresponse[0]);
    } on Exception catch (_) {
      var abc = "abc";
    } catch (error) {
      var cba = "cba";
      // executed for errors of all types other than Exception
    }

    // for (var emlakJson in emlakDetayListeJson) {

    // }
    // }
    // var order = await emlakDetayListe.length != 0;
    // _emlakDetay = emlakDetay;
    return anasayfaSlider;
  }

  @override
  void initState() {
    fetcheanasayfaSlider().then((value) {
      setState(() {
        _anasayfaSlider.addAll(value);
        // _anasayfaSlider = value;
        for (var img in value) {
          for (var img2 in img.fotograflar) {
            _imgList.add(img2.name);
          }
          // _imgList.add(img.fotograflar);
        }
        // _imgList = value.fotograflar.cast<String>();

        for (var image in _anasayfaSlider) {
          // imageSliders.add(
          imageSliders.addAll(image.fotograflar
              .map((item) => Container(
                      child: InkWell(
                    onTap: () {
                      ProjelerScreen.siteAdi = image.isim;
                      ProjelerScreen.ilanTuru = 0;
                      ProjelerScreen.ilanTipi = 0;
                      ProjelerScreen.ilanTurAdi = "İlgili İlanlar";

                      Navigator.pushNamed(context, ProjelerScreen.routeName);
                      // ProjelerScreen.ilanTuru = 3;
                      // ProjelerScreen.ilanTipi = 0;
                      // ProjelerScreen.ilanTurAdi = "Projeler";
                      // SatiliklarScreen.ilanId = image.ilanId;
                      // Navigator.pushNamed(context, SatiliklarScreen.routeName);
                    },
                    child: Container(
                      margin: EdgeInsets.all(5.0),
                      child: ClipRRect(
                          borderRadius: BorderRadius.all(Radius.circular(5.0)),
                          child: Stack(
                            children: <Widget>[
                              // for (var image in item.fotograflar)
                              //   Image.network(image.name,
                              //       fit: BoxFit.cover, width: 1000.0),
                              Image.network(item.name,
                                  fit: BoxFit.cover, width: 1000.0),
                              // Positioned(
                              //   bottom: 0.0,
                              //   left: 0.0,
                              //   right: 0.0,
                              //   child: Container(
                              //     decoration: BoxDecoration(
                              //       gradient: LinearGradient(
                              //         colors: [
                              //           Color.fromARGB(200, 0, 0, 0),
                              //           Color.fromARGB(0, 0, 0, 0)
                              //         ],
                              //         begin: Alignment.bottomCenter,
                              //         end: Alignment.topCenter,
                              //       ),
                              //     ),
                              //     // padding: EdgeInsets.symmetric(
                              //     //     vertical: 10.0, horizontal: 20.0),
                              //     // child: Text(
                              //     //   image.isim,
                              //     //   style: TextStyle(
                              //     //     color: Colors.white,
                              //     //     fontSize: 10.0,
                              //     //     fontWeight: FontWeight.bold,
                              //     //   ),
                              //     // ),
                              //   ),
                              // ),
                            ],
                          )),
                    ),
                  )))
              .toList());
          // );
        }
      });
    });
    super.initState();

    // _SpeechScreenState()._speech = stt.SpeechToText();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(25.0),
      child: SingleChildScrollView(
        child: Form(
          child: Column(
            children: <Widget>[
              SearchField(),
              Divider(
                color: Colors.grey[300],
                height: 20,
                thickness: 5,
                indent: 0,
                endIndent: 0,
              ),
              ProjelerButton(),
              Divider(
                color: Colors.grey[300],
                height: 20,
                thickness: 2,
                indent: 0,
                endIndent: 0,
              ),
              SatilikButton(),
              Divider(
                color: Colors.grey[300],
                height: 20,
                thickness: 2,
                indent: 0,
                endIndent: 0,
              ),
              KiralikButton(),
              Divider(
                color: Colors.grey[300],
                height: 20,
                thickness: 2,
                indent: 0,
                endIndent: 0,
              ),
              AcilButton(),
              Text(""),
              Text(""),
              Text(""),
              TextButton(
                onPressed: () {
                  // ProjelerScreen.ilanTuru = 3;
                  // ProjelerScreen.ilanTipi = 0;
                  // ProjelerScreen.ilanTurAdi = "Projeler";
                  // SatiliklarScreen.ilanId = AnasayfaScreen.ilanId;
                  // Navigator.pushNamed(context, SatiliklarScreen.routeName);
                },
                child: CarouselSlider(
                  items: imageSliders,
                  options:
                      CarouselOptions(enlargeCenterPage: true, height: 200),
                  carouselController: _controller,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ProjelerButton extends StatelessWidget {
  const ProjelerButton({Key key}) : super(key: key);

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

    // const MaterialColor hbRed = const MaterialColor(
    //   0xFFa90600,
    //   const <int, Color>{
    //     50: const Color(0xFFa90600),
    //     100: const Color(0xFFa90600),
    //     200: const Color(0xFFa90600),
    //     300: const Color(0xFFa90600),
    //     400: const Color(0xFFa90600),
    //     500: const Color(0xFFa90600),
    //     600: const Color(0xFFa90600),
    //     700: const Color(0xFFa90600),
    //     800: const Color(0xFFa90600),
    //     900: const Color(0xFFa90600),
    //   },
    // );

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
        final routes = [ProjeScreen.routeName];

        ProjelerScreen.ilanTuru = 3;
        ProjelerScreen.ilanTipi = 0;
        ProjelerScreen.siteAdi = "";
        ProjelerScreen.ilanTurAdi = "Projeler";
        Navigator.of(context)
            .pushNamedAndRemoveUntil(routes[0], (route) => true);
        /*...*/
      },
      child: Row(
        // mainAxisAlignment: MainAxisAlignment.center,
        // Yukarıdan-Aşağıya Hizalama
        crossAxisAlignment: CrossAxisAlignment.start,
        //  Row içerisine eklenen diğer widgetların listesi
        children: <Widget>[
          FloatingActionButton(
            heroTag: "btn1",
            child: Image.asset(
              'assets/logo/hblogopng.png',
              fit: BoxFit.cover,
              width: 25,
              height: 25,
            ),
            elevation: 6,
            backgroundColor: Color.fromRGBO(47, 72, 88, 1),
            onPressed: () {
              final routes = [ProjelerScreen.routeName];

              Navigator.of(context)
                  .pushNamedAndRemoveUntil(routes[0], (route) => true);
            },
            mini: true,
          ),
          Column(
            children: <Widget>[
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Projeler                    ",
                  textAlign: TextAlign.left,
                  style: TextStyle(fontSize: 20.0),
                  // maxLines: 10,
                ),
              ),
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Hidayet Baysal İnşaat Projeleri",
                  textAlign: TextAlign.left,
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.grey,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class SatilikButton extends StatelessWidget {
  const SatilikButton({Key key}) : super(key: key);
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

    // const MaterialColor hbRed = const MaterialColor(
    //   0xFFa90600,
    //   const <int, Color>{
    //     50: const Color(0xFFa90600),
    //     100: const Color(0xFFa90600),
    //     200: const Color(0xFFa90600),
    //     300: const Color(0xFFa90600),
    //     400: const Color(0xFFa90600),
    //     500: const Color(0xFFa90600),
    //     600: const Color(0xFFa90600),
    //     700: const Color(0xFFa90600),
    //     800: const Color(0xFFa90600),
    //     900: const Color(0xFFa90600),
    //   },
    // );

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
        // final routes = [Routes.satilik];

        ProjelerScreen.ilanTuru = 1;
        ProjelerScreen.ilanTipi = 0;
        ProjelerScreen.siteAdi = "";
        ProjelerScreen.ilanTurAdi = "Satılık";
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => SatilikScreen()),
        );
      },
      /*...*/

      child: Row(
        // mainAxisAlignment: MainAxisAlignment.center,
        // Yukarıdan-Aşağıya Hizalama
        crossAxisAlignment: CrossAxisAlignment.start,
        //  Row içerisine eklenen diğer widgetların listesi
        children: <Widget>[
          FloatingActionButton(
            heroTag: "btn2",
            child: Icon(Icons.home),
            elevation: 8,
            backgroundColor:
                Color.fromRGBO(134, 187, 216, 1), //Colors.yellow[900],
            onPressed: () {
              final routes = [SatilikScreen.routeName];

              Navigator.of(context)
                  .pushNamedAndRemoveUntil(routes[0], (route) => true);
            },
            mini: true,
          ),

          // Align(
          //   alignment: CrossAxisAlignment.center,
          //   child: Text(
          //     'Satılık             ',
          //     style: TextStyle(fontSize: 20.0),
          //     textAlign: TextAlign.left,
          //   ),
          // ),
          Column(
            children: <Widget>[
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Satılık                   ",
                  textAlign: TextAlign.left,
                  style: TextStyle(fontSize: 20.0),
                  // maxLines: 10,
                ),
              ),
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Satılık daireler & dükkanlar",
                  textAlign: TextAlign.left,
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.grey,
                  ),
                ),
              ),
            ],
          ),
          // Container(
          //   height: 22,
          //   width: 22,

          //   //: CrossAxisAlignment.center,
          //   child: FloatingActionButton(
          //     child: Icon(Icons.arrow_forward_ios),
          //     elevation: 4,
          //     backgroundColor: hbRed,
          //     onPressed: () {},
          //     mini: true,
          //   ),
          // ),
        ],
      ),
    );
  }
}

class KiralikButton extends StatelessWidget {
  const KiralikButton({Key key}) : super(key: key);
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

    // const MaterialColor hbRed = const MaterialColor(
    //   0xFFa90600,
    //   const <int, Color>{
    //     50: const Color(0xFFa90600),
    //     100: const Color(0xFFa90600),
    //     200: const Color(0xFFa90600),
    //     300: const Color(0xFFa90600),
    //     400: const Color(0xFFa90600),
    //     500: const Color(0xFFa90600),
    //     600: const Color(0xFFa90600),
    //     700: const Color(0xFFa90600),
    //     800: const Color(0xFFa90600),
    //     900: const Color(0xFFa90600),
    //   },
    // );

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
        // final routes = [Routes.satilik];

        ProjelerScreen.ilanTuru = 2;
        ProjelerScreen.ilanTipi = 0;
        ProjelerScreen.siteAdi = "";
        ProjelerScreen.ilanTurAdi = "Kiralık";
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => KiralikScreen()),
        );
      },
      child: Row(
        // mainAxisAlignment: MainAxisAlignment.center,
        // Yukarıdan-Aşağıya Hizalama
        crossAxisAlignment: CrossAxisAlignment.start,
        //  Row içerisine eklenen diğer widgetların listesi
        children: <Widget>[
          FloatingActionButton(
            heroTag: "btn3",
            child: Icon(Icons.home),
            elevation: 8,
            backgroundColor:
                Color.fromRGBO(51, 101, 138, 1), //Colors.tealAccent[400],
            onPressed: () {},
            mini: true,
          ),

          // Align(
          //   alignment: CrossAxisAlignment.center,
          //   child: Text(
          //     'Satılık             ',
          //     style: TextStyle(fontSize: 20.0),
          //     textAlign: TextAlign.left,
          //   ),
          // ),
          Column(
            children: <Widget>[
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Kiralık                   ",
                  style: TextStyle(fontSize: 20.0),
                  // maxLines: 10,
                ),
              ),
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Kiralık daireler & dükkanlar",
                  textAlign: TextAlign.left,
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.grey,
                  ),
                ),
              ),
            ],
          ),
          // Container(
          //   height: 22,
          //   width: 22,

          //   //: CrossAxisAlignment.center,
          //   child: FloatingActionButton(
          //     child: Icon(Icons.arrow_forward_ios),
          //     elevation: 4,
          //     backgroundColor: hbRed,
          //     onPressed: () {},
          //     mini: true,
          //   ),
          // ),
        ],
      ),
    );
  }
}

class AcilButton extends StatelessWidget {
  const AcilButton({Key key}) : super(key: key);

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

    // const MaterialColor hbRed = const MaterialColor(
    //   0xFFa90600,
    //   const <int, Color>{
    //     50: const Color(0xFFa90600),
    //     100: const Color(0xFFa90600),
    //     200: const Color(0xFFa90600),
    //     300: const Color(0xFFa90600),
    //     400: const Color(0xFFa90600),
    //     500: const Color(0xFFa90600),
    //     600: const Color(0xFFa90600),
    //     700: const Color(0xFFa90600),
    //     800: const Color(0xFFa90600),
    //     900: const Color(0xFFa90600),
    //   },
    // );

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
        final routes = [ProjelerScreen.routeName];

        ProjelerScreen.ilanTuru = 4;
        ProjelerScreen.ilanTipi = 0;
        ProjelerScreen.siteAdi = "";
        ProjelerScreen.ilanTurAdi = "Acil";
        Navigator.of(context)
            .pushNamedAndRemoveUntil(routes[0], (route) => true);
        /*...*/
      },
      child: Row(
        // mainAxisAlignment: MainAxisAlignment.center,
        // Yukarıdan-Aşağıya Hizalama
        crossAxisAlignment: CrossAxisAlignment.start,
        //  Row içerisine eklenen diğer widgetların listesi
        children: <Widget>[
          FloatingActionButton(
            heroTag: "btn4",
            child: Icon(Icons.priority_high),
            elevation: 8,
            backgroundColor: Color.fromRGBO(227, 23, 10, 1), //Colors.red,
            onPressed: () {},
            mini: true,
          ),

          // Align(
          //   alignment: CrossAxisAlignment.center,
          //   child: Text(
          //     'Satılık             ',
          //     style: TextStyle(fontSize: 20.0),
          //     textAlign: TextAlign.left,
          //   ),
          // ),
          Column(
            children: <Widget>[
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Acil                    ",
                  style: TextStyle(fontSize: 20.0),
                  // maxLines: 10,
                ),
                // Container(
                //   height: 22,
                //   width: 22,

                //   //: CrossAxisAlignment.center,
                //   child: FloatingActionButton(
                //     child: Icon(Icons.arrow_forward_ios),
                //     elevation: 4,
                //     backgroundColor: hbRed,
                //     onPressed: () {},
                //     mini: true,
                //   ),
              ),
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Acil satılıklar & kiralıklar",
                  textAlign: TextAlign.left,
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.grey,
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}

class SearchField extends StatefulWidget {
  @override
  _SearchFieldState createState() => _SearchFieldState();
}

class _SearchFieldState extends State<SearchField> {
  final Map<String, HighlightedWord> _highlights = {
    'flutter': HighlightedWord(
      onTap: () => print('flutter'),
      textStyle: const TextStyle(
        color: Colors.blue,
        fontWeight: FontWeight.bold,
      ),
    ),
    'voice': HighlightedWord(
      onTap: () => print('voice'),
      textStyle: const TextStyle(
        color: Colors.green,
        fontWeight: FontWeight.bold,
      ),
    ),
    'subscribe': HighlightedWord(
      onTap: () => print('subscribe'),
      textStyle: const TextStyle(
        color: Colors.red,
        fontWeight: FontWeight.bold,
      ),
    ),
    'like': HighlightedWord(
      onTap: () => print('like'),
      textStyle: const TextStyle(
        color: Colors.blueAccent,
        fontWeight: FontWeight.bold,
      ),
    ),
    'comment': HighlightedWord(
      onTap: () => print('comment'),
      textStyle: const TextStyle(
        color: Colors.green,
        fontWeight: FontWeight.bold,
      ),
    ),
  };

  stt.SpeechToText _speech;
  bool _isListening = false;
  String _text = 'Press the button and start speaking';
  double _confidence = 1.0;

  @override
  void initState() {
    super.initState();
    _speech = stt.SpeechToText();
  }

  showAlertDialogSpeech(BuildContext context) {
    // set up the button
    // Widget okButton = TextButton(
    //   child: Text("OK"),
    //   onPressed: () => Navigator.pop(context, false),
    // );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      content: Scaffold(
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButton: AvatarGlow(
          animate: _isListening,
          glowColor: Theme.of(context).primaryColor,
          endRadius: 75.0,
          duration: const Duration(milliseconds: 2000),
          repeatPauseDuration: const Duration(milliseconds: 100),
          repeat: true,
          child: FloatingActionButton(
            onPressed: _listen,
            child: Icon(_isListening ? Icons.mic : Icons.mic_none),
          ),
        ),
        body: SingleChildScrollView(
          reverse: true,
          child: Container(
            padding: const EdgeInsets.fromLTRB(30.0, 30.0, 30.0, 150.0),
            child: TextHighlight(
              text: _text,
              words: _highlights,
              textStyle: const TextStyle(
                fontSize: 32.0,
                color: Colors.black,
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
        ),
      ),
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  void _listen() async {
    if (!_isListening) {
      bool available = await _speech.initialize(
        onStatus: (val) => print('onStatus: $val'),
        onError: (val) => print('onError: $val'),
      );
      if (available) {
        setState(() => _isListening = true);
        _speech.listen(
          onResult: (val) => setState(() {
            _text = val.recognizedWords;
            if (val.hasConfidenceRating && val.confidence > 0) {
              _confidence = val.confidence;
            }
          }),
        );
      }
    } else {
      setState(() => _isListening = false);
      _speech.stop();
    }
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
    // return TextField(
    //     style: TextStyle(
    //       fontSize: 15.0,
    //       color: hbRed,
    //     ),
    //     decoration: InputDecoration(
    //         contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
    //         hintText: "Kelime veya İlan No ile ara",
    //         hintStyle: TextStyle(fontSize: 12),
    //         prefixIcon: Icon(
    //           Icons.search,
    //           color: hbRed,
    //         ),
    //         suffixIcon: Icon(
    //           Icons.keyboard_voice,
    //           color: hbRed,
    //         ),
    //         border: OutlineInputBorder(
    //             borderSide: BorderSide(color: hbRed, width: 32.0)),
    //         //borderRadius: BorderRadius.circular(25.0)),
    //         focusedBorder: OutlineInputBorder(
    //             borderSide: BorderSide(color: Colors.white, width: 32.0))));
    //borderRadius: BorderRadius.circular(25.0))));

    return TextButton(
      onPressed: () {
        final routes = [AramalarScreen.routeName];

        Navigator.of(context)
            .pushNamedAndRemoveUntil(routes[0], (route) => true);
      },

      child: Row(
        children: <Widget>[
          Icon(
            Icons.search,
            color: hbRed,
          ),
          Text(
            "Kelime veya İlan No ile ara",
            style: TextStyle(
              color: Colors.grey,
              fontSize: 14,
            ),
          ),
          // Spacer(),
          // IconButton(
          //     icon: Icon(
          //       Icons.keyboard_voice,
          //       color: hbRed,
          //     ),
          //     onPressed: () {
          //       // final routes = [SpokeScreen.routeName];

          //       // Navigator.of(context)
          //       //     .pushNamedAndRemoveUntil(routes[0], (route) => true);
          //       final routes = [AramalarScreen.routeName];

          //       Navigator.of(context)
          //           .pushNamedAndRemoveUntil(routes[0], (route) => true);
          //       showAlertDialogSpeech(context);
          //       // if (_isAvailable && !_isListening) {
          //       //   _speechRecognition
          //       //       .listen(locale: "tr_TR")
          //       //       .then((result) => print('$result'));
          //       // }
          //       // if (_isListening) {
          //       //   _speechRecognition.stop().then(
          //       //         (result) => setState(() => _isListening = result),
          //       //       );
          //       //   Navigator.push(
          //       //       context,
          //       //       MaterialPageRoute(
          //       //           builder: (context) => AramalarScreen(
          //       //                 result: resultText,
          //       //               )));
          //       // }
          //     }),
        ],
      ),

      // color: Colors.blue,
      // style: TextButton.styleFrom(
      //   primary: Colors.black,
      //   backgroundColor: Colors.white,
      //   padding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),

      // )
      style: ButtonStyle(
        backgroundColor:
            MaterialStateColor.resolveWith((states) => Colors.white),
        padding: MaterialStateProperty.resolveWith(
          (states) => EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
        ),
        side: MaterialStateProperty.resolveWith(
            (states) => BorderSide(color: hbRed, width: 1.0)),
        //  s    BorderRadius(borderRadius: BorderRadius.circular(25.0))

        // shape: MaterialStateProperty.resolveWith(
        // (states) =>  OutlineInputBorder(
        //   borderSide: BorderSide(color: Colors.white, width: 32.0), borderRadius: BorderRadius.circular(25.0))),
      ),
    );
  }
}

//#122a74
// class SearchField extends StatelessWidget {
//   // TextEditingController _controller = TextEditingController();
//   @override
//   Widget build(BuildContext context) {
//     const MaterialColor hbRed = const MaterialColor(
//       0xFFa90600,
//       const <int, Color>{
//         50: const Color(0xFFa90600),
//         100: const Color(0xFFa90600),
//         200: const Color(0xFFa90600),
//         300: const Color(0xFFa90600),
//         400: const Color(0xFFa90600),
//         500: const Color(0xFFa90600),
//         600: const Color(0xFFa90600),
//         700: const Color(0xFFa90600),
//         800: const Color(0xFFa90600),
//         900: const Color(0xFFa90600),
//       },
//     );
//     // return TextField(
//     //     style: TextStyle(
//     //       fontSize: 15.0,
//     //       color: hbRed,
//     //     ),
//     //     decoration: InputDecoration(
//     //         contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
//     //         hintText: "Kelime veya İlan No ile ara",
//     //         hintStyle: TextStyle(fontSize: 12),
//     //         prefixIcon: Icon(
//     //           Icons.search,
//     //           color: hbRed,
//     //         ),
//     //         suffixIcon: Icon(
//     //           Icons.keyboard_voice,
//     //           color: hbRed,
//     //         ),
//     //         border: OutlineInputBorder(
//     //             borderSide: BorderSide(color: hbRed, width: 32.0)),
//     //         //borderRadius: BorderRadius.circular(25.0)),
//     //         focusedBorder: OutlineInputBorder(
//     //             borderSide: BorderSide(color: Colors.white, width: 32.0))));
//     //borderRadius: BorderRadius.circular(25.0))));

//     return TextButton(
//       onPressed: () {
//         final routes = [AramalarScreen.routeName];

//         Navigator.of(context)
//             .pushNamedAndRemoveUntil(routes[0], (route) => true);
//       },

//       child: Row(
//         children: <Widget>[
//           Icon(
//             Icons.search,
//             color: hbRed,
//           ),
//           Text(
//             "Kelime veya İlan No ile ara",
//             style: TextStyle(
//               color: Colors.grey,
//               fontSize: 14,
//             ),
//           ),
//           Spacer(),
//           IconButton(
//               icon: Icon(
//                 Icons.keyboard_voice,
//                 color: hbRed,
//               ),
//               onPressed: (){

//                                   if (_isAvailable && !_isListening)
//                       _speechRecognition
//                           .listen(locale: "en_US")
//                           .then((result) => print('$result'));
//                   },
//               }),
//         ],
//       ),

//       // color: Colors.blue,
//       // style: TextButton.styleFrom(
//       //   primary: Colors.black,
//       //   backgroundColor: Colors.white,
//       //   padding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),

//       // )
//       style: ButtonStyle(
//         backgroundColor:
//             MaterialStateColor.resolveWith((states) => Colors.white),
//         padding: MaterialStateProperty.resolveWith(
//           (states) => EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
//         ),
//         side: MaterialStateProperty.resolveWith(
//             (states) => BorderSide(color: hbRed, width: 1.0)),
//         //  s    BorderRadius(borderRadius: BorderRadius.circular(25.0))

//         // shape: MaterialStateProperty.resolveWith(
//         // (states) =>  OutlineInputBorder(
//         //   borderSide: BorderSide(color: Colors.white, width: 32.0), borderRadius: BorderRadius.circular(25.0))),
//       ),
//     );
//   }
// }
