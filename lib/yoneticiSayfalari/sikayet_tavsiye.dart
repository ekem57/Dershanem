import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dershane/common/resimli_card.dart';
import 'package:dershane/extensions/renkler.dart';
import 'package:dershane/yoneticiSayfalari/sikayet_tavsiye_icerik.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
import 'package:dershane/extensions/size_extention.dart';


class SikayetTavsiyeSayfasi extends StatefulWidget {
  @override
  _SikayetTavsiyeSayfasiState createState() => _SikayetTavsiyeSayfasiState();
}

class _SikayetTavsiyeSayfasiState extends State<SikayetTavsiyeSayfasi> {

  String zaman="";
  final f = new DateFormat('yyyy-MM-dd');
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      extendBody: true,
      backgroundColor: Renkler.backGroundColor,
      appBar:  AppBar(
        backgroundColor: Renkler.appbarGroundColor,
        elevation: 0,
        iconTheme: new IconThemeData(color: Colors.black),
        toolbarHeight: 70.0,
        title: Text(
            "Şikayetler",
            style:  TextStyle(
                color: Renkler.appbarTextColor ,
                fontWeight: FontWeight.w700,
                fontFamily: "OpenSans",
                fontStyle:  FontStyle.normal,
                fontSize: 20.0.spByWidth
            ),
            textAlign: TextAlign.center
        ),
        automaticallyImplyLeading: false,

      ),
      body: ClipRRect(
        borderRadius: BorderRadius.only(topLeft: Radius.circular(40),topRight: Radius.circular(40)),
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
          child: ListView(
            children: [

              SizedBox(height: 40.0.h,),
              StreamBuilder<QuerySnapshot>(
                stream: FirebaseFirestore.instance.collection('yoneticitavsiye').orderBy('tarih',descending: true).snapshots(),
                builder: (BuildContext context,
                    AsyncSnapshot<QuerySnapshot> snapshot) {
                  if (!snapshot.hasData){
                    return Center(child: CircularProgressIndicator(),);
                  }
                  final int cardLength = snapshot.data.docs.length;

                  return ListView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: cardLength,
                    itemBuilder: (_, int index) {

                      final DocumentSnapshot _card = snapshot.data.docs[index];
                      DateTime _tarih = _card['tarih'].toDate();

                      DateTime dateTimeNow = DateTime.now();
                      final differenceInHours = dateTimeNow.difference(_tarih).inHours;


                      if(differenceInHours.abs() < 24)
                      {
                        zaman= _tarih.toString().substring(11,16);
                      }else{
                        zaman= formatTheDate(_tarih, format: DateFormat("dd.MM.y"));
                      }
                      return Slidable(
                        actionPane: SlidableDrawerActionPane(),
                        actionExtentRatio: 0.45,
                        child: ResimliCard(textSubtitle: _card['sikayet'].toString(), textTitle: _card['gonderenIsim'].toString(),
                          fontSize: 20.0.spByWidth,
                          img: _card['gonderenFoto'].toString(),
                          tarih: zaman,
                          onPressed: (){

                            Navigator.of(context, rootNavigator: true).push(MaterialPageRoute(builder: (context) =>SikayetTavsiyeIcerik(card: _card,tarih: formatTheDate(_tarih, format: DateFormat("dd.MM.y")),)),);

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
      ),



    );
  }
  String formatTheDate(DateTime selectedDate, {DateFormat format}) {
    final DateTime now = selectedDate;
    final DateFormat formatter = format ?? DateFormat('dd.MM.y', "tr_TR");
    final String formatted = formatter.format(now);
    initializeDateFormatting("tr_TR");
    return formatted;
  }
}
