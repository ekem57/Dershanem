

import 'package:dershane/model/ogrenci.dart';
import 'package:dershane/model/ogretmenModel.dart';
import 'package:dershane/model/veliModel.dart';
import 'package:dershane/model/yoneticiModel.dart';

abstract class AuthBase {
  Future<Ogrenci> currentUserOgrenci();
  Future<Ogretmen> currentUserOgretmen();
  Future<Veli> currentUserVeli();
  Future<Yonetici> currentUserYonetici();


  Future<Ogretmen> signInWithEmailandPasswordOgretmen(String email, String sifre);
  Future<Ogrenci> signInWithEmailandPasswordOgrenci(String email, String sifre);
  Future<Veli> signInWithEmailandPasswordVeli(String email, String sifre);
  Future<Yonetici> signInWithEmailandPasswordYonetici(String email, String sifre);

  Future<bool> signOut();
}


