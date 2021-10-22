// import 'dart:html';
import 'dart:convert';
import 'dart:ui';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:ilk_projem/Data/Register.dart';
import 'package:ilk_projem/screens/main_menu.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:http/http.dart' as http;
import 'package:ilk_projem/screens/projeler_screen.dart';

import 'contact.dart';
import 'customer_screen.dart';
// import 'package:tckimlikno/tckimlikno.dart';

class UyeOlScreen extends StatefulWidget {
  static const String routeName = "/uyeol";

  @override
  _UyeOlScreenState createState() => _UyeOlScreenState();
}

class Routes {
  static const String contacts = ContactScreen.routeName;
  static const String customer = CustomerScreen.routeName;
  static const String anasayfa = MainMenu.routeName;
  // static const String notes = NotesPage.routeName;
}

// Future<String> uyeOl(Map jsonMap) async {
//   String reply = "";
//   var response = await http.post(
//     Uri.http("192.168.1.106", '/api/Account'),
//     headers: <String, String>{
//       'Content-Type': 'application/json; charset=UTF-8',
//     },
//     body: jsonMap,
//   );
//   if (response.statusCode == 200) {
//     reply = response.body;
//   }
//   return reply;
// }

// json ="""[{"Id":1,"Ad":"Özge","Soyad":"Kazan","PhoneNumber":"05543802228","Password":"123456a","Mail":"oozgeeozdemir@gmail.com","EvSahibi":true,"Bilgilendirme":true,"Sozlesme":true},{"Id":2,"Ad":"Yunus Emre","Soyad":"Kazan","PhoneNumber":"05434364000","Password":"1234567","Mail":"yunusemrekazann@gmail.com","EvSahibi":false,"Bilgilendirme":false,"Sozlesme":true}]""";

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

class _UyeOlScreenState extends State<UyeOlScreen> {
  String _username;
  String _name;
  String _surname;
  String _email;
  String _password;
  bool _sozlesme = false;
  bool _bildiri = false;
  String _tc;
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

  bool _obscureText = true;

  // Toggles the password show status
  void _toggle() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  Widget _buildUserName() {
    return TextFormField(
      decoration: InputDecoration(labelText: 'Kullanıcı Adı'),
      maxLength: 25,
      validator: (String value) {
        if (value.isEmpty) {
          return '*Bu alanı doldurmak zorunlu';
        }

        return null;
      },
      onSaved: (String value) {
        _username = value;
      },
    );
  }

  Widget _buildName() {
    return TextFormField(
      decoration: InputDecoration(labelText: 'Ad'),
      maxLength: 25,
      validator: (String value) {
        if (value.isEmpty) {
          return '*Bu alanı doldurmak zorunlu';
        }

        return null;
      },
      onSaved: (String value) {
        _name = value;
      },
    );
  }

  Widget _buildSurName() {
    return TextFormField(
      decoration: InputDecoration(labelText: 'Soyad'),
      maxLength: 25,
      validator: (String value) {
        if (value.isEmpty) {
          return '*Bu alanı doldurmak zorunlu';
        }

        return null;
      },
      onSaved: (String value) {
        _surname = value;
      },
    );
  }

