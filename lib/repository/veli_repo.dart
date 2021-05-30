import 'package:dershane/AuthBaseVeli/auth_base_veli.dart';
import 'package:dershane/firebase/firebase_auth_service.dart';
import 'package:dershane/firebase/firebase_database.dart';
import 'package:dershane/locator.dart';
import 'package:dershane/model/ogrenci.dart';
import 'package:dershane/model/veliModel.dart';
import 'package:firebase_auth/firebase_auth.dart';


enum AppMode { DEBUG, RELEASE }

class VeliRepo implements AuthBaseVeli {
  FirebaseAuthService _firebaseAuthService = locator<FirebaseAuthService>();

  FirestoreDBService _firestoreDBService = locator<FirestoreDBService>();


  AppMode appMode = AppMode.RELEASE;
  @override
  Future<Veli> currentVeli() async {

    Veli _user = (await _firebaseAuthService.currentUserVeli());
    if (_user != null)
      return await _firestoreDBService.readVeli(_user.userId,_user.email);
    else
      return null;

  }

  @override
  Future<bool> signOut() async {

    return await _firebaseAuthService.signOut();

  }



  @override
  Future<Veli> createUserWithEmailandPasswordVeli(String email, String sifre,Veli users) async {

    Veli _veli = await _firebaseAuthService.createUserWithEmailandPasswordVeli(email, sifre,users);

    bool _sonuc = await _firestoreDBService.saveVeli(Veli(userId: _veli.userId,telefon: users.telefon,email: users.email,adsoyad:users.adsoyad,danisman: null,cinsiyet: users.cinsiyet,ogrencisininIdsi: users.ogrencisininIdsi));
    if (_sonuc) {
      return await _firestoreDBService.readVeli(_veli.userId,email);
    }
  }

  @override
  Future<Veli> signInWithEmailandPasswordVeli(String email, String sifre) async {

    Veli _user =
    await _firebaseAuthService.signInWithEmailandPasswordVeli(email, sifre);

    return await _firestoreDBService.readVeli(_user.userId,email);

  }







}
