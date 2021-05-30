import 'package:dershane/common/myButton.dart';
import 'package:dershane/extensions/renkler.dart';
import 'package:dershane/extensions/size_config.dart';
import 'package:dershane/loginSayfalari/ogrenciGiris.dart';
import 'package:dershane/loginSayfalari/ogretmenGiris.dart';
import 'package:dershane/loginSayfalari/veliGiris.dart';
import 'package:dershane/loginSayfalari/yonetimGiris.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:dershane/extensions/size_extention.dart';
import 'package:google_fonts/google_fonts.dart';


class KullaniciSecim extends StatefulWidget {
  @override
  _KullaniciSecimState createState() => _KullaniciSecimState();
}

class _KullaniciSecimState extends State<KullaniciSecim> {
  @override
  Widget build(BuildContext context) {
    SizeConfig(context).init();
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Center(child: Text("Dershanem",style: GoogleFonts.patuaOne(fontSize: 45.0.spByWidth,color: Colors.green),)),
          SizedBox(height: 60.0.h,),
          Center(
            child: MyButton(text: "Yönetim Giriş",fontSize: 18.0.spByWidth, butonColor: Renkler.onayButonColor,width: 300.0.w,height: 50.0.h,
              onPressed: (){
                Navigator.of(context).push(MaterialPageRoute(builder: (context) => YonetimGiris()));
              },),
          ),
          SizedBox(height: 10.0.h,),
          Center(
            child: MyButton(text: "Öğretmen Giriş", fontSize: 18.0.spByWidth,butonColor: Renkler.onayButonColor,width: 300.0.w,height: 50.0.h,
              onPressed: (){
                Navigator.of(context).push(MaterialPageRoute(builder: (context) => OgretmenGiris()));
              },),
          ),
          SizedBox(height: 10.0.h,),
          Center(
            child: MyButton(text: "Öğrenci Giriş",fontSize: 18.0.spByWidth, butonColor: Renkler.onayButonColor,width: 300.0.w,height: 50.0.h,
              onPressed: (){
                Navigator.of(context).push(MaterialPageRoute(builder: (context) => OgrenciGiris()));
              },),
          ),
          SizedBox(height: 10.0.h,),
          Center(
            child: MyButton(text: "Veli Girişi",fontSize: 18.0.spByWidth, butonColor: Renkler.onayButonColor,width: 300.0.w,height: 50.0.h,
              onPressed: (){
                Navigator.of(context).push(MaterialPageRoute(builder: (context) => VeliGiris()));
              },),
          ),
        ],
      )
    );
  }



}
