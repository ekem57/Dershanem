import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dershane/common/ogretmenKayitKart.dart';
import 'package:flutter/material.dart';
import 'package:dershane/extensions/size_extention.dart';

class OgretmenKayitOnayla extends StatefulWidget {
  @override
  _OgretmenKayitOnaylaState createState() => _OgretmenKayitOnaylaState();
}

class _OgretmenKayitOnaylaState extends State<OgretmenKayitOnayla> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Öğretmen Kayıt"),
      ),
      body: ListView(
        children: [
          FutureBuilder<QuerySnapshot>(
            future: FirebaseFirestore.instance.collection("ogretmen").where('hesapOnay',isEqualTo: false).get(),
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

                  return OgretmenKayitKart(card: _card,onPressed: (){
                    setState(() {

                    });
                  },);
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
