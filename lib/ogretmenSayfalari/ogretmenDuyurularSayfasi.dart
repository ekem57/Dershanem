import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dershane/common/duyuruCard.dart';
import 'package:dershane/common/duyuruSayfasi.dart';
import 'package:dershane/common/myButton.dart';
import 'package:dershane/common/resimsizCard.dart';
import 'package:dershane/common/sinavSonucCard.dart';
import 'package:dershane/extensions/renkler.dart';
import 'package:flutter/material.dart';
import 'package:dershane/extensions/size_extention.dart';
import 'package:intl/intl.dart';


class OgretmenDuyurularSayfasi extends StatefulWidget {
  final DocumentSnapshot card;

  OgretmenDuyurularSayfasi({ @required this.card});
  @override
  _OgretmenDuyurularSayfasiState createState() => _OgretmenDuyurularSayfasiState();
}

class _OgretmenDuyurularSayfasiState extends State<OgretmenDuyurularSayfasi> with SingleTickerProviderStateMixin {
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



  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor:  Renkler.appbarGroundColor,
      appBar: AppBar(
        title: Row(
          children: [
            Padding(
              padding: EdgeInsets.only(right: 20.0.w),
              child: Container(
                width: MediaQuery.of(context).size.width-200,
                child: Padding(
                  padding:  EdgeInsets.only(left: 10.0.w),
                  child: Text("Duyurular",
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
        child:  Column(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(vertical: 16.0.h),
              child: TabBar(
                controller: _tabController,
                unselectedLabelColor: const Color(0xff343633),
                labelStyle: TextStyle(
                    color: Theme.of(context).primaryColor,
                    fontWeight: FontWeight.w700,
                    fontFamily: "OpenSans",
                    fontStyle: FontStyle.normal,
                    fontSize: 15.0.spByWidth),
                labelColor: Theme.of(context).primaryColor,
                indicatorSize: TabBarIndicatorSize.label,
                indicatorColor: Theme.of(context).buttonColor,
                onTap: (int index) {
                  setState(() {});
                },
                tabs: [
                  Tab(child: Text("Öğretmenlere Duyurular")),
                  Tab(child: Text("Genel Duyurular",style: TextStyle(fontSize: 15),)),
                ],
              ),
            ),
            Expanded(
              child: TabBarView(
                controller: _tabController,
                children: [

                  ListView(
                    children: [

                      StreamBuilder<QuerySnapshot>(
                        stream: FirebaseFirestore.instance
                            .collection('ogretmenlerDuyuru').snapshots(),
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
                    ListView(
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
                              return   DuyuruCard(baslik: _card['baslik'], icerik: _card['aciklama'], onPressed: (){
                                Navigator.of(context).push(MaterialPageRoute(builder: (context) => DuyuruDetaySayfasi(card: _card,)));
                              },tarih: tarih,);

                            },
                          );
                        },
                      ),
                      SizedBox(height: 40.0.h,),

                    ],
                  ),

                ],
              ),
            ),
          ],
        ),
      ),
    );
  }


}
