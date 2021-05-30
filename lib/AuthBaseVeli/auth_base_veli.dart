import 'package:dershane/model/veliModel.dart';

abstract class AuthBaseVeli {

  Future<Veli> currentVeli();

  Future<Veli> signInWithEmailandPasswordVeli(String email, String sifre);

  Future<Veli> createUserWithEmailandPasswordVeli(String email, String sifre,Veli users);


  Future<bool> signOut();

}