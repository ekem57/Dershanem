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
  List<String> haftalikgunler = [];
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
    haftalikgunler.add("Pazartesi");
    haftalikgunler.add("Salı");
    haftalikgunler.add("Çarşamba");
    haftalikgunler.add("Perşembe");
    haftalikgunler.add("Cuma");
    haftalikgunler.add("Cumartesi");
    haftalikgunler.add("Pazar");
  }

  FirestoreDBService _firestoreDBService = locator<FirestoreDBService>();
  PageController _controller = PageController(initialPage: 0);
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      floatingActionButton:
      _tabController.index==0 ? MyFloatingButton(tabController: _tabController, pushableScreens: [OgretmenDanismanlikAta(card: widget.card,),Container()]) :Container(),
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
                  Container(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height,
                    child: FutureBuilder<QuerySnapshot>(
                      future: filtrelistream(),
                      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
                        if (!snapshot.hasData)
                          return Center(
                            child: CircularProgressIndicator(),
                          );
                        final int cardLength = snapshot.data.docs.length;

                        return PageView.builder(
                          itemBuilder: (context, index) {
                            final DocumentSnapshot _card = snapshot.data.docs[index];
                            return  program(_card);
                          },
                          itemCount: cardLength, // Can be null
                        );

                      },
                    ),
                  ),



                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<QuerySnapshot> filtrelistream() async {
    QuerySnapshot qn = await FirebaseFirestore.instance.collection("ogretmenprogram").doc("10").collection("program").orderBy('gun').get();
    return qn;
  }

  Widget program(DocumentSnapshot _card) {
    print(" gelen veri :"+_card['program'].length.toString());
    return ListView(
      children: [
        Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height - 80,
          margin: EdgeInsets.only(top: 12.70),

          child: Column(
            children: [
              Center(
                child: Text(haftalikgunler[_card['gun']-1],
                    style: const TextStyle(
                        color: const Color(0xff343633),
                        fontWeight: FontWeight.w700,
                        fontFamily: "OpenSans",
                        fontStyle: FontStyle.italic,
                        fontSize: 25.0),
                    textAlign: TextAlign.center),
              ),


              _card['program'].length==3 ?   DersProgramiCard( sinif: _card['program'][2],saatbaslangic: _card['program'][0].toString().substring(0,5),saatbitis: dersbitis(_card['program'][0].toString()),ders: _card['program'][1],):

              _card['program'].length==6 ?
              Column(
                children: [
                  DersProgramiCard( sinif: _card['program'][2],saatbaslangic: _card['program'][0].toString().substring(0,5),saatbitis: dersbitis(_card['program'][0].toString()),ders: _card['program'][1],),
                  DersProgramiCard( sinif: _card['program'][5],saatbaslangic: _card['program'][3].toString().substring(0,5),saatbitis:dersbitis( _card['program'][3].toString()),ders: _card['program'][4],),
                ],
              ) :

              _card['program'].length==9 ?  Column(
                children: [
                DersProgramiCard( sinif: _card['program'][2],saatbaslangic: _card['program'][0].toString().substring(0,5),saatbitis: dersbitis(_card['program'][0].toString()),ders: _card['program'][1],),
                DersProgramiCard( sinif: _card['program'][5],saatbaslangic: _card['program'][3].toString().substring(0,5),saatbitis:dersbitis( _card['program'][3].toString()),ders: _card['program'][4],),
                DersProgramiCard( sinif: _card['program'][8],saatbaslangic: _card['program'][6].toString().substring(0,5),saatbitis:dersbitis( _card['program'][6].toString()),ders: _card['program'][7],),

                ],
              ) :

              _card['program'].length==12 ?  Column(
                children: [
                  DersProgramiCard( sinif: _card['program'][2],saatbaslangic: _card['program'][0].toString().substring(0,5),saatbitis: dersbitis(_card['program'][0].toString()),ders: _card['program'][1],),
                  DersProgramiCard( sinif: _card['program'][5],saatbaslangic: _card['program'][3].toString().substring(0,5),saatbitis:dersbitis( _card['program'][3].toString()),ders: _card['program'][4],),
                  DersProgramiCard( sinif: _card['program'][8],saatbaslangic: _card['program'][6].toString().substring(0,5),saatbitis:dersbitis( _card['program'][6].toString()),ders: _card['program'][7],),
                  DersProgramiCard( sinif: _card['program'][11],saatbaslangic: _card['program'][9].toString().substring(0,5),saatbitis:dersbitis( _card['program'][9].toString()),ders: _card['program'][10],),
                ],
              ) :

              _card['program'].length==15 ?  Column(
                children: [
                  DersProgramiCard( sinif: _card['program'][2],saatbaslangic: _card['program'][0].toString().substring(0,5),saatbitis: dersbitis(_card['program'][0].toString()),ders: _card['program'][1],),
                  DersProgramiCard( sinif: _card['program'][5],saatbaslangic: _card['program'][3].toString().substring(0,5),saatbitis:dersbitis( _card['program'][3].toString()),ders: _card['program'][4],),
                  DersProgramiCard( sinif: _card['program'][8],saatbaslangic: _card['program'][6].toString().substring(0,5),saatbitis:dersbitis( _card['program'][6].toString()),ders: _card['program'][7],),
                  DersProgramiCard( sinif: _card['program'][11],saatbaslangic: _card['program'][9].toString().substring(0,5),saatbitis:dersbitis( _card['program'][9].toString()),ders: _card['program'][10],),
                  DersProgramiCard( sinif: _card['program'][14],saatbaslangic: _card['program'][12].toString().substring(0,5),saatbitis: dersbitis( _card['program'][12].toString()),ders: _card['program'][13],),
                ],
              ) : Container(),




            ],
          ),
        ),
      ],
    );
  }

  String dersbitis(String saat){
    int dakikasi= int.parse(saat.substring(3,5));
   int saati= int.parse(saat.substring(0,2));
   dakikasi=dakikasi+40;
   if(dakikasi>=60){
     saati++;
    dakikasi= dakikasi-60;
   }

   String yenitarih=saati <10 ? "0"+saati.toString()+":"+dakikasi.toString() : saati.toString()+":"+dakikasi.toString();
   return yenitarih;
  }


}
