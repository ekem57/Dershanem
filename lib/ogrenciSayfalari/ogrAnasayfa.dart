import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dershane/common/duyuruCard.dart';
import 'package:dershane/common/duyuruSayfasi.dart';
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


class OgrenciAnasayfa extends StatefulWidget {
  final DocumentSnapshot card;

  OgrenciAnasayfa({ @required this.card});
  @override
  _OgrenciAnasayfaState createState() => _OgrenciAnasayfaState();
}

class _OgrenciAnasayfaState extends State<OgrenciAnasayfa> with SingleTickerProviderStateMixin {
  

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
        title: Text("Duyurular"),
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
          child:  Column(
            children: [

              StreamBuilder<QuerySnapshot>(
                stream: FirebaseFirestore.instance
                    .collection('duyurular').snapshots(),
                builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
                  if (!snapshot.hasData) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  final int cardLength = snapshot.data.docs.length;

                  return ListView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: cardLength,
                    itemBuilder: (_, int index) {
                      final DocumentSnapshot _card = snapshot.data.docs[index];
                      final DateFormat formatter = DateFormat('yyyy-MM-dd');
                      String  tarih = formatter.format(_card['tarih'].toDate());
                      return DuyuruCard(baslik: _card['baslik'], icerik: _card['aciklama'], onPressed: (){

                        Navigator.of(context).push(MaterialPageRoute(builder: (context) => DuyuruDetaySayfasi(card: _card,)));

                      },tarih: tarih,);

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
