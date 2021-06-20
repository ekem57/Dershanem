import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dershane/common/dersProgramiCard.dart';
import 'package:dershane/common/duyuruSayfasi.dart';
import 'package:dershane/common/loadingscreen.dart';
import 'package:dershane/common/myButton.dart';
import 'package:dershane/common/resimsizCard.dart';
import 'package:dershane/common/sinavSonucCard.dart';
import 'package:dershane/extensions/renkler.dart';
import 'package:dershane/firebase/firebase_database.dart';
import 'package:dershane/locator.dart';
import 'package:dershane/user_state/ogrenci_model_service.dart';
import 'package:flutter/material.dart';
import 'package:dershane/extensions/size_extention.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';


class SinavNotlari extends StatefulWidget {
  final DocumentSnapshot card;

  SinavNotlari({ @required this.card});
  @override
  _SinavNotlariState createState() => _SinavNotlariState();
}

class _SinavNotlariState extends State<SinavNotlari> with SingleTickerProviderStateMixin {


  FirestoreDBService _firebaseIslemleri = locator<FirestoreDBService>();

  final sinifController = TextEditingController();


  PageController _controller = PageController(initialPage: 0);

  @override
  Widget build(BuildContext context) {
    final _ogrenciModel = Provider.of<OgrenciModel>(context, listen: true);
    return Scaffold(
      backgroundColor:  Renkler.appbarGroundColor,
      appBar: AppBar(
        title: Text("Deneme Sınavlarım"),
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
        child:
        StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance.collection("ogrenci").doc(_ogrenciModel.user.userId).collection("sinavnotlari").snapshots(),
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
            final DocumentSnapshot _card = snapshot.data.docs[index];
            return SinavSonucCard(baslik:_card['Sinav'],sayisalSonuc: _card['Sayisal'],esitSonuc:_card['EsitAgirlik'],sozelSonuc: _card['Sozel'],esitSiralama: _card['EsitAgirlikSiralama'],sayisalSiralama: _card['SayisalSiralama'],sozelSiralama: _card['SozelSiralama'],toplamkatilimci: _card['toplamkatilimci'].toString(),);
          },
        );
      },
    ),



      ),
    );
  }



}
