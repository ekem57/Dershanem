import 'package:dershane/AuthBaseVeli/auth_base_yonetici.dart';
import 'package:dershane/locator.dart';
import 'package:dershane/model/yoneticiModel.dart';
import 'package:dershane/repository/yonetici_repo.dart';
import 'package:flutter/material.dart';


enum YoneticiViewState { Idle, Busy }

class YoneticiModel with ChangeNotifier implements AuthBaseYonetici {
  YoneticiViewState _state = YoneticiViewState.Idle;
  YoneticiRepo _userRepository = locator<YoneticiRepo>();
  Yonetici _user;
  String emailHataMesaji;
  String sifreHataMesaji;

  Yonetici get user => _user;

  YoneticiViewState get state => _state;

  set state(YoneticiViewState value) {
    _state = value;
    notifyListeners();
  }

  YoneticiModel(){
    currentYonetici();
  }



  @override
  Future<bool> signOut() async {
    try {
      state = YoneticiViewState.Busy;
      bool sonuc = await _userRepository.signOut();
      _user = null;
      return sonuc;
    } catch (e) {
      return false;
    } finally {
      state = YoneticiViewState.Idle;
    }
  }

  @override
  Future<Yonetici> currentYonetici() async {
    try {
      state = YoneticiViewState.Busy;
      _user = await _userRepository.currentYonetici();
      if (_user != null)
        return _user;
      else
        return null;
    } catch (e) {
      return null;
    } finally {
      state = YoneticiViewState.Idle;
    }
  }

  @override
  Future<Yonetici> signInWithEmailandPasswordYonetici(String email, String sifre) async {
    try {

      _user = await _userRepository.signInWithEmailandPasswordYonetici(email, sifre);

      return _user;

    } finally {
      state = YoneticiViewState.Idle;
    }
  }




  @override
  Future<Yonetici> createUserWithEmailandPasswordYonetici(String email, String sifre, Yonetici users) async {
    try {
      _user = await _userRepository.createUserWithEmailandPasswordYonetici(email, sifre,users);
      return _user;
    } finally {
      state = YoneticiViewState.Idle;
    }
  }

}
