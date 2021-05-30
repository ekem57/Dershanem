import 'package:dershane/AuthBaseVeli/auth_base_veli.dart';
import 'package:dershane/AuthBaseVeli/auth_base_yonetici.dart';
import 'package:dershane/firebase/firebase_auth_service.dart';
import 'package:dershane/firebase/firebase_database.dart';
import 'package:dershane/locator.dart';
import 'package:dershane/model/ogrenci.dart';
import 'package:dershane/model/veliModel.dart';
import 'package:dershane/model/yoneticiModel.dart';
import 'package:firebase_auth/firebase_auth.dart';


enum AppMode { DEBUG, RELEASE }

class YoneticiRepo implements AuthBaseYonetici {
  FirebaseAuthService _firebaseAuthService = locator<FirebaseAuthService>();

  FirestoreDBService _firestoreDBService = locator<FirestoreDBService>();


  AppMode appMode = AppMode.RELEASE;
  @override
  Future<Yonetici> currentYonetici() async {

    Yonetici _user = (await _firebaseAuthService.currentUserYonetici());
    if (_user != null)
      return await _firestoreDBService.readYonetici(_user.userId,_user.email);
    else
      return null;

  }

  @override
  Future<bool> signOut() async {

    return await _firebaseAuthService.signOut();

  }




  @override
  Future<Yonetici> signInWithEmailandPasswordYonetici(String email, String sifre) async {

    Yonetici _user =
    await _firebaseAuthService.signInWithEmailandPasswordYonetici(email, sifre);

    return await _firestoreDBService.readYonetici(_user.userId,email);

  }

  @override
  Future<Yonetici> createUserWithEmailandPasswordYonetici(String email, String sifre, Yonetici users) async {
    Yonetici _user = await _firebaseAuthService.createUserWithEmailandPasswordYonetici(email, sifre,users);
    bool _sonuc = await _firestoreDBService.saveYonetici(Yonetici(userId: _user.userId,telefon: users.telefon,email: email,adsoyad:users.adsoyad,hesaponay: false));
    if (_sonuc) {
      return await _firestoreDBService.readYonetici(_user.userId,email);
    }
  }








}
