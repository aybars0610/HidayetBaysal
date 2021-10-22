//   Widget _buildPassword() {
//     return TextFormField(
//       obscureText: _obscureText,
//       decoration: InputDecoration(
//           labelText: '*****',
//           suffixIcon: IconButton(
//             icon: Icon(Icons.visibility),
//             onPressed: () {
//               _toggle();
//             },
//           )),
//       // keyboardType: TextInputType.visiblePassword,
//       validator: (String value) {
//         if (value.isEmpty) {
//           return '*Bu alanı doldurmak zorunlu';
//         }
//         if (0 < value.length && value.length < 6) {
//           return 'Şifreniz en az 6 basamaklı olmalıdır.';
//         }

//         return null;
//       },
//       onSaved: (String value) {
//         _password = value;
//       },
//     );
//   }

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:ilk_projem/Data/User.dart';
import 'package:ilk_projem/screens/customer_screen.dart';
import 'package:ilk_projem/screens/phoneChange.dart';
import 'package:ilk_projem/screens/profilim_screen.dart';
import 'package:ilk_projem/screens/projeler_screen.dart';
//import 'package:ilk_projem/screens/main_menu.dart';

//import 'contact.dart';
final storage = FlutterSecureStorage();

class SifreDegisScreen extends StatefulWidget {
  static const String routeName = "/sifreDegisikligi";

  @override
  _SifreDegisScreenState createState() => _SifreDegisScreenState();
}

// class Routes {
//   static const String contacts = ContactScreen.routeName;
//   static const String customer = CustomerScreen.routeName;
//   static const String anasayfa = MainMenu.routeName;
//   // static const String notes = NotesPage.routeName;
// }

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

class _SifreDegisScreenState extends State<SifreDegisScreen> {
  // User _userDetay = User();
  String _mevcutSifre;
  String _yeniSifre;
  String _tekrarSifre;

  bool _obscureText = true;

  // Toggles the password show status
  void _toggle() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

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

  // for (var emlakJson in emlakDetayListeJson) {

  // }
  // }
  // var order = await emlakDetayListe.length != 0;
  // _emlakDetay = emlakDetay;
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
    var telNo = "";
    var yeniSifre = ProfilimScreen.newPassword;
    var yeniSifreTekrar = ProfilimScreen.newPasswordConfirm;

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
        returnValue = true;

        var jwtString = json.encode(response);
        storage.write(key: "jwt", value: jwtString);
        displayDialog(context, "BİLDİRİ",
            "Güncelleme işlemi başarı ile gerçekleşmiştir.");
        // Navigator.pushNamed(context, ProfilimScreen.routeName);

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

