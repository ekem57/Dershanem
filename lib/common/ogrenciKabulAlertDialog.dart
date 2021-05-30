import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dershane/common/myButton.dart';
import 'package:dershane/extensions/renkler.dart';
import 'package:dershane/firebase/firebase_database.dart';
import 'package:dershane/locator.dart';
import 'package:flutter/material.dart';
import 'package:dershane/extensions/size_extention.dart';

class OgrenciKabulAlertDialog extends StatefulWidget {

  String title;
  DocumentSnapshot card;

  OgrenciKabulAlertDialog({
    this.title,
    this.card,
  }) ;

  @override
  _OgrenciKabulAlertDialogState createState() => _OgrenciKabulAlertDialogState();
}
class _OgrenciKabulAlertDialogState extends State<OgrenciKabulAlertDialog> {

  FirestoreDBService _firestoreDBService = locator<FirestoreDBService>();

  @override
  Widget build(BuildContext context) {
    TextEditingController editingController = TextEditingController();
    return AlertDialog(
      contentPadding: EdgeInsets.all(15.0.w),
      insetPadding: EdgeInsets.all(12.0.w),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      title:  Text(widget.title,textAlign: TextAlign.center,),
      content: Container(
        width: MediaQuery.of(context).size.width,
        height: 140.0.h,
        child: ListView(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.0.w),
              child: Divider(thickness: 0.5,color: Colors.black,),
            ),

            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.0.w),
              child: TextFormField(
                controller: editingController,
                keyboardType: TextInputType.text,
                textInputAction: TextInputAction.done,
                maxLines: 2,
                style: TextStyle(fontSize: 15.0.spByWidth),
                decoration: InputDecoration(
                  hintText: "Öğrenci Numarası",
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.black,
                      width: 0,
                    ),
                  ),
                ),
                onFieldSubmitted: (String v){

                  Navigator.pop(context);
                  Navigator.pop(context);
                },
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 70.0.w,vertical: 20.0.h),
              child: MyButton(text: "Kayıt Yap", butonColor: Renkler.onayButonColor,
                  fontSize: 15.0.spByWidth, width: 157.0.w, height: 33.0.h,
                  onPressed: (){
                    _firestoreDBService.ogrenciOnay(editingController.text, widget.card.id);
                    Navigator.pop(context);

                  }
              ),
            ),
          ],
        ),
      ),
    );
  }
}


