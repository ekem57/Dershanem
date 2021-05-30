import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dershane/common/resimsizCard.dart';
import 'package:flutter/material.dart';

class OgrencilerSinifAtamasi extends StatefulWidget {
  @override
  _OgrencilerSinifAtamasiState createState() => _OgrencilerSinifAtamasiState();
}

class _OgrencilerSinifAtamasiState extends State<OgrencilerSinifAtamasi> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:  FutureBuilder<QuerySnapshot>(
        future: FirebaseFirestore.instance.collection("siniflar").get(),
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

              return ResimsizCard(baslik: _card['sinif'].toString(), icerik:'', onPressed: (){



              });
            },
          );
        },
      ),
    );
  }
}
