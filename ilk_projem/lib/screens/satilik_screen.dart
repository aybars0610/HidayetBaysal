import 'dart:convert';
//import 'dart:io';

// import 'package:carousel_slider/carousel_options.dart';
// import 'package:carousel_slider/carousel_slider.dart';

// import 'package:carousel_slider/carousel_controller.dart';
// import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
// import 'package:simple_html_css/simple_html_css.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:ilk_projem/Data/EmlakDetailData.dart';
import 'package:fluttertoast/fluttertoast.dart';

// import 'package:photo_view/photo_view_gallery.dart';

import 'package:ilk_projem/screens/contact.dart';
import 'package:ilk_projem/screens/customer_screen.dart';
import 'package:ilk_projem/screens/kiraliklar.dart';
import 'package:ilk_projem/screens/profilim_screen.dart';
import 'package:ilk_projem/screens/projeler_screen.dart';
import 'package:ilk_projem/screens/satiliklar.dart';

// import 'package:map_launcher/map_launcher.dart';
// import 'package:flutter_svg/flutter_svg.dart';
import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';
import 'package:url_launcher/url_launcher.dart';

//import 'package:share/share.dart';
//import "package:pagination/pagination.dart";
// import "package:path/path.dart"

//import 'package:url_launcher/url_launcher.dart';
//import 'package:ilk_projem/screens/product_screen.dart';
//import 'package:http/http.dart' as http;

// openMapsSheet(context) async {
//   try {
//     final coords = Coords(37.759392, -122.5107336);
//     final title = "Ocean Beach";
//     final availableMaps = await MapLauncher.installedMaps;

//     showModalBottomSheet(
//       context: context,
//       builder: (BuildContext context) {
//         return SafeArea(
//           child: SingleChildScrollView(
//             child: Container(
//               child: Wrap(
//                 children: <Widget>[
//                   for (var map in availableMaps)
//                     ListTile(
//                       onTap: () => map.showMarker(
//                         coords: coords,
//                         title: title,
//                       ),
//                       title: Text(map.mapName),
//                       leading: SvgPicture.asset(
//                         map.icon,
//                         height: 30.0,
//                         width: 30.0,
//                       ),
//                     ),
//                 ],
//               ),
//             ),
//           ),
//         );
//       },
//     );
//   } catch (e) {
//     print(e);
//   }
// }

// void _launchMapsUrl(String lat, String lon) async {
//   final url = 'https://www.google.com/maps/search/?api=1&query=$lat,$lon';

//   if (await canLaunch(url)) {
//     await launch(url);
//   } else {
//     throw 'Could not launch $url';
//   }
// }
const _url = 'https://flutter.dev';

void _launchURL() async {
  print('launching');
  try {
    await canLaunch(_url) ? await launch(_url) : throw 'Could not launch $_url';
    print('succcess');
  } catch (_, __) {
    print('failure');
  }
}

class SatiliklarScreen extends StatefulWidget {
  static bool a = false;
  static int ilanId = 0;
  static int ilanTipi = 0;
  static int ilanTuru = 0;

  // List<bool> isSelected = List.generate(3, (_) => false);

  static const String routeName = "/detayliGorunum";
  // final String title;
  @override
  _SatiliklarScreenState createState() => _SatiliklarScreenState();
}

@override
State<StatefulWidget> createState() {
  return _SatiliklarScreenState();
}

// enum Siralama {
//   Gelismis, //sıralama,
//   Fiyata, // göre(Önce en yüksek),
//   banana,
// }

class Routes {
  static const String contacts = ContactScreen.routeName;
  static const String customer = CustomerScreen.routeName;
  static const String satilik = SatilikScreen.routeName;
  static const String kiralik = KiralikScreen.routeName;
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

enum SingingCharacter { zero, one, two, three, four, five, six }
enum GorunumCharacter { zero, one }
int btnIndex = 0;
int currentIndex = 0;

class _SatiliklarScreenState extends State<SatiliklarScreen> {
  // final CarouselController _controller = CarouselController();

  // SingingCharacter _character = SingingCharacter.lafayette;
  get pageFetch => null;
  int page = 1;
  // bool verticalGallery = false;
  bool _lights = false;

  EmlakDetailData _emlakDetay = EmlakDetailData();
  List<String> _imgList = [];
  List<Widget> imageSliders = [];

