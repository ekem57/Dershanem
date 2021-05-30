import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dershane/common/dersProgramiCard.dart';
import 'package:dershane/common/duyuruSayfasi.dart';
import 'package:dershane/common/loadingscreen.dart';
import 'package:dershane/common/myButton.dart';
import 'package:dershane/common/resimsizCard.dart';
import 'package:dershane/common/sinavSonucCard.dart';
import 'package:dershane/extensions/renkler.dart';
import 'package:dershane/firebase/firebase_database.dart';
import 'package:dershane/locator.dart';
import 'package:flutter/material.dart';
import 'package:dershane/extensions/size_extention.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';


class SinavNotlari extends StatefulWidget {
  final DocumentSnapshot card;

  SinavNotlari({ @required this.card});
  @override
  _SinavNotlariState createState() => _SinavNotlariState();
}

class _SinavNotlariState extends State<SinavNotlari> with SingleTickerProviderStateMixin {


  FirestoreDBService _firebaseIslemleri = locator<FirestoreDBService>();

  final sinifController = TextEditingController();


  PageController _controller = PageController(initialPage: 0);

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor:  Renkler.appbarGroundColor,
      appBar: AppBar(
        title: Text("Deneme Sınavlarım"),
        elevation: 0.0,
        brightness: Brightness.dark,
        toolbarHeight: 80.0.h,
        backgroundColor: Renkler.appbarGroundColor,
      ),

      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,

        decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20.70),
              topRight: Radius.circular(20.70)),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
                color: const Color(0x5c000000),
                offset: Offset(0, 0),
                blurRadius: 33.06,
                spreadRadius: 4.94)
          ],
        ),
        child: ListView(
          children: [
            Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height - 80,
              margin: EdgeInsets.only(top: 12.70),

              child: ListView(
                children: [
                 SinavSonucCard(baslik: "TYT 1",),
                 SinavSonucCard(baslik: "TYT 2",),
                 SinavSonucCard(baslik: "AYT 1",),

                ],
              ),
            ),
          ],
        ),
      ),
    );
  }



}
