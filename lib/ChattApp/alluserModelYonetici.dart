import 'dart:async';
import 'package:dershane/locator.dart';
import 'package:dershane/model/konusma.dart';
import 'package:dershane/model/ogretmenModel.dart';
import 'package:dershane/model/yoneticiModel.dart';
import 'package:dershane/repository/ogretmen_repo.dart';
import 'package:dershane/repository/yonetici_repo.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';


enum AllUserViewStateYonetici { Idle, Loaded, Busy }

class AllUserViewModelYonetici with ChangeNotifier {
  AllUserViewStateYonetici _state = AllUserViewStateYonetici.Idle;
  List<Yonetici> _tumKullanicilar;
  Yonetici _enSonGetirilenUser;
  static final sayfaBasinaGonderiSayisi = 10;
  bool _hasMore = true;
  List<Konusma> tumKonusma;
  List<bool> yenigelenokunmamiskonusmalar=[];
  bool get hasMoreLoading => _hasMore;
  StreamSubscription _streamSubscription;
  YoneticiRepo _userRepository = locator<YoneticiRepo>();
  List<Yonetici> get kullanicilarListesi => _tumKullanicilar;

  List<Konusma> get kullaniciBilgileri => tumKonusma;
  AllUserViewStateYonetici get state => _state;

  set state(AllUserViewStateYonetici value) {
    _state = value;
    notifyListeners();
  }

  AllUserViewModelYonetici() {
    _tumKullanicilar = [];
    tumKonusma=[];
    _enSonGetirilenUser = null;
    getUserWithPagination(_enSonGetirilenUser, false,FirebaseAuth.instance.currentUser.uid);
  }


  @override
  dispose() {
    _streamSubscription.cancel();
    super.dispose();
  }

  //refresh ve sayfalama için
  //yenielemanlar getir true yapılır
  //ilk açılıs için yenielemanlar için false deger verilir.
  getUserWithPagination(Yonetici enSonGetirilenUser, bool yeniElemanlarGetiriliyor,String userid) async {
    if (_tumKullanicilar.length > 0) {
      _enSonGetirilenUser = _tumKullanicilar.last;
    }

    if (yeniElemanlarGetiriliyor) {
    } else {
      state = AllUserViewStateYonetici.Busy;
    }

    var yeniListe = await _userRepository.getUserwithPagination(_enSonGetirilenUser, sayfaBasinaGonderiSayisi);

    if (yeniListe.length < sayfaBasinaGonderiSayisi) {
      _hasMore = false;
    }


    _tumKullanicilar.addAll(yeniListe);


    _streamSubscription = _userRepository.getAllConversations(userid)
        .listen((anlikData) async {

      tumKonusma.clear();
      yenigelenokunmamiskonusmalar.clear();

      tumKonusma.addAll(anlikData);

      if(_tumKullanicilar.isNotEmpty) {
        if (tumKonusma[0].kimle_konusuyor != _tumKullanicilar[0].userId) {
          refresh();
        }
      }


      state = AllUserViewStateYonetici.Loaded;

    });

    state = AllUserViewStateYonetici.Loaded;
  }

  Future<void> dahaFazlaUserGetir() async {
    // print("Daha fazla user getir tetiklendi - viewmodeldeyiz -");
    if (_hasMore) getUserWithPagination(_enSonGetirilenUser, true,FirebaseAuth.instance.currentUser.uid);
    //else
    //print("Daha fazla eleman yok o yüzden çagrılmayacak");
    await Future.delayed(Duration(seconds: 2));
  }

  Future<Null> refresh() async {
    _hasMore = true;
    _enSonGetirilenUser = null;
    _tumKullanicilar = [];
    getUserWithPagination(_enSonGetirilenUser, true,FirebaseAuth.instance.currentUser.uid);
  }
}