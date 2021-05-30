import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:dershane/extensions/size_config.dart';
import 'package:dershane/model/ogrenci.dart';
import 'package:dershane/ogrenciSayfalari/OgrenciTavsiye.dart';
import 'package:dershane/ogrenciSayfalari/ders_programi.dart';
import 'package:dershane/ogrenciSayfalari/ogrAnasayfa.dart';
import 'package:dershane/ogrenciSayfalari/IstekSikayetEt.dart';
import 'package:dershane/ogrenciSayfalari/ogrenciProfil.dart';
import 'package:dershane/ogrenciSayfalari/sinavNotlari.dart';
import 'package:dershane/onaylanmamisKullanicilar/ogrenciOnaylanmadi.dart';
import 'package:dershane/user_state/ogrenci_model_service.dart';
import 'package:flutter/material.dart';
import 'dart:collection';
import 'package:provider/provider.dart';
import 'package:dershane/extensions/size_extention.dart';


class OgrenciMainNavigation extends StatefulWidget {
  final Ogrenci user;

  OgrenciMainNavigation({Key key, @required this.user,}) : super(key: key);

  @override
  _OgrenciMainNavigationState createState() => _OgrenciMainNavigationState();
}

class _OgrenciMainNavigationState extends State<OgrenciMainNavigation> {
  GlobalKey _bottomNavigationKey = GlobalKey();
  ListQueue<int> _navigationQueue = ListQueue();
  int index = 0;
  bool onTapped = true;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    onTapped = true;
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig(context).init();


    final _ogrenciModel = Provider.of<OgrenciModel>(context, listen: true);

    return WillPopScope(
      onWillPop: () async {
        if (_navigationQueue.isEmpty){
          onTapped = true;
          return true;
        }
        setState(() {
          _navigationQueue.removeLast();
          int position = _navigationQueue.isEmpty ? 0 : _navigationQueue.last;
          onTapped = false;
          index = position;
        });
        final CurvedNavigationBarState navBarState = _bottomNavigationKey.currentState;
        navBarState.setPage(index);
        print("index: $index");
        setState(() {
          onTapped = true;
        });
        return false;
      },
      child: Scaffold(
          backgroundColor: Theme.of(context).backgroundColor,
          extendBody: true,
          body: _ogrenciModel.user.hesaponay ? (_getBody(index)) : OgrenciOnaylanmadi(),
          bottomNavigationBar:  CurvedNavigationBar(
            key: _bottomNavigationKey,
            index: 0,
            height: 75.0,
            items: <Widget>[
              Icon(Icons.home, size: 40, color: Theme.of(context).backgroundColor),
              Icon(Icons.date_range, size: 30, color: Theme.of(context).backgroundColor),
              Icon(Icons.info, size: 30, color: Theme.of(context).backgroundColor),
              Icon(Icons.message, size: 30, color: Theme.of(context).backgroundColor),
              Icon(Icons.person, size: 30, color: Theme.of(context).backgroundColor),
            ],
            color: Theme.of(context).primaryColor,
            buttonBackgroundColor: Theme.of(context).primaryColor,
            backgroundColor: Colors.transparent,
            animationCurve: Curves.easeInOut,
            animationDuration: Duration(milliseconds: 300),
            onTap: onTapped ? onNavButtonTapped: changeNavButtonAnimation,
            letIndexChange: (index) => true,
          )),
    );
  }
  @override
  void dispose() {
    print("dispose call");
    super.dispose();
  }


  void onNavButtonTapped(int _index){
    if (index != _index) {
      _navigationQueue.removeWhere((element) => element == _index);
      _navigationQueue.addLast(_index);
      setState(() {
        this.index = _index;
      });
    }
  }
  void changeNavButtonAnimation(int _index){
    setState(() {
      this.index = _index;
    });
  }

  Widget _getBody(int index) {
    switch (index) {
      case 0:
        return OgrenciAnasayfa();
      case 1:
        return DersProgrami();
      case 2:
        return SinavNotlari();
      case 3:
        return OgrenciTavsiye();
      case 4:
        return OgrenciProfil();
    }
  }
}
