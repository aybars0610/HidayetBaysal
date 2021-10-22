class AramaList {
  int iD;
  String title;

  AramaList({
    this.iD,
    this.title,
  });

  AramaList.fromJson(Map<String, dynamic> json) {
    iD = json['ID'];
    title = json['Title'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ID'] = this.iD;
    data['Title'] = this.title;

    return data;
  }
}
