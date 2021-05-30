import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:dershane/extensions/size_config.dart';
import 'package:dershane/model/ogrenci.dart';
import 'package:dershane/model/ogretmenModel.dart';
import 'package:dershane/ogrenciSayfalari/ogrAnasayfa.dart';
import 'package:dershane/ogretmenSayfalari/danismanliklarim.dart';
import 'package:dershane/ogretmenSayfalari/ogrenciTavsiyeVer.dart';
import 'package:dershane/ogretmenSayfalari/ogretmenAnasayfa.dart';
import 'package:dershane/ogretmenSayfalari/ogretmenDersProgrami.dart';
import 'package:dershane/ogretmenSayfalari/ogretmenDuyurularSayfasi.dart';
import 'package:dershane/ogretmenSayfalari/ogretmenProfil.dart';
import 'package:dershane/onaylanmamisKullanicilar/ogretmenOnaylanmadi.dart';
import 'package:dershane/sohbet/ogretmenlerSohbet.dart';
import 'package:dershane/user_state/ogrenci_model_service.dart';
import 'package:dershane/user_state/ogretmen_model_service.dart';
import 'package:flutter/material.dart';
import 'dart:collection';
import 'package:provider/provider.dart';
import 'package:dershane/extensions/size_extention.dart';


class OgretmenMainNavigation extends StatefulWidget {
  final Ogretmen user;

  OgretmenMainNavigation({Key key, @required this.user,}) : super(key: key);

  @override
  _OgretmenMainNavigationState createState() => _OgretmenMainNavigationState();
}

class _OgretmenMainNavigationState extends State<OgretmenMainNavigation> {
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
    final _ogretmenModel = Provider.of<OgretmenModel>(context, listen: false);

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

          body: _ogretmenModel.user.hesaponay ? (_getBody(index)): OgretmenOnaylanmadi(),
          bottomNavigationBar:  CurvedNavigationBar(
            key: _bottomNavigationKey,
            index: 0,
            height: 75.0,
            items: <Widget>[
              Icon(Icons.home, size: 40, color: Theme.of(context).backgroundColor),
              Icon(Icons.date_range, size: 30, color: Theme.of(context).backgroundColor),
              Icon(Icons.school, size: 30, color: Theme.of(context).backgroundColor),
              Icon(Icons.message, size: 30, color: Theme.of(context).backgroundColor),
              Icon(Icons.campaign, size: 30, color: Theme.of(context).backgroundColor),
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
        return DanismanSiniflarim();
      case 1:
        return OgretmenDersProgrami();
      case 2:
        return OgrenciTavsiyeVer();
      case 3:
        return OgretmenlerSohbet();
      case 4:
        return OgretmenDuyurularSayfasi();
      case 5:
        return OgretmenProfil();
    }
  }
}
