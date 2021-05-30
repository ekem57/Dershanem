import 'package:cloud_firestore/cloud_firestore.dart';
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


class DuyuruDetaySayfasi extends StatefulWidget {
  final DocumentSnapshot card;

  DuyuruDetaySayfasi({ @required this.card});
  @override
  _DuyuruDetaySayfasiState createState() => _DuyuruDetaySayfasiState();
}

class _DuyuruDetaySayfasiState extends State<DuyuruDetaySayfasi> with SingleTickerProviderStateMixin {


  FirestoreDBService _firebaseIslemleri = locator<FirestoreDBService>();

  final sinifController = TextEditingController();

  bool _loadingVisible = false;
  Future<void> _changeLoadingVisible() async {
    setState(() {
      _loadingVisible = !_loadingVisible;
    });
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor:  Renkler.appbarGroundColor,
      appBar: AppBar(
        title: Text(widget.card['baslik'].toString()),
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
        child:  ListView(
          children: [

            Column(
              children: [
                widget.card['img'] != "" ?  Padding(
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

                        },
                        child:  ClipRRect(
                          borderRadius: BorderRadius.circular(17),
                          child: Image.network(
                            widget.card['img'],
                            width: 312.0.w,
                            height: 146.0.h,
                            fit: BoxFit.fitWidth,
                          ),
                        )
                    ),
                  ),
                ) : Container(),

                SizedBox(height: 30.0.h,),
                Padding(
                  padding:  EdgeInsets.symmetric(horizontal: 20.0.w,vertical: 5),
                  child: Align(
                    alignment: Alignment.topLeft,
                    child: Text(
                      widget.card['aciklama'].toString(),
                      style: TextStyle(
                          color: const Color(0xff343633),
                          fontWeight: FontWeight.w600,
                          fontFamily: "OpenSans",
                          fontStyle: FontStyle.normal,
                          fontSize: 14.0.spByWidth),
                      textAlign: TextAlign.start,
                    ),
                  ),
                ),



              ],
            ),
            SizedBox(height: 40.0.h,),

          ],
        ),
      ),
    );
  }


}
