import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
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
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:provider/provider.dart';
import 'package:dershane/extensions/size_extention.dart';

class KullaniciIslemleri extends StatefulWidget {
  @override
  _KullaniciIslemleriState createState() => _KullaniciIslemleriState();
}

class _KullaniciIslemleriState extends State<KullaniciIslemleri> with SingleTickerProviderStateMixin {
  TabController _tabController;

  List secilenCinsiyet = List();
  List secilenYas = List();
  List secilenMeslekler = List();
  final aciklamaController = TextEditingController();

  final _firestore = FirebaseFirestore.instance;
  FirestoreDBService _firestoreDBService = locator<FirestoreDBService>();
  String _filtreCinsiyet = "yok";
  String _filtreSinif = "yok";
  String _filtreBolum = "yok";
  String _filtreOkul = "yok";

  List<String> _items = ['Erkek', 'Kadın'];
  List<String> _bolum = ["Matematik Fen","Türkçe Matematik", "Sözel"];
  List<String> _sinif = ["1.Sınıf", "2.Sınıf", "3.Sınıf", "4.Sınıf","5.Sınıf","6.Sınıf","7.Sınıf","8.Sınıf","9.Sınıf","10.Sınıf","11.Sınıf","12.Sınıf","Mezun"];
  static List<String> okulList=[];
  
  
  @override
  void initState() {
    super.initState();
    _tabController = new TabController(length: 3, vsync: this);
    okulList=["Seciniz"];
    _firestoreDBService.okulGetir().then(( value) {
      print("gelen okul son" + value.last);
      okulList.addAll(value);
    });
    _tabController.addListener(() {
      setState(() {
        print("Tab Index ${_tabController.index}");
      });
    });


  }