  Future<EmlakDetailData> fetchemlakDetay() async {
    // var url =
    //     "file:///C:/Users/oozge/OneDrive/Masa%C3%BCst%C3%BC/emlakexample.json";
    // var response = await http.get(url);
    var emlakDetay = EmlakDetailData();

    String url = 'IlanBilgileri/GetIlan';
    Map map = {
      'UserName': '',
      'Password': '',
      'ID': SatiliklarScreen.ilanId,
      'UserId': ProfilimScreen.userId
    };

    var response = await apiRequest(url, map);

    // var response =
    //     """[{"Id":"891459300","Konum":"Yazır Mahallesi","Aciklama":"İçi Full Yapılı Daire","Baslik": "YALÇINKAYA EMLAK KIRALIYOR","Tarih":"03 Ocak 2021","EmlakTipi":"Satılık Daire","Metrekare":"60","OdaSayisi":"1+1","BinaYasi":"0","BulunduguKat":"3","KatSayisi":"4","Isitma":"Yerden Isıtma","BanyoSayisi":"1","Balkon":"Var","Esyali":"Evet","KullanimDurumu":"Boş","SiteIcerisinde":"Hayır","SiteAdi":"","Aidat":"Belirtilmemiş","KrediyeUygun":"Belirtilmemiş","GoruntuluAramaIleGezilebilir":"Hayır","Fiyat":"158.000 TL","Fotograflar":["https://i0.shbdn.com/photos/45/93/00/x5_891459300xn3.jpg","https://i0.shbdn.com/photos/45/93/00/x5_891459300b8t.jpg"],"Cephe":["Kuzey","Güney"],"IcOzellikler":["Asansör","Adsl"],"DisOzellikler":["Isı Yalıtımı", "Asansör"],"Muhit":["Park","Cami"],"Ulasim":["Dolmuş","Otobüs"],"Manzara":["Şehir","Göl"],"IsCheck":false,"KonutTipi":["Ters Dubleks","Bahçeli"]}]""";

    // if (response.statusCode == 200) {
    // var emlakDetayListeJson = json.decode(response.body);
    // var emlakDetayListeJson = json.decode(response);
    try {
      // emlakDetay = json.decode(response);
      var register = json.decode(response);

      emlakDetay = EmlakDetailData.fromJson(register);
      _lights = emlakDetay.isCheck;
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
    return emlakDetay;
  }

  void displayDialog(context, title, text) => showDialog(
        context: context,
        builder: (context) =>
            AlertDialog(title: Text(title), content: Text(text)),
      );

  Future<bool> postFavori() async {
    var returnValue = false;
    var username = ProfilimScreen.userName;

    var password = ProfilimScreen.password;
    int id = SatiliklarScreen.ilanId;

    var url = "IlanBilgileri/PostFavori";

    Map map = {
      'Username': username,
      'Password': password,
      'ID': id,
    };

    var response = await apiRequest(url, map, "Post");

    if (response != null) {
      if (response == "true") {
        // displayDialog(context, "HATA", "Kayıt işleminde hata oluştu.");
        returnValue = true;
      }
      // else {
      //   returnValue = true;
      //   // Navigator.pushNamed(context, SatiliklarScreen.routeName);
      // }

      // Navigator.push(
      //     context,
      //     MaterialPageRoute(
      //         builder: (context) =>
      //             Routes.anasayfa.fromBase64(jwt)));
    }
    // else {
    //   // displayDialog(context, "HATA", "Kayıt işleminde hata oluştu.");
    //   returnValue = false;
    // }
    return returnValue;
  }

  showAlertDialogg(BuildContext context) {
    // set up the button
    Widget iptalButton = TextButton(
      child: Text("VAZGEÇ"),
      onPressed: () => Navigator.pop(context, true),
    );
    Widget okButton = TextButton(
      onPressed: () async {
        Navigator.pop(context, false);
        var isSuccessFavori = await _SatiliklarScreenState().postFavori();
        setState(() {
          if (isSuccessFavori) {
            _emlakDetay.isCheck = true;
            _lights = true;
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
            Fluttertoast.showToast(
                msg: " İlan Favorilerinize Eklenmiştir.",
                toastLength: Toast.LENGTH_SHORT,
                gravity: ToastGravity.BOTTOM,
                timeInSecForIosWeb: 1,
                backgroundColor: hbRed,
                textColor: Colors.white,
                fontSize: 16.0);
          } else {
            displayDialog(context, "HATA", "Kayıt işleminde hata oluştu.");
          }
        });
      },
      child: Text("TAMAM"),
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("Favorilerime Kaydet"),
      content:
          Text("Bu ilanı favorilerinize eklemek istediğinize emin misiniz?"),
      //"Bu ilana ait bundan sonraki fiyat değişimlerini görüntüleyebilirsiniz."),
      actions: [
        Row(children: [
          iptalButton,
          okButton,
        ])
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

  // showAlertDialogg(BuildContext context) {
  //   // int _radioValue1 = 0;
  //   // set up the button
  //   Widget iptalButton = TextButton(
  //     child: Text("VAZGEÇ"),
  //     onPressed: () => Navigator.pop(context, true),
  //   );
  //   Widget okButton = TextButton(
  //     onPressed: () {
  //       Navigator.pop(context, false);
  //       setState(() {
  //         _emlakDetay.isCheck = true;
  //         const MaterialColor hbRed = const MaterialColor(
  //           0xFFa90600,
  //           const <int, Color>{
  //             50: const Color(0xFFa90600),
  //             100: const Color(0xFFa90600),
  //             200: const Color(0xFFa90600),
  //             300: const Color(0xFFa90600),
  //             400: const Color(0xFFa90600),
  //             500: const Color(0xFFa90600),
  //             600: const Color(0xFFa90600),
  //             700: const Color(0xFFa90600),
  //             800: const Color(0xFFa90600),
  //             900: const Color(0xFFa90600),
  //           },
  //         );
  //         Fluttertoast.showToast(
  //             msg: " İlan Favorilerinize Eklenmiştir.",
  //             toastLength: Toast.LENGTH_SHORT,
  //             gravity: ToastGravity.BOTTOM,
  //             timeInSecForIosWeb: 1,
  //             backgroundColor: hbRed,
  //             textColor: Colors.white,
  //             fontSize: 16.0);
  //       });
  //     },
  //     child: Text("TAMAM"),
  //   );

  //   showDialog(
  //       context: context,
  //       builder: (BuildContext context) {
  //         return StatefulBuilder(
  //           builder: (context, setState) {
  //             return AlertDialog(
  //               title: Text("Favorilerime Kaydet"),
  //               content: Container(
  //                   width: MediaQuery.of(context).size.width,
  //                   height: MediaQuery.of(context).size.height,
  //                   child: Column(
  //                       mainAxisSize: MainAxisSize.min,
  //                       children: <Widget>[
  //                         Expanded(
  //                             child: Text(
  //                                 "Bu ilana ait bundan sonraki fiyat değişimlerini görüntüleyebilirsiniz.")),
  //                       ])),
  //               actions: [
  //                 okButton,
  //                 iptalButton,
  //               ],
  //               //);
  //               // }
  //             );
  //           },
  //         );
  //       });
  // }

  @override
  void initState() {
    fetchemlakDetay().then((value) {
      setState(() {
        // _emlakDetay.addAll(value);
        _emlakDetay = value;
        // for (var img in value.fotograflar) {
        //   _imgList.add(img.name);
        // }
        _imgList = value.fotograflar;

        imageSliders = _imgList
            .map((item) => Container(
                  child: Container(
                    margin: EdgeInsets.all(5.0),
                    child: ClipRRect(
                        borderRadius: BorderRadius.all(Radius.circular(5.0)),
                        child: Stack(
                          children: <Widget>[
                            Image.network(item,
                                fit: BoxFit.cover, width: 1000.0),
                            Positioned(
                              bottom: 0.0,
                              left: 0.0,
                              right: 0.0,
                              child: Container(
                                decoration: BoxDecoration(
                                  gradient: LinearGradient(
                                    colors: [
                                      Color.fromARGB(200, 0, 0, 0),
                                      Color.fromARGB(0, 0, 0, 0)
                                    ],
                                    begin: Alignment.bottomCenter,
                                    end: Alignment.topCenter,
                                  ),
                                ),
                                padding: EdgeInsets.symmetric(
                                    vertical: 10.0, horizontal: 20.0),
                                child: Text(
                                  '${_imgList.indexOf(item) + 1}/${_imgList.length}',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 10.0,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        )),
                  ),
                ))
            .toList();
      });
    });
    super.initState();
  }

  void onPageChanged(int index) {
    setState(() {
      currentIndex = index;
    });
  }

  void open(BuildContext context, final int index) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => GalleryPhotoViewWrapper(
          galleryItems: _imgList,
          backgroundDecoration: const BoxDecoration(
            color: Colors.black,
          ),
          initialIndex: index,
          scrollDirection: Axis.horizontal,
          // scrollDirection: verticalGallery ? Axis.vertical : Axis.horizontal,
        ),
      ),
    );
  }

  // List<String> imgList = _emlakDetay.fotograflar;
  List<bool> isSelected = [true, false, false];

  void onPressButton(int id) {
    setState(() {
      for (int buttonIndex = 0;
          buttonIndex < isSelected.length;
          buttonIndex++) {
        if (buttonIndex == id) {
          isSelected[buttonIndex] = true;
          //  Theme.of(context).color = Colors.yellow;
          if (buttonIndex == 2) {
            var latit = _emlakDetay.enlem;
            var longit = _emlakDetay.boylam;
            launch(
                'https://www.google.com/maps/search/?api=1&query=$latit,$longit');
            // _launchURL;
            // _launchMapsUrl(_emlakDetay.enlem,
            //     _emlakDetay.boylam);
          }
          btnIndex = buttonIndex;
        } else {
          isSelected[buttonIndex] = false;
        }
      }
    });

    isSelected = isSelected;
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    SatiliklarScreen.ilanTipi = ProjelerScreen.ilanTipi;
    SatiliklarScreen.ilanTuru = ProjelerScreen.ilanTuru;
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

    List<bool> isSelected = List.generate(3, (_) => false);
    /*...*/
    return Scaffold(
        appBar: AppBar(
          // flexibleSpace: Row(
          //   mainAxisAlignment: MainAxisAlignment.center,
          //   // crossAxisAlignment: CrossAxisAlignment.end,

          //   children: [
          //     Text(
          //       "İlan Detayları",
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
          title: Text("İlan Detayları"),
          actions: <Widget>[
            Padding(
                padding: EdgeInsets.only(right: 24.0),
                child: GestureDetector(
                  onTap: () async {
                    if (_emlakDetay.isCheck == true) {
                      var isSuccessFavori =
                          await _SatiliklarScreenState().postFavori();
                      setState(() {
                        if (isSuccessFavori) {
                          _emlakDetay.isCheck = false;
                          _lights = false;
                          Fluttertoast.showToast(
                              msg: " İlan Favorilerinizden Kaldırılmıştır.",
                              toastLength: Toast.LENGTH_SHORT,
                              gravity: ToastGravity.BOTTOM,
                              timeInSecForIosWeb: 1,
                              backgroundColor: hbRed,
                              textColor: Colors.white,
                              fontSize: 16.0);
                        } else {
                          displayDialog(
                              context, "HATA", "Kayıt işleminde hata oluştu.");
                        }
                      });
                    } else {
                      showAlertDialogg(context);
                    }
                  },
                  child: Icon(
                    Icons.star,
                    color: _lights ? Colors.yellow : Colors.white,
                  ),
                )),
            // Padding(
            //     padding: EdgeInsets.only(right: 24.0),
            //     child: GestureDetector(
            //       onTap: () {
            //         //   Share.share("hidayetbaysal.com'da incelediğim arama sonucunu sizinle paylaşmak istiyorum");
            //       },
            //       child: Icon(Icons.share),
            //     )),
          ],
        ),
        // appBar: AppBar(
        //   title: Text("İlan Detayları"),
        //   leading: GestureDetector(
        //     onTap: () {/* Write listener code here */},
        //     child: Icon(
        //       Icons.menu, // add custom icons also
        //     ),
        //   ),
        //   actions: <Widget>[
        //     Padding(
        //         padding: EdgeInsets.only(right: 24.0),
        //         child: GestureDetector(
        //           onTap: () {},
        //           child: Icon(Icons.star),
        //         )),
        //     Padding(
        //         padding: EdgeInsets.only(right: 24.0),
        //         child: GestureDetector(
        //           onTap: () {
        //             //   Share.share("hidayetbaysal.com'da incelediğim arama sonucunu sizinle paylaşmak istiyorum");
        //           },
        //           child: Icon(Icons.share),
        //         )),
        //   ],
        // ),
        body: _emlakDetay.baslik == null
            ? Column()
            : Column(
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.all(10),
                    padding: EdgeInsets.all(10),

                    child: Text(
                      _emlakDetay.baslik,
                      softWrap: true,
                      overflow: TextOverflow.clip,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 16.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    //_emlakDetayListe[0].title),
                  ),

                  ///SingleChildScrollView(
                  //   child: Container(
                  //     height: 250,
                  //     child: PhotoViewGallery.builder(
                  //       scrollPhysics: const BouncingScrollPhysics(),
                  //       builder: (BuildContext context, int index) {
                  //         return PhotoViewGalleryPageOptions(
                  //           imageProvider: NetworkImage(
                  //             _imgList[index],
                  //           ),
                  //           initialScale:
                  //               PhotoViewComputedScale.contained * 0.8,
                  //           minScale: PhotoViewComputedScale.contained * 0.8,
                  //           maxScale: PhotoViewComputedScale.covered * 1.1,
                  //           heroAttributes: PhotoViewHeroAttributes(
                  //               tag: _imgList[index].hashCode),
                  //         );
                  //       },
                  //       itemCount: _imgList.length,
                  //       loadingBuilder: (context, event) => Center(
                  //         child: Container(
                  //           width: 20.0,
                  //           height: 20.0,
                  //           child: CircularProgressIndicator(
                  //             value: event == null
                  //                 ? 0
                  //                 : event.cumulativeBytesLoaded /
                  //                     event.expectedTotalBytes,
                  //           ),
                  //         ),
                  //       ),
                  //       backgroundDecoration: BoxDecoration(
                  //         color: Theme.of(context).canvasColor,
                  //       ),
                  //       // pageController: widget.pageController,
                  //       // onPageChanged: onPageChanged,
                  //     ),
                  //   ),
                  // ),

                  Expanded(
                    child: SingleChildScrollView(
                      padding: EdgeInsets.all(10),
                      child: Column(
                        children: <Widget>[
                          SingleChildScrollView(
                            child: Column(
                              children: <Widget>[
                                Container(
                                    height: 250,
                                    // width: 870,
                                    child: TextButton(
                                      child: PhotoViewGallery.builder(
                                        customSize: Size.fromWidth(
                                            SizeConfig.screenWidth),
                                        scrollPhysics:
                                            const BouncingScrollPhysics(),
                                        builder:
                                            (BuildContext context, int index) {
                                          return PhotoViewGalleryPageOptions(
                                            imageProvider:
                                                // Image.network(
                                                //   _imgList[index],
                                                //   //cacheHeight: 250,
                                                //   cacheWidth: 870,
                                                // ).image,
                                                NetworkImage(
                                              _imgList[index],
                                            ),
                                            // initialScale:
                                            //     PhotoViewComputedScale.contained * 0.8,
                                            // minScale:
                                            //     PhotoViewComputedScale.contained * 0.8,
                                            // maxScale:
                                            //     PhotoViewComputedScale.covered * 1.1,
                                            heroAttributes:
                                                PhotoViewHeroAttributes(
                                                    tag: _imgList[index]
                                                        .hashCode),
                                          );
                                        },
                                        itemCount: _imgList.length,
                                        loadingBuilder: (context, event) =>
                                            Center(
                                          child: Container(
                                            width: 20.0,
                                            height: 20.0,
                                            child: CircularProgressIndicator(
                                              value: event == null
                                                  ? 0
                                                  : event.cumulativeBytesLoaded /
                                                      event.expectedTotalBytes,
                                            ),
                                          ),
                                        ),
                                        backgroundDecoration: BoxDecoration(
                                          color: Theme.of(context).canvasColor,
                                          // color: Colors.black,
                                        ),
                                        // pageController: widget.pageController,
                                        onPageChanged: onPageChanged,
                                      ),
                                      onPressed: () {
                                        setState(() {
                                          open(context, currentIndex);
                                        });
                                      },
                                    )),
                                // FlatButton(
                                //   child: Image.network(
                                //     _imgList[0],
                                //   ),
                                //   onPressed: () {
                                //     open(context, 0);
                                //   },
                                // ),

                                // Row(
                                //   mainAxisAlignment: MainAxisAlignment.center,
                                //   children: <Widget>[
                                //     const Text("Dikey Galeri"),
                                //     Checkbox(
                                //       value: verticalGallery,
                                //       onChanged: (value) {
                                //         setState(() {
                                //           verticalGallery = value;
                                //         });
                                //       },
                                //     ),
                                //   ],
                                // ),

                                // Text(
                                //   _emlakDetay.emlakTipi,
                                //   textAlign: TextAlign.center,
                                //   style: TextStyle(
                                //     fontSize: 15.0,
                                //     color: Colors.black54,
                                //   ),
                                // ),
                                Text(
                                  _emlakDetay.konum,
                                  textAlign: TextAlign.center,
                                  softWrap: true,
                                  overflow: TextOverflow.clip,
                                  style: TextStyle(
                                    fontSize: 13.0,
                                    color: Colors.blue,
                                  ),
                                ),
                              ],
                            ),
                          ),

                          Row(
                            children: [
                              SizedBox(
                                width: 20,
                              ),
                              ElevatedButton(
                                child: (Text(
                                  "İlan Bilgisi",
                                  style: TextStyle(fontStyle: FontStyle.italic),
                                )),
                                onPressed: () => onPressButton(0),
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              ElevatedButton(
                                child: (Text(
                                  "Özellikler",
                                  style: TextStyle(fontStyle: FontStyle.italic),
                                )),
                                onPressed: () => onPressButton(1),
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              ElevatedButton(
                                child: (Text(
                                  "Konum",
                                  style: TextStyle(fontStyle: FontStyle.italic),
                                )),
                                onPressed: () => onPressButton(2),
                              ),
                            ],
                          ),
                          Divider(
                            color: hbRed,
                            //height: ,
                            thickness: 3,
                            indent: 0,
                            endIndent: 0,
                          ),

                          // ToggleButtons(
                          //    selectedColor: Colors.white,
                          //    fillColor: Colors.blue,
                          //   children: <Widget>[
                          //     Text("İlan Bilgisi"),
                          //     Text("Özellikler"),
                          //     Text("Konum"),
                          //   ],
                          //   onPressed: (int index) {
                          //     setState(() {
                          //       for (int buttonIndex = 0;
                          //           buttonIndex < isSelected.length;
                          //           buttonIndex++) {
                          //         if (buttonIndex == index) {
                          //           isSelected[buttonIndex] = true;
                          //           //  Theme.of(context).color = Colors.yellow;
                          //           if (buttonIndex == 2) {
                          //             var latit = _emlakDetay.enlem;
                          //             var longit = _emlakDetay.boylam;
                          //             launch(
                          //                 'https://www.google.com/maps/search/?api=1&query=$latit,$longit');
                          //             // _launchURL;
                          //             // _launchMapsUrl(_emlakDetay.enlem,
                          //             //     _emlakDetay.boylam);
                          //           }
                          //           btnIndex = buttonIndex;
                          //         } else {
                          //           isSelected[buttonIndex] = false;
                          //         }
                          //       }
                          //     });
                          //   },
                          //   isSelected: isSelected,
                          //   // fillColor: Colors.yellow,
                          //   // selectedColor: Colors.red,
                          // ),
                          // Divider(
                          //   color: Colors.yellow,
                          //   //height: ,
                          //   thickness: 3,
                          //   indent: 0,
                          //   endIndent: 0,
                          // ),
                          btnIndex == 0
                              ? _emlakDetay.ilanTipiID == 1
                                  ? SingleChildScrollView(
                                      child: Column(
                                        children: <Widget>[
                                          Row(
                                            children: <Widget>[
                                              Text("Fiyat:"),
                                              Spacer(),
                                              Text(
                                                _emlakDetay.fiyat,
                                                textAlign: TextAlign.end,
                                                softWrap: true,
                                                overflow: TextOverflow.clip,
                                              ),
                                            ],
                                          ),
                                          Divider(
                                            color: Colors.black,
                                            //height: ,
                                            thickness: 1,
                                            indent: 0,
                                            endIndent: 0,
                                          ),
                                          Row(
                                            children: <Widget>[
                                              Text("İlan Tarihi:"),
                                              Spacer(),
                                              Text(
                                                _emlakDetay.tarih,
                                                softWrap: true,
                                                overflow: TextOverflow.clip,
                                              ),
                                            ],
                                          ),
                                          Divider(
                                            color: Colors.black,
                                            //height: ,
                                            thickness: 1,
                                            indent: 0,
                                            endIndent: 0,
                                          ),
                                          Row(
                                            children: <Widget>[
                                              Text("İlan No:"),
                                              Spacer(),
                                              Text(_emlakDetay.id),
                                            ],
                                          ),
                                          Divider(
                                            color: Colors.black,
                                            //height: ,
                                            thickness: 1,
                                            indent: 0,
                                            endIndent: 0,
                                          ),
                                          Row(
                                            children: <Widget>[
                                              Text("Emlak Tipi:"),
                                              Spacer(),
                                              Text(
                                                _emlakDetay.emlakTipi,
                                                softWrap: true,
                                                overflow: TextOverflow.clip,
                                              ),
                                            ],
                                          ),
                                          Divider(
                                            color: Colors.black,
                                            //height: ,
                                            thickness: 1,
                                            indent: 0,
                                            endIndent: 0,
                                          ),
                                          Row(
                                            children: <Widget>[
                                              Text("m2(Brüt):"),
                                              Spacer(),
                                              Text(_emlakDetay.metrekare),
                                            ],
                                          ),
                                          Divider(
                                            color: Colors.black,
                                            //height: ,
                                            thickness: 1,
                                            indent: 0,
                                            endIndent: 0,
                                          ),
                                          Row(
                                            children: <Widget>[
                                              Text("m2(Net):"),
                                              Spacer(),
                                              Text(_emlakDetay.metrekareNet),
                                            ],
                                          ),
                                          Divider(
                                            color: Colors.black,
                                            //height: ,
                                            thickness: 1,
                                            indent: 0,
                                            endIndent: 0,
                                          ),
                                          Row(
                                            children: <Widget>[
                                              Text("Oda sayısı:"),
                                              Spacer(),
                                              Text(_emlakDetay.odaSayisi),
                                            ],
                                          ),
                                          Divider(
                                            color: Colors.black,
                                            //height: ,
                                            thickness: 1,
                                            indent: 0,
                                            endIndent: 0,
                                          ),
                                          Row(
                                            children: <Widget>[
                                              Text("Bina Yaşı:"),
                                              Spacer(),
                                              Text(_emlakDetay.binaYasi),
                                            ],
                                          ),
                                          Divider(
                                            color: Colors.black,
                                            //height: ,
                                            thickness: 1,
                                            indent: 0,
                                            endIndent: 0,
                                          ),
                                          Row(
                                            children: <Widget>[
                                              Text("Bulunduğu Kat:"),
                                              Spacer(),
                                              Text(_emlakDetay.bulunduguKat),
                                            ],
                                          ),
                                          Divider(
                                            color: Colors.black,
                                            //height: ,
                                            thickness: 1,
                                            indent: 0,
                                            endIndent: 0,
                                          ),
                                          Row(
                                            children: <Widget>[
                                              Text("Kat Sayısı:"),
                                              Spacer(),
                                              Text(_emlakDetay.katSayisi),
                                            ],
                                          ),
                                          Divider(
                                            color: Colors.black,
                                            //height: ,
                                            thickness: 1,
                                            indent: 0,
                                            endIndent: 0,
                                          ),
                                          Row(
                                            children: <Widget>[
                                              Text("Isıtma:"),
                                              Spacer(),
                                              Text(_emlakDetay.isitma),
                                            ],
                                          ),
                                          Divider(
                                            color: Colors.black,
                                            //height: ,
                                            thickness: 1,
                                            indent: 0,
                                            endIndent: 0,
                                          ),
                                          Row(
                                            children: <Widget>[
                                              Text("Banyo Sayısı:"),
                                              Spacer(),
                                              Text(_emlakDetay.banyoSayisi),
                                            ],
                                          ),
                                          Divider(
                                            color: Colors.black,
                                            //height: ,
                                            thickness: 1,
                                            indent: 0,
                                            endIndent: 0,
                                          ),
                                          Row(
                                            children: <Widget>[
                                              Text("Balkon:"),
                                              Spacer(),
                                              Text(_emlakDetay.balkon),
                                            ],
                                          ),
                                          Divider(
                                            color: Colors.black,
                                            //height: ,
                                            thickness: 1,
                                            indent: 0,
                                            endIndent: 0,
                                          ),
                                          Row(
                                            children: <Widget>[
                                              Text("Eşyalı:"),
                                              Spacer(),
                                              Text(_emlakDetay.esyali),
                                            ],
                                          ),
                                          Divider(
                                            color: Colors.black,
                                            //height: ,
                                            thickness: 1,
                                            indent: 0,
                                            endIndent: 0,
                                          ),
                                          Row(
                                            children: <Widget>[
                                              Text("Kullanım Durumu:"),
                                              Spacer(),
                                              Text(_emlakDetay.kullanimDurumu),
                                            ],
                                          ),
                                          Divider(
                                            color: Colors.black,
                                            //height: ,
                                            thickness: 1,
                                            indent: 0,
                                            endIndent: 0,
                                          ),
                                          Row(
                                            children: <Widget>[
                                              Text("Site içerisinde:"),
                                              Spacer(),
                                              Text(_emlakDetay.siteIcerisinde),
                                            ],
                                          ),
                                          Divider(
                                            color: Colors.black,
                                            //height: ,
                                            thickness: 1,
                                            indent: 0,
                                            endIndent: 0,
                                          ),
                                          Row(
                                            children: <Widget>[
                                              Text("Site Adı:"),
                                              Spacer(),
                                              Text(_emlakDetay.siteAdi),
                                            ],
                                          ),
                                          Divider(
                                            color: Colors.black,
                                            //height: ,
                                            thickness: 1,
                                            indent: 0,
                                            endIndent: 0,
                                          ),
                                          Row(
                                            children: <Widget>[
                                              Text("Aidat:"),
                                              Spacer(),
                                              Text(_emlakDetay.aidat),
                                            ],
                                          ),
                                          Divider(
                                            color: Colors.black,
                                            //height: ,
                                            thickness: 1,
                                            indent: 0,
                                            endIndent: 0,
                                          ),
                                          Row(
                                            children: <Widget>[
                                              Text("Krediye Uygun:"),
                                              Spacer(),
                                              Text(_emlakDetay.krediyeUygun),
                                            ],
                                          ),
                                          Divider(
                                            color: Colors.black,
                                            //height: ,
                                            thickness: 1,
                                            indent: 0,
                                            endIndent: 0,
                                          ),

                                          Container(
                                            // margin: EdgeInsets.all(10),
                                            // padding: EdgeInsets.all(10),
                                            alignment: Alignment.center,
                                            decoration: BoxDecoration(
                                                color: Colors.grey,
                                                border: Border.all(
                                                    color: Colors.grey,
                                                    // set border color
                                                    width:
                                                        10.0), // set border width
                                                // set rounded corner radius
                                                boxShadow: [
                                                  BoxShadow(
                                                    //blurRadius: 10,
                                                    color: Colors.black,
                                                    // offset: Offset(1, 3))
                                                  )
                                                ] // make rounded corner of border
                                                ),
                                            child: Text(
                                              "Açıklama",
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          ),
                                          // Text(
                                          //   "Cephe",
                                          //   // textAlign: TextAlign.left,
                                          //   style: TextStyle(fontWeight: FontWeight.bold),
                                          // ),
                                          // Container(
                                          //   child: HTML.toRichText(
                                          //       context,
                                          //       _emlakDetay.aciklama != null
                                          //           ? _emlakDetay.aciklama
                                          //           : ''),
                                          // ),
                                          // RichText(
                                          //   text: HTML.toTextSpan(
                                          //     context,
                                          //     _emlakDetay.aciklama != null
                                          //         ? (_emlakDetay.aciklama +
                                          //             "</br>&nbsp")
                                          //         : '',
                                          //   ),
                                          // )
                                          Html(
                                            data: _emlakDetay.aciklama != null
                                                ? _emlakDetay.aciklama
                                                : '',
                                            // softWrap: true,
                                            // overflow: TextOverflow.clip,
                                          ),
                                          /////
                                        ],
                                      ),
                                    )
                                  : _emlakDetay.emlakTipi == "Satılık"
                                      ? SingleChildScrollView(
                                          child: Column(children: <Widget>[
                                          Row(
                                            children: <Widget>[
                                              Text("Fiyat:"),
                                              Spacer(),
                                              Text(
                                                _emlakDetay.fiyat,
                                                textAlign: TextAlign.end,
                                                softWrap: true,
                                                overflow: TextOverflow.clip,
                                              ),
                                            ],
                                          ),
                                          Divider(
                                            color: Colors.black,
                                            //height: ,
                                            thickness: 1,
                                            indent: 0,
                                            endIndent: 0,
                                          ),
                                          Row(
                                            children: <Widget>[
                                              Text("İlan Tarihi:"),
                                              Spacer(),
                                              Text(
                                                _emlakDetay.tarih,
                                                softWrap: true,
                                                overflow: TextOverflow.clip,
                                              ),
                                            ],
                                          ),
                                          Divider(
                                            color: Colors.black,
                                            //height: ,
                                            thickness: 1,
                                            indent: 0,
                                            endIndent: 0,
                                          ),
                                          Row(
                                            children: <Widget>[
                                              Text("İlan No:"),
                                              Spacer(),
                                              Text(_emlakDetay.id),
                                            ],
                                          ),
                                          Divider(
                                            color: Colors.black,
                                            //height: ,
                                            thickness: 1,
                                            indent: 0,
                                            endIndent: 0,
                                          ),
                                          Row(
                                            children: <Widget>[
                                              Text("Emlak Tipi:"),
                                              Spacer(),
                                              Text(
                                                _emlakDetay.emlakTipi,
                                                softWrap: true,
                                                overflow: TextOverflow.clip,
                                              ),
                                            ],
                                          ),
                                          Divider(
                                            color: Colors.black,
                                            //height: ,
                                            thickness: 1,
                                            indent: 0,
                                            endIndent: 0,
                                          ),
                                          Row(
                                            children: <Widget>[
                                              Text("m2(Brüt)"),
                                              Spacer(),
                                              Text(_emlakDetay.metrekare),
                                            ],
                                          ),
                                          Divider(
                                            color: Colors.black,
                                            //height: ,
                                            thickness: 1,
                                            indent: 0,
                                            endIndent: 0,
                                          ),
                                          Row(
                                            children: <Widget>[
                                              Text("m2(Net):"),
                                              Spacer(),
                                              Text(_emlakDetay.metrekareNet),
                                            ],
                                          ),
                                          Divider(
                                            color: Colors.black,
                                            //height: ,
                                            thickness: 1,
                                            indent: 0,
                                            endIndent: 0,
                                          ),
                                          Row(
                                            children: <Widget>[
                                              Text("Bölüm & Oda sayısı:"),
                                              Spacer(),
                                              Text(_emlakDetay.odaSayisi),
                                            ],
                                          ),
                                          Divider(
                                            color: Colors.black,
                                            //height: ,
                                            thickness: 1,
                                            indent: 0,
                                            endIndent: 0,
                                          ),
                                          Row(
                                            children: <Widget>[
                                              Text("Bina Yaşı:"),
                                              Spacer(),
                                              Text(_emlakDetay.binaYasi),
                                            ],
                                          ),
                                          Divider(
                                            color: Colors.black,
                                            //height: ,
                                            thickness: 1,
                                            indent: 0,
                                            endIndent: 0,
                                          ),
                                          Row(
                                            children: <Widget>[
                                              Text("Isıtma:"),
                                              Spacer(),
                                              Text(_emlakDetay.isitma),
                                            ],
                                          ),
                                          Divider(
                                            color: Colors.black,
                                            //height: ,
                                            thickness: 1,
                                            indent: 0,
                                            endIndent: 0,
                                          ),
                                          Row(
                                            children: <Widget>[
                                              Text("Kullanım Durumu:"),
                                              Spacer(),
                                              Text(_emlakDetay.kullanimDurumu),
                                            ],
                                          ),
                                          Divider(
                                            color: Colors.black,
                                            //height: ,
                                            thickness: 1,
                                            indent: 0,
                                            endIndent: 0,
                                          ),
                                          Row(
                                            children: <Widget>[
                                              Text("Site içerisinde:"),
                                              Spacer(),
                                              Text(_emlakDetay.siteIcerisinde),
                                            ],
                                          ),
                                          Divider(
                                            color: Colors.black,
                                            //height: ,
                                            thickness: 1,
                                            indent: 0,
                                            endIndent: 0,
                                          ),
                                          Row(
                                            children: <Widget>[
                                              Text("Site Adı:"),
                                              Spacer(),
                                              Text(_emlakDetay.siteAdi),
                                            ],
                                          ),
                                          Divider(
                                            color: Colors.black,
                                            //height: ,
                                            thickness: 1,
                                            indent: 0,
                                            endIndent: 0,
                                          ),
                                          Row(
                                            children: <Widget>[
                                              Text("Aidat:"),
                                              Spacer(),
                                              Text(_emlakDetay.aidat),
                                            ],
                                          ),
                                          Divider(
                                            color: Colors.black,
                                            //height: ,
                                            thickness: 1,
                                            indent: 0,
                                            endIndent: 0,
                                          ),
                                          Row(
                                            children: <Widget>[
                                              Text("Krediye Uygun:"),
                                              Spacer(),
                                              Text(_emlakDetay.krediyeUygun),
                                            ],
                                          ),
                                          Divider(
                                            color: Colors.black,
                                            //height: ,
                                            thickness: 1,
                                            indent: 0,
                                            endIndent: 0,
                                          ),
                                          Container(
                                            // margin: EdgeInsets.all(10),
                                            // padding: EdgeInsets.all(10),
                                            alignment: Alignment.center,
                                            decoration: BoxDecoration(
                                                color: Colors.grey,
                                                border: Border.all(
                                                    color: Colors.grey,
                                                    // set border color
                                                    width:
                                                        10.0), // set border width
                                                // set rounded corner radius
                                                boxShadow: [
                                                  BoxShadow(
                                                    //blurRadius: 10,
                                                    color: Colors.black,
                                                    // offset: Offset(1, 3))
                                                  )
                                                ] // make rounded corner of border
                                                ),
                                            child: Text(
                                              "Açıklama",
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          ),
                                          Html(
                                            data: _emlakDetay.aciklama != null
                                                ? _emlakDetay.aciklama
                                                : '',
                                            // softWrap: true,
                                            // overflow: TextOverflow.clip,
                                          ),
                                        ]))
                                      : SingleChildScrollView(
                                          child: Column(children: <Widget>[
                                          Row(
                                            children: <Widget>[
                                              Text("Fiyat:"),
                                              Spacer(),
                                              Text(
                                                _emlakDetay.fiyat,
                                                textAlign: TextAlign.end,
                                                softWrap: true,
                                                overflow: TextOverflow.clip,
                                              ),
                                            ],
                                          ),
                                          Divider(
                                            color: Colors.black,
                                            //height: ,
                                            thickness: 1,
                                            indent: 0,
                                            endIndent: 0,
                                          ),
                                          Row(
                                            children: <Widget>[
                                              Text("İlan Tarihi:"),
                                              Spacer(),
                                              Text(
                                                _emlakDetay.tarih,
                                                softWrap: true,
                                                overflow: TextOverflow.clip,
                                              ),
                                            ],
                                          ),
                                          Divider(
                                            color: Colors.black,
                                            //height: ,
                                            thickness: 1,
                                            indent: 0,
                                            endIndent: 0,
                                          ),
                                          Row(
                                            children: <Widget>[
                                              Text("İlan No:"),
                                              Spacer(),
                                              Text(_emlakDetay.id),
                                            ],
                                          ),
                                          Divider(
                                            color: Colors.black,
                                            //height: ,
                                            thickness: 1,
                                            indent: 0,
                                            endIndent: 0,
                                          ),
                                          Row(
                                            children: <Widget>[
                                              Text("Emlak Tipi:"),
                                              Spacer(),
                                              Text(
                                                _emlakDetay.emlakTipi,
                                                softWrap: true,
                                                overflow: TextOverflow.clip,
                                              ),
                                            ],
                                          ),
                                          Divider(
                                            color: Colors.black,
                                            //height: ,
                                            thickness: 1,
                                            indent: 0,
                                            endIndent: 0,
                                          ),
                                          Row(
                                            children: <Widget>[
                                              Text("m2(Brüt)"),
                                              Spacer(),
                                              Text(_emlakDetay.metrekare),
                                            ],
                                          ),
                                          Divider(
                                            color: Colors.black,
                                            //height: ,
                                            thickness: 1,
                                            indent: 0,
                                            endIndent: 0,
                                          ),
                                          Row(
                                            children: <Widget>[
                                              Text("m2(Net):"),
                                              Spacer(),
                                              Text(_emlakDetay.metrekareNet),
                                            ],
                                          ),
                                          Divider(
                                            color: Colors.black,
                                            //height: ,
                                            thickness: 1,
                                            indent: 0,
                                            endIndent: 0,
                                          ),
                                          Row(
                                            children: <Widget>[
                                              Text("Bölüm & Oda sayısı:"),
                                              Spacer(),
                                              Text(_emlakDetay.odaSayisi),
                                            ],
                                          ),
                                          Divider(
                                            color: Colors.black,
                                            //height: ,
                                            thickness: 1,
                                            indent: 0,
                                            endIndent: 0,
                                          ),
                                          Row(
                                            children: <Widget>[
                                              Text("Bina Yaşı:"),
                                              Spacer(),
                                              Text(_emlakDetay.binaYasi),
                                            ],
                                          ),
                                          Divider(
                                            color: Colors.black,
                                            //height: ,
                                            thickness: 1,
                                            indent: 0,
                                            endIndent: 0,
                                          ),
                                          Row(
                                            children: <Widget>[
                                              Text("Isıtma:"),
                                              Spacer(),
                                              Text(_emlakDetay.isitma),
                                            ],
                                          ),
                                          Divider(
                                            color: Colors.black,
                                            //height: ,
                                            thickness: 1,
                                            indent: 0,
                                            endIndent: 0,
                                          ),
                                          Row(
                                            children: <Widget>[
                                              Text("Kullanım Durumu:"),
                                              Spacer(),
                                              Text(_emlakDetay.kullanimDurumu),
                                            ],
                                          ),
                                          Divider(
                                            color: Colors.black,
                                            //height: ,
                                            thickness: 1,
                                            indent: 0,
                                            endIndent: 0,
                                          ),
                                          Row(
                                            children: <Widget>[
                                              Text("Site içerisinde:"),
                                              Spacer(),
                                              Text(_emlakDetay.siteIcerisinde),
                                            ],
                                          ),
                                          Divider(
                                            color: Colors.black,
                                            //height: ,
                                            thickness: 1,
                                            indent: 0,
                                            endIndent: 0,
                                          ),
                                          Row(
                                            children: <Widget>[
                                              Text("Site Adı:"),
                                              Spacer(),
                                              Text(_emlakDetay.siteAdi),
                                            ],
                                          ),
                                          Divider(
                                            color: Colors.black,
                                            //height: ,
                                            thickness: 1,
                                            indent: 0,
                                            endIndent: 0,
                                          ),
                                          Row(
                                            children: <Widget>[
                                              Text("Aidat:"),
                                              Spacer(),
                                              Text(_emlakDetay.aidat),
                                            ],
                                          ),
                                          Divider(
                                            color: Colors.black,
                                            //height: ,
                                            thickness: 1,
                                            indent: 0,
                                            endIndent: 0,
                                          ),
                                          Container(
                                            // margin: EdgeInsets.all(10),
                                            // padding: EdgeInsets.all(10),
                                            alignment: Alignment.center,
                                            decoration: BoxDecoration(
                                                color: Colors.grey,
                                                border: Border.all(
                                                    color: Colors.grey,
                                                    // set border color
                                                    width:
                                                        10.0), // set border width
                                                // set rounded corner radius
                                                boxShadow: [
                                                  BoxShadow(
                                                    //blurRadius: 10,
                                                    color: Colors.black,
                                                    // offset: Offset(1, 3))
                                                  )
                                                ] // make rounded corner of border
                                                ),
                                            child: Text(
                                              "Açıklama",
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          ),
                                          Html(
                                            data: _emlakDetay.aciklama != null
                                                ? _emlakDetay.aciklama
                                                : '',
                                            // softWrap: true,
                                            // overflow: TextOverflow.clip,
                                          ),
                                        ]))
                              : btnIndex == 1
                                  ? SingleChildScrollView(
                                      child: Column(children: <Widget>[
                                      Text(
                                        "Cephe",
                                        // textAlign: TextAlign.left,
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold),
                                      ),
                                      Text(
                                        (_emlakDetay.cephe ?? "").toString(),
                                        softWrap: true,
                                        overflow: TextOverflow.clip,
                                      ),
                                      Divider(
                                        color: Colors.black,
                                        //height: ,
                                        thickness: 1,
                                        indent: 0,
                                        endIndent: 0,
                                      ),
                                      Text(
                                        "İç Özellikler",
                                        //textAlign: TextAlign.left,
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold),
                                      ),
                                      Text(
                                        (_emlakDetay.icOzellikler ?? "")
                                            .toString(),
                                        softWrap: true,
                                        overflow: TextOverflow.clip,
                                      ),
                                      Divider(
                                        color: Colors.black,
                                        //height: ,
                                        thickness: 1,
                                        indent: 0,
                                        endIndent: 0,
                                      ),
                                      Text(
                                        "Dış Özellikler",
                                        //textAlign: TextAlign.left,
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold),
                                      ),
                                      Text(
                                        (_emlakDetay.disOzellikler ?? "")
                                            .toString(),
                                        softWrap: true,
                                        overflow: TextOverflow.clip,
                                      ),
                                      Divider(
                                        color: Colors.black,
                                        //height: ,
                                        thickness: 1,
                                        indent: 0,
                                        endIndent: 0,
                                      ),
                                      Text(
                                        "Muhit",
                                        //textAlign: TextAlign.left,
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold),
                                      ),
                                      Text(
                                        (_emlakDetay.muhit ?? "").toString(),
                                        softWrap: true,
                                        overflow: TextOverflow.clip,
                                      ),
                                      Divider(
                                        color: Colors.black,
                                        //height: ,
                                        thickness: 1,
                                        indent: 0,
                                        endIndent: 0,
                                      ),
                                      Text(
                                        "Ulaşım",
                                        //textAlign: TextAlign.left,
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold),
                                      ),
                                      Text(
                                        (_emlakDetay.ulasim ?? "").toString(),
                                        softWrap: true,
                                        overflow: TextOverflow.clip,
                                      ),
                                      Divider(
                                        color: Colors.black,
                                        //height: ,
                                        thickness: 1,
                                        indent: 0,
                                        endIndent: 0,
                                      ),
                                      Text(
                                        "Manzara",
                                        //textAlign: TextAlign.left,
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold),
                                      ),
                                      Text(
                                        (_emlakDetay.manzara ?? "").toString(),
                                        softWrap: true,
                                        overflow: TextOverflow.clip,
                                      ),
                                      Divider(
                                        color: Colors.black,
                                        //height: ,
                                        thickness: 1,
                                        indent: 0,
                                        endIndent: 0,
                                      ),
                                      Text(
                                        "Konut Tipi",
                                        //textAlign: TextAlign.left,
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold),
                                      ),
                                      Text(
                                        (_emlakDetay.konutTipi ?? "")
                                            .toString(),
                                        softWrap: true,
                                        overflow: TextOverflow.clip,
                                      ),
                                      Divider(
                                        color: Colors.black,
                                        //height: ,
                                        thickness: 1,
                                        indent: 0,
                                        endIndent: 0,
                                      )
                                    ]))
                                  // : btnIndex == 2
                                  //     // ? openMapsSheet(context)
                                  //     ? _launchMapsUrl(37.759392, -122.5107336)
                                  : SingleChildScrollView(
                                      child: Column(children: <Widget>[
                                      Text(
                                        "Konum",
                                        // textAlign: TextAlign.left,
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold),
                                      )
                                    ]))
                        ],
                      ),
                    ),
                  ),
                ],
              ));
  }
}

class GalleryPhotoViewWrapper extends StatefulWidget {
  GalleryPhotoViewWrapper({
    this.loadingBuilder,
    this.backgroundDecoration,
    this.minScale,
    this.maxScale,
    this.initialIndex,
    @required this.galleryItems,
    this.scrollDirection = Axis.horizontal,
  }) : pageController = PageController(initialPage: initialIndex);

