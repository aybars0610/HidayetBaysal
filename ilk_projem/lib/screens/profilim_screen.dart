import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:ilk_projem/Data/User.dart';
import 'package:ilk_projem/screens/phoneChange.dart';
import 'package:ilk_projem/screens/projeler_screen.dart';
import 'package:ilk_projem/screens/sifreDegis.dart';

import 'contact.dart';
import 'customer_screen.dart';
import 'main_menu.dart';
//import 'package:ilk_projem/screens/main_menu.dart';

//import 'contact.dart';

class ProfilimScreen extends StatefulWidget {
  static const String routeName = "/profilim";
  static String userName = "";
  static String password = "";
  static String userId = "";
  static String ad = "";
  static String soyad = "";
  static String mail = "";
  static String tcKimlik = "";
  static String role = "";
  static String phoneNumber = "";
  static String newPassword = "";
  static String newPasswordConfirm = "";

  @override
  _ProfilimScreenState createState() => _ProfilimScreenState();
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

class _ProfilimScreenState extends State<ProfilimScreen> {
  String _name;
  String _surname;
  String _email;
  String _phone;
  User _userDetay = User();

  String phoneIsoCode;
  bool visible = false;
  String confirmedNumber = '';

  void onPhoneNumberChange(
      String number, String internationalizedPhoneNumber, String isoCode) {
    print(number);
    setState(() {
      _phone = number;
      phoneIsoCode = isoCode;
    });
  }

  onValidPhoneNumber(
      String number, String internationalizedPhoneNumber, String isoCode) {
    setState(() {
      visible = true;
      confirmedNumber = internationalizedPhoneNumber;
    });
  }

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  // Future<User> fetchUserDetay() async {
  //   // var url =
  //   //     "file:///C:/Users/oozge/OneDrive/Masa%C3%BCst%C3%BC/emlakexample.json";
  //   // var response = await http.get(url);
  //   var userDetay = User();

  //   var response =
  //       """[{"Id":1,"Ad":"Özge","Soyad":"Kazan","PhoneNumber":"05543802228","Password":"123456a","Mail":"oozgeeozdemir@gmail.com","TcKimlik":"28466496656","KullaniciAdi":"28466496656","EvSahibi":true,"Bilgilendirme":true,"Sozlesme":true}]""";

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

