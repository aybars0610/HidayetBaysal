class Favori {
  int iD;
  String title;
  String price;
  String picture;
  bool favorite;
  bool yayin;

  Favori(
      {this.iD,
      this.title,
      this.price,
      this.picture,
      this.favorite,
      this.yayin});

  Favori.fromJson(Map<String, dynamic> json) {
    iD = json['ID'];
    title = json['Title'];
    price = json['Price'];
    picture = json['Picture'];
    favorite = json['Favorite'];
    yayin = json['Yayin'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ID'] = this.iD;
    data['Title'] = this.title;
    data['Price'] = this.price;
    data['Picture'] = this.picture;
    data['Favorite'] = this.favorite;
    data['Yayin'] = this.yayin;

    return data;
  }
}
