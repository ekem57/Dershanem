import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dershane/common/myButton.dart';
import 'package:dershane/extensions/renkler.dart';
import 'package:dershane/ogrenciSayfalari/profilAyarlar.dart';
import 'package:dershane/user_state/ogrenci_model_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:dershane/extensions/size_extention.dart';

class OgrenciProfil extends StatefulWidget {
  @override
  _OgrenciProfilState createState() => _OgrenciProfilState();
}

class _OgrenciProfilState extends State<OgrenciProfil> {


  @override
  Widget build(BuildContext context) {
    final _ogrenciModel = Provider.of<OgrenciModel>(context, listen: true);
    return Scaffold(
      appBar: AppBar(
        brightness: Brightness.light,
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        iconTheme: new IconThemeData(color: Colors.black),
        title: Text("Profil", style: TextStyle(
            fontSize: 30, fontWeight: FontWeight.bold, color: Colors.black),),
        automaticallyImplyLeading: false,
        actions: <Widget>[
        Padding(
          padding: const EdgeInsets.only(right: 20),
          child: IconButton(icon: Icon(Icons.exit_to_app,size: 40,), onPressed: (){
            _ogrenciModel.signOut();
          }),
        )

        ],
      ),

      body: ListView(
        children: <Widget>[


          Center(
            child: Column(
              children: <Widget>[

                Container(
                    width: 120.0.w,
                    height: 120.0.h,
                    margin: EdgeInsets.all(
                        10.0.w
                    ),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(100.0),
                        boxShadow:[
                          BoxShadow(
                              color: Color.fromARGB(60, 0, 0, 0),
                              blurRadius: 5.0,
                              offset: Offset(3.0, 3.0)
                          )
                        ],
                        image: DecorationImage(
                          fit: BoxFit.fill,
                          image: _ogrenciModel.user.avatarImageUrl.toString() == "null" ? _ogrenciModel.user.avatarImageUrl == ""  ? AssetImage("assets/image/userprofil.png") : AssetImage("assets/image/userprofil.png")  : NetworkImage(_ogrenciModel.user.avatarImageUrl),
                        )
                    )
                ),

                MyButton(text: "Ayarlar", onPressed: (){

                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => ProfilAyarlar(),
                    ),
                  );
                }, textColor: Colors.white, fontSize: 16.0.spByWidth, width: 240.0.w, height: 40.0.h,butonColor: Renkler.onayButonColor,),

                SizedBox(height: 10.0.h,),
                Divider(),
                Row(children: <Widget>[
                  Padding(
                    padding:  EdgeInsets.only(left: 10.0.w),
                    child: Text("İsim:",style: TextStyle(fontSize: 16.0.spByWidth),),
                  ),
                  Padding(
                    padding:  EdgeInsets.only(left: 85.0.w),
                    child: Container(
                      width: 200.0.w,
                      child: Text(
                        _ogrenciModel.user.adsoyad.toString(),
                        overflow: TextOverflow.ellipsis,
                        maxLines: 3,
                        style: TextStyle(fontSize: 17.0.spByWidth),
                      ),
                    ),
                  ),
                ],),
                Divider(),
                Row(children: <Widget>[
                  Padding(
                    padding:  EdgeInsets.only(left: 10.0.w),
                    child: Text("Telefon:",style: TextStyle(fontSize: 16.0.spByWidth),),
                  ),
                  Padding(
                    padding:  EdgeInsets.only(left: 60.0.w),
                    child: Container(
                      width: 200.0.w,
                      child: Text(
                        _ogrenciModel.user.telefon.toString(),
                        overflow: TextOverflow.ellipsis,
                        maxLines: 3,
                        style: TextStyle(fontSize: 17.0.spByWidth),
                      ),
                    ),
                  ),
                ],),
                Divider(),
                Row(children: <Widget>[
                  Padding(
                    padding:  EdgeInsets.only(left: 10.0.w),
                    child: Text("Email:",style: TextStyle(fontSize: 16.0.spByWidth),),
                  ),
                  Padding(
                    padding:  EdgeInsets.only(left: 75.0.w),
                    child: Container(
                      width: 200.0.w,
                      child: Text(
                        _ogrenciModel.user.email.toString(),
                        overflow: TextOverflow.ellipsis,
                        maxLines: 3,
                        style: TextStyle(fontSize: 17.0.spByWidth),
                      ),
                    ),
                  ),
                ],),


                Divider(),
                Row(children: <Widget>[
                  Padding(
                    padding:  EdgeInsets.only(left: 10.0.w),
                    child: Text("Öğrenci No:",style: TextStyle(fontSize: 16.0.spByWidth),),
                  ),
                  Padding(
                    padding:  EdgeInsets.only(left: 30.0.w),
                    child: Container(
                      width: 200.0.w,
                      child: Text(
                        _ogrenciModel.user.ogrenciNo.toString(),
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                        style: TextStyle(fontSize: 17.0.spByWidth),
                      ),
                    ),
                  ),
                ],),
                Divider(),
                Row(children: <Widget>[
                  Padding(
                    padding:  EdgeInsets.only(left: 10.0.w),
                    child: Text("Okul:",style: TextStyle(fontSize: 16.0.spByWidth),),
                  ),
                  Padding(
                    padding:  EdgeInsets.only(left: 80.0.w),
                    child: Container(
                      width: 200.0.w,
                      child: Text(
                        _ogrenciModel.user.okul.toString(),
                        overflow: TextOverflow.ellipsis,
                        maxLines: 3,
                        style: TextStyle(fontSize: 17.0.spByWidth),
                      ),
                    ),
                  ),
                ],),
                Divider(),
                Row(children: <Widget>[
                  Padding(
                    padding:  EdgeInsets.only(left: 10.0.w),
                    child: Text("Bölüm:",style: TextStyle(fontSize: 16.0.spByWidth),),
                  ),
                  Padding(
                    padding:  EdgeInsets.only(left: 70.0.w),
                    child: Container(
                      width: 200.0.w,
                      child: Text(
                        _ogrenciModel.user.bolum.toString(),
                        overflow: TextOverflow.ellipsis,
                        maxLines: 3,
                        style: TextStyle(fontSize: 17.0.spByWidth),
                      ),
                    ),
                  ),
                ],),
                Divider(),
                Row(children: <Widget>[
                  Padding(
                    padding:  EdgeInsets.only(left: 10.0.w),
                    child: Text("Sınıf:",style: TextStyle(fontSize: 16.0.spByWidth),),
                  ),
                  Padding(
                    padding:  EdgeInsets.only(left: 80.0.w),
                    child: Container(
                      width: 200.0.w,
                      child: Text(
                        _ogrenciModel.user.sinif.toString(),
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(fontSize: 17.0.spByWidth),
                      ),
                    ),
                  ),
                ],),
                Divider(),
                Row(children: <Widget>[
                  Padding(
                    padding:  EdgeInsets.only(left: 10.0.w),
                    child: Text("Dershane Sınıf:",style: TextStyle(fontSize: 16.0.spByWidth),),
                  ),
                  Padding(
                    padding:  EdgeInsets.only(left: 10.0.w),
                    child: Container(
                      width: 200.0.w,
                      child: Text(
                        _ogrenciModel.user.dershaneSinif.toString(),
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(fontSize: 17.0.spByWidth),
                      ),
                    ),
                  ),
                ],),
                Divider(),
                Row(children: <Widget>[
                  Padding(
                    padding:  EdgeInsets.only(left: 10.0.w),
                    child: Text("Danışman öğretmen:",style: TextStyle(fontSize: 16.0.spByWidth),),
                  ),
                  Padding(
                    padding:  EdgeInsets.only(left: 10.0.w),
                    child: Container(
                      width: 100.0.w,
                      child: Text(
                        _ogrenciModel.user.danisman.toString(),
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(fontSize: 17.0.spByWidth),
                      ),
                    ),
                  ),
                ],),


                SizedBox(height: 20.0.h,),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
