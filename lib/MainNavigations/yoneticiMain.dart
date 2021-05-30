import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:dershane/extensions/renkler.dart';
import 'package:dershane/extensions/size_config.dart';
import 'package:dershane/kullanicilar.dart';
import 'package:dershane/model/yoneticiModel.dart';
import 'package:dershane/ogrenciSayfalari/ogrAnasayfa.dart';
import 'package:dershane/onaylanmamisKullanicilar/yoneticiOnaylanmadi.dart';
import 'package:dershane/sohbet/ogretmenlerSohbet.dart';
import 'package:dershane/user_state/yonetici_model_service.dart';
import 'package:dershane/yoneticiSayfalari/YoneticiEtkinlikDuyuru.dart';
import 'package:dershane/yoneticiSayfalari/ogrenciKayitOnayla.dart';
import 'package:dershane/yoneticiSayfalari/ogrenci_ders_programi_gir.dart';
import 'package:dershane/yoneticiSayfalari/ogretmenHesapOnayla.dart';
import 'package:dershane/yoneticiSayfalari/ogretmen_ders_programi_ayarla.dart';
import 'package:dershane/yoneticiSayfalari/sikayet_tavsiye.dart';
import 'package:dershane/yoneticiSayfalari/sinavNotlari.dart';
import 'package:dershane/yoneticiSayfalari/sinifAc.dart';
import 'package:dershane/yoneticiSayfalari/sinifOlustur.dart';
import 'package:dershane/yoneticiSayfalari/yoneticiAnasayfa.dart';
import 'package:dershane/yoneticiSayfalari/yoneticiKayitOnayla.dart';
import 'package:flutter/material.dart';
import 'dart:collection';
import 'package:provider/provider.dart';
import 'package:dershane/extensions/size_extention.dart';


class YoneticiMainNavigation extends StatefulWidget {
  final Yonetici user;

  YoneticiMainNavigation({Key key, @required this.user,}) : super(key: key);

  @override
  _YoneticiMainNavigationState createState() => _YoneticiMainNavigationState();
}

class _YoneticiMainNavigationState extends State<YoneticiMainNavigation> {
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


    final _yoneticiModel = Provider.of<YoneticiModel>(context, listen: true);

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
          backgroundColor: Renkler.backGroundColor,
          extendBody: true,
          drawer: Drawer(
            child: ListView(children: [
             SizedBox(height: 40.0.h,),
              ListTile(
                onTap: () {
                  Navigator.of(context).pop();
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => YoneticiKayitOnayla(),
                    ),
                  );
                },
                title: Text(
                  "Yonetici Kayıt Onayla",
                  style: Theme.of(context).textTheme.caption.copyWith(fontSize: 15.0.spByWidth),
                ),
                leading: Icon(
                  Icons.person_add,
                  size: 20.0.w,
                  color: Theme.of(context).primaryColor,
                ),
              ),

              ListTile(
                onTap: () {
                  Navigator.of(context).pop();
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => OgretmenKayitOnayla(),
                    ),
                  );
                },
                title: Text(
                  "Öğretmen Kayıt Onayla",
                  style: Theme.of(context).textTheme.caption.copyWith(fontSize: 15.0.spByWidth),
                ),
                leading: Icon(
                  Icons.person_add,
                  size: 20.0.w,
                  color: Theme.of(context).primaryColor,
                ),
              ),

              ListTile(
                onTap: () {
                  Navigator.of(context).pop();
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => OgrenciKayitOnayla(),
                    ),
                  );
                },
                title: Text(
                  "Öğrenci Kayıt Onayla",
                  style: Theme.of(context).textTheme.caption.copyWith(fontSize: 15.0.spByWidth),
                ),
                leading: Icon(
                  Icons.person_add,
                  size: 20.0.w,
                  color: Theme.of(context).primaryColor,
                ),
              ),

              ListTile(
                onTap: () {
                  Navigator.of(context).pop();
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => SinifAc(),
                    ),
                  );
                },
                title: Text(
                  "Yeni Sınıf Aç",
                  style: Theme.of(context).textTheme.caption.copyWith(fontSize: 15.0.spByWidth),
                ),
                leading: Icon(
                  Icons.add,
                  size: 20.0.w,
                  color: Theme.of(context).primaryColor,
                ),
              ),

              ListTile(
                onTap: () {
                  Navigator.of(context).pop();
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => SinavNotlari(),
                    ),
                  );
                },
                title: Text(
                  "Sınav Notlarını Gir",
                  style: Theme.of(context).textTheme.caption.copyWith(fontSize: 15.0.spByWidth),
                ),
                leading: Icon(
                  Icons.add,
                  size: 20.0.w,
                  color: Theme.of(context).primaryColor,
                ),
              ),

              ListTile(
                onTap: () {
                  Navigator.of(context).pop();
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => OgrenciDersProgramiGir(),
                    ),
                  );
                },
                title: Text(
                  "Öğrenci Ders Programı Ayarla",
                  style: Theme.of(context).textTheme.caption.copyWith(fontSize: 15.0.spByWidth),
                ),
                leading: Icon(
                  Icons.assignment_rounded,
                  size: 20.0.w,
                  color: Theme.of(context).primaryColor,
                ),
              ),

              ListTile(
                onTap: () {
                  Navigator.of(context).pop();
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => OgretmenDersProgramiAyarla(),
                    ),
                  );
                },
                title: Text(
                  "Öğretmen Ders Programı Ayarla",
                  style: Theme.of(context).textTheme.caption.copyWith(fontSize: 15.0.spByWidth),
                ),
                leading: Icon(
                  Icons.assignment_rounded,
                  size: 20.0.w,
                  color: Theme.of(context).primaryColor,
                ),
              ),




              ListTile(
                onTap: () {

                  _yoneticiModel.signOut();


                },
                title: Text(
                  "Çıkış",
                  style: Theme.of(context).textTheme.caption.copyWith(fontSize: 15.0.spByWidth),
                ),
                leading: Icon(
                  Icons.logout,
                  size: 20.0.w,
                  color: Theme.of(context).primaryColor,
                ),
              ),

            ]),
          ),
          body:  _yoneticiModel.user.hesaponay ? (_getBody(index)) : YoneticiOnaylanmadi(),
          bottomNavigationBar:  CurvedNavigationBar(
            key: _bottomNavigationKey,
            index: 0,
            height: 75.0,
            items: <Widget>[
              Icon(Icons.home, size: 40, color: Theme.of(context).backgroundColor),
              Icon(Icons.campaign, size: 30, color: Theme.of(context).backgroundColor),
              Icon(Icons.assignment_rounded, size: 30, color: Theme.of(context).backgroundColor),
              Icon(Icons.message, size: 30, color: Theme.of(context).backgroundColor),
              Icon(Icons.school, size: 30, color: Theme.of(context).backgroundColor),
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
        return KullaniciIslemleri();
      case 1:
        return EtkinlikDuyuru();
      case 2:
        return SikayetTavsiyeSayfasi();
      case 3:
        return OgretmenlerSohbet();
      case 4:
        return SinifOlustur();
    }
  }
}
