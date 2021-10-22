import 'dart:convert';
//import 'dart:io';

// import 'package:carousel_slider/carousel_options.dart';
// import 'package:carousel_slider/carousel_slider.dart';

// import 'package:carousel_slider/carousel_controller.dart';
// import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:ilk_projem/Data/EmlakDetailData.dart';
import 'package:ilk_projem/Data/User.dart';

// import 'package:photo_view/photo_view_gallery.dart';

import 'package:ilk_projem/screens/contact.dart';
import 'package:ilk_projem/screens/customer_screen.dart';
import 'package:ilk_projem/screens/kiraliklar.dart';
import 'package:ilk_projem/screens/projeler_screen.dart';
import 'package:ilk_projem/screens/satiliklar.dart';

// import 'package:map_launcher/map_launcher.dart';
// import 'package:flutter_svg/flutter_svg.dart';

class SifremiUnuttumScreen extends StatefulWidget {
  static bool a = false;

  // List<bool> isSelected = List.generate(3, (_) => false);

  static const String routeName = "/sifremiUnuttum";
  // final String title;
  @override
  _SifremiUnuttumScreenState createState() => _SifremiUnuttumScreenState();
}

@override
State<StatefulWidget> createState() {
  return _SifremiUnuttumScreenState();
}

class Routes {
  static const String contacts = ContactScreen.routeName;
  static const String customer = CustomerScreen.routeName;
  static const String satilik = SatilikScreen.routeName;
  static const String kiralik = KiralikScreen.routeName;
  static const String projeler = ProjelerScreen.routeName;

  // static const String notes = NotesPage.routeName;
}

class _SifremiUnuttumScreenState extends State<SifremiUnuttumScreen> {
  // final CarouselController _controller = CarouselController();

  // SingingCharacter _character = SingingCharacter.lafayette;
  get pageFetch => null;
  String _email;

  List<String> _imgList = [];
  List<Widget> imageSliders = [];

  ///
  List<User> _userListe = [];

  Future<List<User>> fetchUserListe() async {
    // var url =
    //     "file:///C:/Users/oozge/OneDrive/Masa%C3%BCst%C3%BC/emlakexample.json";
    // var response = await http.get(url);
    List<User> userListe = [];

    var response =
        """[{"Id":1,"Ad":"Özge","Soyad":"Kazan","PhoneNumber":"05543802228","Password":"123456a","Mail":"oozgeeozdemir@gmail.com","EvSahibi":true,"Bilgilendirme":true,"Sozlesme":true},{"Id":2,"Ad":"Yunus Emre","Soyad":"Kazan","PhoneNumber":"05434364000","Password":"1234567","Mail":"yunusemrekazann@gmail.com","EvSahibi":false,"Bilgilendirme":false,"Sozlesme":true}]""";

    // if (response.statusCode == 200) {
    // var emlakListeJson = json.decode(response.body);
    var userListeJson = json.decode(response);

    for (var userJson in userListeJson) {
      userListe.add(User.fromJson(userJson));
    }
    // }
    // var order = await emlakListe.length != 0;
    return userListe;
  }

  ///

  @override
  void initState() {
    fetchUserListe().then((value) {
      setState(() {
        _userListe.addAll(value);
      });
    });
    super.initState();
  }

  // Widget _buildEmail() {
  //   return TextFormField(
  //     decoration: InputDecoration(labelText: 'E-mail Adresi'),
  //     validator: (String value) {
  //       if (value.isEmpty) {
  //         return '*Bu alanı doldurmak zorunlu';
  //       }

  //       if (!RegExp(
  //               r"[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&'*+/=?^_`{|}~-]+)*@(?:[a-z0-9](?:[a-z0-9-]*[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?")
  //           .hasMatch(value)) {
  //         return 'Lütfen geçerli bir E-mail Adresi Giriniz';
  //       }

  //       return null;
  //     },
  //     onSaved: (String value) {
  //       value = value.trim();
  //       _email = value;
  //     },
  //   );
  // }

  // List<String> imgList = _emlakDetay.fotograflar;

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

    /*...*/
    return Scaffold(
      appBar: AppBar(
        title: Text("Şifre Unuttum"),

        // flexibleSpace: Row(
        //   mainAxisAlignment: MainAxisAlignment.center,
        //   // crossAxisAlignment: CrossAxisAlignment.end,

        //   children: [
        //     Text(
        //       "Şifre Unuttum",
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
      body: Container(
        margin: EdgeInsets.all(20.0),
        child: Column(
          children: <Widget>[
            SizedBox(
                child: Text(
                    "Öncelikle size ait hesabı bulmamız gerekiyor. Lütfen e-posta adresinizi yazın ve devam edin.")),
            // _buildEmail(),
            Expanded(
              child: TextFormField(
                decoration: InputDecoration(labelText: 'E-mail Adresi'),
                validator: (String value) {
                  if (value.isEmpty) {
                    return '*Bu alanı doldurmak zorunlu';
                  }

                  if (!RegExp(
                          r"[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&'*+/=?^_`{|}~-]+)*@(?:[a-z0-9](?:[a-z0-9-]*[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?")
                      .hasMatch(value)) {
                    return 'Lütfen geçerli bir E-mail Adresi Giriniz';
                  }

                  return null;
                },
                onSaved: (String value) {
                  value = value.trim();
                  _email = value;
                },
              ),
            ),
            TextButton(
              child: Text("Devam Et"),
              onPressed: () {
                //api ye gönderilecek ve apiden gelen cevaba göre alert dialog dönecek
              },
            ),
          ],
        ),
      ),
    );
  }
}
