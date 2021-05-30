import 'dart:convert';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dershane/common/loadingscreen.dart';
import 'package:dershane/common/myButton.dart';
import 'package:dershane/extensions/renkler.dart';
import 'package:dershane/firebase/firebase_database.dart';
import 'package:dershane/locator.dart';
import 'package:dershane/user_state/yonetici_model_service.dart';
import 'package:flutter/material.dart';
import 'package:dershane/extensions/size_extention.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;



class EtkinlikDuyuru extends StatefulWidget {
  @override
  _EtkinlikDuyuruState createState() => _EtkinlikDuyuruState();
}


class _EtkinlikDuyuruState extends State<EtkinlikDuyuru> {

  FirestoreDBService _firebaseIslemleri = locator<FirestoreDBService>();

  final aciklamaController = TextEditingController();
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

 static String duyuruTur="Genel Duyuru";
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
                "Duyuru Paylaş",
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
        automaticallyImplyLeading: false,

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
                  padding:  EdgeInsets.only(left: 30.0.w),
                  child: Opacity(
                    opacity: 0.85,
                    child: Text("Fotoğraf",
                        style: TextStyle(
                            color: const Color(0xd9343633),
                            fontWeight: FontWeight.w400,
                            fontFamily: "OpenSans",
                            fontStyle: FontStyle.normal,
                            fontSize: 20.0.spByWidth),
                        textAlign: TextAlign.left),
                  ),
                ),
                Padding(
                  padding:  EdgeInsets.only(right: 20.0.w,left: 20.0.w),
                  child: Container(
                    width: 312.0.w,
                    height: 146.0.h,
                    margin: EdgeInsets.symmetric(vertical: 20.0.h),
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(17)),
                        boxShadow: [
                          BoxShadow(
                              color: const Color(0x30000000), offset: Offset(0, 2), blurRadius: 14, spreadRadius: 0)
                        ],
                        color: Colors.white),
                    child: GestureDetector(
                      onTap: () {
                        _showPicker(context);
                      },
                      child: _image == null
                          ? Container(
                        width: 56.0.w,
                        height: 56.0.w,
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            boxShadow: [
                              BoxShadow(
                                  color: const Color(0x36000000),
                                  offset: Offset(2, 3),
                                  blurRadius: 18,
                                  spreadRadius: 0)
                            ],
                            color: Colors.white),
                        child: Icon(Icons.camera_alt, size: 24.0.h, color: Theme.of(context).primaryColor),
                      )
                          : ClipRRect(
                        borderRadius: BorderRadius.circular(17),
                        child: Image.file(
                          File(_image.path),
                          width: 312.0.w,
                          height: 146.0.h,
                          fit: BoxFit.fitWidth,
                        ),
                      ),
                    ),
                  ),
                ),

                Padding(
                  padding:  EdgeInsets.symmetric(horizontal: 30.0.w),
                  child: TextFormField(
                    controller: baslikController,
                    keyboardType: TextInputType.text,
                    autocorrect: false,
                    maxLines: 1,
                    textInputAction: TextInputAction.next,
                    style: TextStyle(fontSize: 15.0.spByWidth),
                    decoration: InputDecoration(
                      labelText: "Başlık",
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



                Padding(
                  padding:  EdgeInsets.symmetric(horizontal: 30.0.w),
                  child: TextFormField(
                    controller: aciklamaController,
                    keyboardType: TextInputType.text,
                    autocorrect: false,
                    maxLines: 3,
                    textInputAction: TextInputAction.next,
                    style: TextStyle(fontSize: 15.0.spByWidth),
                    decoration: InputDecoration(
                      labelText: "Açıklama",
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
                SizedBox(height: 30.0.h,),
                InkWell(
                    onTap: () {

                    },
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 18),
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(8),
                          boxShadow: <BoxShadow>[
                            BoxShadow(
                                color: Colors.grey.withOpacity(0.8),
                                offset: const Offset(4, 4),
                                blurRadius: 8),
                          ],
                        ),
                        child: DropdownButtonFormField(

                          decoration: new InputDecoration(

                            enabledBorder:OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.white)

                            ),
                            fillColor: Colors.white,
                            focusColor: Renkler.reddetButonColor,
                            errorStyle: Theme.of(context)
                                .textTheme
                                .caption
                                .copyWith(fontSize: 12.0.spByWidth, color: Colors.red),

                          ),
                          value: duyuruTur,
                          items: ["Genel Duyuru", "Öğretmenler Duyuru"].map((e) {
                            return DropdownMenuItem(value: e , child: Text(e));
                          }).toList(),
                          onChanged: (newValue) {
                            duyuruTur = newValue;
                          },
                        ),


                      ),
                    )),

                SizedBox(height: 10.0.h,),
                Padding(
                  padding:  EdgeInsets.symmetric(horizontal: 30.0.w,vertical: 20.0.h),
                  child: MyButton(text: "Gönder",
                    onPressed: () async {

                      SystemChannels.textInput.invokeMethod('TextInput.hide');
                      await _changeLoadingVisible();

                     DocumentReference ref= FirebaseFirestore.instance.collection("etidolustur").doc();

                      Map<String, dynamic> DuyuruBilgileri = Map();

                      var downloadUrl = await uploadDuyuruImage(ref.id);

                      DuyuruBilgileri['img'] = downloadUrl;
                      DuyuruBilgileri['baslik'] = baslikController.text;
                      DuyuruBilgileri['aciklama'] = aciklamaController.text;
                      DuyuruBilgileri['duyuruId'] = ref.id;
                      DuyuruBilgileri['tarih'] = DateTime.now();


                      bool veri =  await   _firebaseIslemleri.yoneticiDuyuruPaylas(DuyuruBilgileri,ref.id,duyuruTur);
                      if(veri)
                      {
                        await _changeLoadingVisible();
                        Fluttertoast.showToast(
                          msg: "Duyuru Oluşturuldu.",
                          toastLength: Toast.LENGTH_LONG,
                          gravity: ToastGravity.CENTER,
                          textColor: Colors.white,
                          backgroundColor: Colors.green,
                        );


                        aciklamaController.clear();
                        baslikController.clear();
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


  void _showPicker(context) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext bc) {
          return SafeArea(
            child: Container(
              child: new Wrap(
                children: <Widget>[
                  new ListTile(
                      leading: new Icon(Icons.photo_library),
                      title: new Text('Galeri'),
                      onTap: () {
                        _imgFromGallery();
                        Navigator.of(context).pop();
                      }),
                  new ListTile(
                    leading: new Icon(Icons.photo_camera),
                    title: new Text('Kamera'),
                    onTap: () {
                      _imgFromCamera();
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              ),
            ),
          );
        });
  }

  _imgFromCamera() async {
    PickedFile image = await picker.getImage(source: ImageSource.camera, imageQuality: 25);

    setState(() {
      _image = image;
    });
  }

  _imgFromGallery() async {
    PickedFile image = await picker.getImage(source: ImageSource.gallery, imageQuality: 25);

    setState(() {
      _image = image;
      print(_image.path);
    });
  }

  Future<String> uploadDuyuruImage(String id) async {
    final _modelYonetici = Provider.of<YoneticiModel>(context, listen: false);
    if(_image == null)
      return "";
    String filePath = _image.path;
    String userId = _modelYonetici.user.userId;
    String fileName = "${userId}-${id}}.jpg";
    File file = File(filePath);
    try {
      await firebase_storage.FirebaseStorage.instance.ref('duyuru/$fileName').putFile(file);
      String downloadURL =
      await firebase_storage.FirebaseStorage.instance.ref('duyuru/$fileName').getDownloadURL();
      return downloadURL;
    } on FirebaseException catch (e) {
      // e.g, e.code == 'canceled'
      return "error";
      print("Error on uploading image file ${e.code}");
    }
  }


}