  showAlertDialogBildirim(BuildContext context) {
    // set up the button
    Widget okButton = TextButton(
      child: Text("OK"),
      onPressed: () => Navigator.pop(context, true),
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("UYARI"),
      content: Text("Lütfen gerekli alanları doldurunuz."),
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

  showAlertDialogMevcutSifre(BuildContext context) {
    // set up the button
    Widget okButton = TextButton(
      child: Text("OK"),
      onPressed: () => Navigator.pop(context, true),
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("Bilgilendirme"),
      content: Text("Lütfen mevcut şifrenizin doğruluğundan emin olunuz."),
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

  showAlertDialogSifreTekrar(BuildContext context) {
    // set up the button
    Widget okButton = TextButton(
      child: Text("OK"),
      onPressed: () => Navigator.pop(context, true),
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("Bilgilendirme"),
      content: Text("Şifreniz tekrarı ile uyuşmuyor."),
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

  showAlertDialogSifreKontrol(BuildContext context) {
    // set up the button
    Widget okButton = TextButton(
      child: Text("OK"),
      onPressed: () => Navigator.pop(context, true),
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("Bilgilendirme"),
      content: Text(
          "Mevcut şifrenizin doğruluğundan emin olun ve Yeni şifreniz tekrarı ile uyuşmuyor "),
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

  showAlertDialogSifreSuccess(BuildContext context) {
    // set up the button
    Widget okButton = TextButton(
      child: Text("OK"),
      onPressed: () =>
          Navigator.popAndPushNamed(context, ProfilimScreen.routeName),
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("Bilgilendirme"),
      content: Text("Şifre değişikliğiniz yapılmıştır"),
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
        appBar: AppBar(title: Text("Şifre Değişikliği")
            //   ],
            // ),
            ),
        body: Container(
            margin: EdgeInsets.all(25.0),
            child: SingleChildScrollView(
                child: Form(
                    key: _formKey,
                    child: Column(children: <Widget>[
                      TextFormField(
                        obscureText: _obscureText,
                        decoration: InputDecoration(
                            labelText: 'Mevcut Şifre',
                            suffixIcon: IconButton(
                              icon: Icon(Icons.visibility),
                              onPressed: () {
                                _toggle();
                              },
                            )),
                        // keyboardType: TextInputType.visiblePassword,
                        validator: (String value) {
                          if (value.isEmpty) {
                            return '*Bu alanı doldurmak zorunlu';
                          }

                          return null;
                        },
                        onChanged: (String value) {
                          _mevcutSifre = value;
                        },
                      ),
                      TextFormField(
                        obscureText: _obscureText,
                        decoration: InputDecoration(
                            labelText: 'Yeni Şifre',
                            suffixIcon: IconButton(
                              icon: Icon(Icons.visibility),
                              onPressed: () {
                                _toggle();
                              },
                            )),
                        // keyboardType: TextInputType.visiblePassword,
                        validator: (String value) {
                          if (value.isEmpty) {
                            return '*Bu alanı doldurmak zorunlu';
                          }
                          if (0 < value.length && value.length < 6) {
                            return 'Şifreniz en az 6 basamaklı olmalıdır.';
                          }

                          return null;
                        },
                        onChanged: (String value) {
                          _yeniSifre = value;
                        },
                      ),
                      TextFormField(
                        obscureText: _obscureText,
                        decoration: InputDecoration(
                            labelText: "Yeni Şifre(Tekrar)",
                            suffixIcon: IconButton(
                              icon: Icon(Icons.visibility),
                              onPressed: () {
                                _toggle();
                              },
                            )),
                        // keyboardType: TextInputType.visiblePassword,
                        validator: (String value) {
                          if (value.isEmpty) {
                            return '*Bu alanı doldurmak zorunlu';
                          }
                          if (0 < value.length && value.length < 6) {
                            return 'Şifreniz en az 6 basamaklı olmalıdır.';
                          }

                          return null;
                        },
                        onChanged: (String value) {
                          _tekrarSifre = value;
                        },
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
                        onPressed: () async {
                          if (_formKey.currentState.validate() &&
                              _mevcutSifre != ProfilimScreen.password) {
                            showAlertDialogMevcutSifre(context);
                          } else if (_formKey.currentState.validate() &&
                              _yeniSifre != _tekrarSifre) {
                            showAlertDialogSifreTekrar(context);
                          } else if (_formKey.currentState.validate() &&
                              _yeniSifre != _tekrarSifre &&
                              _mevcutSifre != ProfilimScreen.password) {
                            showAlertDialogSifreKontrol(context);
                          } else {
                            ProfilimScreen.newPassword = _yeniSifre;
                            ProfilimScreen.newPasswordConfirm = _tekrarSifre;
                            var isSuccess = await profilGuncelleme();
                            if (isSuccess) {
                              ProfilimScreen.password = _yeniSifre;
                              showAlertDialogSifreSuccess(context);
                              //Navigator.popAndPushNamed(context, ProfilimScreen.routeName);
                            }
                          }

                          if (!_formKey.currentState.validate()) {
                            showAlertDialogBildirim(context);
                          }

                          _formKey.currentState.save();

                          //Send to API
                        },
                      ),
                    ])))));
  }
}
