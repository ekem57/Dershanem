import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dershane/extensions/renkler.dart';
import 'package:flutter/material.dart';
import 'package:dershane/extensions/size_extention.dart';


class VeliDetaySayfasi extends StatefulWidget {
  final DocumentSnapshot card;

  VeliDetaySayfasi({ @required this.card});
  @override
  _VeliDetaySayfasiState createState() => _VeliDetaySayfasiState();
}

class _VeliDetaySayfasiState extends State<VeliDetaySayfasi> {



  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor:  Renkler.appbarGroundColor,
      appBar: AppBar(
        title: Row(
          children: [

            Padding(
              padding: EdgeInsets.only(right: 20.0.w),
              child: Container(
                width: MediaQuery.of(context).size.width-200,
                child: Padding(
                  padding:  EdgeInsets.only(left: 10.0.w),
                  child: Text(widget.card['adSoyad'],
                    style: TextStyle(
                        color: const Color(0xffffffff),
                        fontWeight: FontWeight.w700,
                        fontFamily: "OpenSans",
                        fontStyle: FontStyle.normal,
                        fontSize: 20.0.spByWidth),

                    overflow: TextOverflow.ellipsis,
                    softWrap: false,

                  ),
                ),
              ),
            ),
          ],
        ),
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
        child: Center(
          child: Column(
            children: <Widget>[

              Padding(
                padding:  EdgeInsets.symmetric(horizontal: 30.0.w),
                child: Row(children: [
                  Text("E-mail:",style: TextStyle(fontSize: 16.0.spByWidth,fontWeight: FontWeight.bold),),
                  SizedBox(width: 20.0.w,),
                  Text(widget.card['email'],style: TextStyle(fontSize: 16.0.spByWidth,fontWeight: FontWeight.bold),),
                ],),
              ),

              SizedBox(height: 10.0.h,),

              Padding(
                padding:  EdgeInsets.symmetric(horizontal: 30.0.w),
                child: Row(children: [
                  Text("Telefon:",style: TextStyle(fontSize: 16.0.spByWidth,fontWeight: FontWeight.bold),),
                  SizedBox(width: 20.0.w,),
                  Text(widget.card['telefon'],style: TextStyle(fontSize: 16.0.spByWidth,fontWeight: FontWeight.bold),),
                ],),
              ),

              SizedBox(height: 10.0.h,),

              Padding(
                padding:  EdgeInsets.symmetric(horizontal: 30.0.w),
                child: Row(children: [
                  Text("Cinsiyet:",style: TextStyle(fontSize: 16.0.spByWidth,fontWeight: FontWeight.bold),),
                  SizedBox(width: 20.0.w,),
                  Text(widget.card['cinsiyet'],style: TextStyle(fontSize: 16.0.spByWidth,fontWeight: FontWeight.bold),),
                ],),
              ),

              SizedBox(height: 10.0.h,),

              Padding(
                padding:  EdgeInsets.symmetric(horizontal: 30.0.w),
                child: Row(children: [
                  Text("Danisman:",style: TextStyle(fontSize: 16.0.spByWidth,fontWeight: FontWeight.bold),),
                  SizedBox(width: 20.0.w,),
                  Text(widget.card['danisman'].toString(),style: TextStyle(fontSize: 16.0.spByWidth,fontWeight: FontWeight.bold),),
                ],),
              ),






            ],
          ),
        ),
      ),
    );
  }



}
