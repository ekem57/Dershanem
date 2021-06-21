import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dershane/AuthBaseVeli/auth_base_ogretmen.dart';
import 'package:dershane/firebase/firebase_auth_service.dart';
import 'package:dershane/firebase/firebase_database.dart';
import 'package:dershane/locator.dart';
import 'package:dershane/model/konusma.dart';
import 'package:dershane/model/mesaj.dart';
import 'package:dershane/model/ogretmenModel.dart';
import 'package:timeago/timeago.dart' as timeago;


enum AppMode { DEBUG, RELEASE }

class OgretmenRepo implements AuthBaseOgretmen {
  FirebaseAuthService _firebaseAuthService = locator<FirebaseAuthService>();

  FirestoreDBService _firestoreDBService = locator<FirestoreDBService>();

  List<Ogretmen> tumKullaniciListesi = [];

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
  Future<Ogretmen> currentUser() async {

    Ogretmen _user = await _firebaseAuthService.currentUserOgretmen();
    if (_user != null)
     // return await _firestoreDBService.readOgretmen(_user.userId,_user.email);

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



  //Mesajlaşma kısmı başlıyor

  Stream<List<Mesaj>> getMessages(
      String currentUserID, String sohbetEdilenUserID) {
    if (appMode == AppMode.DEBUG) {
      return Stream.empty();
    } else {
      return _firestoreDBService.getMessages(currentUserID, sohbetEdilenUserID);
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

  Future<bool> saveMessage(Mesaj kaydedilecekMesaj, Ogretmen currentUser) async {
    if (appMode == AppMode.DEBUG) {
      return true;
    } else {
      var dbYazmaIslemi = await _firestoreDBService.saveMessage(kaydedilecekMesaj,currentUser.userId);


      return true;
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


  Future<List<Ogretmen>> getUserwithPagination(Ogretmen enSonGetirilenUser, int getirilecekElemanSayisi) async {
    if (appMode == AppMode.DEBUG) {
      return [];
    } else {
      List<Ogretmen> _userList = await _firestoreDBService.getUserwithPagination(enSonGetirilenUser, getirilecekElemanSayisi);
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


  Ogretmen listedeUserBul(String userID) {
    for (int i = 0; i < tumKullaniciListesi.length; i++) {
      if (tumKullaniciListesi[i].userId == userID) {
        return tumKullaniciListesi[i];
      }
    }

    return null;
  }


}
