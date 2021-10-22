// return Scaffold(
//       appBar: AppBar(
//         flexibleSpace: Row(
//           mainAxisAlignment: MainAxisAlignment.center,
//           // crossAxisAlignment: CrossAxisAlignment.end,

//           children: [
//             Text(
//               "Projeler",
//               style: TextStyle(
//                   fontWeight: FontWeight.bold,
//                   color: Colors.white,
//                   fontSize: 20),
//             ),
//             Padding(
//               padding: EdgeInsets.symmetric(
//                 vertical: 200,
//               ),
//             ),
//           ],
//         ),
//         actions: <Widget>[
//           Padding(
//               padding: EdgeInsets.only(right: 10.0),
//               child: GestureDetector(
//                 onTap: () {
//                   Navigator.pushNamed(context, AramalarScreen.routeName);
//                 },
//                 child: Icon(
//                   Icons.search,
//                   size: 26.0,
//                 ),
//               )),
//           Padding(
//               padding: EdgeInsets.only(right: 24.0),
//               child: GestureDetector(
//                 onTap: () {
//                   //   Share.share("hidayetbaysal.com'da incelediğim arama sonucunu sizinle paylaşmak istiyorum");
//                 },
//                 child: Icon(Icons.share),
//               )),
//         ],
//       ),

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import 'package:ilk_projem/Data/User.dart';
import 'package:ilk_projem/screens/profilim_screen.dart';
import 'package:ilk_projem/screens/projeler_screen.dart';
import 'package:ilk_projem/screens/sifreDegis.dart';

import 'contact.dart';
import 'customer_screen.dart';
import 'main_menu.dart';
//import 'package:ilk_projem/screens/main_menu.dart';

//import 'contact.dart';

final storage = FlutterSecureStorage();

class PhoneChangeScreen extends StatefulWidget {
  static const String routeName = "/numaraDegistir";

  @override
  _PhoneChangeScreenState createState() => _PhoneChangeScreenState();
}

class Routes {
  static const String contacts = ContactScreen.routeName;
  static const String customer = CustomerScreen.routeName;
  static const String anasayfa = MainMenu.routeName;
  static const String sifreDegis = SifreDegisScreen.routeName;
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

class _PhoneChangeScreenState extends State<PhoneChangeScreen> {
  String _phone;
  dynamic basamak;
  dynamic basamak1;
  dynamic basamak2;
  dynamic basamak3;
  dynamic basamak4;
  dynamic basamak5;
  dynamic basamak6;
  dynamic basamak7;
  dynamic basamak8;
  dynamic basamak9;
  dynamic basamak10;
  dynamic basamak11;
  dynamic basamak10Test;
  dynamic basamak11Test;
  dynamic sonuc;
  User _userDetay = User();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  // Future<User> fetchUserDetay() async {
  //   // var url =
  //   //     "file:///C:/Users/oozge/OneDrive/Masa%C3%BCst%C3%BC/emlakexample.json";
  //   // var response = await http.get(url);
  //   var userDetay = User();

  //   var response =
  //       """[{"Id":1,"Ad":"Özge","Soyad":"Kazan","PhoneNumber":"+905543802228","Password":"123456a","Mail":"oozgeeozdemir@gmail.com","TcKimlik":"28466496656","KullaniciAdi":"28466496656","EvSahibi":true,"Bilgilendirme":true,"Sozlesme":true}]""";

  //   // if (response.statusCode == 200) {
  //   // var emlakDetayListeJson = json.decode(response.body);
  //   // var emlakDetayListeJson = json.decode(response);
  //   try {
  //     // emlakDetay = json.decode(response);
  //     var jsonresponse = json.decode(response);
  //     userDetay = User.fromJson(jsonresponse[0]);
  //   } on Exception catch (_) {
  //     var abc = "abc";
  //   } catch (error) {
  //     var cba = "cba";
  //     // executed for errors of all types other than Exception
  //   }

  //   // for (var emlakJson in emlakDetayListeJson) {

