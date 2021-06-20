import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dershane/common/dersProgramiCard.dart';
import 'package:dershane/common/duyuruSayfasi.dart';
import 'package:dershane/common/loadingscreen.dart';
import 'package:dershane/common/myButton.dart';
import 'package:dershane/common/ogrenciDersProgrami.dart';
import 'package:dershane/common/resimsizCard.dart';
import 'package:dershane/extensions/renkler.dart';
import 'package:dershane/firebase/firebase_database.dart';
import 'package:dershane/locator.dart';
import 'package:dershane/user_state/ogrenci_model_service.dart';
import 'package:flutter/material.dart';
import 'package:dershane/extensions/size_extention.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';


class DersProgrami extends StatefulWidget {
  final DocumentSnapshot card;

  DersProgrami({ @required this.card});
  @override
  _DersProgramiState createState() => _DersProgramiState();
}

class _DersProgramiState extends State<DersProgrami> with SingleTickerProviderStateMixin {

  List<String> haftalikgunler = [];
  FirestoreDBService _firebaseIslemleri = locator<FirestoreDBService>();

  final sinifController = TextEditingController();


  PageController _controller = PageController(initialPage: 0);

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    haftalikgunler.add("Pazartesi");
    haftalikgunler.add("Salı");
    haftalikgunler.add("Çarşamba");
    haftalikgunler.add("Perşembe");
    haftalikgunler.add("Cuma");
    haftalikgunler.add("Cumartesi");
    haftalikgunler.add("Pazar");
  }
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor:  Renkler.appbarGroundColor,
      appBar: AppBar(
        title: Text("Ders Programı"),
        elevation: 0.0,
        brightness: Brightness.dark,
        toolbarHeight: 80.0.h,
        backgroundColor: Renkler.appbarGroundColor,
      ),

      body:  Container(
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
                print("gelen gun:"+_card['gun'].toString());
                return  program(_card);
              },
              itemCount: cardLength, // Can be null
            );

          },
        ),
      ),
    );
  }


  Future<QuerySnapshot> filtrelistream() async {
    final _ogrenciModel = Provider.of<OgrenciModel>(context, listen: false);
    QuerySnapshot qn = await FirebaseFirestore.instance.collection("siniflar").doc(_ogrenciModel.user.dershaneSinif.toLowerCase().toString()).collection("program").orderBy('gun').get();
    return qn;
  }

  Widget program(DocumentSnapshot _card) {
    return ListView(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      children: [
        Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height - 80,
          margin: EdgeInsets.only(top: 12.70),

          child: ListView(
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


              _card['program'].length==2 ? OgrenciDersProgramiCard(saatbaslangic: _card['program'][0].toString().substring(0,5),saatbitis: dersbitis(_card['program'][0].toString()),ders: _card['program'][1],) :

              _card['program'].length==4 ?
              Column(
                children: [
                  OgrenciDersProgramiCard(saatbaslangic: _card['program'][0].toString().substring(0,5),saatbitis: dersbitis(_card['program'][0].toString()),ders: _card['program'][1],),
                  OgrenciDersProgramiCard(saatbaslangic: _card['program'][2].toString().substring(0,5),saatbitis:dersbitis( _card['program'][2].toString()),ders: _card['program'][3],),
                ],
              ) :

              _card['program'].length==6 ?  Column(
                children: [
                  OgrenciDersProgramiCard(saatbaslangic: _card['program'][0].toString().substring(0,5),saatbitis: dersbitis(_card['program'][0].toString()),ders: _card['program'][1],),
                  OgrenciDersProgramiCard(saatbaslangic: _card['program'][2].toString().substring(0,5),saatbitis:dersbitis( _card['program'][2].toString()),ders: _card['program'][3],),
                  OgrenciDersProgramiCard(saatbaslangic: _card['program'][4].toString().substring(0,5),saatbitis:dersbitis( _card['program'][4].toString()),ders: _card['program'][5],),
                ],
              ) :

              _card['program'].length==8 ?  Column(
                children: [
                  OgrenciDersProgramiCard(saatbaslangic: _card['program'][0].toString().substring(0,5),saatbitis: dersbitis(_card['program'][0].toString()),ders: _card['program'][1],),
                  OgrenciDersProgramiCard(saatbaslangic: _card['program'][2].toString().substring(0,5),saatbitis:dersbitis( _card['program'][2].toString()),ders: _card['program'][3],),
                  OgrenciDersProgramiCard(saatbaslangic: _card['program'][4].toString().substring(0,5),saatbitis:dersbitis( _card['program'][4].toString()),ders: _card['program'][5],),
                  OgrenciDersProgramiCard(saatbaslangic: _card['program'][6].toString().substring(0,5),saatbitis:dersbitis( _card['program'][6].toString()),ders: _card['program'][7],),
                ],
              ) :

              _card['program'].length==10 ?  Column(
                children: [
                  OgrenciDersProgramiCard(saatbaslangic: _card['program'][0].toString().substring(0,5),saatbitis: dersbitis(_card['program'][0].toString()),ders: _card['program'][1],),
                  OgrenciDersProgramiCard(saatbaslangic: _card['program'][2].toString().substring(0,5),saatbitis:dersbitis( _card['program'][2].toString()),ders: _card['program'][3],),
                  OgrenciDersProgramiCard(saatbaslangic: _card['program'][4].toString().substring(0,5),saatbitis:dersbitis( _card['program'][4].toString()),ders: _card['program'][5],),
                  OgrenciDersProgramiCard(saatbaslangic: _card['program'][6].toString().substring(0,5),saatbitis:dersbitis( _card['program'][6].toString()),ders: _card['program'][7],),
                  OgrenciDersProgramiCard(saatbaslangic: _card['program'][8].toString().substring(0,5),saatbitis: dersbitis( _card['program'][8].toString()),ders: _card['program'][9],),
                ],
              ) : _card['program'].length==12 ?  Column(
                children: [
                  OgrenciDersProgramiCard(saatbaslangic: _card['program'][0].toString().substring(0,5),saatbitis: dersbitis(_card['program'][0].toString()),ders: _card['program'][1],),
                  OgrenciDersProgramiCard(saatbaslangic: _card['program'][2].toString().substring(0,5),saatbitis:dersbitis( _card['program'][2].toString()),ders: _card['program'][3],),
                  OgrenciDersProgramiCard(saatbaslangic: _card['program'][4].toString().substring(0,5),saatbitis:dersbitis( _card['program'][4].toString()),ders: _card['program'][5],),
                  OgrenciDersProgramiCard(saatbaslangic: _card['program'][6].toString().substring(0,5),saatbitis:dersbitis( _card['program'][6].toString()),ders: _card['program'][7],),
                  OgrenciDersProgramiCard(saatbaslangic: _card['program'][8].toString().substring(0,5),saatbitis: dersbitis( _card['program'][8].toString()),ders: _card['program'][9],),
                  OgrenciDersProgramiCard(saatbaslangic: _card['program'][10].toString().substring(0,5),saatbitis: dersbitis( _card['program'][10].toString()),ders: _card['program'][11],),
                ],
              ) :
              _card['program'].length==14 ?  Column(
                children: [
                  OgrenciDersProgramiCard(saatbaslangic: _card['program'][0].toString().substring(0,5),saatbitis: dersbitis(_card['program'][0].toString()),ders: _card['program'][1],),
                  OgrenciDersProgramiCard(saatbaslangic: _card['program'][2].toString().substring(0,5),saatbitis:dersbitis( _card['program'][2].toString()),ders: _card['program'][3],),
                  OgrenciDersProgramiCard(saatbaslangic: _card['program'][4].toString().substring(0,5),saatbitis:dersbitis( _card['program'][4].toString()),ders: _card['program'][5],),
                  OgrenciDersProgramiCard(saatbaslangic: _card['program'][6].toString().substring(0,5),saatbitis:dersbitis( _card['program'][6].toString()),ders: _card['program'][7],),
                  OgrenciDersProgramiCard(saatbaslangic: _card['program'][8].toString().substring(0,5),saatbitis: dersbitis( _card['program'][8].toString()),ders: _card['program'][9],),
                  OgrenciDersProgramiCard(saatbaslangic: _card['program'][10].toString().substring(0,5),saatbitis: dersbitis( _card['program'][10].toString()),ders: _card['program'][11],),
                  OgrenciDersProgramiCard(saatbaslangic: _card['program'][12].toString().substring(0,5),saatbitis: dersbitis( _card['program'][12].toString()),ders: _card['program'][13],),
                ],
              ) :
              Container(),


            SizedBox(height: 160,),

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
