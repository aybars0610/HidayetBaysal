class EmlakDetailData {
  String id;
  String aciklama;
  String konum;
  String baslik;
  String tarih;
  String emlakTipi;
  int ilanTipiID;
  String metrekare;
  String metrekareNet;
  String odaSayisi;
  String binaYasi;
  String bulunduguKat;
  String katSayisi;
  String isitma;
  String banyoSayisi;
  String balkon;
  String esyali;
  String kullanimDurumu;
  String siteIcerisinde;
  String siteAdi;
  String aidat;
  String krediyeUygun;
  String goruntuluAramaIleGezilebilir;
  String fiyat;
  String enlem;
  String boylam;
  List<String> fotograflar;
  List<String> cephe;
  List<String> icOzellikler;
  List<String> disOzellikler;
  List<String> muhit;
  List<String> ulasim;
  List<String> manzara;
  List<String> konutTipi;
  bool isCheck;

  EmlakDetailData(
      {this.id,
      this.aciklama,
      this.konum,
      this.baslik,
      this.tarih,
      this.emlakTipi,
      this.ilanTipiID,
      this.metrekare,
      this.metrekareNet,
      this.odaSayisi,
      this.binaYasi,
      this.bulunduguKat,
      this.katSayisi,
      this.isitma,
      this.banyoSayisi,
      this.balkon,
      this.esyali,
      this.kullanimDurumu,
      this.siteIcerisinde,
      this.siteAdi,
      this.aidat,
      this.krediyeUygun,
      this.goruntuluAramaIleGezilebilir,
      this.fiyat,
      this.enlem,
      this.boylam,
      this.fotograflar,
      this.cephe,
      this.icOzellikler,
      this.disOzellikler,
      this.muhit,
      this.ulasim,
      this.manzara,
      this.isCheck,
      this.konutTipi});

  EmlakDetailData.fromJson(Map<String, dynamic> json) {
    id = json['Id'];
    aciklama = json['Aciklama'];
    konum = json['Konum'];
    baslik = json['Baslik'];
    tarih = json['Tarih'];
    emlakTipi = json['EmlakTipi'];
    ilanTipiID = json['IlanTipiID'];
    metrekare = json['Metrekare'];
    metrekareNet = json['MetrekareNet'];
    odaSayisi = json['OdaSayisi'];
    binaYasi = json['BinaYasi'];
    bulunduguKat = json['BulunduguKat'];
    katSayisi = json['KatSayisi'];
    isitma = json['Isitma'];
    banyoSayisi = json['BanyoSayisi'];
    balkon = json['Balkon'];
    esyali = json['Esyali'];
    kullanimDurumu = json['KullanimDurumu'];
    siteIcerisinde = json['SiteIcerisinde'];
    siteAdi = json['SiteAdi'];
    aidat = json['Aidat'];
    krediyeUygun = json['KrediyeUygun'];
    goruntuluAramaIleGezilebilir = json['GoruntuluAramaIleGezilebilir'];
    fiyat = json['Fiyat'];
    enlem = json['Enlem'];
    boylam = json['Boylam'];
    fotograflar = json['Fotograflar'].cast<String>();
    cephe = json['Cepheler'].cast<String>();
    icOzellikler = json['IcOzellikler'].cast<String>();
    disOzellikler = json['DisOzellikler'].cast<String>();
    muhit = json['Muhit'].cast<String>();
    ulasim = json['Ulasim'].cast<String>();
    manzara = json['Manzara'].cast<String>();
    isCheck = json['IsCheck'];
    konutTipi = json['KonutTipi'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Id'] = this.id;
    data['Aciklama'] = this.aciklama;
    data['Konum'] = this.konum;
    data['Baslik'] = this.baslik;
    data['Tarih'] = this.tarih;
    data['EmlakTipi'] = this.emlakTipi;
    data['Metrekare'] = this.metrekare;
    data['MetrekareNet'] = this.metrekareNet;
    data['OdaSayisi'] = this.odaSayisi;
    data['BinaYasi'] = this.binaYasi;
    data['BulunduguKat'] = this.bulunduguKat;
    data['KatSayisi'] = this.katSayisi;
    data['Isitma'] = this.isitma;
    data['BanyoSayisi'] = this.banyoSayisi;
    data['Balkon'] = this.balkon;
    data['Esyali'] = this.esyali;
    data['KullanimDurumu'] = this.kullanimDurumu;
    data['SiteIcerisinde'] = this.siteIcerisinde;
    data['SiteAdi'] = this.siteAdi;
    data['Aidat'] = this.aidat;
    data['KrediyeUygun'] = this.krediyeUygun;
    data['GoruntuluAramaIleGezilebilir'] = this.goruntuluAramaIleGezilebilir;
    data['Fiyat'] = this.fiyat;
    data['Enlem'] = this.enlem;
    data['Boylam'] = this.boylam;
    data['Fotograflar'] = this.fotograflar;
    data['Cepheler'] = this.cephe;
    data['IcOzellikler'] = this.icOzellikler;
    data['DisOzellikler'] = this.disOzellikler;
    data['Muhit'] = this.muhit;
    data['Ulasim'] = this.ulasim;
    data['Manzara'] = this.manzara;
    data['IsCheck'] = this.isCheck;
    data['KonutTipi'] = this.konutTipi;
    return data;
  }
}