  //   // }
  //   // }
  //   // var order = await emlakDetayListe.length != 0;
  //   // _emlakDetay = emlakDetay;
  //   return userDetay;
  // }

  // @override
  // void initState() {
  //   fetchUserDetay().then((value) {
  //     setState(() {
  //       _userDetay = value;
  //     });
  //   });
  //   super.initState();
  // }
  void displayDialog(context, title, text) => showDialog(
        context: context,
        builder: (context) =>
            AlertDialog(title: Text(title), content: Text(text)),
      );

  Future<bool> profilGuncelleme() async {
    var returnValue = false;
    var username = ProfilimScreen.userName;

    var email = "";
    var telNo = ProfilimScreen.phoneNumber;
    var yeniSifre = "";
    var yeniSifreTekrar = "";

    var password = ProfilimScreen.password;

    var url = "IlanBilgileri/PostKullaniciBilgileriGuncelle";

    Map map = {
      'Username': username,
      'Password': password,
      'TelNo': telNo,
      'Email': email,
      'NewPassword': yeniSifre,
      'NewPasswordConfirm': yeniSifreTekrar
    };

    var response = await apiRequest(url, map, "Post");

    if (response != null) {
      if (response != "false") {
        var jwtString = json.encode(sonuc);

        returnValue = true;
        displayDialog(context, "BİLDİRİ",
            "Güncelleme işlemi başarı ile gerçekleşmiştir.");
        //Navigator.pushNamed(context, ProfilimScreen.routeName);

        // Navigator.push(
        //     context,
        //     MaterialPageRoute(
        //         builder: (context) =>
        //             Routes.anasayfa.fromBase64(jwt)));
      } else {
        displayDialog(context, "HATA", "Kayıt işleminde hata oluştu.");
      }
    }
    return returnValue;
  }

