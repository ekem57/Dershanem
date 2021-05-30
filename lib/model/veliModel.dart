import 'package:flutter/cupertino.dart';

class Veli extends ChangeNotifier {
  String userId;
  String telefon;
  String email;
  String password;
  String adsoyad;
  String ogrencisininIdsi;
  String cinsiyet;
  String danisman;




  Veli({
    this.userId,
    this.telefon,
    this.email,
    this.password,
    this.adsoyad,
    this.ogrencisininIdsi,
    this.cinsiyet,
    this.danisman,
  });

  Map<String, dynamic> toMap() {
    return {
      'userId': userId,
      'telefon': telefon ?? '00000000000',
      'email': email,
      'adSoyad': adsoyad,
      'danisman':danisman,
      'cinsiyet':cinsiyet,
      'ogrencisininIdsi':ogrencisininIdsi,

    };
  }

  Veli.fromMap(Map<String, dynamic> map)
      : userId = map['userId'],
        telefon = map['telefon'],
        email = map['email'],
        adsoyad = map['adSoyad'],
        danisman = map['danisman'],
        ogrencisininIdsi = map['ogrencisininIdsi'],
        cinsiyet = map['cinsiyet'];






  @override
  String toString() {
    return 'Yonetici{Yonetici: $userId, email: $email, userName: $adsoyad, telefon: $telefon}';
  }


}
