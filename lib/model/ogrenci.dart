import 'dart:math';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';

class Ogrenci extends ChangeNotifier {
  String userId;
  String telefon;
  String email;
  String password;
  String adsoyad;
  String bolum;
  String cinsiyet;
  String danisman;
  DateTime dogumTarihi;
  String avatarImageUrl;
  String sinif;
  String ogrenciNo;
  String okul;
  String dershaneSinif;
  bool hesaponay;


  Ogrenci({
    this.userId,
    this.telefon,
    this.email,
    this.password,
    this.adsoyad,
    this.bolum,
    this.cinsiyet,
    this.dogumTarihi,
    this.avatarImageUrl,
    this.sinif,
    this.ogrenciNo,
    this.okul,
    this.danisman,
    this.hesaponay,
    this.dershaneSinif,
  });

  Map<String, dynamic> toMap() {
    return {
      'userId': userId,
      'telefon': telefon ?? '00000000000',
      'email': email,
      'adSoyad': adsoyad,
      'bolum':bolum,
      'cinsiyet':cinsiyet,
      'dogumTarihi':dogumTarihi,
      'avatarImageUrl':avatarImageUrl,
      'sinif':sinif,
      'ogrenciNo':ogrenciNo,
      'okul':okul,
      'danisman':danisman,
      'hesapOnay':hesaponay ?? false,
      'dershaneSinifi':dershaneSinif ?? "Atanmadı",
    };
  }

  Ogrenci.fromMap(Map<String, dynamic> map)
      : userId = map['userId'],
        telefon = map['telefon'],
        email = map['email'],
        adsoyad = map['adSoyad'],
        bolum = map['bolum'],
        cinsiyet = map['cinsiyet'],
        dogumTarihi = (map['dogumTarihi'] as Timestamp).toDate(),
        avatarImageUrl = map['avatarImageUrl'],
        sinif = map['sinif'],
        okul = map['okul'],
        danisman = map['danisman'],
        hesaponay = map['hesapOnay'],
        dershaneSinif = map['dershaneSinifi'],
        ogrenciNo = map['ogrenciNo'];






  @override
  String toString() {
    return 'User{userID: $userId, email: $email, userName: $adsoyad, profilURL: $avatarImageUrl, createdAt: $dogumTarihi,  telefon: $telefon,okul: $okul,bolum: $bolum}';
  }

  String randomSayiUret() {
    int rastgeleSayi = Random().nextInt(999999);
    return rastgeleSayi.toString();
  }
}
