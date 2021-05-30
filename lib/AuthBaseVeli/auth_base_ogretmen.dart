
import 'package:dershane/model/ogretmenModel.dart';

abstract class AuthBaseOgretmen {

  Future<Ogretmen> currentOgretmen();

  Future<Ogretmen> signInWithEmailandPasswordOgretmen(String email, String sifre);

  Future<Ogretmen> createUserWithEmailandPasswordOgretmen(String email, String sifre,Ogretmen users);


  Future<bool> signOut();

}