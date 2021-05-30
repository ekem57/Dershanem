import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dershane/common/myButton.dart';
import 'package:dershane/extensions/renkler.dart';
import 'package:dershane/ogrenciSayfalari/profilAyarlar.dart';
import 'package:dershane/ogretmenSayfalari/ogretmenProfilGuncelle.dart';
import 'package:dershane/user_state/ogrenci_model_service.dart';
import 'package:dershane/user_state/ogretmen_model_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:dershane/extensions/size_extention.dart';

class OgretmenProfil extends StatefulWidget {
  @override
  _OgretmenProfilState createState() => _OgretmenProfilState();
}

class _OgretmenProfilState extends State<OgretmenProfil> {


  @override
  Widget build(BuildContext context) {
    final _ogretmenModel = Provider.of<OgretmenModel>(context, listen: true);
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
              _ogretmenModel.signOut();
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
                          image: _ogretmenModel.user.avatarImageUrl.toString() == "null" ? _ogretmenModel.user.avatarImageUrl == ""  ? AssetImage("assets/image/userprofil.png") : AssetImage("assets/image/userprofil.png")  : NetworkImage(_ogretmenModel.user.avatarImageUrl),
                        )
                    )
                ),

                MyButton(text: "Ayarlar", onPressed: (){

                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => ProfilAyarlarOgretmen(),
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
                        _ogretmenModel.user.adsoyad,
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
                        _ogretmenModel.user.telefon,
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
                        _ogretmenModel.user.email,
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
                    child: Text("Cinsiyet:",style: TextStyle(fontSize: 16.0.spByWidth),),
                  ),
                  Padding(
                    padding:  EdgeInsets.only(left: 55.0.w),
                    child: Container(
                      width: 200.0.w,
                      child: Text(
                        _ogretmenModel.user.cinsiyet,
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
                    child: Text("Branş:",style: TextStyle(fontSize: 16.0.spByWidth),),
                  ),
                  Padding(
                    padding:  EdgeInsets.only(left: 70.0.w),
                    child: Container(
                      width: 100.0.w,
                      child: Text(
                        _ogretmenModel.user.brans.toString(),
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
