import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dershane/common/myButton.dart';
import 'package:dershane/common/myfloatingButton.dart';
import 'package:dershane/common/resimsizCard.dart';
import 'package:dershane/extensions/renkler.dart';
import 'package:dershane/firebase/firebase_database.dart';
import 'package:dershane/locator.dart';
import 'package:flutter/material.dart';
import 'package:dershane/extensions/size_extention.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:intl/intl.dart';


class OgretmenDanismanlikAta extends StatefulWidget {
  final DocumentSnapshot card;

  OgretmenDanismanlikAta({ @required this.card});
  @override
  _OgretmenDanismanlikAtaState createState() => _OgretmenDanismanlikAtaState();
}

class _OgretmenDanismanlikAtaState extends State<OgretmenDanismanlikAta> with SingleTickerProviderStateMixin {
  TabController _tabController;
  String dogumtarih;
  @override
  void initState() {
    super.initState();
    _tabController = new TabController(length: 2, vsync: this);

    _tabController.addListener(() {
      setState(() {
        print("Tab Index ${_tabController.index}");
      });
    });
    final DateFormat formatter = DateFormat('yyyy-MM-dd');
    dogumtarih = formatter.format(widget.card['dogumTarihi'].toDate());

  }

  FirestoreDBService _firebaseIslemleri = locator<FirestoreDBService>();

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor:  Renkler.appbarGroundColor,
      appBar: AppBar(
        title: Row(
          children: [
            CircleAvatar(
              backgroundImage: widget.card['avatarImageUrl'].toString() == "null" ? AssetImage("assets/image/userprofil.png") :  NetworkImage(widget.card['avatarImageUrl']),
              radius: 26.0,
            ),
            Padding(
              padding: EdgeInsets.only(right: 20.0.w),
              child: Container(
                width: MediaQuery.of(context).size.width-200,
                child: Padding(
                  padding:  EdgeInsets.only(left: 10.0.w),
                  child: Text(widget.card['adSoyad'],
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
        child:  ListView(
          children: [
            StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance
                  .collection('siniflar').snapshots(),
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
                    return  _card['danismanvarmi'] ?
                    Container() :
                    Slidable(
                      actionPane: SlidableDrawerActionPane(),
                      actionExtentRatio: 0.45,
                      child: ResimsizCard(
                          baslik: _card['sinif'].toString(),
                          icerik: "",
                          tarih: "",
                          onPressed: () async {
                            Map<String, dynamic> SinifAta = Map();

                            SinifAta['sinif'] = _card['sinif'].toString();


                          await  _firebaseIslemleri.ogretmeneSinifAta(SinifAta,_card.id,widget.card.id,widget.card['adSoyad'].toString());

                          Navigator.pop(context);

                          },
                         ),
                      secondaryActions: <Widget>[

                        Container(
                          height: 70.0.h,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(20.70)),

                          ),
                          child: IconSlideAction(
                              caption: 'Sil',
                              color: Colors.red,
                              icon: Icons.delete,
                              onTap: () async {
                                _card.reference.delete();
                                setState(() {

                                });
                              }
                          ),
                        ),
                      ],
                    );

                  },
                );
              },
            ),
          ],
        ),
      ),
    );
  }


}
