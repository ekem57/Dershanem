import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dershane/common/dersProgramiCard.dart';
import 'package:dershane/common/myButton.dart';
import 'package:dershane/common/myfloatingButton.dart';
import 'package:dershane/common/resimsizCard.dart';
import 'package:dershane/extensions/renkler.dart';
import 'package:dershane/firebase/firebase_database.dart';
import 'package:dershane/locator.dart';
import 'package:dershane/yoneticiSayfalari/ogretmeneDanismanlikAta.dart';
import 'package:flutter/material.dart';
import 'package:dershane/extensions/size_extention.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:intl/intl.dart';


class OgretmenDetaySayfasi extends StatefulWidget {
  final DocumentSnapshot card;

  OgretmenDetaySayfasi({ @required this.card});
  @override
  _OgretmenDetaySayfasiState createState() => _OgretmenDetaySayfasiState();
}

class _OgretmenDetaySayfasiState extends State<OgretmenDetaySayfasi> with SingleTickerProviderStateMixin {
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

  FirestoreDBService _firestoreDBService = locator<FirestoreDBService>();
  PageController _controller = PageController(initialPage: 0);
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      floatingActionButton:
      MyFloatingButton(tabController: _tabController, pushableScreens: [OgretmenDanismanlikAta(card: widget.card,),Container()]),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
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
                  Tab(child: Text("Ders Programı",style: TextStyle(fontSize: 15.0.spByWidth),)),
                ],
              ),
            ),
            Expanded(
              child: TabBarView(
                controller: _tabController,
                children: [

                  ListView(children: [
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
                        Text(widget.card['cinsiyet'],style: TextStyle(fontSize: 16.0.spByWidth,fontWeight: FontWeight.bold),),
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
                        Text("Brans:",style: TextStyle(fontSize: 16.0.spByWidth,fontWeight: FontWeight.bold),),
                        SizedBox(width: 20.0.w,),
                        Text(widget.card['brans'],style: TextStyle(fontSize: 16.0.spByWidth,fontWeight: FontWeight.bold),),
                      ],),
                    ),
                    SizedBox(height: 30.0.h,),
                    Center(child: Text("Danısmanlıkları",style: TextStyle(fontSize: 20.0.spByWidth,fontWeight: FontWeight.bold),)),

                    StreamBuilder<QuerySnapshot>(
                      stream: FirebaseFirestore.instance
                          .collection('ogretmen').doc(widget.card.id).collection("danismanliklar").snapshots(),
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
                            return Slidable(
                              actionPane: SlidableDrawerActionPane(),
                              actionExtentRatio: 0.45,
                              child: ResimsizCard(
                                baslik: _card['sinif'].toString(),
                                icerik: "",
                                tarih: "",
                                onPressed: () async {


                                },
                              ),
                              secondaryActions: <Widget>[

                                Container(
                                  height: 70,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.all(Radius.circular(20.70)),

                                  ),
                                  child: IconSlideAction(
                                      caption: 'Sil',
                                      color: Colors.red,
                                      icon: Icons.delete,
                                      onTap: () async {
                                         await _firestoreDBService.ogretmenDanismanlikSil(_card);
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






                  ],),
                  PageView(
                    scrollDirection: Axis.horizontal,
                    controller: _controller,
                    children: <Widget>[
                      pazartesi(),
                      sali(),
                      carsamba(),
                      persembe(),
                      cuma(),
                      cumartesi(),
                      pazar(),
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

  Widget pazartesi() {
    return ListView(
      children: [
        Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height - 80,
          margin: EdgeInsets.only(top: 12.70),

          child: Column(
            children: [
              Center(
                child: Text("Pazartesi",
                    style: const TextStyle(
                        color: const Color(0xff343633),
                        fontWeight: FontWeight.w700,
                        fontFamily: "OpenSans",
                        fontStyle: FontStyle.italic,
                        fontSize: 25.0),
                    textAlign: TextAlign.center),
              ),

              DersProgramiCard(sinif: "MF-4",saatbaslangic: "09:00",saatbitis: "09:40",ders: "Karekök alma işlemleri",),
              DersProgramiCard(sinif: "MF-4",saatbaslangic: "09:50",saatbitis: "10:30",ders: "İntegral giriş",),
              DersProgramiCard(sinif: "MF-4",saatbaslangic: "12:30",saatbitis: "13:10",ders: "Türev giriş",),


            ],
          ),
        ),
      ],
    );
  }

  Widget sali() {
    return ListView(
      children: [
        Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height - 80,
          margin: EdgeInsets.only(top: 12.70),

          child: Column(
            children: [
              Center(
                child: Text("Salı",
                    style: const TextStyle(
                        color: const Color(0xff343633),
                        fontWeight: FontWeight.w700,
                        fontFamily: "OpenSans",
                        fontStyle: FontStyle.italic,
                        fontSize: 25.0),
                    textAlign: TextAlign.center),
              ),

              DersProgramiCard(sinif: "TM-6",saatbaslangic: "09:00",saatbitis: "09:40",ders: "Karekök alma işlemleri",),
              DersProgramiCard(sinif: "TM-6",saatbaslangic: "09:50",saatbitis: "10:30",ders: "İntegral giriş",),
              DersProgramiCard(sinif: "TM-6",saatbaslangic: "12:30",saatbitis: "13:10",ders: "Türev giriş",),


            ],
          ),
        ),
      ],
    );
  }


  Widget carsamba() {
    return ListView(
      children: [
        Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height - 80,
          margin: EdgeInsets.only(top: 12.70),

          child: Column(
            children: [
              Center(
                child: Text("Çarşamba",
                    style: const TextStyle(
                        color: const Color(0xff343633),
                        fontWeight: FontWeight.w700,
                        fontFamily: "OpenSans",
                        fontStyle: FontStyle.italic,
                        fontSize: 25.0),
                    textAlign: TextAlign.center),
              ),

              DersProgramiCard(sinif: "MF-4",saatbaslangic: "09:00",saatbitis: "09:40",ders: "Karekök alma işlemleri",),
              DersProgramiCard(sinif: "MF-4",saatbaslangic: "09:50",saatbitis: "10:30",ders: "İntegral giriş",),
              DersProgramiCard(sinif: "MF-4",saatbaslangic: "12:30",saatbitis: "13:10",ders: "Türev giriş",),


            ],
          ),
        ),
      ],
    );
  }


  Widget persembe() {
    return ListView(
      children: [
        Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height - 80,
          margin: EdgeInsets.only(top: 12.70),

          child: Column(
            children: [
              Center(
                child: Text("Perşembe",
                    style: const TextStyle(
                        color: const Color(0xff343633),
                        fontWeight: FontWeight.w700,
                        fontFamily: "OpenSans",
                        fontStyle: FontStyle.italic,
                        fontSize: 25.0),
                    textAlign: TextAlign.center),
              ),

              DersProgramiCard(sinif: "MF-4",saatbaslangic: "09:00",saatbitis: "09:40",ders: "Karekök alma işlemleri",),
              DersProgramiCard(sinif: "MF-4",saatbaslangic: "09:50",saatbitis: "10:30",ders: "İntegral giriş",),
              DersProgramiCard(sinif: "MF-4",saatbaslangic: "12:30",saatbitis: "13:10",ders: "Türev giriş",),


            ],
          ),
        ),
      ],
    );
  }


  Widget cuma() {
    return ListView(
      children: [
        Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height - 80,
          margin: EdgeInsets.only(top: 12.70),

          child: Column(
            children: [
              Center(
                child: Text("Cuma",
                    style: const TextStyle(
                        color: const Color(0xff343633),
                        fontWeight: FontWeight.w700,
                        fontFamily: "OpenSans",
                        fontStyle: FontStyle.italic,
                        fontSize: 25.0),
                    textAlign: TextAlign.center),
              ),

              DersProgramiCard(sinif: "MF-4",saatbaslangic: "09:00",saatbitis: "09:40",ders: "Karekök alma işlemleri",),
              DersProgramiCard(sinif: "MF-4",saatbaslangic: "09:50",saatbitis: "10:30",ders: "İntegral giriş",),
              DersProgramiCard(sinif: "MF-4",saatbaslangic: "12:30",saatbitis: "13:10",ders: "Türev giriş",),


            ],
          ),
        ),
      ],
    );
  }


  Widget cumartesi() {
    return ListView(
      children: [
        Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height - 80,
          margin: EdgeInsets.only(top: 12.70),

          child: Column(
            children: [
              Center(
                child: Text("Cumartesi",
                    style: const TextStyle(
                        color: const Color(0xff343633),
                        fontWeight: FontWeight.w700,
                        fontFamily: "OpenSans",
                        fontStyle: FontStyle.italic,
                        fontSize: 25.0),
                    textAlign: TextAlign.center),
              ),

              DersProgramiCard(sinif: "MF-4",saatbaslangic: "09:00",saatbitis: "09:40",ders: "Karekök alma işlemleri",),
              DersProgramiCard(sinif: "MF-4",saatbaslangic: "09:50",saatbitis: "10:30",ders: "İntegral giriş",),
              DersProgramiCard(sinif: "MF-4",saatbaslangic: "12:30",saatbitis: "13:10",ders: "Türev giriş",),


            ],
          ),
        ),
      ],
    );
  }

  Widget pazar() {
    return ListView(
      children: [
        Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height - 80,
          margin: EdgeInsets.only(top: 12.70),

          child: Column(
            children: [
              Center(
                child: Text("Pazar",
                    style: const TextStyle(
                        color: const Color(0xff343633),
                        fontWeight: FontWeight.w700,
                        fontFamily: "OpenSans",
                        fontStyle: FontStyle.italic,
                        fontSize: 25.0),
                    textAlign: TextAlign.center),
              ),

              DersProgramiCard(sinif: "MF-4",saatbaslangic: "09:00",saatbitis: "09:40",ders: "Karekök alma işlemleri",),
              DersProgramiCard(sinif: "MF-4",saatbaslangic: "09:50",saatbitis: "10:30",ders: "İntegral giriş",),
              DersProgramiCard(sinif: "MF-4",saatbaslangic: "12:30",saatbitis: "13:10",ders: "Türev giriş",),


            ],
          ),
        ),
      ],
    );
  }
}
