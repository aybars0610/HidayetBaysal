class User {
  String userId;
  String name;
  String surname;
  String phone;
  String password;
  String email;
  String tcKimlik;
  String userName;
  String role;
  // bool bilgilendirme;
  // bool sozlesme;

  User({
    this.userId,
    this.name,
    this.surname,
    this.phone,
    this.password,
    this.email,
    this.tcKimlik,
    this.userName,
    this.role,
    // this.bilgilendirme,
    // this.sozlesme
  });

  User.fromJson(Map<String, dynamic> json) {
    userId = json['userId'];
    name = json['name'];
    surname = json['surname'];
    phone = json['phone'];
    password = json['password'];
    email = json['email'];
    tcKimlik = json['tc'];
    userName = json['userName'];
    role = json['role'];
    // bilgilendirme = json['Bilgilendirme'];
    // sozlesme = json['Sozlesme'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['userId'] = this.userId;
    data['name'] = this.name;
    data['surname'] = this.surname;
    data['phone'] = this.phone;
    data['password'] = this.password;
    data['email'] = this.email;
    data['tc'] = this.tcKimlik;
    data['userName'] = this.userName;
    data['role'] = this.role;
    // data['Bilgilendirme'] = this.bilgilendirme;
    // data['Sozlesme'] = this.sozlesme;
    return data;
  }
}
