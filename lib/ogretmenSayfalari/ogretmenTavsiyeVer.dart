import 'dart:convert';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dershane/common/loadingscreen.dart';
import 'package:dershane/common/myButton.dart';
import 'package:dershane/extensions/renkler.dart';
import 'package:dershane/firebase/firebase_database.dart';
import 'package:dershane/locator.dart';
import 'package:dershane/user_state/ogretmen_model_service.dart';
import 'package:dershane/user_state/yonetici_model_service.dart';
import 'package:flutter/material.dart';
import 'package:dershane/extensions/size_extention.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;



class OgretmenTavsiyeVer extends StatefulWidget {
  final DocumentSnapshot card;
  OgretmenTavsiyeVer({this.card});

  @override
  _OgretmenTavsiyeVerState createState() => _OgretmenTavsiyeVerState();
}


class _OgretmenTavsiyeVerState extends State<OgretmenTavsiyeVer> {

  FirestoreDBService _firebaseIslemleri = locator<FirestoreDBService>();

  final tavsiyeController = TextEditingController();
  final baslikController = TextEditingController();


  PickedFile _image;
  var imageUrl;
  final picker = ImagePicker();
  bool _loadingVisible = false;
  Future<void> _changeLoadingVisible() async {
    setState(() {
      _loadingVisible = !_loadingVisible;
    });
  }
  @override
  Widget build(BuildContext context) {


    return Scaffold(

      extendBody: true,
      backgroundColor: Renkler.backGroundColor,
      appBar:  AppBar(
        backgroundColor: Renkler.backGroundColor,
        elevation: 0,
        iconTheme: new IconThemeData(color: Renkler.appbarIconColor),
        toolbarHeight: 70.0.h,
        title: Center(

          child: Padding(
            padding:  EdgeInsets.only(right: 40.0.w),
            child: Text(
                widget.card['adSoyad'].toString(),
                style: TextStyle(
                    color:  Renkler.appbarTextColor,
                    fontWeight: FontWeight.w700,
                    fontFamily: "OpenSans",
                    fontStyle:  FontStyle.normal,
                    fontSize: 20.0.spByWidth
                ),
                textAlign: TextAlign.center
            ),
          ),
        ),


      ),
      body: LoadingScreen(
        inAsyncCall: _loadingVisible,
        child: ClipRRect(
          borderRadius: BorderRadius.only(topLeft: Radius.circular(40),topRight: Radius.circular(40)),
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,

              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.1),
                  spreadRadius: 8,
                  blurRadius: 7,
                  offset: Offset(0, 1), // changes position of shadow
                ),
              ],
            ),
            child: ListView(
              children: [


                SizedBox(
                  height: 10.0.h,
                ),


                Padding(
                  padding:  EdgeInsets.symmetric(horizontal: 30.0.w),
                  child: TextFormField(
                    controller: tavsiyeController,
                    keyboardType: TextInputType.text,
                    autocorrect: false,
                    maxLines: 2,
                    textInputAction: TextInputAction.next,
                    style: TextStyle(fontSize: 15.0.spByWidth),
                    decoration: InputDecoration(
                      labelText: "Tavsiye",
                      labelStyle: Theme.of(context).textTheme.caption.copyWith(fontSize: 20.0.spByWidth),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                          color: Theme.of(context).primaryColor,
                          width: 0,
                        ),
                      ),
                    ),
                  ),
                ),




                SizedBox(height: 10.0.h,),
                Padding(
                  padding:  EdgeInsets.symmetric(horizontal: 30.0.w,vertical: 20.0.h),
                  child: MyButton(text: "Gönder",
                    onPressed: () async {
                      final _ogretmenModel = Provider.of<OgretmenModel>(context, listen: false);
                      SystemChannels.textInput.invokeMethod('TextInput.hide');
                      await _changeLoadingVisible();


                      Map<String, dynamic> TavsiyeBilgileri = Map();



                      TavsiyeBilgileri['tavsiye'] = tavsiyeController.text;
                      TavsiyeBilgileri['ogretmenId'] = _ogretmenModel.user.userId;
                      TavsiyeBilgileri['tarih'] = DateTime.now();

                      bool veri =  await   _firebaseIslemleri.ogretmenTavsiye(TavsiyeBilgileri,widget.card['userId']);
                      if(veri)
                      {
                        await _changeLoadingVisible();
                        Fluttertoast.showToast(
                          msg: "Tavsiye Verildi.",
                          toastLength: Toast.LENGTH_LONG,
                          gravity: ToastGravity.CENTER,
                          textColor: Colors.white,
                          backgroundColor: Colors.green,
                        );
                          tavsiyeController.clear();
                      }


                    },
                    textColor: Colors.black,
                    fontSize: 17,
                    width: MediaQuery.of(context).size.width,
                    height: 45.0.h,butonColor: Renkler.onayButonColor,
                  ),
                ),

                SizedBox(height: 40.0.h,),
              ],
            ),
          ),
        ),
      ),



    );
  }

}
