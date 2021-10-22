// import 'dart:convert';
//import 'dart:io';

// import 'package:carousel_slider/carousel_options.dart';
// import 'package:carousel_slider/carousel_slider.dart';

// import 'package:carousel_slider/carousel_controller.dart';
// import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
// import 'package:flutter_html/flutter_html.dart';
// import 'package:ilk_projem/Data/EmlakDetailData.dart';
// import 'package:ilk_projem/Data/User.dart';

// import 'package:photo_view/photo_view_gallery.dart';

import 'package:ilk_projem/screens/contact.dart';
import 'package:ilk_projem/screens/customer_screen.dart';
import 'package:ilk_projem/screens/kiraliklar.dart';
import 'package:ilk_projem/screens/projeler_screen.dart';
import 'package:ilk_projem/screens/satiliklar.dart';
import 'package:flutter_switch/flutter_switch.dart';

// import 'package:map_launcher/map_launcher.dart';
// import 'package:flutter_svg/flutter_svg.dart';
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

class BildirimAyarlariScreen extends StatefulWidget {
  static bool a = false;

  // List<bool> isSelected = List.generate(3, (_) => false);

  static const String routeName = "/bildirimAyarlari";
  // final String title;
  @override
  _BildirimAyarlariScreenState createState() => _BildirimAyarlariScreenState();
}

@override
State<StatefulWidget> createState() {
  return _BildirimAyarlariScreenState();
}

class Routes {
  static const String contacts = ContactScreen.routeName;
  static const String customer = CustomerScreen.routeName;
  static const String satilik = SatilikScreen.routeName;
  static const String kiralik = KiralikScreen.routeName;
  static const String projeler = ProjelerScreen.routeName;

  // static const String notes = NotesPage.routeName;
}

class _BildirimAyarlariScreenState extends State<BildirimAyarlariScreen> {
  // final CarouselController _controller = CarouselController();

  // SingingCharacter _character = SingingCharacter.lafayette;
  get pageFetch => null;
  bool _bildirim = false; // BURAYI APIDEN ÇEKCEZ....
  ///

  ///

  @override
  void initState() {
    super.initState();
  }

  // List<String> imgList = _emlakDetay.fotograflar;

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);

    /*...*/
    return Scaffold(
        appBar: AppBar(
          // flexibleSpace: Row(
          //   mainAxisAlignment: MainAxisAlignment.center,
          //   // crossAxisAlignment: CrossAxisAlignment.end,

          //   children: [
          //     Text(
          //       "Bildirim Ayarları",
          //       style: TextStyle(
          //           fontWeight: FontWeight.bold,
          //           color: Colors.white,
          //           fontSize: 20),
          //     ),
          //     Padding(
          //       padding: EdgeInsets.symmetric(horizontal: 100),
          //     ),

          title:
              // Padding(
              //   padding: EdgeInsets.symmetric(horizontal: 50),
              //   child:
              Text(
            "Bildirim Ayarları",
            style: TextStyle(
                fontWeight: FontWeight.bold, color: Colors.white, fontSize: 20),
          ),
          // ),
          //   ],
          // ),
        ),
        body: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Row(
                children: <Widget>[
                  Text(
                    "Ticari Elektronik İleti İzni",
                    style:
                        TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0),
                  ),
                  Spacer(),
                  FlutterSwitch(
                    width: 100.0,
                    height: 30.0,
                    // valueFontSize: 25.0,
                    toggleSize: 20.0,
                    value: _bildirim,
                    borderRadius: 30.0,
                    padding: 8.0,
                    showOnOff: false,
                    onToggle: (val) {
                      setState(() {
                        _bildirim = val;
                      });
                    },
                  ),
                ],
              ),
              Text("Bana Özel Kampanya, Teklif ve Tanıtımlar"),
            ],
          ),
        ));
  }
}
