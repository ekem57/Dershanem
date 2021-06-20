import 'package:dershane/AuthBaseVeli/auth_base_ogretmen.dart';
import 'package:dershane/firebase/firebase_auth_service.dart';
import 'package:dershane/firebase/firebase_database.dart';
import 'package:dershane/locator.dart';
import 'package:dershane/model/ogretmenModel.dart';


enum AppMode { DEBUG, RELEASE }

class OgretmenRepo implements AuthBaseOgretmen {
  FirebaseAuthService _firebaseAuthService = locator<FirebaseAuthService>();

  FirestoreDBService _firestoreDBService = locator<FirestoreDBService>();


  AppMode appMode = AppMode.RELEASE;

  @override
  Future<Ogretmen> currentOgretmen() async {

    Ogretmen _user = await _firebaseAuthService.currentUserOgretmen();
    if (_user != null)
      return await _firestoreDBService.readOgretmen(_user.userId,_user.email);
    else
      return null;

  }

  @override
  Future<bool> signOut() async {

    return await _firebaseAuthService.signOut();

  }



  @override
  Future<Ogretmen> signInWithEmailandPasswordOgretmen(String email, String sifre) async {


    Ogretmen _user = await _firebaseAuthService.signInWithEmailandPasswordOgretmen(email, sifre);

    return await _firestoreDBService.readOgretmen(_user.userId,email);
  }


  @override
  Future<Ogretmen> createUserWithEmailandPasswordOgretmen(String email, String sifre,Ogretmen users) async {
    Ogretmen _user = await _firebaseAuthService.createUserWithEmailandPasswordOgretmen(email, sifre,users);

    bool _sonuc = await _firestoreDBService.saveOgretmen(Ogretmen(userId: _user.userId,telefon: users.telefon,email: email,adsoyad:users.email,cinsiyet: users.cinsiyet,dogumTarihi: users.dogumTarihi,avatarImageUrl: users.avatarImageUrl,brans: users.brans,hesaponay: false ));
    if (_sonuc) {
      return await _firestoreDBService.readOgretmen(_user.userId,email);
    }
  }




}
