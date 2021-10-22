class Ilce {
  int iD;
  String ilceAdi;
  bool isChecked;

  Ilce({this.iD, this.ilceAdi, this.isChecked});

  Ilce.fromJson(Map<String, dynamic> json) {
    iD = json['ID'];
    ilceAdi = json['Ilce_Adi'];
    isChecked = false; //json['IsCheck'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ID'] = this.iD;
    data['Ilce_Adi'] = this.ilceAdi;
    data['IsChecked'] = false; // this.isCheck;
    return data;
  }
}

class Semt {
  int iD;
  String semtAdi;
  List<Mahalle> mahalle;
  bool isCheck;

  Semt({this.iD, this.semtAdi, this.mahalle, this.isCheck});

  Semt.fromJson(Map<String, dynamic> json) {
    iD = json['ID'];
    semtAdi = json['Semt_Adi'];
    isCheck = json['IsCheck'];
    if (json['Mahalle'] != null) {
      mahalle = [];
      json['Mahalle'].forEach((v) {
        mahalle.add(new Mahalle.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ID'] = this.iD;
    data['Semt_Adi'] = this.semtAdi;
    data['IsCheck'] = this.isCheck;
    if (this.mahalle != null) {
      data['Mahalle'] = this.mahalle.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

//  class Mahalle {
//   int iD;
//   String mahalleAdi;
//   bool isChecked;

//   Mahalle({this.iD, this.mahalleAdi, this.isChecked});

//   Mahalle.fromJson(Map<String, dynamic> json) {
//     iD = json['ID'];
//     mahalleAdi = json['Mahalle_Adi'];
//     isChecked = json['IsChecked'];
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['ID'] = this.iD;
//     data['Mahalle_Adi'] = this.mahalleAdi;
//     data['IsChecked'] = this.isChecked;
//     return data;
//   }
// }
//
class Mahalle {
  int iD;
  String mahalleAdi;
  bool isChecked;

  Mahalle({this.iD, this.mahalleAdi, this.isChecked});

  Mahalle.fromJson(Map<String, dynamic> json) {
    iD = json['ID'];
    mahalleAdi = json['Mahalle_Adi'];
    isChecked = false; //json['IsChecked'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ID'] = this.iD;
    data['Mahalle_Adi'] = this.mahalleAdi;
    data['IsChecked'] = false; //this.isChecked;
    return data;
  }
}

class OdaSayisi {
  int iD;
  String ad;
  bool isCheck;

  OdaSayisi({this.iD, this.ad, this.isCheck});

  OdaSayisi.fromJson(Map<String, dynamic> json) {
    iD = json['ID'];
    ad = json['Ad'];
    isCheck = false; //json['IsCheck'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ID'] = this.iD;
    data['Ad'] = this.ad;
    data['IsCheck'] = false; //this.isCheck;
    return data;
  }
}

class Esya {
  int iD;
  String esyaAdi;

  Esya({this.iD, this.esyaAdi});

  Esya.fromJson(Map<String, dynamic> json) {
    iD = json['ID'];
    esyaAdi = json['EsyaAdi'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ID'] = this.iD;
    data['EsyaAdi'] = this.esyaAdi;
    return data;
  }
}

class SiteAdi {
  int iD;
  String siteAdi;

  SiteAdi({this.iD, this.siteAdi});

  SiteAdi.fromJson(Map<String, dynamic> json) {
    iD = json['ID'];
    siteAdi = json['SiteAdi'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ID'] = this.iD;
    data['SiteAdi'] = this.siteAdi;
    return data;
  }
}

class BulunduguKat {
  int iD;
  String ad;
  bool isCheck;

  BulunduguKat({this.iD, this.ad, this.isCheck});

  BulunduguKat.fromJson(Map<String, dynamic> json) {
    iD = json['ID'];
    ad = json['Ad'];
    isCheck = false; //json['IsCheck'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ID'] = this.iD;
    data['Ad'] = this.ad;
    data['IsCheck'] = false; //this.isCheck;
    return data;
  }
}
