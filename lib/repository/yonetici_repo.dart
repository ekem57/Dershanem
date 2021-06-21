import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dershane/AuthBaseVeli/auth_base_veli.dart';
import 'package:dershane/AuthBaseVeli/auth_base_yonetici.dart';
import 'package:dershane/firebase/firebase_auth_service.dart';
import 'package:dershane/firebase/firebase_database.dart';
import 'package:dershane/locator.dart';
import 'package:dershane/model/konusma.dart';
import 'package:dershane/model/mesaj.dart';
import 'package:dershane/model/ogrenci.dart';
import 'package:dershane/model/ogretmenModel.dart';
import 'package:dershane/model/veliModel.dart';
import 'package:dershane/model/yoneticiModel.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:timeago/timeago.dart' as timeago;


enum AppMode { DEBUG, RELEASE }

class YoneticiRepo implements AuthBaseYonetici {
  FirebaseAuthService _firebaseAuthService = locator<FirebaseAuthService>();

  FirestoreDBService _firestoreDBService = locator<FirestoreDBService>();

  List<Yonetici> tumKullaniciListesi = [];

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



  Stream<List<Konusma>> getAllConversations(String userID)  {
    if (appMode == AppMode.DEBUG) {
      return Stream.empty();
    } else {


      var konusmaListesi =  _firestoreDBService.getAllConversations(userID);


      return konusmaListesi;
    }
  }


  void timeagoHesapla(Konusma oankiKonusma, Timestamp zaman) {
    oankiKonusma.sonOkunmaZamani = zaman;

    timeago.setLocaleMessages("tr", timeago.TrMessages());

    var _duration = zaman.toDate().difference(oankiKonusma.olusturulma_tarihi.toDate());
    oankiKonusma.aradakiFark = timeago.format(zaman.toDate().subtract(_duration), locale: "tr");
  }


  Future<List<Yonetici>> getUserwithPagination(Yonetici enSonGetirilenUser, int getirilecekElemanSayisi) async {
    if (appMode == AppMode.DEBUG) {
      return [];
    } else {
      List<Yonetici> _userList = await _firestoreDBService.getUserwithPaginationYonetici(enSonGetirilenUser, getirilecekElemanSayisi);
      tumKullaniciListesi.addAll(_userList);
      return _userList;
    }
  }


  Future<List<Mesaj>> getMessageWithPagination(
      String currentUserID,
      String sohbetEdilenUserID,
      Mesaj enSonGetirilenMesaj,
      int getirilecekElemanSayisi) async {
    if (appMode == AppMode.DEBUG) {
      return [];
    } else {
      return await _firestoreDBService.getMessagewithPagination(currentUserID,
          sohbetEdilenUserID, enSonGetirilenMesaj, getirilecekElemanSayisi);
    }
  }


  Future<bool> saveMessage(Mesaj kaydedilecekMesaj, Yonetici currentUser) async {
    if (appMode == AppMode.DEBUG) {
      return true;
    } else {
      var dbYazmaIslemi = await _firestoreDBService.saveMessage(kaydedilecekMesaj,currentUser.userId);


      return true;
    }
  }

  Stream<List<DocumentSnapshot>> getMessagesDoc(
      String currentUserID, String sohbetEdilenUserID) {
    if (appMode == AppMode.DEBUG) {
      return Stream.empty();
    } else {
      return _firestoreDBService.getMessagesDoc(currentUserID, sohbetEdilenUserID);
    }
  }

  Future<bool> mesajguncelle(String currentUserID, String sohbetEdilenUserID,String Docid) async {
    if (appMode == AppMode.DEBUG) {
      return true;
    } else {
      var dbGuncellemeIslemi = await _firestoreDBService.mesajguncelle(currentUserID, sohbetEdilenUserID,Docid);
      return dbGuncellemeIslemi;
    }
  }




}
