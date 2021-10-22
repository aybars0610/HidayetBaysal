import 'dart:convert' show json, base64, ascii;
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:ilk_projem/Data/User.dart';
import 'package:ilk_projem/screens/favorilerim_screen.dart';
import 'package:ilk_projem/screens/main_menu.dart';
import 'package:ilk_projem/screens/profilim_screen.dart';
import 'package:ilk_projem/screens/projeler_screen.dart';
import 'package:ilk_projem/screens/satilik_screen.dart';
import 'package:ilk_projem/screens/sifreDegis.dart';
import 'package:ilk_projem/screens/sifremiUnuttum_screen.dart';
import 'package:ilk_projem/screens/uyeOl.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:url_launcher/url_launcher.dart';

import 'contact.dart';

final storage = FlutterSecureStorage();

class CustomerScreen extends StatefulWidget {
  static const String routeName = "/uyegirisi";

  @override
  _CustomerScreenState createState() => _CustomerScreenState();
}

class Routes {
  static const String contacts = ContactScreen.routeName;
  static const String customer = CustomerScreen.routeName;
  static const String anasayfa = MainMenu.routeName;
  static const String uye = UyeOlScreen.routeName;
  static const String sifremiUnuttum = SifremiUnuttumScreen.routeName;
}

Future<String> login(Map jsonMap) async {
  String reply = "";
  var response = await http.post(
    // Uri.http("192.168.1.106", '/token'),
    Uri.http("api.hidayetbaysal.net", '/token'),
    headers: <String, String>{
      'Content-Type': 'application/x-www-form-urlencoded; charset=UTF-8',
    },
    body: jsonMap,
  );
  if (response.statusCode == 200) {
    reply = response.body;
  }
  return reply;
}

class _CustomerScreenState extends State<CustomerScreen> {
  TextEditingController user = TextEditingController();

  TextEditingController pass = TextEditingController();
  void displayDialog(context, title, text) => showDialog(
        context: context,
        builder: (context) =>
            AlertDialog(title: Text(title), content: Text(text)),
      );

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
          // actions: [
          //   // Icon(Icons.account_circle),
          //   Padding(
          //     padding: EdgeInsets.symmetric(horizontal: 16),
          //     child: IconButton(
          //       icon: Icon(Icons.account_circle),
          //       //color: Colors.white,
          //       onPressed: () {
          //         Navigator.pushNamed(context, CustomerScreen.routeName);
          //       },
          //     ),

