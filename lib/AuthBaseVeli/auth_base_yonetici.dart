
import 'package:dershane/model/yoneticiModel.dart';

abstract class AuthBaseYonetici {

  Future<Yonetici> currentYonetici();

  Future<Yonetici> signInWithEmailandPasswordYonetici(String email, String sifre);

  Future<Yonetici> createUserWithEmailandPasswordYonetici(String email, String sifre,Yonetici users);


  Future<bool> signOut();

}