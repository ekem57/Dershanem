
import 'package:dershane/model/ogrenci.dart';

abstract class AuthBaseOgrenci {

  Future<Ogrenci> currentOgrenci();

  Future<Ogrenci> signInWithEmailandPasswordOgrenci(String email, String sifre);

  Future<Ogrenci> createUserWithEmailandPasswordOgrenci(String email, String sifre,Ogrenci users);

  Future<bool> signOut();

}