  final LoadingBuilder loadingBuilder;
  final Decoration backgroundDecoration;
  final dynamic minScale;
  final dynamic maxScale;
  final int initialIndex;
  final PageController pageController;
  final List<String> galleryItems;
  final Axis scrollDirection;

  @override
  State<StatefulWidget> createState() {
    return _GalleryPhotoViewWrapperState();
  }
}

class _GalleryPhotoViewWrapperState extends State<GalleryPhotoViewWrapper> {
  int currentIndex = 0;

  @override
  void initState() {
    currentIndex = widget.initialIndex;
    super.initState();
  }

  void onPageChanged(int index) {
    setState(() {
      currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: widget.backgroundDecoration,
        constraints: BoxConstraints.expand(
          height: MediaQuery.of(context).size.height,
        ),
        child: Stack(
          alignment: Alignment.bottomRight,
          children: <Widget>[
            PhotoViewGallery.builder(
              scrollPhysics: const BouncingScrollPhysics(),
              builder: _buildItem,
              itemCount: widget.galleryItems.length,
              loadingBuilder: widget.loadingBuilder,
              backgroundDecoration: widget.backgroundDecoration,
              pageController: widget.pageController,
              onPageChanged: onPageChanged,
              scrollDirection: widget.scrollDirection,
            ),
            Container(
              padding: const EdgeInsets.all(20.0),
              child: Text(
                "Fotoğraf ${currentIndex + 1}",
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 17.0,
                  decoration: null,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  PhotoViewGalleryPageOptions _buildItem(BuildContext context, int index) {
    final String item = widget.galleryItems[index];
    return PhotoViewGalleryPageOptions(
      imageProvider: NetworkImage(
        item,
      ),
      // initialScale: PhotoViewComputedScale.contained,
      // minScale: PhotoViewComputedScale.contained * (0.5 + index / 10),
      // maxScale: PhotoViewComputedScale.covered * 4.1,
      heroAttributes: PhotoViewHeroAttributes(tag: item.hashCode),
    );
  }
}