  showAlertDialogTelKaydet(BuildContext context) {
    // set up the button
    Widget iptalButton = TextButton(
      child: Text("İPTAL"),
      onPressed: () => Navigator.pop(context, false),
    );
    Widget okButton = TextButton(
        child: Text("OK"),
        onPressed: () async {
          //Navigator.pop(context, true);
          var isSuccess = await profilGuncelleme();
          if (isSuccess) {
            ProfilimScreen.phoneNumber = _phone;
            //Navigator.pop(context);
            Navigator.popAndPushNamed(context, ProfilimScreen.routeName);
          }
          //Navigator.popAndPushNamed(context, ProfilimScreen.routeName);
        });

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("BİLDİRİ"),
      content: Text(
          "Cep telefonu numaranızı değiştirmek istediğinizden emin misiniz?"),
      actions: [
        iptalButton,
        okButton,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  showAlertDialogBildirim(BuildContext context) {
    // set up the button
    Widget okButton = TextButton(
      child: Text("OK"),
      onPressed: () => Navigator.pop(context, true),
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("UYARI"),
      content: Text("Lütfen Cep Telefonu Numaranızı kontrol ediniz."),
      actions: [
        okButton,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  rakamMi(String str) {
    RegExp _numeric = new RegExp(r'^-?[0-9]+$');

    return _numeric.hasMatch(str);
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
        appBar: AppBar(title: Text("Numara Değiştirme")
            //   ],
            // ),
            ),
        body: Container(
            margin: EdgeInsets.all(25.0),
            child: SingleChildScrollView(
                child: Form(
                    key: _formKey,
                    child: Column(children: <Widget>[
                      Text("Numaranı Değiştir"),
                      SizedBox(height: 10.0),
                      Row(
                        // mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: <Widget>[
                          Expanded(
                            child: TextFormField(
                              initialValue: "05",
                              decoration: InputDecoration(
                                  labelText: 'Yeni Cep Telefonu Numaranız'),
                              maxLength: 11,
                              validator: (String value) {
                                if (value.length < 3) {
                                  return '*Bu alanı doldurmak zorunlu';
                                }

                                if (rakamMi(value) == true) {
                                  if (value.length ==
                                      11) //onbir haneyse işleme devam et
                                  {
                                    basamak = value.split("");
                                    basamak1 = num.parse(basamak[0]);
                                    basamak2 = num.parse(basamak[1]);
                                    basamak3 = num.parse(basamak[2]);
                                    basamak4 = num.parse(basamak[3]);
                                    basamak5 = num.parse(basamak[4]);
                                    basamak6 = num.parse(basamak[5]);
                                    basamak7 = num.parse(basamak[6]);
                                    basamak8 = num.parse(basamak[7]);
                                    basamak9 = num.parse(basamak[8]);
                                    basamak10 = num.parse(basamak[9]);
                                    basamak11 = num.parse(basamak[10]);

                                    basamak10Test = ((basamak1 +
                                                    basamak3 +
                                                    basamak5 +
                                                    basamak7 +
                                                    basamak9) *
                                                7 -
                                            (basamak2 +
                                                basamak4 +
                                                basamak6 +
                                                basamak8)) %
                                        10;
                                    basamak11Test = (basamak1 +
                                            basamak2 +
                                            basamak3 +
                                            basamak4 +
                                            basamak5 +
                                            basamak6 +
                                            basamak7 +
                                            basamak8 +
                                            basamak9 +
                                            basamak10) %
                                        10;
                                  }

                                  if (value.length !=
                                      11) //onbir hane değilse geçersizdir.
                                  {
                                    sonuc = false;
                                    return '*Geçersiz Cep Telefonu Numarası';
                                  } else if (basamak1 != 0 &&
                                      basamak2 !=
                                          5) //birinci basamak sıfır ve ikinci basamak 5 değilse
                                  {
                                    sonuc = false;
                                    return '*Geçersiz Cep Telefonu Numarası';
                                  } else if (!rakamMi(basamak1.toString()) ||
                                      !rakamMi(basamak2.toString()) ||
                                      !rakamMi(basamak3.toString()) ||
                                      !rakamMi(basamak4.toString()) ||
                                      !rakamMi(basamak5.toString()) ||
                                      !rakamMi(basamak6.toString()) ||
                                      !rakamMi(basamak7.toString()) ||
                                      !rakamMi(basamak8.toString()) ||
                                      !rakamMi(basamak9.toString()) ||
                                      !rakamMi(basamak10.toString()) ||
                                      !rakamMi(basamak11.toString())) {
                                    sonuc = "false";
                                    return '*Geçersiz Cep Telefonu Numarası';
                                  } else {
                                    sonuc = true;
                                  }
                                } else {
                                  sonuc = false;
                                  return '*Geçersiz Cep Telefonu Numarası';
                                }

                                return null;
                              },
                              onChanged: (String value) {
                                _phone = value;
                              },
                            ),
                          )
                        ],
                      ),
                      ElevatedButton(
                        style: ButtonStyle(
                            shadowColor: MaterialStateColor.resolveWith(
                                (states) => hbRed),
                            backgroundColor: MaterialStateColor.resolveWith(
                                (states) => Colors.white),
                            foregroundColor: MaterialStateColor.resolveWith(
                                (states) => hbRed),
                            shape: MaterialStateProperty.resolveWith((states) =>
                                new RoundedRectangleBorder(
                                  borderRadius: new BorderRadius.circular(2.0),
                                ))),
                        // width: 2.0, color: const Color(0xFFa90600)))),
                        // textColor: hbRed,
                        // color: Colors.white,
                        child: Text('KAYDET'),
                        // shape: Border.all(
                        //     width: 2.0, color: const Color(0xFFa90600)),
                        onPressed: () {
                          if (!_formKey.currentState.validate()) {
                            showAlertDialogBildirim(context);
                          } else {
                            showAlertDialogTelKaydet(context);
                          }

                          _formKey.currentState.save();

                          //Send to API
                        },
                      ),
                    ])))));
  }
}
