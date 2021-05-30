import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dershane/common/resimli_card.dart';
import 'package:dershane/common/resimsizCard.dart';
import 'package:flutter/material.dart';
import 'package:dershane/extensions/size_extention.dart';

class YoneticiKayitOnayla extends StatefulWidget {
  @override
  _YoneticiKayitOnaylaState createState() => _YoneticiKayitOnaylaState();
}

class _YoneticiKayitOnaylaState extends State<YoneticiKayitOnayla> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Yönetici Kayıt"),
      ),
      body: ListView(
        children: [
          FutureBuilder<QuerySnapshot>(
            future: FirebaseFirestore.instance.collection("yonetici").where('hesapOnay',isEqualTo: false).get(),
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

                  return ResimsizCard(
                      icerik: "",
                      baslik: _card['adSoyad'].toString(),
                      tarih: "",
                      onPressed: () {

                      },
                  );
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
