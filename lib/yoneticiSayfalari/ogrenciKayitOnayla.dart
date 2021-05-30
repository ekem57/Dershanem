import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dershane/common/alertokeycancel.dart';
import 'package:dershane/common/myButton.dart';
import 'package:dershane/common/ogrenciKabulAlertDialog.dart';
import 'package:dershane/common/ogrenciKayitKart.dart';
import 'package:dershane/common/resimli_card.dart';
import 'package:dershane/common/resimsizCard.dart';
import 'package:flutter/material.dart';
import 'package:dershane/extensions/size_extention.dart';

class OgrenciKayitOnayla extends StatefulWidget {
  @override
  _OgrenciKayitOnaylaState createState() => _OgrenciKayitOnaylaState();
}

class _OgrenciKayitOnaylaState extends State<OgrenciKayitOnayla> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Kayıt Olacak Öğrenciler"),
      ),
      body: ListView(
        children: [
          StreamBuilder<QuerySnapshot>(
            stream: FirebaseFirestore.instance.collection("ogrenci").where('hesapOnay',isEqualTo: false).snapshots(),
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

                  return OgrenciKayitKart(card: _card,onPressed: (){},);
                },
              );
            },
          ),
          SizedBox(
            height: 40.0.h,
          ),
        ],
      ),
    );
  }
}