  @override
  Widget build(BuildContext context) {
    final _yoneticiModel = Provider.of<YoneticiModel>(context, listen: false);
    return Scaffold(
      floatingActionButton:
      MyFloatingButton(tabController: _tabController, pushableScreens: []),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      backgroundColor: Renkler.backGroundColor,
      appBar: AppBar(
        backgroundColor: Renkler.appbarGroundColor,
        elevation: 0,
        iconTheme: new IconThemeData(color: Colors.black),
        toolbarHeight: 70.0.h,
        title: Text("Üye İşlemleri",
            style: TextStyle(
                color: Renkler.appbarTextColor,
                fontWeight: FontWeight.w700,
                fontFamily: "OpenSans",
                fontStyle: FontStyle.normal,
                fontSize: 20.0),
            textAlign: TextAlign.center),
        leading: IconButton(
          icon: Icon(Icons.menu, color: Renkler.appbarIconColor, size: 20.0.w),
          onPressed: () {
            Scaffold.of(context).openDrawer();
          },
        ),
      ),
      body: ClipRRect(
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
                    Tab(child: Text("Veli")),
                    Tab(child: Text("Öğretmenler",style: TextStyle(fontSize: 14.0.spByWidth),)),
                    Tab(child: Text("Öğrenciler")),
                  ],
                ),
              ),
              Expanded(
                child: TabBarView(
                  controller: _tabController,
                  children: [
                    //1. Tab View
                    StreamBuilder<QuerySnapshot>(
                stream: FirebaseFirestore.instance
                    .collection('veli').snapshots(),
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

                      return   Slidable(
                        actionPane: SlidableDrawerActionPane(),
                        actionExtentRatio: 0.45,
                        child:ResimliCard(
                            textSubtitle: null,
                            textTitle: _card['adSoyad'].toString(),
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => VeliDetaySayfasi(
                                      card: _card,
                                    )),
                              );
                            },
                            fontSize: 12,
                            img: "null",
                            tarih: null),
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
                                  // await _adminIslemleri.adminYoneticiGorevdenAl(_cardYonetici);
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


                    //2. Tab View
                    StreamBuilder<QuerySnapshot>(
                      stream: FirebaseFirestore.instance
                          .collection('ogretmen').snapshots(),
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

                            return   Slidable(
                              actionPane: SlidableDrawerActionPane(),
                              actionExtentRatio: 0.45,
                              child:ResimliCard(
                                  textSubtitle: null,
                                  textTitle: _card['adSoyad'].toString(),
                                  onPressed: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => OgretmenDetaySayfasi(
                                            card: _card,
                                          )),
                                    );
                                  },
                                  fontSize: 12,
                                  img: _card['avatarImageUrl'].toString(),
                                  tarih: null),
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
                                        //   await _adminIslemleri.adminTemsilciGorevdenAl(_cardYonetici);
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



                    //3. Tab View
                    ListView(
                      children: [
                        SizedBox(
                          height: 10.0.h,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Column(
                              children: [
                                Container(
                                  width: 150.0.w,
                                  child: ListTile(
                                    title: Text(_filtreCinsiyet == "yok" ? "Cinsiyet" : _filtreCinsiyet,
                                        style: TextStyle(
                                            color: const Color(0xff343633),
                                            fontWeight: FontWeight.w400,
                                            fontFamily: "OpenSans",
                                            fontStyle: FontStyle.normal,
                                            fontSize: 15.0.spByWidth),
                                        textAlign: TextAlign.left),
                                    contentPadding: EdgeInsets.zero,
                                    onTap: () {
                                      _showCinsiyetFilter(context);
                                    },
                                    trailing: Icon(
                                      Icons.keyboard_arrow_down,
                                      color: Theme.of(context).primaryColor,
                                      size: 16.0.h,
                                    ),
                                  ),
                                ),
                                Container(
                                  width: 150.0.w,
                                  child: Divider(
                                    height: 3.0,
                                    color: Colors.black,
                                  ),
                                ),
                              ],
                            ),
                            Column(
                              children: [
                                Container(
                                  width: 150.0.w,
                                  child: ListTile(
                                    title: Text(_filtreSinif == "yok" ? "Sınıf" : _filtreSinif.toString(),
                                        style: TextStyle(
                                            color: const Color(0xff343633),
                                            fontWeight: FontWeight.w400,
                                            fontFamily: "OpenSans",
                                            fontStyle: FontStyle.normal,
                                            fontSize: 15.0.spByWidth),
                                        textAlign: TextAlign.left),
                                    contentPadding: EdgeInsets.zero,
                                    onTap: () {
                                      _showSinifFilter(context);
                                    },
                                    trailing: Icon(
                                      Icons.keyboard_arrow_down,
                                      color: Theme.of(context).primaryColor,
                                      size: 16.0.h,
                                    ),
                                  ),
                                ),
                                Container(
                                  width: 150.0.w,
                                  child: Divider(
                                    height: 3.0,
                                    color: Colors.black,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 20.0.h,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Column(
                              children: [
                                Container(
                                  width: 150.0.w,
                                  child: ListTile(
                                    title: Text(_filtreBolum == "yok" ? "Bolum" : _filtreBolum.toString(),
                                        style: TextStyle(
                                            color: const Color(0xff343633),
                                            fontWeight: FontWeight.w400,
                                            fontFamily: "OpenSans",
                                            fontStyle: FontStyle.normal,
                                            fontSize: 15.0.spByWidth),
                                        textAlign: TextAlign.left),
                                    contentPadding: EdgeInsets.zero,
                                    onTap: () {
                                      _showBolumFilter(context);
                                    },
                                    trailing: Icon(
                                      Icons.keyboard_arrow_down,
                                      color: Theme.of(context).primaryColor,
                                      size: 16.0.h,
                                    ),
                                  ),
                                ),
                                Container(
                                  width: 150.0.w,
                                  child: Divider(
                                    height: 3.0,
                                    color: Colors.black,
                                  ),
                                ),
                              ],
                            ),
                            Column(
                              children: [
                                Container(
                                  width: 150.0.w,
                                  child: ListTile(
                                    title: Text(_filtreOkul == "yok" ? "Okul" : _filtreOkul.toString(),
                                        style: TextStyle(
                                            color: const Color(0xff343633),
                                            fontWeight: FontWeight.w400,
                                            fontFamily: "OpenSans",
                                            fontStyle: FontStyle.normal,
                                            fontSize: 15.0.spByWidth),
                                        textAlign: TextAlign.left),
                                    contentPadding: EdgeInsets.zero,
                                    onTap: () {

                                     _showOkulFilter(context);
                                    },
                                    trailing: Icon(
                                      Icons.keyboard_arrow_down,
                                      color: Theme.of(context).primaryColor,
                                      size: 16.0.h,
                                    ),
                                  ),
                                ),
                                Container(
                                  width: 150.0.w,
                                  child: Divider(
                                    height: 3.0,
                                    color: Colors.black,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),

                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 30.0.w, vertical: 8.0.h),
                          child: Container(
                            child: RaisedButton.icon(
                              icon: Icon(
                                Icons.refresh,
                                color: Colors.white,
                                size: 30.0.h,
                              ),
                              color: Theme.of(context).primaryColor,
                              onPressed: () {
                                setState(() {
                                  _filtreCinsiyet = "yok";
                                  _filtreSinif = "yok";
                                  _filtreBolum = "yok";
                                  _filtreOkul = "yok";
                                });
                              },
                              label: Text(
                                "Filtreleri Temizle",
                                style: TextStyle(color: Colors.white,fontSize: 16.0.spByWidth),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 20.0.h,
                        ),
                        FutureBuilder<QuerySnapshot>(
                          future: filtrelistream(),
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
                                    onPressed: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) => OgrenciDetaySayfasi(
                                                card: _card,
                                              )));
                                    },
                                    fontSize: 12,
                                    img: _card['avatarImageUrl'].toString(),
                                    tarih: null);
                              },
                            );
                          },
                        ),
                        SizedBox(
                          height: 40.0.h,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<QuerySnapshot> filtrelistream() async {
   // print("meslek seçme: " + _filtreMeslek);
    if (_filtreOkul != "yok" && _filtreSinif != "yok" && _filtreBolum != "yok" && _filtreCinsiyet != "yok") {
      print("Filtre: 1 e geldi");
      QuerySnapshot qn = await _firestore
          .collection("ogrenci")
          .where("dogumTarihi",
          isLessThanOrEqualTo: DateTime.now().subtract(Duration(days: 365 * int.parse(_filtreSinif.substring(0, 2)))))
          .where("dogumTarihi",
          isGreaterThanOrEqualTo:
          DateTime.now().subtract(Duration(days: 365 * int.parse(_filtreSinif.substring(3, 5)))))
          .where('bolum', isEqualTo: _filtreBolum)
          .where('cinsiyet', isEqualTo: _filtreCinsiyet)
          .where('okul', isEqualTo: _filtreOkul)
          .get();
      return qn;
    }
    // 4(1) li kombinasyonu=4
    else if (_filtreOkul != "yok" && _filtreSinif == "yok" && _filtreBolum == "yok" && _filtreCinsiyet == "yok") {
      print("Filtre: 2 e geldi");
      QuerySnapshot qn = await _firestore.collection("ogrenci").where('okul', isEqualTo: _filtreOkul).get();
      return qn;
    } else if (_filtreOkul == "yok" && _filtreSinif != "yok" && _filtreBolum == "yok" && _filtreCinsiyet == "yok") {
      print("Filtre: 2 e geldi");
      QuerySnapshot qn = await _firestore
          .collection("ogrenci")
          .where("dogumTarihi",
          isLessThanOrEqualTo: DateTime.now().subtract(Duration(days: 365 * int.parse(_filtreSinif.substring(0, 2)))))
          .where("dogumTarihi",
          isGreaterThanOrEqualTo:
          DateTime.now().subtract(Duration(days: 365 * int.parse(_filtreSinif.substring(3, 5)))))
          .get();
      return qn;
    } else if (_filtreOkul == "yok" && _filtreSinif == "yok" && _filtreBolum != "yok" && _filtreCinsiyet == "yok") {
      print("Filtre: 3 e geldi");
      QuerySnapshot qn = await _firestore.collection("ogrenci").where('bolum', isEqualTo: _filtreBolum).get();
      return qn;
    } else if (_filtreOkul == "yok" && _filtreSinif == "yok" && _filtreBolum == "yok" && _filtreCinsiyet != "yok") {
      print("Filtre: 4 e geldi");
      QuerySnapshot qn =
      await _firestore.collection("ogrenci").where('cinsiyet', isEqualTo: _filtreCinsiyet).get();
      return qn;
    }
    // 4(2) li kombinasyonu=6
    else if (_filtreOkul != "yok" && _filtreSinif != "yok" && _filtreBolum == "yok" && _filtreCinsiyet == "yok") {
      print("Filtre: 4 e geldi");
      QuerySnapshot qn = await _firestore
          .collection("ogrenci")
          .where("dogumTarihi",
          isLessThanOrEqualTo: DateTime.now().subtract(Duration(days: 365 * int.parse(_filtreSinif.substring(0, 2)))))
          .where("dogumTarihi",
          isGreaterThanOrEqualTo:
          DateTime.now().subtract(Duration(days: 365 * int.parse(_filtreSinif.substring(3, 5)))))
          .where('okul', isEqualTo: _filtreOkul)
          .get();
      return qn;
    } else if (_filtreOkul != "yok" && _filtreSinif == "yok" && _filtreBolum != "yok" && _filtreCinsiyet == "yok") {
      print("Filtre: 5 e geldi");
      QuerySnapshot qn = await _firestore
          .collection("ogrenci")
          .where('okul', isEqualTo: _filtreOkul)
          .where('bolum', isEqualTo: _filtreBolum)
          .get();
      return qn;
    } else if (_filtreOkul != "yok" && _filtreSinif == "yok" && _filtreBolum == "yok" && _filtreCinsiyet != "yok") {
      print("Filtre: 6 e geldi");
      QuerySnapshot qn = await _firestore
          .collection("ogrenci")
          .where('okul', isEqualTo: _filtreOkul)
          .where('cinsiyet', isEqualTo: _filtreCinsiyet)
          .get();
      return qn;
    } else if (_filtreOkul == "yok" && _filtreSinif != "yok" && _filtreBolum == "yok" && _filtreCinsiyet != "yok") {
      print("Filtre: 6 e geldi");
      QuerySnapshot qn = await _firestore
          .collection("ogrenci")
          .where("dogumTarihi",
          isLessThanOrEqualTo: DateTime.now().subtract(Duration(days: 365 * int.parse(_filtreSinif.substring(0, 2)))))
          .where("dogumTarihi",
          isGreaterThanOrEqualTo:
          DateTime.now().subtract(Duration(days: 365 * int.parse(_filtreSinif.substring(3, 5)))))
          .where('cinsiyet', isEqualTo: _filtreCinsiyet)
          .get();
      return qn;
    } else if (_filtreOkul == "yok" && _filtreSinif != "yok" && _filtreBolum != "yok" && _filtreCinsiyet == "yok") {
      print("Filtre: 7 e geldi" + _filtreBolum);
      QuerySnapshot qn = await _firestore
          .collection("ogrenci")
          .where("dogumTarihi",
          isLessThanOrEqualTo: DateTime.now().subtract(Duration(days: 365 * int.parse(_filtreSinif.substring(0, 2)))))
          .where("dogumTarihi",
          isGreaterThanOrEqualTo:
          DateTime.now().subtract(Duration(days: 365 * int.parse(_filtreSinif.substring(3, 5)))))
          .where('bolum', isEqualTo: _filtreBolum)
          .get();
      return qn;
    } else if (_filtreOkul == "yok" && _filtreSinif == "yok" && _filtreBolum != "yok" && _filtreCinsiyet != "yok") {
      print("Filtre: 8 e geldi");
      QuerySnapshot qn = await _firestore
          .collection("ogrenci")
          .where('bolum', isEqualTo: _filtreBolum)
          .where('cinsiyet', isEqualTo: _filtreCinsiyet)
          .get();
      return qn;
    }

    //4(3) lü kombinasyonu=4
    else if (_filtreOkul == "yok" && _filtreSinif != "yok" && _filtreBolum != "yok" && _filtreCinsiyet != "yok") {
      print("Filtre: 9 e geldi");
      QuerySnapshot qn = await _firestore
          .collection("ogrenci")
          .where("dogumTarihi",
          isLessThanOrEqualTo: DateTime.now().subtract(Duration(days: 365 * int.parse(_filtreSinif.substring(0, 2)))))
          .where("dogumTarihi",
          isGreaterThanOrEqualTo:
          DateTime.now().subtract(Duration(days: 365 * int.parse(_filtreSinif.substring(3, 5)))))
          .where('bolum', isEqualTo: _filtreBolum)
          .where('cinsiyet', isEqualTo: _filtreCinsiyet)
          .get();
      return qn;
    } else if (_filtreOkul != "yok" && _filtreSinif == "yok" && _filtreBolum != "yok" && _filtreCinsiyet != "yok") {
      print("Filtre: 10 e geldi");
      QuerySnapshot qn = await _firestore
          .collection("ogrenci")
          .where('bolum', isEqualTo: _filtreBolum)
          .where('cinsiyet', isEqualTo: _filtreCinsiyet)
          .where('okul', isEqualTo: _filtreOkul)
          .get();
      return qn;
    } else if (_filtreOkul != "yok" && _filtreSinif != "yok" && _filtreBolum == "yok" && _filtreCinsiyet != "yok") {
      print("Filtre: 11 e geldi");
      QuerySnapshot qn = await _firestore
          .collection("ogrenci")
          .where("dogumTarihi",
          isLessThanOrEqualTo: DateTime.now().subtract(Duration(days: 365 * int.parse(_filtreSinif.substring(0, 2)))))
          .where("dogumTarihi",
          isGreaterThanOrEqualTo:
          DateTime.now().subtract(Duration(days: 365 * int.parse(_filtreSinif.substring(3, 5)))))
          .where('okul', isEqualTo: _filtreOkul)
          .where('cinsiyet', isEqualTo: _filtreCinsiyet)
          .get();
      return qn;
    } else if (_filtreOkul != "yok" && _filtreSinif != "yok" && _filtreBolum != "yok" && _filtreCinsiyet == "yok") {
      print("Filtre: 12 e geldi");
      QuerySnapshot qn = await _firestore
          .collection("ogrenci")
          .where("dogumTarihi",
          isLessThanOrEqualTo: DateTime.now().subtract(Duration(days: 365 * int.parse(_filtreSinif.substring(0, 2)))))
          .where("dogumTarihi",
          isGreaterThanOrEqualTo:
          DateTime.now().subtract(Duration(days: 365 * int.parse(_filtreSinif.substring(3, 5)))))
          .where('bolum', isEqualTo: _filtreBolum)
          .where('okul', isEqualTo: _filtreOkul)
          .get();
      return qn;
    } else {
      //print("Filtre: 13 e geldi");
      QuerySnapshot qn = await _firestore.collection("ogrenci").orderBy('adSoyad').get();
      return qn;
    }
  }

  void _showCinsiyetFilter(context) {
    showModalBottomSheet(
        context: context,
        builder: (context) {
          return Container(
            padding: EdgeInsets.all(8),
            height: 180,
            alignment: Alignment.center,
            child: ListView(
              children: [
                ListView.separated(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: _items.length,
                    separatorBuilder: (context, int) {
                      return Divider();
                    },
                    itemBuilder: (context, index) {
                      return GestureDetector(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 30),
                            child: Row(
                              children: [
                                Text(
                                  _items[index].toString(),
                                  style: TextStyle(fontSize: 17),
                                ),
                              ],
                            ),
                          ),
                          onTap: () {
                            setState(() {
                              _filtreCinsiyet = _items[index];
                            });
                            Navigator.of(context).pop();
                          });
                    }),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: ListTile(
                    leading: Icon(Icons.close),
                    title: Text("Kapat"),
                    onTap: () {
                      setState(() {
                        _filtreCinsiyet = "yok";
                      });
                      Navigator.pop(context);
                    },
                  ),
                ),
              ],
            ),
          );
        });
  }

  void _showBolumFilter(context) {
    showModalBottomSheet(
        context: context,
        builder: (context) {
          return Container(
            padding: EdgeInsets.all(8),
            height: 600.0.h,
            alignment: Alignment.center,
            child: ListView(
              children: [
                ListView.separated(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: _bolum.length,
                    separatorBuilder: (context, int) {
                      return Divider();
                    },
                    itemBuilder: (context, index) {
                      return GestureDetector(
                          child: Padding(
                            padding:  EdgeInsets.symmetric(vertical: 10.0.h, horizontal: 30.0.w),
                            child: Row(
                              children: [
                                Text(
                                  _bolum[index].toString(),
                                  style: TextStyle(fontSize: 17.0.spByWidth),
                                ),
                              ],
                            ),
                          ),
                          onTap: () {
                            setState(() {
                              _filtreBolum = _bolum[index];
                            });
                            Navigator.of(context).pop();
                          });
                    }),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: ListTile(
                    leading: Icon(Icons.close),
                    title: Text("Kapat"),
                    onTap: () {
                      setState(() {
                        _filtreBolum = "yok";
                      });
                      Navigator.pop(context);
                    },
                  ),
                ),
              ],
            ),
          );
        });
  }

  void _showOkulFilter(context) {
    showModalBottomSheet(
        context: context,
        builder: (context) {
          return Container(
            padding: EdgeInsets.all(8),
            height: 600,
            alignment: Alignment.center,
            child: ListView(
              children: [
                ListView.separated(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: okulList.length,
                    separatorBuilder: (context, int) {
                      return Divider();
                    },
                    itemBuilder: (context, index) {
                      return GestureDetector(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 30),
                            child: Row(
                              children: [
                                Text(
                                  okulList[index].toString(),
                                  style: TextStyle(fontSize: 17),
                                ),
                              ],
                            ),
                          ),
                          onTap: () {
                            setState(() {
                              _filtreOkul = okulList[index];
                            });
                            Navigator.of(context).pop();
                          });
                    }),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: ListTile(
                    leading: Icon(Icons.close),
                    title: Text("Kapat"),
                    onTap: () {
                      setState(() {
                        _filtreOkul = "yok";
                      });
                      Navigator.pop(context);
                    },
                  ),
                ),
              ],
            ),
          );
        });
  }

  void _showSinifFilter(context) {
    showModalBottomSheet(
        context: context,
        builder: (context) {
          return Container(
            padding: EdgeInsets.all(8),
            height: 280,
            alignment: Alignment.center,
            child: ListView(
              children: [
                ListView.separated(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: _sinif.length,
                    separatorBuilder: (context, int) {
                      return Divider();
                    },
                    itemBuilder: (context, index) {
                      return GestureDetector(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 30),
                            child: Row(
                              children: [
                                Text(
                                  _sinif[index].toString(),
                                  style: TextStyle(fontSize: 17),
                                ),
                              ],
                            ),
                          ),
                          onTap: () {
                            print("on tap");
                            setState(() {
                              _filtreSinif = _sinif[index];
                            });
                            Navigator.of(context).pop();
                          });
                    }),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: ListTile(
                    leading: Icon(Icons.close),
                    title: Text("Kapat"),
                    onTap: () {
                      setState(() {
                        _filtreSinif = "yok";
                      });
                      Navigator.pop(context);
                    },
                  ),
                ),
              ],
            ),
          );
        });
  }
}
