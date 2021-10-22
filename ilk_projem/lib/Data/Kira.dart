import 'dart:ffi';

class Kira {
  int userId;
  String name;
  String surname;
  String daireNo;
  String siteAdi;
  String kat;
  String borc;
  bool odemeDurumu;

  String tcKimlik;

  String role;
  // bool bilgilendirme;
  // bool sozlesme;

  Kira({
    this.userId,
    this.name,
    this.surname,
    this.borc,
    this.daireNo,
    this.siteAdi,
    this.kat,
    this.odemeDurumu,
    this.tcKimlik,
    this.role,
    // this.bilgilendirme,
    // this.sozlesme
  });

  Kira.fromJson(Map<String, dynamic> json) {
    userId = json['userId'];
    name = json['name'];
    surname = json['surname'];
    borc = json['borc'];
    odemeDurumu = json['odemeDurumu'];
    daireNo = json['daireNo'];
    siteAdi = json['siteAdi'];
    kat = json['kat'];

    tcKimlik = json['tcKimlik'];

    role = json['role'];
    // bilgilendirme = json['Bilgilendirme'];
    // sozlesme = json['Sozlesme'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['userId'] = this.userId;
    data['name'] = this.name;
    data['surname'] = this.surname;
    data['borc'] = this.borc;
    data['daireNo'] = this.daireNo;
    data['siteAdi'] = this.siteAdi;
    data['kat'] = this.kat;
    data['odemeDurumu'] = this.odemeDurumu;

    data['tcKimlik'] = this.tcKimlik;

    data['role'] = this.role;
    // data['Bilgilendirme'] = this.bilgilendirme;
    // data['Sozlesme'] = this.sozlesme;
    return data;
  }
}
