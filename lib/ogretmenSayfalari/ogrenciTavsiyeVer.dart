import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dershane/common/duyuruSayfasi.dart';
import 'package:dershane/common/loadingscreen.dart';
import 'package:dershane/common/myButton.dart';
import 'package:dershane/common/resimli_card.dart';
import 'package:dershane/common/resimsizCard.dart';
import 'package:dershane/extensions/renkler.dart';
import 'package:dershane/firebase/firebase_database.dart';
import 'package:dershane/locator.dart';
import 'package:dershane/ogretmenSayfalari/ogretmenTavsiyeVer.dart';
import 'package:flutter/material.dart';
import 'package:dershane/extensions/size_extention.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';


class OgrenciTavsiyeVer extends StatefulWidget {
  final DocumentSnapshot card;

  OgrenciTavsiyeVer({ @required this.card});
  @override
  _OgrenciTavsiyeVerState createState() => _OgrenciTavsiyeVerState();
}

class _OgrenciTavsiyeVerState extends State<OgrenciTavsiyeVer> with SingleTickerProviderStateMixin {


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
        title: Text("Öğrenci Tavsiye Ver"),
        elevation: 0.0,
        brightness: Brightness.dark,
        toolbarHeight: 80.0.h,
        backgroundColor: Renkler.appbarGroundColor,
      ),

      body: LoadingScreen(
        inAsyncCall: _loadingVisible,
        child: Container(
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

              FutureBuilder<QuerySnapshot>(
                future: FirebaseFirestore.instance.collection("ogrenci").get(),
                builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
                  if (!snapshot.hasData)
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  final int cardLength = snapshot.data.docs.length;
                  return ListView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: cardLength,
                    itemBuilder: (_, int index) {
                      final DocumentSnapshot _card = snapshot.data.docs[index];

                      return ResimliCard(
                          textSubtitle: null,
                          textTitle: _card['adSoyad'].toString(),
                          onPressed: () {

                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => OgretmenTavsiyeVer(
                                      card: _card,
                                    )));

                          },
                          fontSize: 12,
                          img: _card['avatarImageUrl'].toString(),
                          tarih: null);
                    },
                  );
                },
              ),
              SizedBox(height: 40.0.h,),

            ],
          ),
        ),
      ),
    );
  }


}
