import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dershane/common/alertokeycancel.dart';
import 'package:dershane/common/myButton.dart';
import 'package:dershane/common/ogrenciKabulAlertDialog.dart';
import 'package:flutter/material.dart';
import 'package:dershane/extensions/size_extention.dart';


class OgrenciKayitKart extends StatelessWidget {

  DocumentSnapshot card;
  final VoidCallback onPressed;



  OgrenciKayitKart(
      {Key key,

        @required this.card,
        @required this.onPressed,
      })
      : assert(onPressed!=null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return  Padding(
      padding: EdgeInsets.symmetric(horizontal: 21.0.w,vertical: 10.0.h),
      child:  GestureDetector(
        onTap: (){},
        child: Container(
          width: MediaQuery.of(context).size.width,

          alignment: Alignment.center,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(11.70.w)),
              boxShadow: [
                BoxShadow(
                    color: const Color(0x26000000),
                    offset: Offset(0, 0),
                    blurRadius: 8.50,
                    spreadRadius: 0.8)
              ],
              color: Theme.of(context).backgroundColor),
          child: Column(
            children: [
              SizedBox(height: 10.0.h,),
              Padding(
                padding:  EdgeInsets.only(left: 15.0.w),
                child: Align(
                  alignment: Alignment.topLeft,
                  child: Text(
                    card['adSoyad'].toString(),
                    style: TextStyle(
                        color: const Color(0xff343633),
                        fontWeight: FontWeight.w600,
                        fontFamily: "OpenSans",
                        fontStyle: FontStyle.normal,
                        fontSize: 17.7.spByWidth),
                  ),
                ),
              ),
              Padding(
                padding:  EdgeInsets.only(left: 15.0.w),
                child: Align(
                  alignment: Alignment.topLeft,
                  child: Text(
                    card['sinif'].toString(),
                    style: TextStyle(
                        color: const Color(0xff343633),
                        fontWeight: FontWeight.w600,
                        fontFamily: "OpenSans",
                        fontStyle: FontStyle.normal,
                        fontSize: 17.7.spByWidth),
                  ),
                ),
              ),
              Padding(
                padding:  EdgeInsets.only(left: 15.0.w),
                child: Align(
                  alignment: Alignment.topLeft,
                  child: Text(
                    card['bolum'].toString(),
                    textAlign: TextAlign.left,
                    style: TextStyle(
                        color: const Color(0xff343633),
                        fontWeight: FontWeight.w600,
                        fontFamily: "OpenSans",
                        fontStyle: FontStyle.normal,
                        fontSize: 17.7.spByWidth),
                  ),
                ),
              ),
              SizedBox(height: 20.0.h,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  MyButton(text: "Onayla",  textColor: Colors.white, fontSize: 12.0.w, width: 130.0.w, height: 30.0.h,onPressed: (){
                    var dialog = OgrenciKabulAlertDialog(
                      title: "????renciye bir numara atay??n",
                      card: card,
                    );
                    showDialog(
                        context: context,
                        builder: (BuildContext context) => dialog);
                  },),
                  MyButton(text: "Sil",  textColor: Colors.white, fontSize: 12.0.w, width: 130.0.w, height: 30.0.h,butonColor: Colors.red,onPressed: (){
                    var dialog = CustomAlertDialog(
                        message: "Bu ????renciyi silmek istedi??inizden emin misiniz?",
                        onPostivePressed: () {
                          card.reference.delete();
                          Navigator.pop(context);
                          Navigator.pop(context);
                        },
                        onNegativePressed: (){
                          Navigator.pop(context);
                        },
                        positiveBtnText: 'Evet',
                        negativeBtnText: 'Hay??r');

                    showDialog(
                        context: context,
                        builder: (BuildContext context) => dialog);
                  },),
                ],
              ),
              SizedBox(height: 20.0.h,),
            ],
          ),
        ),
      ),
    );

  }
}
