import 'package:dershane/AuthBaseVeli/auth_base_ogretmen.dart';
import 'package:dershane/locator.dart';
import 'package:dershane/model/ogretmenModel.dart';
import 'package:dershane/repository/ogretmen_repo.dart';
import 'package:flutter/material.dart';


enum OgretmenViewState { Idle, Busy }

class OgretmenModel with ChangeNotifier implements AuthBaseOgretmen {
  OgretmenViewState _state = OgretmenViewState.Idle;
  OgretmenRepo _userRepository = locator<OgretmenRepo>();
  Ogretmen _user;
  String emailHataMesaji;
  String sifreHataMesaji;

  Ogretmen get user => _user;

  OgretmenViewState get state => _state;

  set state(OgretmenViewState value) {
    _state = value;
    notifyListeners();
  }

  OgretmenModel() {
    currentOgretmen();
  }

  @override
  Future<Ogretmen> currentOgretmen() async {
    try {
      state = OgretmenViewState.Busy;
      _user = await _userRepository.currentOgretmen();
      if (_user != null)
        return _user;
      else
        return null;
    } catch (e) {
      return null;
    } finally {
      state = OgretmenViewState.Idle;
    }
  }


  @override
  Future<Ogretmen> signInWithEmailandPasswordOgretmen(String email, String sifre) async {
    try {

      _user = await _userRepository.signInWithEmailandPasswordOgretmen(email, sifre);
      return _user;

    } finally {
      state = OgretmenViewState.Idle;
    }
  }



  @override
  Future<bool> signOut() async {
    try {
      state = OgretmenViewState.Busy;
      bool sonuc = await _userRepository.signOut();
      _user = null;
      return sonuc;
    } catch (e) {
      return false;
    } finally {
      state = OgretmenViewState.Idle;
    }
  }



  @override
  Future<Ogretmen> createUserWithEmailandPasswordOgretmen(String email, String sifre, Ogretmen users) async {
    try {
      _user = await _userRepository.createUserWithEmailandPasswordOgretmen(email, sifre,users);
      print("ogretmen service gelen user:"+_user.toString());
      return _user;
    } finally {
      state = OgretmenViewState.Idle;
    }
  }






}
