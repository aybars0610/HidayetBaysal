class EmlakData {
  int id;
  String type;
  String title;
  int area;
  String numberOfRooms;
  String price;
  String releaseDate;
  String district;
  String picture;
  String floor;
  String detail;

  EmlakData(
      {this.id,
      this.type,
      this.title,
      this.area,
      this.numberOfRooms,
      this.price,
      this.releaseDate,
      this.district,
      this.floor,
      this.picture,
      this.detail});

  EmlakData.fromJson(Map<String, dynamic> json) {
    id = json['Id'];
    type = json['Type'];
    title = json['Title'];
    area = json['Area'];
    numberOfRooms = json['NumberOfRooms'];
    floor = json['Floor'];
    price = json['Price'];
    releaseDate = json['ReleaseDate'];
    district = json['District'];
    picture = json['Picture'];
    detail = json['Detail'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();

    data['Id'] = this.id;
    data['Type'] = this.type;
    data['Title'] = this.title;
    data['Area'] = this.area;
    data['NumberOfRooms'] = this.numberOfRooms;
    data['Price'] = this.price;
    data['ReleaseDate'] = this.releaseDate;
    data['Floor'] = this.floor;

    data['District'] = this.district;
    data['Picture'] = this.picture;
    data['Detail'] = this.detail;
    return data;
  }
}
