import 'package:dershane/firebase/auth_base.dart';
import 'package:dershane/model/ogrenci.dart';
import 'package:dershane/model/ogretmenModel.dart';
import 'package:dershane/model/veliModel.dart';
import 'package:dershane/model/yoneticiModel.dart';
import 'package:firebase_auth/firebase_auth.dart';


class FirebaseAuthService implements AuthBase {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  @override
  Future<bool> signOut() async {
    try {

      await _firebaseAuth.signOut();
      return true;
    } catch (e) {
      print("sign out hata:" + e.toString());
      return false;
    }
  }


  @override
  Future<Ogrenci> currentUserOgrenci() async {
    try {
      User user = await _firebaseAuth.currentUser;
      return _userFromFirebaseOgrenci(user);
    } catch (e) {
      print("HATA CURRENT USER" + e.toString());
      return null;
    }
  }

  Ogrenci _userFromFirebaseOgrenci(User user) {
    if (user == null) {
      return null;
    } else {
      return Ogrenci(userId: user.uid, email: user.email);
    }
  }


  @override
  Future<Ogrenci> createUserWithEmailandPasswordOgrenci(String email, String sifre) async {
    UserCredential sonuc = await _firebaseAuth.createUserWithEmailAndPassword(email: email, password: sifre);
    return _userFromFirebaseOgrenci(sonuc.user);
  }

  @override
  Future<Ogrenci> signInWithEmailandPasswordOgrenci(String email, String sifre) async {
    print("sign girdi");
    UserCredential sonuc = await _firebaseAuth.signInWithEmailAndPassword(email: email, password: sifre);
    print("giris yapıldı");
    return _userFromFirebaseOgrenci(sonuc.user);
  }






  @override
  Future<Ogretmen> currentUserOgretmen() async {
    try {
      User user = await _firebaseAuth.currentUser;
      return _userFromFirebaseOgretmen(user);
    } catch (e) {
      print("HATA CURRENT USER" + e.toString());
      return null;
    }
  }

  Ogretmen _userFromFirebaseOgretmen(User user) {
    if (user == null) {
      return null;
    } else {
      return Ogretmen(userId: user.uid, email: user.email);
    }
  }


  @override
  Future<Ogretmen> createUserWithEmailandPasswordOgretmen(String email, String sifre,Ogretmen users) async {
    UserCredential sonuc = await _firebaseAuth.createUserWithEmailAndPassword(email: email, password: sifre);
    return _userFromFirebaseOgretmen(sonuc.user);
  }

  @override
  Future<Ogretmen> signInWithEmailandPasswordOgretmen(String email, String sifre) async {
    UserCredential sonuc = await _firebaseAuth.signInWithEmailAndPassword(email: email, password: sifre);
    print("giris yapıldı");
    return _userFromFirebaseOgretmen(sonuc.user);
  }






  @override
  Future<Veli> currentUserVeli() async {
    try {
      User user = await _firebaseAuth.currentUser;
      return _userFromFirebaseVeli(user);
    } catch (e) {
      print("HATA CURRENT USER" + e.toString());
      return null;
    }
  }

  Veli _userFromFirebaseVeli(User user) {
    if (user == null) {
      return null;
    } else {
      return Veli(userId: user.uid, email: user.email);
    }
  }


  @override
  Future<Veli> createUserWithEmailandPasswordVeli(String email, String sifre,Veli users) async {
    UserCredential sonuc = await _firebaseAuth.createUserWithEmailAndPassword(email: email, password: sifre);
    return _userFromFirebaseVeli(sonuc.user);
  }

  @override
  Future<Veli> signInWithEmailandPasswordVeli(String email, String sifre) async {
    UserCredential sonuc = await _firebaseAuth.signInWithEmailAndPassword(email: email, password: sifre);
    return _userFromFirebaseVeli(sonuc.user);
  }







  @override
  Future<Yonetici> currentUserYonetici() async {
    try {
      User user = await _firebaseAuth.currentUser;
      return _userFromFirebaseYonetici(user);
    } catch (e) {
      print("HATA CURRENT USER" + e.toString());
      return null;
    }
  }

  Yonetici _userFromFirebaseYonetici(User user) {
    if (user == null) {
      return null;
    } else {
      return Yonetici(userId: user.uid, email: user.email);
    }
  }


  @override
  Future<Yonetici> createUserWithEmailandPasswordYonetici(String email, String sifre,Yonetici users) async {
    UserCredential sonuc = await _firebaseAuth.createUserWithEmailAndPassword(email: email, password: sifre);
    return _userFromFirebaseYonetici(sonuc.user);
  }

  @override
  Future<Yonetici> signInWithEmailandPasswordYonetici(String email, String sifre) async {
    UserCredential sonuc = await _firebaseAuth.signInWithEmailAndPassword(email: email, password: sifre);
    return _userFromFirebaseYonetici(sonuc.user);
  }



}
