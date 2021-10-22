class AnasayfaSlider {
  int ilanId;
  List<Fotograflar> fotograflar;
  String isim;

  AnasayfaSlider({this.ilanId, this.fotograflar, this.isim});

  AnasayfaSlider.fromJson(Map<String, dynamic> json) {
    if (json['Fotograflar'] != null) {
      fotograflar = [];
      json['Fotograflar'].forEach((v) {
        fotograflar.add(new Fotograflar.fromJson(v));
      });
    }
    isim = json['Isim'];
    ilanId = json['IlanId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.fotograflar != null) {
      data['Fotograflar'] = this.fotograflar.map((v) => v.toJson()).toList();
    }
    data['Isim'] = this.isim;
    data['IlanId'] = this.ilanId;
    return data;
  }
}

class Fotograflar {
  String name;

  Fotograflar({this.name});

  Fotograflar.fromJson(Map<String, dynamic> json) {
    name = json['Name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Name'] = this.name;
    return data;
  }
}
