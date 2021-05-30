import 'package:dershane/AuthBaseVeli/auth_base_veli.dart';
import 'package:dershane/locator.dart';
import 'package:dershane/model/veliModel.dart';
import 'package:dershane/repository/veli_repo.dart';
import 'package:flutter/material.dart';


enum VeliViewState { Idle, Busy }

class VeliModel with ChangeNotifier implements AuthBaseVeli {
  VeliViewState _state = VeliViewState.Idle;
  VeliRepo _userRepository = locator<VeliRepo>();
  Veli _user;
  String emailHataMesaji;
  String sifreHataMesaji;

  Veli get user => _user;

  VeliViewState get state => _state;

  set state(VeliViewState value) {
    _state = value;
    notifyListeners();
  }

  VeliModel() {
    currentVeli();
  }



  @override
  Future<bool> signOut() async {
    try {
      state = VeliViewState.Busy;
      bool sonuc = await _userRepository.signOut();
      _user = null;
      return sonuc;
    } catch (e) {
      return false;
    } finally {
      state = VeliViewState.Idle;
    }
  }

  @override
  Future<Veli> currentVeli() async {
    try {
      state = VeliViewState.Busy;
      _user = await _userRepository.currentVeli();
      if (_user != null)
        return _user;
      else
        return null;
    } catch (e) {
      return null;
    } finally {
      state = VeliViewState.Idle;
    }
  }

  @override
  Future<Veli> signInWithEmailandPasswordVeli(String email, String sifre) async {
    try {

      _user = await _userRepository.signInWithEmailandPasswordVeli(email, sifre);
      return _user;

    } finally {
      state = VeliViewState.Idle;
    }
  }

  @override
  Future<Veli> createUserWithEmailandPasswordVeli(String email, String sifre, Veli users) async {
    try {
      _user = await _userRepository.createUserWithEmailandPasswordVeli(email, sifre,users);
      return _user;
    } finally {
      state = VeliViewState.Idle;
    }
  }



}
