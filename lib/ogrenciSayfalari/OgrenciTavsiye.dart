import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dershane/common/myButton.dart';
import 'package:dershane/extensions/renkler.dart';
import 'package:dershane/user_state/ogrenci_model_service.dart';
import 'package:flutter/material.dart';
import 'package:dershane/extensions/size_extention.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';


class OgrenciTavsiye extends StatefulWidget {
  final DocumentSnapshot card;

  OgrenciTavsiye({ @required this.card});
  @override
  _OgrenciTavsiyeState createState() => _OgrenciTavsiyeState();
}

class _OgrenciTavsiyeState extends State<OgrenciTavsiye> {

  @override
  void initState() {
    super.initState();

  }

  @override
  Widget build(BuildContext context) {
    final _ogrenciModel = Provider.of<OgrenciModel>(context, listen: false);
    return Scaffold(
      backgroundColor:  Renkler.appbarGroundColor,
      appBar: AppBar(
        title: Row(
          children: [
            CircleAvatar(
              backgroundImage: _ogrenciModel.user.avatarImageUrl.toString() == "null" ? AssetImage("assets/image/userprofil.png") :  NetworkImage(_ogrenciModel.user.avatarImageUrl),
              radius: 26.0,
            ),
            Padding(
              padding: EdgeInsets.only(right: 20.0.w),
              child: Container(
                width: MediaQuery.of(context).size.width-200,
                child: Padding(
                  padding:  EdgeInsets.only(left: 10.0.w),
                  child: Text(_ogrenciModel.user.adsoyad,
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
        child:  _buildYorumlar(),
      ),
    );
  }

  Widget _buildYorumlar() {
    final _ogrenciModel = Provider.of<OgrenciModel>(context, listen: false);
    return StreamBuilder<QuerySnapshot>(
      stream:
      FirebaseFirestore.instance.collection("ogrenci").doc(_ogrenciModel.user.userId).collection("tavsiyeler").snapshots(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (!snapshot.hasData) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }

        final int cardLength = snapshot.data.docs.length;

        return ListView.builder(
          padding: EdgeInsets.all(0),
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          itemCount: cardLength,
          itemBuilder: (_, int index) {
            final DocumentSnapshot _cardYonetici = snapshot.data.docs[index];
            return StreamBuilder<DocumentSnapshot>(
              stream: FirebaseFirestore.instance.collection("ogretmen").doc(_cardYonetici['ogretmenId']).snapshots(),
              builder: (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
                if (!snapshot.hasData) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }


                return ListView.builder(
                  padding: EdgeInsets.all(0),
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: 1,
                  itemBuilder: (_, int index) {
                    final DocumentSnapshot _card = snapshot.data;


                    final gun = _cardYonetici['tarih'].toDate();
                    final bugun = DateTime.now();
                    final difference = bugun.difference(gun).inDays;
                    return Container(
                      padding: EdgeInsets.symmetric(horizontal: 16.0.w),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ListTile(
                            contentPadding: EdgeInsets.symmetric(horizontal: 0.0.w),
                            title: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(_card['adSoyad'].toString(),
                                    style: TextStyle(
                                        color: const Color(0xff343633),
                                        fontWeight: FontWeight.w600,
                                        fontFamily: "OpenSans",
                                        fontStyle: FontStyle.normal,
                                        fontSize: 15.3.spByWidth),
                                    textAlign: TextAlign.left),

                                Text(_card['brans'].toString(),
                                    style: TextStyle(
                                        color: const Color(0xff343633),
                                        fontWeight: FontWeight.w600,
                                        fontFamily: "OpenSans",
                                        fontStyle: FontStyle.normal,
                                        fontSize: 13.3.spByWidth),
                                    textAlign: TextAlign.left),
                              ],
                            ),
                            leading: CircleAvatar(
                              backgroundColor: Colors.white,
                              backgroundImage: _card['avatarImageUrl'].toString() == "null" ? _card['avatarImageUrl'].toString() == ""  ? AssetImage("assets/image/userprofil.png") : AssetImage("assets/image/userprofil.png")  : NetworkImage(_card['avatarImageUrl'].toString()),
                              radius: 20.0.h,
                            ),

                            trailing: difference < 0 ? Text(difference.abs().toString() + " gün önce",
                                style: TextStyle(
                                    color: const Color(0xff343633),
                                    fontWeight: FontWeight.w400,
                                    fontFamily: "OpenSans",
                                    fontStyle: FontStyle.normal,
                                    fontSize: 12.0.spByWidth),
                                textAlign: TextAlign.right) :
                            Text(difference.toString() + " gün sonra",
                                style: TextStyle(
                                    color: const Color(0xff343633),
                                    fontWeight: FontWeight.w400,
                                    fontFamily: "OpenSans",
                                    fontStyle: FontStyle.normal,
                                    fontSize: 12.0.spByWidth),
                                textAlign: TextAlign.right),
                          ),
                          Text(
                            _cardYonetici['tavsiye'] != null ? _cardYonetici['tavsiye'].toString() : "",
                            style:  TextStyle(
                                color: const Color(0xff343633),
                                fontWeight: FontWeight.w400,
                                fontFamily: "OpenSans",
                                fontStyle: FontStyle.normal,
                                fontSize: 15.3.spByWidth),
                          ),
                          Divider(),
                        ],
                      ),
                    );
                  },
                );
              },
            );
          },
        );
      },
    );
  }

}
