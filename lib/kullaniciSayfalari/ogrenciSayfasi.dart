import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dershane/common/myButton.dart';
import 'package:dershane/common/sinavSonucCard.dart';
import 'package:dershane/extensions/renkler.dart';
import 'package:flutter/material.dart';
import 'package:dershane/extensions/size_extention.dart';
import 'package:intl/intl.dart';


class OgrenciDetaySayfasi extends StatefulWidget {
  final DocumentSnapshot card;

  OgrenciDetaySayfasi({ @required this.card});
  @override
  _OgrenciDetaySayfasiState createState() => _OgrenciDetaySayfasiState();
}

class _OgrenciDetaySayfasiState extends State<OgrenciDetaySayfasi> with SingleTickerProviderStateMixin {
  TabController _tabController;
  String dogumtarih;
  @override
  void initState() {
    super.initState();
    _tabController = new TabController(length: 3, vsync: this);

    _tabController.addListener(() {
      setState(() {
        print("Tab Index ${_tabController.index}");
      });
    });
    final DateFormat formatter = DateFormat('yyyy-MM-dd');
     dogumtarih = formatter.format(widget.card['dogumTarihi'].toDate());

  }

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
                  Tab(child: Text("Bilgileri")),
                  Tab(child: Text("Sınav Sonuçları",style: TextStyle(fontSize: 12.0.spByWidth),)),
                  Tab(child: Text("Tavsiyeler")),
                ],
              ),
            ),
            Expanded(
              child: TabBarView(
                controller: _tabController,
                children: [

                   Column(children: [
                     Padding(
                       padding:  EdgeInsets.symmetric(horizontal: 30.0.w),
                       child: Row(children: [
                         Text("E-mail:",style: TextStyle(fontSize: 16.0.spByWidth,fontWeight: FontWeight.bold),),
                         SizedBox(width: 20.0.w,),
                         Text(widget.card['email'],style: TextStyle(fontSize: 16.0.spByWidth,fontWeight: FontWeight.bold),),
                       ],),
                     ),

                     SizedBox(height: 10.0.h,),

                     Padding(
                       padding:  EdgeInsets.symmetric(horizontal: 30.0.w),
                       child: Row(children: [
                         Text("Telefon:",style: TextStyle(fontSize: 16.0.spByWidth,fontWeight: FontWeight.bold),),
                         SizedBox(width: 20.0.w,),
                         Text(widget.card['telefon'],style: TextStyle(fontSize: 16.0.spByWidth,fontWeight: FontWeight.bold),),
                       ],),
                     ),

                     SizedBox(height: 10.0.h,),

                     Padding(
                       padding:  EdgeInsets.symmetric(horizontal: 30.0.w),
                       child: Row(children: [
                         Text("Cinsiyet:",style: TextStyle(fontSize: 16.0.spByWidth,fontWeight: FontWeight.bold),),
                         SizedBox(width: 20.0.w,),
                         Text(widget.card['cinsiyet'].toString(),style: TextStyle(fontSize: 16.0.spByWidth,fontWeight: FontWeight.bold),),
                       ],),
                     ),

                     SizedBox(height: 10.0.h,),

                     Padding(
                       padding:  EdgeInsets.symmetric(horizontal: 30.0.w),
                       child: Row(children: [
                         Text("Doğum Tarihi:",style: TextStyle(fontSize: 16.0.spByWidth,fontWeight: FontWeight.bold),),
                         SizedBox(width: 20.0.w,),
                         Text(dogumtarih,style: TextStyle(fontSize: 16.0.spByWidth,fontWeight: FontWeight.bold),),
                       ],),
                     ),

                     SizedBox(height: 10.0.h,),


                     Padding(
                       padding:  EdgeInsets.symmetric(horizontal: 30.0.w),
                       child: Row(children: [
                         Text("Danışman:",style: TextStyle(fontSize: 16.0.spByWidth,fontWeight: FontWeight.bold),),
                         SizedBox(width: 20.0.w,),
                         Text(widget.card['danisman'].toString(),style: TextStyle(fontSize: 16.0.spByWidth,fontWeight: FontWeight.bold),),
                       ],),
                     ),

                     SizedBox(height: 10.0.h,),

                     Padding(
                       padding:  EdgeInsets.symmetric(horizontal: 30.0.w),
                       child: Row(children: [
                         Text("Sınıfı:",style: TextStyle(fontSize: 16.0.spByWidth,fontWeight: FontWeight.bold),),
                         SizedBox(width: 20.0.w,),
                         Text(widget.card['dershaneSinifi'].toString(),style: TextStyle(fontSize: 16.0.spByWidth,fontWeight: FontWeight.bold),),
                       ],),
                     ),

                     

                     SizedBox(height: 10.0.h,),

                     Padding(
                       padding:  EdgeInsets.symmetric(horizontal: 30.0.w),
                       child: Row(children: [
                         Text("Sınıf:",style: TextStyle(fontSize: 16.0.spByWidth,fontWeight: FontWeight.bold),),
                         SizedBox(width: 20.0.w,),
                         Text(widget.card['sinif'].toString(),style: TextStyle(fontSize: 16.0.spByWidth,fontWeight: FontWeight.bold),),
                       ],),
                     ),

                     SizedBox(height: 10.0.h,),

                     Padding(
                       padding:  EdgeInsets.symmetric(horizontal: 30.0.w),
                       child: Row(children: [
                         Text("Bölüm:",style: TextStyle(fontSize: 16.0.spByWidth,fontWeight: FontWeight.bold),),
                         SizedBox(width: 20.0.w,),
                         Text(widget.card['bolum'].toString(),style: TextStyle(fontSize: 16.0.spByWidth,fontWeight: FontWeight.bold),),
                       ],),
                     ),




                     SizedBox(height: 10.0.h,),

                     Padding(
                       padding:  EdgeInsets.symmetric(horizontal: 30.0.w),
                       child: Row(children: [
                         Text("Öğrenci Numarası:",style: TextStyle(fontSize: 16.0.spByWidth,fontWeight: FontWeight.bold),),
                         SizedBox(width: 20.0.w,),
                         Text(widget.card['ogrenciNo'].toString(),style: TextStyle(fontSize: 16.0.spByWidth,fontWeight: FontWeight.bold),),
                       ],),
                     ),


                     SizedBox(height: 10.0.h,),

                     Padding(
                       padding:  EdgeInsets.symmetric(horizontal: 30.0.w),
                       child: Row(children: [
                         Text("Okul:",style: TextStyle(fontSize: 16.0.spByWidth,fontWeight: FontWeight.bold),),
                         SizedBox(width: 20.0.w,),
                         Text(widget.card['okul'].toString(),style: TextStyle(fontSize: 16.0.spByWidth,fontWeight: FontWeight.bold),),
                       ],),
                     ),



                   ],),
                  Column(
                    children: [
                      SinavSonucCard(baslik: "",),
                      SinavSonucCard(baslik: "",),
                    ],
                  ),
                  _buildYorumlar(),

                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildYorumlar() {

    return StreamBuilder<QuerySnapshot>(
      stream:
      FirebaseFirestore.instance.collection("ogrenci").doc(widget.card['userId']).collection("tavsiyeler").orderBy("tarih",descending: false).snapshots(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
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
            final DocumentSnapshot _cardYonetici = snapshot.data.docs[index];
            return StreamBuilder<DocumentSnapshot>(
              stream: FirebaseFirestore.instance.collection("ogretmen").doc(_cardYonetici['ogretmenId']).snapshots(),
              builder: (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }


                return ListView.builder(
                  padding: EdgeInsets.all(0),
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: 1,
                  itemBuilder: (_, int index) {
                    final DocumentSnapshot _card = snapshot.data;


                    final gun = _cardYonetici['tarih'].toDate();
                    final bugun = DateTime.now();
                    final difference = bugun.difference(gun).inDays;
                    return Container(
                      padding: EdgeInsets.symmetric(horizontal: 16.0.w),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ListTile(
                            contentPadding: EdgeInsets.symmetric(horizontal: 0.0.w),
                            title: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(_card['adSoyad'].toString(),
                                    style: TextStyle(
                                        color: const Color(0xff343633),
                                        fontWeight: FontWeight.w600,
                                        fontFamily: "OpenSans",
                                        fontStyle: FontStyle.normal,
                                        fontSize: 15.3.spByWidth),
                                    textAlign: TextAlign.left),

                                Text(_card['brans'].toString(),
                                    style: TextStyle(
                                        color: const Color(0xff343633),
                                        fontWeight: FontWeight.w600,
                                        fontFamily: "OpenSans",
                                        fontStyle: FontStyle.normal,
                                        fontSize: 13.3.spByWidth),
                                    textAlign: TextAlign.left),
                              ],
                            ),
                            leading: CircleAvatar(
                              backgroundColor: Colors.white,
                              backgroundImage: _card['avatarImageUrl'].toString() == "null" ? _card['avatarImageUrl'].toString() == "" ? AssetImage("assets/image/userprofil.png") : AssetImage("assets/image/userprofil.png")  : NetworkImage(_card['avatarImageUrl'].toString()),
                              radius: 20.0.h,
                            ),

                            trailing: difference < 0 ? Text(difference.abs().toString() + " gün önce",
                                style: TextStyle(
                                    color: const Color(0xff343633),
                                    fontWeight: FontWeight.w400,
                                    fontFamily: "OpenSans",
                                    fontStyle: FontStyle.normal,
                                    fontSize: 12.0.spByWidth),
                                textAlign: TextAlign.right) :
                            Text(difference.toString() + " gün sonra",
                                style: TextStyle(
                                    color: const Color(0xff343633),
                                    fontWeight: FontWeight.w400,
                                    fontFamily: "OpenSans",
                                    fontStyle: FontStyle.normal,
                                    fontSize: 12.0.spByWidth),
                                textAlign: TextAlign.right),
                          ),
                          Text(
                            _cardYonetici['tavsiye'] != null ? _cardYonetici['tavsiye'].toString() : "",
                            style:  TextStyle(
                                color: const Color(0xff343633),
                                fontWeight: FontWeight.w400,
                                fontFamily: "OpenSans",
                                fontStyle: FontStyle.normal,
                                fontSize: 15.3.spByWidth),
                          ),
                          Divider(),
                        ],
                      ),
                    );
                  },
                );
              },
            );
          },
        );
      },
    );
  }

}
