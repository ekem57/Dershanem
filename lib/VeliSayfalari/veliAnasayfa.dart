import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dershane/common/duyuruCard.dart';
import 'package:dershane/common/duyuruSayfasi.dart';
import 'package:dershane/user_state/veli_model_service.dart';
import 'package:flutter/material.dart';
import 'package:dershane/extensions/size_extention.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class VeliAnasayfa extends StatefulWidget {
  @override
  _VeliAnasayfaState createState() => _VeliAnasayfaState();
}

class _VeliAnasayfaState extends State<VeliAnasayfa> {
  @override
  Widget build(BuildContext context) {
    final _veliModel = Provider.of<VeliModel>(context, listen: true);
    return Scaffold(
      appBar: AppBar(
       title: Row(

          children: [
            Text("Duyurular"),
            SizedBox(width: 170.0.w,),
            Align(
              alignment: Alignment.bottomRight,
              child: Padding(
                padding: const EdgeInsets.only(right: 20),
                child: IconButton(icon: Icon(Icons.exit_to_app,size: 40,), onPressed: (){
                  _veliModel.signOut();
                }),
              ),
            ),
          ],
        ),
      ),
      body: ListView(
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
    );
  }
}
