import 'dart:ffi';

class AylikBorc {
  int userId;
  String name;
  String surname;
  String aylikGelir;
  String toplamBorc;

  String role;
  // bool bilgilendirme;
  // bool sozlesme;

  AylikBorc({
    this.userId,
    this.name,
    this.surname,
    this.aylikGelir,
    this.toplamBorc,
    this.role,
    // this.bilgilendirme,
    // this.sozlesme
  });

  AylikBorc.fromJson(Map<String, dynamic> json) {
    userId = json['userId'];
    name = json['name'];
    surname = json['surname'];
    aylikGelir = json['aylikGelir'];
    toplamBorc = json['toplamBorc'];

    role = json['role'];
    // bilgilendirme = json['Bilgilendirme'];
    // sozlesme = json['Sozlesme'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['userId'] = this.userId;
    data['name'] = this.name;
    data['surname'] = this.surname;
    data['aylikGelir'] = this.aylikGelir;
    data['toplamBorc'] = this.toplamBorc;

    data['role'] = this.role;
    // data['Bilgilendirme'] = this.bilgilendirme;
    // data['Sozlesme'] = this.sozlesme;
    return data;
  }
}
