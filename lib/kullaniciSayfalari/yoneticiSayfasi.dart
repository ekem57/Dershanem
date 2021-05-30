import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dershane/extensions/renkler.dart';
import 'package:flutter/material.dart';
import 'package:dershane/extensions/size_extention.dart';


class YoneticiDetaySayfasi extends StatefulWidget {
  final DocumentSnapshot card;

  YoneticiDetaySayfasi({ @required this.card});
  @override
  _YoneticiDetaySayfasiState createState() => _YoneticiDetaySayfasiState();
}

class _YoneticiDetaySayfasiState extends State<YoneticiDetaySayfasi> {



  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor:  Renkler.appbarGroundColor,
      appBar: AppBar(
        title: Row(
          children: [
            CircleAvatar(
              backgroundImage: widget.card['avatarImageUrl'].toString() == "null" ? AssetImage("assets/image/userprofil.png") : NetworkImage(widget.card['avatarImageUrl']),
              radius: 26.0,
            ),
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
          color: Theme.of(context).backgroundColor,
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

            ],
          ),
        ),
      ),
    );
  }



}
