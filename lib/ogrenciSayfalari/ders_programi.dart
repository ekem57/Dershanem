import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dershane/common/dersProgramiCard.dart';
import 'package:dershane/common/duyuruSayfasi.dart';
import 'package:dershane/common/loadingscreen.dart';
import 'package:dershane/common/myButton.dart';
import 'package:dershane/common/resimsizCard.dart';
import 'package:dershane/extensions/renkler.dart';
import 'package:dershane/firebase/firebase_database.dart';
import 'package:dershane/locator.dart';
import 'package:flutter/material.dart';
import 'package:dershane/extensions/size_extention.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';


class DersProgrami extends StatefulWidget {
  final DocumentSnapshot card;

  DersProgrami({ @required this.card});
  @override
  _DersProgramiState createState() => _DersProgramiState();
}

class _DersProgramiState extends State<DersProgrami> with SingleTickerProviderStateMixin {


  FirestoreDBService _firebaseIslemleri = locator<FirestoreDBService>();

  final sinifController = TextEditingController();


  PageController _controller = PageController(initialPage: 0);

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor:  Renkler.appbarGroundColor,
      appBar: AppBar(
        title: Text("Ders Programı"),
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
        child: PageView(
          scrollDirection: Axis.horizontal,
          controller: _controller,
          children: <Widget>[
            pazartesi(),
            sali(),
            carsamba(),
            persembe(),
            cuma(),
            cumartesi(),
            pazar(),
          ],
        ),
      ),
    );
  }

  Widget pazartesi() {
    return ListView(
      children: [
        Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height - 80,
          margin: EdgeInsets.only(top: 12.70),

          child: Column(
            children: [
              Center(
                child: Text("Pazartesi",
                    style: const TextStyle(
                        color: const Color(0xff343633),
                        fontWeight: FontWeight.w700,
                        fontFamily: "OpenSans",
                        fontStyle: FontStyle.italic,
                        fontSize: 25.0),
                    textAlign: TextAlign.center),
              ),

             DersProgramiCard(sinif: "MF-4",saatbaslangic: "09:00",saatbitis: "09:40",ders: "Karekök alma işlemleri",),
             DersProgramiCard(sinif: "MF-4",saatbaslangic: "09:50",saatbitis: "10:30",ders: "İntegral giriş",),
             DersProgramiCard(sinif: "MF-4",saatbaslangic: "12:30",saatbitis: "13:10",ders: "Türev giriş",),


            ],
          ),
        ),
      ],
    );
  }

  Widget sali() {
    return ListView(
      children: [
        Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height - 80,
          margin: EdgeInsets.only(top: 12.70),

          child: Column(
            children: [
              Center(
                child: Text("Salı",
                    style: const TextStyle(
                        color: const Color(0xff343633),
                        fontWeight: FontWeight.w700,
                        fontFamily: "OpenSans",
                        fontStyle: FontStyle.italic,
                        fontSize: 25.0),
                    textAlign: TextAlign.center),
              ),

              DersProgramiCard(sinif: "TM-6",saatbaslangic: "09:00",saatbitis: "09:40",ders: "Karekök alma işlemleri",),
              DersProgramiCard(sinif: "TM-6",saatbaslangic: "09:50",saatbitis: "10:30",ders: "İntegral giriş",),
              DersProgramiCard(sinif: "TM-6",saatbaslangic: "12:30",saatbitis: "13:10",ders: "Türev giriş",),


            ],
          ),
        ),
      ],
    );
  }


  Widget carsamba() {
    return ListView(
      children: [
        Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height - 80,
          margin: EdgeInsets.only(top: 12.70),

          child: Column(
            children: [
              Center(
                child: Text("Çarşamba",
                    style: const TextStyle(
                        color: const Color(0xff343633),
                        fontWeight: FontWeight.w700,
                        fontFamily: "OpenSans",
                        fontStyle: FontStyle.italic,
                        fontSize: 25.0),
                    textAlign: TextAlign.center),
              ),

              DersProgramiCard(sinif: "MF-4",saatbaslangic: "09:00",saatbitis: "09:40",ders: "Karekök alma işlemleri",),
              DersProgramiCard(sinif: "MF-4",saatbaslangic: "09:50",saatbitis: "10:30",ders: "İntegral giriş",),
              DersProgramiCard(sinif: "MF-4",saatbaslangic: "12:30",saatbitis: "13:10",ders: "Türev giriş",),


            ],
          ),
        ),
      ],
    );
  }


  Widget persembe() {
    return ListView(
      children: [
        Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height - 80,
          margin: EdgeInsets.only(top: 12.70),

          child: Column(
            children: [
              Center(
                child: Text("Perşembe",
                    style: const TextStyle(
                        color: const Color(0xff343633),
                        fontWeight: FontWeight.w700,
                        fontFamily: "OpenSans",
                        fontStyle: FontStyle.italic,
                        fontSize: 25.0),
                    textAlign: TextAlign.center),
              ),

              DersProgramiCard(sinif: "MF-4",saatbaslangic: "09:00",saatbitis: "09:40",ders: "Karekök alma işlemleri",),
              DersProgramiCard(sinif: "MF-4",saatbaslangic: "09:50",saatbitis: "10:30",ders: "İntegral giriş",),
              DersProgramiCard(sinif: "MF-4",saatbaslangic: "12:30",saatbitis: "13:10",ders: "Türev giriş",),


            ],
          ),
        ),
      ],
    );
  }


  Widget cuma() {
    return ListView(
      children: [
        Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height - 80,
          margin: EdgeInsets.only(top: 12.70),

          child: Column(
            children: [
              Center(
                child: Text("Cuma",
                    style: const TextStyle(
                        color: const Color(0xff343633),
                        fontWeight: FontWeight.w700,
                        fontFamily: "OpenSans",
                        fontStyle: FontStyle.italic,
                        fontSize: 25.0),
                    textAlign: TextAlign.center),
              ),

              DersProgramiCard(sinif: "MF-4",saatbaslangic: "09:00",saatbitis: "09:40",ders: "Karekök alma işlemleri",),
              DersProgramiCard(sinif: "MF-4",saatbaslangic: "09:50",saatbitis: "10:30",ders: "İntegral giriş",),
              DersProgramiCard(sinif: "MF-4",saatbaslangic: "12:30",saatbitis: "13:10",ders: "Türev giriş",),


            ],
          ),
        ),
      ],
    );
  }


  Widget cumartesi() {
    return ListView(
      children: [
        Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height - 80,
          margin: EdgeInsets.only(top: 12.70),

          child: Column(
            children: [
              Center(
                child: Text("Cumartesi",
                    style: const TextStyle(
                        color: const Color(0xff343633),
                        fontWeight: FontWeight.w700,
                        fontFamily: "OpenSans",
                        fontStyle: FontStyle.italic,
                        fontSize: 25.0),
                    textAlign: TextAlign.center),
              ),

              DersProgramiCard(sinif: "MF-4",saatbaslangic: "09:00",saatbitis: "09:40",ders: "Karekök alma işlemleri",),
              DersProgramiCard(sinif: "MF-4",saatbaslangic: "09:50",saatbitis: "10:30",ders: "İntegral giriş",),
              DersProgramiCard(sinif: "MF-4",saatbaslangic: "12:30",saatbitis: "13:10",ders: "Türev giriş",),


            ],
          ),
        ),
      ],
    );
  }

  Widget pazar() {
    return ListView(
      children: [
        Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height - 80,
          margin: EdgeInsets.only(top: 12.70),

          child: Column(
            children: [
              Center(
                child: Text("Pazar",
                    style: const TextStyle(
                        color: const Color(0xff343633),
                        fontWeight: FontWeight.w700,
                        fontFamily: "OpenSans",
                        fontStyle: FontStyle.italic,
                        fontSize: 25.0),
                    textAlign: TextAlign.center),
              ),

              DersProgramiCard(sinif: "MF-4",saatbaslangic: "09:00",saatbitis: "09:40",ders: "Karekök alma işlemleri",),
              DersProgramiCard(sinif: "MF-4",saatbaslangic: "09:50",saatbitis: "10:30",ders: "İntegral giriş",),
              DersProgramiCard(sinif: "MF-4",saatbaslangic: "12:30",saatbitis: "13:10",ders: "Türev giriş",),


            ],
          ),
        ),
      ],
    );
  }

}