  Widget _buildEmail() {
    return TextFormField(
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
        _email = value;
      },
    );
  }

  rakamMi(String str) {
    RegExp _numeric = new RegExp(r'^-?[0-9]+$');

    return _numeric.hasMatch(str);
  }

  Widget _buildTcKimlik() {
    return TextFormField(
      decoration: InputDecoration(
        labelText: 'TC Kimlik No',
      ),
      // keyboardType: TextInputType.visiblePassword,
      validator: (String value) {
        if (value.isNotEmpty) {
          //   return '*Bu alanı doldurmak zorunlu';
          // }

          if (rakamMi(value) == true) {
            if (value.length == 11) //onbir haneyse işleme devam et
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

              basamak10Test =
                  ((basamak1 + basamak3 + basamak5 + basamak7 + basamak9) * 7 -
                          (basamak2 + basamak4 + basamak6 + basamak8)) %
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

            if (value.length != 11) //onbir hane değilse geçersizdir.
            {
              sonuc = false;
              return '*Geçersiz TC Kimlik Numarası';
            } else if (basamak1 == 0) //birinci basamak sıfır olamaz
            {
              sonuc = false;
              return '*Geçersiz TC Kimlik Numarası';
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
              return '*Geçersiz TC Kimlik Numarası';
            } else if (basamak10Test !=
                basamak10) // T.C. Kimlik Numaralarımızın 1. 3. 5. 7. ve 9. hanelerinin toplamının 7 katından, 2. 4. 6. ve 8. hanelerinin toplamı çıkartıldığında, elde edilen var sonucun 10'a bölümünden kalan, yani Mod10'u bize 10. haneyi verir.
            {
              sonuc = false;
              return '*Geçersiz TC Kimlik Numarası';
            } else if (basamak11Test !=
                basamak11) // 1. 2. 3. 4. 5. 6. 7. 8. 9. ve 10. hanelerin toplamından elde edilen var sonucun 10'a bölümünden kalan, yani Mod10'u bize 11. haneyi verir.
            {
              sonuc = false;
              return '*Geçersiz TC Kimlik Numarası';
            } else {
              sonuc = true;
            }
          } else {
            sonuc = false;
            return '*Geçersiz TC Kimlik Numarası';
          }
        }
        return null;
      },
      onSaved: (String value) {
        _tc = value;
      },
    );
  }

  void UyeTalep() async {
    var username = _username.trim();
    var name = _name.trim();
    var surname = _surname.trim();
    var email = _email.trim();
    var tc = _tc.trim();
    var password = _password.trim();

    var url = "/Account/Register";

    Map map = {
      'Register': {
        'Name': name,
        'Surname': surname,
        'Password': password,
        'Username': username,
        'Email': email,
        'TC': tc,
        'ConfirmPassword': password
      }
    };

    var response = await apiRequest(url, map, "Post");

    if (response != null) {
      var register = json.decode(response);
      var sonuc = Register.fromJson(register);
      if (sonuc.success) {
        Navigator.pushReplacementNamed(context, Routes.customer);
      }
      displayDialog(context, "BİLDİRİ", sonuc.message);

      // Navigator.push(
      //     context,
      //     MaterialPageRoute(
      //         builder: (context) =>
      //             Routes.anasayfa.fromBase64(jwt)));
    } else {
      displayDialog(context, "HATA", "Kayıt işleminde hata oluştu.");
    }
  }

  Widget _buildPassword() {
    return TextFormField(
      obscureText: _obscureText,
      decoration: InputDecoration(
          labelText: 'Şifre',
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
      onSaved: (String value) {
        _password = value;
      },
    );
  }

  showAlertDialogBildirim(BuildContext context) {
    // int _radioValue1 = 0;
    // set up the button
    Widget iptalButton = ElevatedButton(
        child: Text("İzin Vermeden Devam Et"),
        onPressed: () {
          Navigator.pop(context, false);
          // showAlertDialogUyeTalep(context);
          UyeTalep();
          setState(() {
            _bildiri = false;
          });
        });
    Widget okButton = ElevatedButton(
      onPressed: () {
        Navigator.pop(context, false);
        // showAlertDialogUyeTalep(context);
        UyeTalep();
        setState(() {
          _bildiri = true;
        });
      },
      style: ElevatedButton.styleFrom(
          primary: Colors.blue,
          textStyle: TextStyle(fontWeight: FontWeight.bold)),
      child: Text("İzin Veriyorum"),
    );

    showDialog(
        context: context,
        builder: (BuildContext context) {
          return StatefulBuilder(
            builder: (context, setState) {
              return AlertDialog(
                title: Column(
                  children: <Widget>[
                    Icon(
                      Icons.notification_important,
                      color: Colors.yellow[700],
                    ),
                    Text("BİLDİRİ")
                  ],
                ),

                content: Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height,
                  child:
                      Column(mainAxisSize: MainAxisSize.min, children: <Widget>[
                    Expanded(
                      child: Text(
                          "Size özel kampanya, fırsat ve indirimlerden faydalanabilmeniz için göndereceğimiz site içi bilgilendirme mesajları, e-posta SMS vb. elektronik iletiler ve aramalar için izin vermenizi tavsiye ederiz."),
                    ),
                    SizedBox(
                        width: 320.0,
                        child: Column(children: <Widget>[
                          okButton,
                          iptalButton,
                        ]))
                  ]),
                ),

                //);
                // }
              );
            },
          );
        });
  }

  ///
  showAlertDialogUye(BuildContext context) {
    // set up the button
    Widget okButton = TextButton(
      child: Text("OK"),
      onPressed: () => Navigator.pop(context, true),
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("UYARI"),
      content: Text(
          "Lütfen gerekli alanları doldurun ve üyelik sözleşmesini işaretleyiniz."),
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

  void displayDialog(context, title, text) => showDialog(
        context: context,
        builder: (context) =>
            AlertDialog(title: Text(title), content: Text(text)),
      );

  showAlertDialogUyeTalep(BuildContext context) {
    // set up the button
    Widget okButton = TextButton(
      child: Text("OK"),
      onPressed: () => Navigator.pop(context, false),
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("BİLDİRİ"),
      content: Text("Üyelik talebiniz alınmıştır."),
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

  // showAlertDialogBildirim(BuildContext context) {
  //   // set up the button
  //   Widget okButton = TextButton(
  //     child: Text("İzin Veriyorum",
  //         style: TextStyle(backgroundColor: Colors.blue, color: Colors.white)),
  //     onPressed: () => Navigator.pop(context, true),
  //   );
  //   Widget iptalButton = TextButton(
  //     child: Text("İzin Vermiyorum"),
  //     onPressed: () => Navigator.pop(context, true),
  //   );

  //   // set up the AlertDialog
  //   AlertDialog alert = AlertDialog(
  //     title: Text("BİLDİRİ"),

  //     content: Text(
  //         "Size özel kampanya, fırsat ve indirimlerden faydalanabilmeniz için göndereceğimiz site içi bilgilendirme mesajları, e-posta SMS vb. elektronik iletiler ve aramalar için izin vermenizi tavsiye ederiz."),
  //     actions: [okButton, iptalButton],
  //   );

  //   // show the dialog
  //   showDialog(
  //     context: context,
  //     builder: (BuildContext context) {
  //       return alert;
  //     },
  //   );
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
        appBar: AppBar(
          flexibleSpace: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Image.asset(
                'assets/logo/hblogopng.png',
                fit: BoxFit.cover,
                width: 40,
                height: 40,
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 38),
              ),
            ],
          ),
          elevation: 30.0,
          brightness: Brightness.light,
        ),
        //  AppBar(
        //   flexibleSpace: Row(
        //     mainAxisAlignment: MainAxisAlignment.center,
        //     crossAxisAlignment: CrossAxisAlignment.end,
        //     children: [
        //       Image.asset(
        //         'assets/logo/hblogopng.png',
        //         fit: BoxFit.cover,
        //         width: 40,
        //         height: 40,
        //       ),
        //       Padding(
        //         padding: EdgeInsets.symmetric(vertical: 35),
        //       ),
        //     ],
        //   ),
        // ),
        body: SingleChildScrollView(
          child: Container(
            margin: EdgeInsets.all(24),

            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    'ÜYE OL',
                    style: TextStyle(
                        color: hbRed,
                        fontWeight: FontWeight.w500,
                        fontSize: 20),
                  ),
                  _buildUserName(),
                  _buildName(),
                  _buildSurName(),
                  _buildTcKimlik(),
                  _buildEmail(),
                  _buildPassword(),
                  Row(
                    children: [
                      Checkbox(
                        value: _sozlesme,
                        onChanged: (value) {
                          setState(() {
                            _sozlesme = !_sozlesme;
                          });
                        },
                        //  if (value == false) {
                        //     return '*Bu alanı işaretlemek zorunlu';
                        //   }
                      ),
                      Flexible(
                          child: RichText(
                              text: TextSpan(children: [
                        new TextSpan(
                          text: 'Bireysel Üyelik Sözleşmesi ve Eklerini',
                          style: new TextStyle(color: Colors.blue),
                          recognizer: new TapGestureRecognizer()
                            ..onTap = () {
                              launch(
                                  'https://docs.flutter.io/flutter/services/UrlLauncher-class.html');
                            },
                        ),
                        new TextSpan(
                          text: ' kabul ediyorum. ',
                          style: new TextStyle(color: Colors.black),
                        ),
                      ])))
                    ],
                  ),
                  Row(
                    children: [
                      Checkbox(
                        value: _bildiri,
                        onChanged: (value) {
                          setState(() {
                            _bildiri = !_bildiri;
                          });
                        },
                      ),
                      Flexible(
                        child: Text(
                            'İletişim bilgilerime kampanya, tanıtım ve reklam içerikli ticari elektronik ileti gönderilmesine, bu amaçla kişisel verilerimin işlenmesine ve tedarikçilerinizle paylaşılmasına izin veriyorum.'),
                      ),
                    ],
                  ),
                  SizedBox(height: 10),
                  ElevatedButton(
                      child: Text(
                        'Üye Ol',
                        style: TextStyle(color: Colors.white, fontSize: 16),
                      ),
                      onPressed: () async {
                        if (_formKey.currentState.validate() && _sozlesme) {
                          showAlertDialogBildirim(context);
                        } else if (_formKey.currentState.validate() &&
                            _sozlesme &&
                            _bildiri) {
                          UyeTalep();
                          //showAlertDialogUyeTalep(context);
                          // var username = _name.trim();
                          // var surname = _surname.trim();
                          // var email = _email.trim();
                          // var tc = _tc.trim();
                          // var password = _password.trim();

                          // var url = "/Account/Register";

                          // Map map = {
                          //   'Register': {
                          //     'Name': username,
                          //     'Surname': surname,
                          //     'Password': password,
                          //     'Username': tc,
                          //     'Email': email,
                          //     'ConfirmPassword': password
                          //   }
                          // };

                          // var response = await apiRequest(url, map, "Post");

                          // if (response != null) {
                          //   var register = json.decode(response);
                          //   var sonuc = Register.fromJson(register);
                          //   if (sonuc.success) {
                          //     Navigator.pushReplacementNamed(
                          //         context, Routes.customer);
                          //   }
                          //   displayDialog(context, "BİLDİRİ", sonuc.message);

                          //   // Navigator.push(
                          //   //     context,
                          //   //     MaterialPageRoute(
                          //   //         builder: (context) =>
                          //   //             Routes.anasayfa.fromBase64(jwt)));
                          // } else {
                          //   displayDialog(context, "HATA",
                          //       "Kayıt işleminde hata oluştu.");
                          // }
                        } else {
                          showAlertDialogUye(context);
                        }

                        _formKey.currentState.save();

                        // print(_name);
                        // print(_surname);
                        // print(_email);
                        // print(_tc);

                        // print(_password);
                        // print(_sozlesme.toString() + "sözleşme");
                        // print(_bildiri.toString() + "bildiri");

                        //Send to API
                      }),
                  SizedBox(
                      child: RichText(
                          text: TextSpan(children: [
                    new TextSpan(
                      text:
                          'Bu sayfadaki bilgiler hidayetbaysal.com üyeliği için alınmaktadır. Kişisel verilerin korunması hakkında detaylı bilgiye',
                      style: new TextStyle(color: Colors.black),
                    ),
                    new TextSpan(
                      text: ' buradan',
                      style: new TextStyle(color: Colors.blue),
                      recognizer: new TapGestureRecognizer()
                        ..onTap = () {
                          launch(
                              'https://docs.flutter.io/flutter/services/UrlLauncher-class.html');
                        },
                    ),
                    new TextSpan(
                      text: ' ulaşabilirsiniz.',
                      style: new TextStyle(color: Colors.black),
                    ),
                  ])))
                ],
              ),
            ),
            // ]
            // )
          ),
          // ]
        )
        // ),
        );
  }
}
