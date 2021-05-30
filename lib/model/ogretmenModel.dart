import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';

class Ogretmen extends ChangeNotifier {
  String userId;
  String telefon;
  String email;
  String password;
  String adsoyad;
  String brans;
  String cinsiyet;
  DateTime dogumTarihi;
  String avatarImageUrl;
  bool hesaponay;



  Ogretmen({
    this.userId,
    this.telefon,
    this.email,
    this.password,
    this.adsoyad,
    this.brans,
    this.cinsiyet,
    this.dogumTarihi,
    this.avatarImageUrl,
    this.hesaponay,
  });

  Map<String, dynamic> toMap() {
    return {
      'userId': userId,
      'telefon': telefon ?? '00000000000',
      'email': email,
      'adSoyad': adsoyad,
      'brans':brans,
      'cinsiyet':cinsiyet,
      'dogumTarihi':dogumTarihi,
      'avatarImageUrl':avatarImageUrl,
      'hesapOnay':hesaponay,
    };
  }

  Ogretmen.fromMap(Map<String, dynamic> map)
      : userId = map['userId'],
        telefon = map['telefon'],
        email = map['email'],
        adsoyad = map['adSoyad'],
        brans = map['brans'],
        cinsiyet = map['cinsiyet'],
        hesaponay = map['hesapOnay'],
        dogumTarihi = (map['dogumTarihi'] as Timestamp).toDate(),
        avatarImageUrl = map['avatarImageUrl'];






  @override
  String toString() {
    return 'Yonetici{Yonetici: $userId, email: $email, userName: $adsoyad, profilURL: $avatarImageUrl, createdAt: $dogumTarihi,  telefon: $telefon}';
  }


}