          //     // onTap: () {
          //     //   Navigator.of(context)
          //     //       .pushNamedAndRemoveUntil(routess[0], (route) => false);
          //     // },
          //   ),
          // ]
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
        body: Padding(
            padding: EdgeInsets.all(10),
            child: ListView(
              children: <Widget>[
                Container(
                    alignment: Alignment.center,
                    padding: EdgeInsets.all(10),
                    child: Text(
                      'ÜYE GİRİŞİ',
                      style: TextStyle(
                          color: hbRed,
                          fontWeight: FontWeight.w500,
                          fontSize: 20),
                    )),
                Container(
                  padding: EdgeInsets.all(10),
                  child: TextFormField(
                    controller: user,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Kullanıcı Adı',
                    ),
                    validator: (String value) {
                      if (value.isEmpty) {
                        return 'Zorunlu alan';
                      }
                      return null;
                    },
                  ),
                ),
                Container(
                  padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
                  child: TextFormField(
                    obscureText: true,
                    controller: pass,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Şifre',
                    ),
                    validator: (String value) {
                      if (value.isEmpty) {
                        return 'Zorunlu alan';
                      }
                      return null;
                    },
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    TextButton(
                      onPressed: () => launch(
                          'https://api.whatsapp.com/send?phone=903322612333'),
                      // Navigator.pushReplacementNamed(
                      //     context, Routes.sifremiUnuttum),
                      style: ButtonStyle(
                        shadowColor:
                            MaterialStateColor.resolveWith((states) => hbRed),
                        // overlayColor: MaterialStateColor.resolveWith((states) => hbBlue),
                        // backgroundColor:
                        //     MaterialStateColor.resolveWith((states) => Colors.white),
                        // foregroundColor:
                        //     MaterialStateColor.resolveWith((states) => Colors.black),
                        // padding:
                        //     MaterialStateProperty.resolveWith((states) => EdgeInsets.all(6.0)),
                      ),
                      // textColor: hbRed,
                      child: Text(
                        'Şifremi Unuttum',
                        style: TextStyle(fontSize: 12.0),
                        textAlign: TextAlign.right,
                      ),
                    ),
                  ],
                ),
                Container(
                  height: 30,
                  padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                  child: ElevatedButton(
                      style: ButtonStyle(
                          shadowColor:
                              MaterialStateColor.resolveWith((states) => hbRed),
                          backgroundColor: MaterialStateColor.resolveWith(
                              (states) => Colors.white),
                          foregroundColor:
                              MaterialStateColor.resolveWith((states) => hbRed),
                          shape: MaterialStateProperty.resolveWith((states) =>
                              new RoundedRectangleBorder(
                                borderRadius: new BorderRadius.circular(2.0),
                              ))),
                      // width: 2.0, color: const Color(0xFFa90600)))),
                      // textColor: hbRed,
                      // color: Colors.white,
                      child: Text('Giriş Yap'),
                      // shape: Border.all(
                      //     width: 2.0, color: const Color(0xFFa90600)),
                      onPressed: () async {
                        var username = user.text.trim();
                        var password = pass.text.trim();
                        Map map = {
                          'UserName': username,
                          'Password': password,
                          'grant_type': 'password'
                        };

                        var jwt = await login(map);
                        if (jwt != "") {
                          // var sonuc = User();
                          var register = json.decode(jwt);
                          // sonuc = User.fromJson(register);
                          var sonuc = User.fromJson(register);
                          ProfilimScreen.userName = sonuc.userName;
                          ProfilimScreen.password = password;
                          ProfilimScreen.userId = sonuc.userId;
                          ProfilimScreen.ad = sonuc.name;
                          ProfilimScreen.soyad = sonuc.surname;
                          ProfilimScreen.mail = sonuc.email;
                          ProfilimScreen.tcKimlik = sonuc.tcKimlik;
                          ProfilimScreen.role = sonuc.role;
                          ProfilimScreen.phoneNumber = sonuc.phone;

                          sonuc.password = password;
                          var jwtString = json.encode(sonuc);
                          storage.write(key: "jwt", value: jwtString);

                          Navigator.pushReplacementNamed(
                              context, Routes.anasayfa);
                          // Navigator.push(
                          //     context,
                          //     MaterialPageRoute(
                          //         builder: (context) =>
                          //             Routes.anasayfa.fromBase64(jwt)));
                        } else {
                          displayDialog(context, "HATA",
                              "Bu kullanıcı adı ve şifreyle eşleşen bir hesap bulunamadı");
                        }

                        // Map map = {
                        //   'UserName': user,
                        //   'Password': pass,
                        //   'grant_type': 'password'
                        // };
                        // var response = login(map);
                      }),
                  // onPressed: () => Navigator.pushReplacementNamed(
                  //     context, Routes.anasayfa)),
                ),
                Container(
                    height: 50,
                    padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                    child: Row(
                      children: <Widget>[
                        ElevatedButton(
                            style: ButtonStyle(
                              shadowColor: MaterialStateColor.resolveWith(
                                  (states) => hbRed),
                              backgroundColor: MaterialStateColor.resolveWith(
                                  (states) => hbRed),
                              foregroundColor: MaterialStateColor.resolveWith(
                                  (states) => Colors.white),
                              shape: MaterialStateProperty.resolveWith(
                                  (states) => new RoundedRectangleBorder(
                                        borderRadius:
                                            new BorderRadius.circular(2.0),
                                      )),
                              padding: MaterialStateProperty.resolveWith(
                                  (states) =>
                                      EdgeInsets.fromLTRB(10, 0, 10, 0)),
                            ),
                            // padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                            // textColor: Colors.white,
                            // color: hbRed,
                            child: Text('Üye Ol'),
                            onPressed: () => Navigator.pushReplacementNamed(
                                context, Routes.uye))
                      ],
                      mainAxisAlignment: MainAxisAlignment.center,
                    ))
              ],
            )));
  }
}
