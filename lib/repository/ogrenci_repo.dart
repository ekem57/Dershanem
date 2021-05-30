import 'package:dershane/AuthBaseVeli/auth_base_ogrenci.dart';
import 'package:dershane/firebase/firebase_auth_service.dart';
import 'package:dershane/firebase/firebase_database.dart';
import 'package:dershane/locator.dart';
import 'package:dershane/model/ogrenci.dart';


enum AppMode { DEBUG, RELEASE }

class OgrenciRepo implements AuthBaseOgrenci {
  FirebaseAuthService _firebaseAuthService = locator<FirebaseAuthService>();

  FirestoreDBService _firestoreDBService = locator<FirestoreDBService>();


  AppMode appMode = AppMode.RELEASE;
  @override
  Future<Ogrenci> currentOgrenci() async {

    Ogrenci _user = await _firebaseAuthService.currentUserOgrenci();
    if (_user != null)
      return await _firestoreDBService.readOgrenci(_user.userId,_user.email);
    else
      return null;

  }

  @override
  Future<bool> signOut() async {

    return await _firebaseAuthService.signOut();

  }



  @override
  Future<Ogrenci> createUserWithEmailandPasswordOgrenci(String email, String sifre,Ogrenci users) async {
    Ogrenci _user = await _firebaseAuthService.createUserWithEmailandPasswordOgrenci(email, sifre);
    bool _sonuc = await _firestoreDBService.saveOgrenci(Ogrenci(userId: _user.userId,telefon: users.telefon,email: email,adsoyad:users.adsoyad,bolum: users.bolum,cinsiyet: users.cinsiyet,dogumTarihi: users.dogumTarihi,avatarImageUrl: users.avatarImageUrl,sinif: users.sinif,ogrenciNo: null,okul: users.okul ));
    if (_sonuc) {
      return await _firestoreDBService.readOgrenci(_user.userId,email);
    }
  }

  @override
  Future<Ogrenci> signInWithEmailandPasswordOgrenci(String email, String sifre) async {

    Ogrenci _user =
    await _firebaseAuthService.signInWithEmailandPasswordOgrenci(email, sifre);

    return await _firestoreDBService.readOgrenci(_user.userId,email);

  }







}
