import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:dershane/VeliSayfalari/veliAnasayfa.dart';
import 'package:dershane/VeliSayfalari/veliDanismanBilgileri.dart';
import 'package:dershane/VeliSayfalari/veliogrencisininbilgileri.dart';
import 'package:dershane/extensions/size_config.dart';
import 'package:dershane/model/ogrenci.dart';
import 'package:dershane/model/veliModel.dart';
import 'package:dershane/ogrenciSayfalari/ogrAnasayfa.dart';
import 'package:dershane/user_state/ogrenci_model_service.dart';
import 'package:dershane/user_state/veli_model_service.dart';
import 'package:flutter/material.dart';
import 'dart:collection';
import 'package:provider/provider.dart';
import 'package:dershane/extensions/size_extention.dart';


class VeliMainNavigation extends StatefulWidget {
  final Veli user;

  VeliMainNavigation({Key key, @required this.user,}) : super(key: key);

  @override
  _VeliMainNavigationState createState() => _VeliMainNavigationState();
}

class _VeliMainNavigationState extends State<VeliMainNavigation> {
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
    Future.delayed(Duration(milliseconds: 1000)).then((value) {
      if (mounted) {
        setState(() {

        });
      }

    });

    final _veliModel = Provider.of<VeliModel>(context, listen: true);

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
          drawer: Drawer(
            child: ListView(children: [
              DrawerHeader(

                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [

                    Text(widget.user.adsoyad,
                        style: TextStyle(
                            color: const Color(0xffffffff),
                            fontWeight: FontWeight.w700,
                            fontFamily: "OpenSans",
                            fontStyle: FontStyle.normal,
                            fontSize: 15.7.h),
                        textAlign: TextAlign.center),

                  ],
                ),
              ),
              ListTile(
                onTap: () {
                  Navigator.of(context).pop();
                  setState(() {
                    index = 4;
                    _navigationQueue.addLast(index);
                    CurvedNavigationBarState d = _bottomNavigationKey.currentState;
                    d.setPage(index);
                  });
                },
                title: Text(
                  "Profil",
                  style: Theme.of(context).textTheme.caption.copyWith(fontSize: 15.0.spByWidth),
                ),
                leading: Icon(
                  Icons.person,
                  size: 20.0.w,
                  color: Theme.of(context).primaryColor,
                ),
              ),
              ListTile(
                onTap: () {
                  Navigator.of(context).pop();
                  setState(() {
                    index = 3;
                    _navigationQueue.addLast(index);
                    CurvedNavigationBarState d = _bottomNavigationKey.currentState;
                    d.setPage(index);
                  });
                },
                title: Text(
                  "Mesajlar",
                  style: Theme.of(context).textTheme.caption.copyWith(fontSize: 15.0.spByWidth),
                ),
                leading: Icon(
                  Icons.message,
                  size: 20.0.w,
                  color: Theme.of(context).primaryColor,
                ),
              ),
              ListTile(
                onTap: () {
                  Navigator.of(context).pop();
                  setState(() {
                    index = 1;
                    _navigationQueue.addLast(index);
                    CurvedNavigationBarState d = _bottomNavigationKey.currentState;
                    d.setPage(index);
                  });
                },
                title: Text(
                  "Etkinliklerim",
                  style: Theme.of(context).textTheme.caption.copyWith(fontSize: 15.0.spByWidth),
                ),
                leading: Icon(
                  Icons.date_range,
                  size: 20.0.w,
                  color: Theme.of(context).primaryColor,
                ),
              ),



              ListTile(
                onTap: () {

                  _veliModel.signOut();


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
          body:  (_getBody(index)),
          bottomNavigationBar:  CurvedNavigationBar(
            key: _bottomNavigationKey,
            index: 0,
            height: 75.0,
            items: <Widget>[
              Icon(Icons.home, size: 40, color: Theme.of(context).backgroundColor),
              Icon(Icons.date_range, size: 30, color: Theme.of(context).backgroundColor),
              Icon(Icons.add, size: 30, color: Theme.of(context).backgroundColor),

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
        return VeliAnasayfa();
      case 1:
        return VeliOgrenciDetaySayfasi();
      case 2:
        return VeliDanismanBilgileri();

    }
  }
}
