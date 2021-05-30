import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dershane/common/loadingscreen.dart';
import 'package:dershane/common/myButton.dart';
import 'package:dershane/extensions/renkler.dart';
import 'package:dershane/firebase/firebase_database.dart';
import 'package:dershane/locator.dart';
import 'package:dershane/user_state/ogrenci_model_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_masked_text/flutter_masked_text.dart';
import 'package:dershane/extensions/size_extention.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;


class ProfilFotografiGuncelle extends StatefulWidget {
  @override
  _ProfilFotografiGuncelleState createState() => _ProfilFotografiGuncelleState();
}
var controller = new MaskedTextController(mask: '000-000-00-00');
String sinif="1.Sınıf";
FirestoreDBService _firestoreDBService = locator<FirestoreDBService>();
final picker = ImagePicker();
PickedFile _image;

class _ProfilFotografiGuncelleState extends State<ProfilFotografiGuncelle> {
  bool _loadingVisible = false;
  Future<void> _changeLoadingVisible() async {
    setState(() {
      _loadingVisible = !_loadingVisible;
    });
  }
  var downloadUrl = "";
  @override
  Widget build(BuildContext context) {
    final _ogrenciModel = Provider.of<OgrenciModel>(context, listen: true);

    return Scaffold(
      appBar: AppBar(),
      body: LoadingScreen(
        inAsyncCall: _loadingVisible,
        child: Column(

          children: [
            SizedBox(height: 40.0.h,),

            GestureDetector(
              onTap: (){
                _showPicker(context);
              },
              child: Center(
                child: Container(
                    width: 160.0.w,
                    height: 160.0.h,
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
                          image: _ogrenciModel.user.avatarImageUrl != "" ? _image == null ?   _ogrenciModel.user.avatarImageUrl.toString() != "null" ? NetworkImage(_ogrenciModel.user.avatarImageUrl) : AssetImage("assets/image/userprofil.png") : FileImage(File(_image.path)) :  AssetImage("assets/image/userprofil.png"),
                        )
                    )
                ),
              ),
            ),

            SizedBox(height: 20.0.h,),
            MyButton(text: "Güncelle", onPressed: () async {
              SystemChannels.textInput.invokeMethod('TextInput.hide');
              await _changeLoadingVisible();



              if (_image != null ) {

                downloadUrl = await uploadImage();
                _ogrenciModel.user.avatarImageUrl=downloadUrl;
               bool veri= await _firestoreDBService.ogrenciFotografGuncelle(_ogrenciModel.user.userId,downloadUrl);
                if(veri)
                {
                  await _changeLoadingVisible();
                  Fluttertoast.showToast(
                    msg: "Güncelleme Tamamlandı.",
                    toastLength: Toast.LENGTH_LONG,
                    gravity: ToastGravity.BOTTOM,
                    textColor: Colors.white,
                    backgroundColor: Colors.green,
                  );

                }
              }else{
                await _changeLoadingVisible();
                Fluttertoast.showToast(
                  msg: "Lütfen yeni fotoğraf ekleyiniz.",
                  toastLength: Toast.LENGTH_LONG,
                  gravity: ToastGravity.BOTTOM,
                  textColor: Colors.black,
                  backgroundColor: Colors.green,
                );
              }

            }, textColor: Colors.white, fontSize: 16.0.spByWidth, width: 280.0.w, height: 45.0.h),

          ],
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


  Future<String> uploadImage() async {
    final _ogrenciModel = Provider.of<OgrenciModel>(context, listen: false);
    if(_image == null)
      return "";
    String filePath = _image.path;
    String userId = _ogrenciModel.user.userId;
    String fileName = "${userId}}.jpg";
    File file = File(filePath);
    try {
      await firebase_storage.FirebaseStorage.instance.ref('avataruser/$fileName').putFile(file);
      String downloadURL =
      await firebase_storage.FirebaseStorage.instance.ref('avataruser/$fileName').getDownloadURL();
      return downloadURL;
    } on FirebaseException catch (e) {
      // e.g, e.code == 'canceled'
      return "error";
      print("Error on uploading image file ${e.code}");
    }
  }

  _imgFromCamera() async {
    PickedFile image = await picker.getImage(source: ImageSource.camera, imageQuality: 50);
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


}
