import 'dart:math';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';

class Yonetici extends ChangeNotifier {
  String userId;
  String telefon;
  String email;
  String password;
  String adsoyad;
  bool hesaponay;




  Yonetici({
    this.userId,
    this.telefon,
    this.email,
    this.password,
    this.adsoyad,
    this.hesaponay,

  });

  Map<String, dynamic> toMap() {
    return {
      'userId': userId,
      'telefon': telefon ?? '00000000000',
      'email': email,
      'adSoyad': adsoyad,
      'hesapOnay': hesaponay,

    };
  }

  Yonetici.fromMap(Map<String, dynamic> map)
      : userId = map['userId'],
        telefon = map['telefon'],
        email = map['email'],
        hesaponay = map['hesapOnay'],
        adsoyad = map['adSoyad'];







  @override
  String toString() {
    return 'Yonetici{Yonetici: $userId, email: $email, userName: $adsoyad, telefon: $telefon}';
  }

  String randomSayiUret() {
    int rastgeleSayi = Random().nextInt(999999);
    return rastgeleSayi.toString();
  }
}
