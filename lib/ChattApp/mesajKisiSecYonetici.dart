import 'dart:async';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dershane/ChattApp/chat_view_model.dart';
import 'package:dershane/ChattApp/chat_view_model_Yonetici.dart';
import 'package:dershane/ChattApp/sohbetPage.dart';
import 'package:dershane/common/resimli_card.dart';
import 'package:dershane/extensions/renkler.dart';
import 'package:dershane/model/ogretmenModel.dart';
import 'package:dershane/model/yoneticiModel.dart';
import 'package:dershane/user_state/ogretmen_model_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:dershane/extensions/size_extention.dart';

class ChattKisiSecYonetici extends StatefulWidget {
  @override
  _ChattKisiSecYoneticiState createState() => _ChattKisiSecYoneticiState();
}



class _ChattKisiSecYoneticiState extends State<ChattKisiSecYonetici> {
  bool isSearching = false;
  List<DocumentSnapshot> totalUsers = [];
  List data=[];



  @override
  Widget build(BuildContext context) {
    final _ogretmenModel = Provider.of<OgretmenModel>(context, listen: false);

    return  Scaffold(
      backgroundColor: Renkler.backGroundColor,
      appBar: AppBar(
        backgroundColor:  Colors.white,
        title: Text("Kişi Seç",
          style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.w700,
              fontFamily: "OpenSans",
              fontStyle: FontStyle.normal,
              fontSize: 21.7.spByWidth),
        ),
        leading: IconButton(
          icon: Platform.isAndroid ? Icon(
            Icons.arrow_back,
            color: Colors.deepPurpleAccent,
            size: 18.0.h,
          ): Icon(
            Icons.arrow_back_ios,
            color: Colors.deepPurpleAccent,
            size: 18.0.h,
          ) ,
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        elevation: 0.0,
        brightness: Brightness.light,


      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        color: Colors.white,
        child: StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance.collection('yonetici').snapshots(),
          builder: (BuildContext context,
              AsyncSnapshot<QuerySnapshot> snapshot) {
            if (!snapshot.hasData){
              return Center(child: CircularProgressIndicator(),);
            }
            final int cardLength = snapshot.data.docs.length;


            return ListView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: cardLength,
              itemBuilder: (_, int index) {

                final DocumentSnapshot _card = snapshot.data.docs[index];

                return ResimliCard(textSubtitle: null, textTitle: _card['adSoyad'].toString(), fontSize: 12.0.spByWidth,
                  img: "_card['avatarImageUrl'].toString()", tarih: null,
                  onPressed: (){

                    Navigator.of(context, rootNavigator: true).push(
                      MaterialPageRoute(
                        builder: (context) => ChangeNotifierProvider(
                          create: (context) => ChatViewModelYonetici(currentUser: _ogretmenModel.user, sohbetEdilenUser: Yonetici.fromMap(_card.data())),
                          child: SohbetPage(fotourl:  "_card['avatarImageUrl'].toString()",userad:  _card['adSoyad'].toString(),userid: _card['userId']),
                        ),
                      ),
                    );
                  },


                );

              },
            );

          },
        ),
      ),
    );
  }
}
