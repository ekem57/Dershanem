import 'dart:async';
import 'package:dershane/locator.dart';
import 'package:dershane/model/mesaj.dart';
import 'package:dershane/model/ogretmenModel.dart';
import 'package:dershane/model/yoneticiModel.dart';
import 'package:dershane/repository/ogretmen_repo.dart';
import 'package:dershane/repository/yonetici_repo.dart';
import 'package:dershane/user_state/ogretmen_model_service.dart';
import 'package:flutter/material.dart';


enum ChatViewStateYonetici { Idle, Loaded, Busy }

class ChatViewModelYonetici with ChangeNotifier {
  List<Mesaj> _tumMesajlar;
  ChatViewStateYonetici _state = ChatViewStateYonetici.Idle;
  static final sayfaBasinaGonderiSayisi = 20;
  OgretmenRepo _userRepository = locator<OgretmenRepo>();
  final Ogretmen currentUser;
  final Yonetici sohbetEdilenUser;
  Mesaj _enSonGetirilenMesaj;
  Mesaj _listeyeEklenenIlkMesaj;
  bool _hasMore = true;
  bool _yeniMesajDinleListener = false;
  List<Mesaj> _tumMesajlarTers;
  bool get hasMoreLoading => _hasMore;

  StreamSubscription _streamSubscription;

  ChatViewModelYonetici({this.currentUser, this.sohbetEdilenUser}) {
    _tumMesajlar = [];
    _tumMesajlarTers=[];
    getMessageWithPagination(false);
  }

  List<Mesaj> get mesajlarListesi => _tumMesajlar;
  List<Mesaj> get mesajlarListesiTers => _tumMesajlarTers;
  ChatViewStateYonetici get state => _state;

  set state(ChatViewStateYonetici value) {
    _state = value;
    notifyListeners();
  }

  @override
  dispose() {
    print("Chatviewmodel dispose edildi");
    _streamSubscription.cancel();
    super.dispose();
  }

  Future<bool> saveMessage(Mesaj kaydedilecekMesaj, Ogretmen currentUser) async {
    return await _userRepository.saveMessage(kaydedilecekMesaj, currentUser);
  }

  void getMessageWithPagination(bool yeniMesajlarGetiriliyor) async {
    if (_tumMesajlar.length > 0) {
      print("tüm mesajlar listesi buyuk 0dır.");
      print("tüm mesajlar son mesaj."+_tumMesajlar.last.mesaj);
      _enSonGetirilenMesaj = _tumMesajlar.last;
    }

    if (!yeniMesajlarGetiriliyor) state = ChatViewStateYonetici.Busy;

    var getirilenMesajlar = await _userRepository.getMessageWithPagination(
        currentUser.userId,
        sohbetEdilenUser.userId,
        _enSonGetirilenMesaj,
        sayfaBasinaGonderiSayisi);

    if (getirilenMesajlar.length < sayfaBasinaGonderiSayisi) {
      _hasMore = false;
    }

    getirilenMesajlar
        .forEach((msj) => print("getirilen mesajlar:" + msj.mesaj));

    _tumMesajlar.addAll(getirilenMesajlar);
    _tumMesajlarTers.addAll(_tumMesajlar.reversed);
    if (_tumMesajlar.length > 0) {
      _listeyeEklenenIlkMesaj = _tumMesajlar.first;
      // print("Listeye eklenen ilk mesaj :" + _listeyeEklenenIlkMesaj.mesaj);
    }

    state = ChatViewStateYonetici.Loaded;

    if (_yeniMesajDinleListener == false) {
      _yeniMesajDinleListener = true;
      //print("Listener yok o yüzden atanacak");
      yeniMesajListenerAta();
    }
  }

  Future<void> dahaFazlaMesajGetir() async {
    //print("Daha fazla mesaj getir tetiklendi - viewmodeldeyiz -");
    if (_hasMore) getMessageWithPagination(true);
    /*else
      print("Daha fazla eleman yok o yüzden çagrılmayacak");*/
    await Future.delayed(Duration(seconds: 2));
  }
  void yeniMesajListenerAta() {
    //print("Yeni mesajlar için listener atandı");
    // _userRepository.mesajguncelle(currentUser.userID, sohbetEdilenUser.userID);
    _streamSubscription = _userRepository.getMessagesDoc(currentUser.userId, sohbetEdilenUser.userId)
        .listen((anlikData) {

      if (anlikData.isNotEmpty) {

        //print("mesaj lsitesinin ilk elemani:" +_tumMesajlar[0].toString());

        Mesaj msj=Mesaj.fromMap(anlikData[0].data());
        if (msj.date != null) {
          if(!msj.bendenMi){
            _userRepository.mesajguncelle(sohbetEdilenUser.userId, currentUser.userId,anlikData[0].id);
          }


          if (_listeyeEklenenIlkMesaj == null) {

            _tumMesajlar.insert(0, msj);
            _tumMesajlarTers.insert(0, msj);
          }
          else  if(_tumMesajlar[0].date.millisecondsSinceEpoch == msj.date.millisecondsSinceEpoch){

            if(_tumMesajlar[0].goruldumu != msj.goruldumu){
              _tumMesajlar[0].goruldumu=msj.goruldumu;

            }
          }
          else if (_listeyeEklenenIlkMesaj.date.millisecondsSinceEpoch != msj.date.millisecondsSinceEpoch) {

            _tumMesajlar.insert(0, msj);
            _tumMesajlarTers.insert(0, msj);
            if(_tumMesajlar[0].date.millisecondsSinceEpoch == msj.date.millisecondsSinceEpoch && _tumMesajlar[0].goruldumu != msj.goruldumu) {
              _tumMesajlar[0].goruldumu=msj.goruldumu;
            }
          }

        }


        state = ChatViewStateYonetici.Loaded;
      }
    });
  }

}
