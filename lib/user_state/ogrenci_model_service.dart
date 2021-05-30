import 'package:dershane/AuthBaseVeli/auth_base_ogrenci.dart';
import 'package:dershane/locator.dart';
import 'package:dershane/model/ogrenci.dart';
import 'package:dershane/repository/ogrenci_repo.dart';
import 'package:flutter/material.dart';


enum OgrenciViewState { Idle, Busy }

class OgrenciModel with ChangeNotifier implements AuthBaseOgrenci {
  OgrenciViewState _state = OgrenciViewState.Idle;
  OgrenciRepo _userRepository = locator<OgrenciRepo>();
  Ogrenci _user;
  String emailHataMesaji;
  String sifreHataMesaji;

  Ogrenci get user => _user;

  OgrenciViewState get state => _state;

  set state(OgrenciViewState value) {
    _state = value;
    notifyListeners();
  }

  OgrenciModel() {
    currentOgrenci();
  }



  @override
  Future<bool> signOut() async {
    try {
      state = OgrenciViewState.Busy;
      bool sonuc = await _userRepository.signOut();
      _user = null;
      return sonuc;
    } catch (e) {
      return false;
    } finally {
      state = OgrenciViewState.Idle;
    }
  }

  @override
  Future<Ogrenci> createUserWithEmailandPasswordOgrenci(String email, String sifre, Ogrenci users) async {
    try {
      _user = await _userRepository.createUserWithEmailandPasswordOgrenci(email, sifre,users);
      return _user;
    } finally {
      state = OgrenciViewState.Idle;
    }
  }

  @override
  Future<Ogrenci> currentOgrenci() async {
    try {
      state = OgrenciViewState.Busy;
      _user = await _userRepository.currentOgrenci();
      if (_user != null)
        return _user;
      else
        return null;
    } catch (e) {
      return null;
    } finally {
      state = OgrenciViewState.Idle;
    }
  }

  @override
  Future<Ogrenci> signInWithEmailandPasswordOgrenci(String email, String sifre) async {
    try {

      _user = await _userRepository.signInWithEmailandPasswordOgrenci(email, sifre);
      return _user;

    } finally {
      state = OgrenciViewState.Idle;
    }
  }









}
