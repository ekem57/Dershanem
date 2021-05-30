import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dershane/common/loadingscreen.dart';
import 'package:dershane/common/myButton.dart';
import 'package:dershane/common/myfloatingButton.dart';
import 'package:dershane/common/resimli_card.dart';
import 'package:dershane/extensions/renkler.dart';
import 'package:dershane/firebase/firebase_database.dart';
import 'package:dershane/kullaniciSayfalari/ogrenciSayfasi.dart';
import 'package:dershane/kullaniciSayfalari/ogretmenSayfasi.dart';
import 'package:dershane/kullaniciSayfalari/veliSayfasi.dart';
import 'package:dershane/locator.dart';
import 'package:dershane/user_state/yonetici_model_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:dershane/extensions/size_extention.dart';

class OgrenciSec extends StatefulWidget {
  final DocumentSnapshot card;
  OgrenciSec({this.card});
  @override
  _OgrenciSecState createState() => _OgrenciSecState();
}

class _OgrenciSecState extends State<OgrenciSec> with SingleTickerProviderStateMixin {
  TabController _tabController;

  FirestoreDBService _firebaseIslemleri = locator<FirestoreDBService>();


  List<String> ogrenciList=[];
   List<String> ogrenciSecilenler=[];


  @override
  void initState() {
    super.initState();
    _tabController = new TabController(length: 2, vsync: this);

    FirebaseFirestore.instance.collection("ogrenci").get().then((value) {
      for(DocumentSnapshot item in value.docs){
        ogrenciList.add(item.id);
      }
    });


    print("gelen widget card ogrenci sec:"+widget.card['danisman'].toString());
  }


  bool _loadingVisible = false;
  Future<void> _changeLoadingVisible() async {
    setState(() {
      _loadingVisible = !_loadingVisible;
    });
  }

  @override
  Widget build(BuildContext context) {
    final _yoneticiModel = Provider.of<YoneticiModel>(context, listen: false);


    return Scaffold(
      backgroundColor: Renkler.backGroundColor,
      appBar: AppBar(
        backgroundColor: Renkler.appbarGroundColor,
        elevation: 0,
        iconTheme: new IconThemeData(color: Colors.white),
        toolbarHeight: 70.0.h,
        title: Text(widget.card['sinif'].toString(),
            style: TextStyle(
                color: Renkler.appbarTextColor,
                fontWeight: FontWeight.w700,
                fontFamily: "OpenSans",
                fontStyle: FontStyle.normal,
                fontSize: 20.0),
            textAlign: TextAlign.center),

      ),
      body:  LoadingScreen(
        inAsyncCall: _loadingVisible,
        child: ClipRRect(
          borderRadius: BorderRadius.only(topLeft: Radius.circular(40), topRight: Radius.circular(40)),
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.1),
                  spreadRadius: 8,
                  blurRadius: 7,
                  offset: Offset(0, 1), // changes position of shadow
                ),
              ],
            ),
            child: Column(
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
                      Tab(child: Text("Sınıfı Olmayanlar")),
                      Tab(child: Text("Sınıfı Olanlar",style: TextStyle(fontSize: 14),)),
                    ],
                  ),
                ),
                Expanded(
                  child: TabBarView(
                    controller: _tabController,
                    children: [
                      ListView(
                        children: [
                          FutureBuilder<QuerySnapshot>(
                            future: FirebaseFirestore.instance.collection("ogrenci").where("dershaneSinifi",isEqualTo: "Atanmadı").get(),
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



                                  return ResimliCard(
                                      textSubtitle: null,
                                      textTitle: _card['adSoyad'].toString(),
                                      color: ogrenciSecilenler.contains(_card.id) ? Colors.green : Colors.white ,
                                      onPressed: () {

                                        if(!ogrenciSecilenler.contains(_card.id)){
                                          ogrenciSecilenler.add(_card.id);
                                          setState(() {

                                          });
                                        }

                                      },
                                      fontSize: 12,
                                      img: _card['avatarImageUrl'].toString(),
                                      tarih: null);
                                },
                              );
                            },
                          ),
                          SizedBox(height: 30,),
                          ogrenciSecilenler.length != 0 ?   Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 30),
                            child: MyButton(text: "Öğrencileri Ata", textColor: Colors.black, fontSize: 16.0.spByWidth, width: 260.0.w, height: 45.0.h,onPressed: () async {
                              bool veri;
                              SystemChannels.textInput.invokeMethod('TextInput.hide');
                              await _changeLoadingVisible();

                              for(String item in ogrenciSecilenler) {
                                Map<String, dynamic> SinifOgrenciAta = Map();

                                SinifOgrenciAta['userid'] = item;


                                veri =  await _firebaseIslemleri.sinifOgrenciAta(SinifOgrenciAta, widget.card);
                              }
                              if(veri)
                              {
                                await _changeLoadingVisible();
                                Fluttertoast.showToast(
                                  msg: "Oğrenciler Atandı.",
                                  toastLength: Toast.LENGTH_LONG,
                                  gravity: ToastGravity.BOTTOM,
                                  textColor: Colors.white,
                                  backgroundColor: Colors.green,
                                );

                              }

                            },),
                          ) : Container(
                            child: Center(child: Text("Sınıfı Olmayan Öğrenci Yok..",style: TextStyle(fontSize: 20.0.spByWidth,fontWeight: FontWeight.bold),),),
                          ),


                          SizedBox(height: 100,),
                        ],
                      ),
                      ListView(
                        children: [
                          FutureBuilder<QuerySnapshot>(
                            future: FirebaseFirestore.instance.collection("ogrenci").where("dershaneSinifi",isNotEqualTo: "Atanmadı").get(),
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

                                  return ResimliCard(
                                      textSubtitle: null,
                                      textTitle: _card['adSoyad'].toString(),
                                      color: ogrenciSecilenler.contains(_card.id) ? Colors.green : Colors.white ,
                                      onPressed: () {
                                        if(!ogrenciSecilenler.contains(_card.id)){
                                          ogrenciSecilenler.add(_card.id);
                                          setState(() {

                                          });
                                        }


                                        print(ogrenciSecilenler.length);


                                      },
                                      fontSize: 12,
                                      img: _card['avatarImageUrl'].toString(),
                                      tarih: null);
                                },
                              );
                            },
                          ),
                          SizedBox(height: 30,),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 30),
                            child: MyButton(text: "Öğrencileri Ata", textColor: Colors.black, fontSize: 16.0.spByWidth, width: 260.0.w, height: 45.0.h,onPressed: () async {
                              bool veri;
                              SystemChannels.textInput.invokeMethod('TextInput.hide');
                              await _changeLoadingVisible();

                              for(String item in ogrenciSecilenler) {
                                Map<String, dynamic> SinifOgrenciAta = Map();

                                SinifOgrenciAta['userid'] = item;

                               veri =  await _firebaseIslemleri.sinifOgrenciAta(SinifOgrenciAta, widget.card);
                              }
                              if(veri)
                              {
                                await _changeLoadingVisible();
                                Fluttertoast.showToast(
                                  msg: "Oğrenciler Atandı.",
                                  toastLength: Toast.LENGTH_LONG,
                                  gravity: ToastGravity.BOTTOM,
                                  textColor: Colors.white,
                                  backgroundColor: Colors.green,
                                );

                              }

                            },),
                          ),


                          SizedBox(height: 100,),
                        ],
                      ),

                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }


}
