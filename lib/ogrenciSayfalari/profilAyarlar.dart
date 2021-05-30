import 'package:dershane/common/myButton.dart';
import 'package:dershane/ogrenciSayfalari/IstekSikayetEt.dart';
import 'package:dershane/ogrenciSayfalari/profilayarlar/profilFotografiGuncelle.dart';
import 'package:dershane/ogrenciSayfalari/profilayarlar/sinifGuncelle.dart';
import 'package:dershane/ogrenciSayfalari/profilayarlar/telefonNumarasiGuncelle.dart';
import 'package:dershane/user_state/ogrenci_model_service.dart';
import 'package:flutter/material.dart';
import 'package:dershane/extensions/size_extention.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class ProfilAyarlar extends StatefulWidget {
  @override
  _ProfilAyarlarState createState() => _ProfilAyarlarState();
}

class _ProfilAyarlarState extends State<ProfilAyarlar> {
  @override
  Widget build(BuildContext context) {
    final _ogrenciModel = Provider.of<OgrenciModel>(context, listen: true);

    return Scaffold(
      appBar: AppBar(),
      body: Column(

        crossAxisAlignment: CrossAxisAlignment.center,
        children: [

          SizedBox(height: 30.0.h,),
          Center(child: Text("Profil Ayarlar",style: GoogleFonts.patuaOne(fontSize: 45.0.spByWidth,color: Colors.green),)),
          SizedBox(height: 70.0.h,),
          Center(child: MyButton(text: "İstek ve şikayetde bulun", butonColor: Colors.green, textColor: Colors.white, fontSize: 16.0.sp, width: 300.0.w, height: 55.0.h,onPressed: (){
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => IstekSikayetEt(),
              ),
            );
          },)),
          SizedBox(height: 60.0.h,),
          Center(child: MyButton(text: "Telefon Numaranı Güncelle",  textColor: Colors.white, fontSize: 16.0.sp, width: 300.0.w, height: 45.0.h,onPressed: (){
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => TelefonNumarasiGuncelle(),
              ),
            );
          },)),
          SizedBox(height: 10.0.h,),
          Center(child: MyButton(text: "Sınıf Güncelle",  textColor: Colors.white, fontSize: 16.0.sp, width: 300.0.w, height: 45.0.h,onPressed: (){
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => SinifGuncelle(),
              ),
            );
          },)),
          SizedBox(height: 10.0.h,),
          Center(child: MyButton(text: "Profil Fotoğrafını Güncelle",  textColor: Colors.white, fontSize: 16.0.sp, width: 300.0.w, height: 45.0.h,onPressed: (){

            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => ProfilFotografiGuncelle(),
              ),
            );
          },)),
          SizedBox(height: 10.0.h,),
          Center(child: MyButton(text: "Çıkış Yap",  textColor: Colors.white, fontSize: 16.0.sp, width: 300.0.w, height: 45.0.h,onPressed: (){
            _ogrenciModel.signOut();
          },)),
        ],
      ),
    );
  }
}