  showAlertDialogDegisik(BuildContext context) {
    // set up the button
    Widget okButton = TextButton(
        child: Text("OK"),
        onPressed: () {
          Navigator.pop(context, true);
          profilGuncelleme();
        });

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("BİLDİRİ"),
      content: Text("Değişiklikler kaydedilmiştir"),
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

  void profilGuncelleme() async {
    var username = ProfilimScreen.userName;

    var email = _email.trim();
    var telNo = ProfilimScreen.phoneNumber;
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

    if (response != "false") {
      ProfilimScreen.mail = email;
      Navigator.pushNamed(context, ProfilimScreen.routeName);

      // Navigator.push(
      //     context,
      //     MaterialPageRoute(
      //         builder: (context) =>
      //             Routes.anasayfa.fromBase64(jwt)));
    } else {
      displayDialog(context, "HATA", "Kayıt işleminde hata oluştu.");
    }
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
        appBar: AppBar(title: Text("Profilim")
            //   ],
            // ),
            ),
        body: Container(
            margin: EdgeInsets.all(25.0),
            child: SingleChildScrollView(
                child: Form(
                    key: _formKey,
                    child: Column(children: <Widget>[
                      Row(children: <Widget>[
                        Text("Kullanıcı Adı:"),
                        SizedBox(width: 10.0),
                        Text(ProfilimScreen.userName != null
                            ? ProfilimScreen.userName
                            : ''),
                      ]),
                      Divider(
                        color: Colors.grey[300],
                        height: 20,
                        thickness: 2,
                        indent: 0,
                        endIndent: 0,
                      ),
                      Row(children: <Widget>[
                        Text("Ad*:"),
                        SizedBox(width: 10.0),
                        Text(
                            ProfilimScreen.ad != null ? ProfilimScreen.ad : ''),
                      ]),
                      // Row(
                      //   // mainAxisAlignment: MainAxisAlignment.spaceAround,
                      //   children: <Widget>[
                      //     Text("Ad*:"),
                      //     SizedBox(width: 10.0),
                      //     Expanded(
                      //       child: TextFormField(
                      //         initialValue:
                      //             _userDetay.ad != null ? _userDetay.ad : '',
                      //         decoration: InputDecoration(labelText: ''),
                      //         maxLength: 25,
                      //         validator: (String value) {
                      //           if (value.isEmpty) {
                      //             return '*Bu alanı doldurmak zorunlu';
                      //           }

                      //           return null;
                      //         },
                      //         onSaved: (String value) {
                      //           _name = value;
                      //         },
                      //       ),
                      //     )
                      //   ],
                      // ),
                      Divider(
                        color: Colors.grey[300],
                        height: 20,
                        thickness: 2,
                        indent: 0,
                        endIndent: 0,
                      ),
                      Row(children: <Widget>[
                        Text("Soyad*:"),
                        SizedBox(width: 10.0),
                        Text(ProfilimScreen.soyad != null
                            ? ProfilimScreen.soyad
                            : ''),
                      ]),
                      // Row(
                      //   // mainAxisAlignment: MainAxisAlignment.spaceAround,
                      //   children: <Widget>[
                      //     Text("Soyad*:"),
                      //     SizedBox(width: 10.0),
                      //     Expanded(
                      //       child: TextFormField(
                      //         initialValue: _userDetay.soyad != null
                      //             ? _userDetay.soyad
                      //             : '',
                      //         decoration: InputDecoration(labelText: ''),
                      //         maxLength: 25,
                      //         validator: (String value) {
                      //           if (value.isEmpty) {
                      //             return '*Bu alanı doldurmak zorunlu';
                      //           }

                      //           return null;
                      //         },
                      //         onSaved: (String value) {
                      //           _surname = value;
                      //         },
                      //       ),
                      //     )
                      //   ],
                      // ),
                      Divider(
                        color: Colors.grey[300],
                        height: 20,
                        thickness: 2,
                        indent: 0,
                        endIndent: 0,
                      ),
                      Row(children: <Widget>[
                        Text("TC Kimlik No:"),
                        SizedBox(width: 10.0),
                        Text(ProfilimScreen.tcKimlik != null
                            ? ProfilimScreen.tcKimlik
                            : ''),
                      ]),
                      Divider(
                        color: Colors.grey[300],
                        height: 20,
                        thickness: 2,
                        indent: 0,
                        endIndent: 0,
                      ),
                      Row(children: <Widget>[
                        Text("E-mail*:"),
                        SizedBox(width: 6.0),
                        Expanded(
                            child: TextFormField(
                          initialValue: ProfilimScreen.mail != null
                              ? ProfilimScreen.mail
                              : '',
                          // decoration: InputDecoration(labelText: 'E-mail Adresi'),
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
                          onChanged: (String value) {
                            _email = value;
                          },
                        )),
                      ]),
                      Divider(
                        color: Colors.grey[300],
                        height: 20,
                        thickness: 2,
                        indent: 0,
                        endIndent: 0,
                      ),
                      Row(children: <Widget>[
                        Text("Cep Telefonu*:"),
                        SizedBox(width: 6.0),
                        Expanded(
                          child: Text(ProfilimScreen.phoneNumber != null
                              ? ProfilimScreen.phoneNumber
                              : ''),
                          // TextFormField(
                          //   initialValue: _userDetay.phoneNumber != null ? _userDetay.phoneNumber : '',
                          //   keyboardType: TextInputType.phone,
                          //   validator: (String value) {
                          //     if (value.isEmpty) {
                          //       return '*Bu alanı doldurmak zorunlu';
                          //     }

                          //     return null;
                          //   },
                          //   onSaved: (String value) {
                          //     _phone = value;
                          //   },
                          // ),
                        ),
                        IconButton(
                          icon: Icon(
                            Icons.edit,
                            size: 20.0,
                          ),
                          onPressed: () => Navigator.pushNamed(
                              context, PhoneChangeScreen.routeName),
                        )
                      ]),
                      Divider(
                        color: Colors.grey[300],
                        height: 20,
                        thickness: 2,
                        indent: 0,
                        endIndent: 0,
                      ),
                      Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            TextButton(
                                onPressed: () => Navigator.pushNamed(
                                    context, SifreDegisScreen.routeName),
                                style: ButtonStyle(
                                  shadowColor: MaterialStateColor.resolveWith(
                                      (states) => hbRed),
                                  // overlayColor: MaterialStateColor.resolveWith((states) => hbBlue),
                                  // backgroundColor:
                                  //     MaterialStateColor.resolveWith((states) => Colors.white),
                                  // foregroundColor:
                                  //     MaterialStateColor.resolveWith((states) => Colors.black),
                                  // padding:
                                  //     MaterialStateProperty.resolveWith((states) => EdgeInsets.all(6.0)),
                                ),
                                // textColor: hbRed,
                                child: Row(
                                  children: <Widget>[
                                    Text(
                                      'Şifre Değişikliği',
                                      style: TextStyle(
                                          fontSize: 15.0,
                                          color: Colors.black87),
                                      textAlign: TextAlign.right,
                                    ),
                                    // Spacer(),
                                    Icon(Icons.chevron_right),
                                  ],
                                )),
                          ]),
                      Divider(
                        color: Colors.grey[300],
                        height: 20,
                        thickness: 2,
                        indent: 0,
                        endIndent: 0,
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
                            showAlertDialogDegisik(context);
                          }

                          _formKey.currentState.save();

                          //Send to API
                        },
                      ),
                    ])))));
  }
}
