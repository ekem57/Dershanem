import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dershane/common/dersProgramiCard.dart';
import 'package:dershane/firebase/firebase_database.dart';
import 'package:dershane/locator.dart';
import 'package:excel/excel.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';

class OgrenciDersProgramiGir extends StatefulWidget {
  @override
  _OgrenciDersProgramiGirState createState() => _OgrenciDersProgramiGirState();
}
FirestoreDBService _firebaseIslemleri = locator<FirestoreDBService>();

class _OgrenciDersProgramiGirState extends State<OgrenciDersProgramiGir> {
  List<String> dersprogramiPazartesi= [];
  List<String> dersprogramiSali= [];
  List<String> dersprogramiCarsamba= [];
  List<String> dersprogramiPersembe= [];
  List<String> dersprogramiCuma= [];
  List<String> dersprogramiCumartesi= [];
  List<String> dersprogramiPazar = [];
  String sinifid;
  List<String> haftalikgunler = [];

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

  Map<String, dynamic> ProgramMapPazartesi = Map();
  Map<String, dynamic> ProgramMapSali = Map();
  Map<String, dynamic> ProgramMapCarsamba = Map();
  Map<String, dynamic> ProgramMapPersembe = Map();
  Map<String, dynamic> ProgramMapCuma = Map();
  Map<String, dynamic> ProgramMapCumartesi = Map();
  Map<String, dynamic> ProgramMapPazar = Map();


  @override
  Widget build(BuildContext context) {
    return   Scaffold(
      appBar: AppBar(
        title: Text("Öğrenci Ders Programı"),
      ),
      body: ListView(
        children: [
          SizedBox(height: 20,),
          Container(
            width: 400,
            height: 200,
            child: Center(
              child: InkWell(
                onTap: () async {

                  dersprogramiPazar.clear();
                  dersprogramiCumartesi.clear();
                  dersprogramiCuma.clear();
                  dersprogramiPersembe.clear();
                  dersprogramiCarsamba.clear();
                  dersprogramiSali.clear();
                  dersprogramiSali.clear();


                  FilePickerResult result = await FilePicker.platform.pickFiles();

                  if(result != null) {
                    File file = File(result.files.single.path);
                    print("dosya yolu: "+result.files.single.path);
                    // var file = "Path_to_pre_existing_Excel_File/excel_file.xlsx";
                    var bytes = File(result.files.single.path).readAsBytesSync();
                    var excel = Excel.decodeBytes(bytes);



                    sinifid= excel.tables["Sayfa1"].rows[1][0].props[0].toString();


                    int toplamcolumns;
                    int toplamrows;
                    for (var table in excel.tables.keys) {
                      toplamcolumns = excel.tables[table].maxCols;
                      toplamrows = excel.tables[table].maxRows;
                    }
                    int a=0;
                    print("toplam columns "+toplamcolumns.toString());



                    ProgramMapPazartesi['sinifid'] = sinifid.toString();
                    ProgramMapPazartesi['gun'] = 1;
                    ProgramMapPazartesi['program'] = dersprogramiPazartesi;

                    ProgramMapSali['sinifid'] = sinifid.toString();
                    ProgramMapSali['gun'] = 2;
                    ProgramMapSali['program'] = dersprogramiSali;


                    ProgramMapCarsamba['sinifid'] = sinifid.toString();
                    ProgramMapCarsamba['gun'] = 3;
                    ProgramMapCarsamba['program'] = dersprogramiCarsamba;


                    ProgramMapPersembe['sinifid'] =  sinifid.toString();
                    ProgramMapPersembe['gun'] = 4;
                    ProgramMapPersembe['program'] = dersprogramiPersembe;


                    ProgramMapCuma['sinifid'] =  sinifid.toString();
                    ProgramMapCuma['gun'] = 5;
                    ProgramMapCuma['program'] = dersprogramiCuma;


                    ProgramMapCumartesi['sinifid'] =  sinifid.toString();
                    ProgramMapCumartesi['gun'] = 6;
                    ProgramMapCumartesi['program'] = dersprogramiCumartesi;


                    ProgramMapPazar['sinifid'] =  sinifid.toString();
                    ProgramMapPazar['gun'] = 7;
                    ProgramMapPazar['program'] = dersprogramiPazar;

                    print("toplam veri sutunu: "+toplamrows.toString());

                    for(int i=1;i<toplamrows;i++) {
                      if (excel.tables["Sayfa1"].rows[0][2].props[0] == "Pazartesi") {


                        dersprogramiPazartesi.add(excel.tables["Sayfa1"].rows[i][1].props[0].toString());
                        dersprogramiPazartesi.add(excel.tables["Sayfa1"].rows[i][2].props[0].toString());
                        if(sinifid!=""){
                          if(sinifid!=excel.tables["Sayfa1"].rows[i][0].props[0].toString()){

                            veritabanikayit(sinifid);
                          }
                        }
                        sinifid=excel.tables["Sayfa1"].rows[i][0].props[0].toString();


                        // dersprogramiPazartesi.clear();
                      }
                      if (excel.tables["Sayfa1"].rows[0][3].props[0] == "Salı") {


                        dersprogramiSali.add(excel.tables["Sayfa1"].rows[i][1]
                            .props[0].toString());
                        dersprogramiSali.add(excel.tables["Sayfa1"].rows[i][3]
                            .props[0].toString());
                        // _firebaseIslemleri.ogretmenDersPorgramiAta(ProgramMapSali, "10");
                        // dersprogramiSali.clear();
                        sinifid=excel.tables["Sayfa1"].rows[i][0].props[0].toString();
                      }
                      if (excel.tables["Sayfa1"].rows[0][4].props[0] ==
                          "Çarşamba") {


                        dersprogramiCarsamba.add(excel.tables["Sayfa1"].rows[i][1]
                            .props[0].toString());
                        dersprogramiCarsamba.add(excel.tables["Sayfa1"].rows[i][4]
                            .props[0].toString());
                        // _firebaseIslemleri.ogretmenDersPorgramiAta(ProgramMapCarsamba, "10");
                        //dersprogramiCarsamba.clear();
                        sinifid=excel.tables["Sayfa1"].rows[i][0].props[0].toString();
                      }
                      if (excel.tables["Sayfa1"].rows[0][5].props[0] ==
                          "Perşembe") {

                        dersprogramiPersembe.add(excel.tables["Sayfa1"].rows[i][1]
                            .props[0].toString());
                        dersprogramiPersembe.add(excel.tables["Sayfa1"].rows[i][5]
                            .props[0].toString());
                        //_firebaseIslemleri.ogretmenDersPorgramiAta(ProgramMapPersembe, "10");
                        //dersprogramiPersembe.clear();
                        sinifid=excel.tables["Sayfa1"].rows[i][0].props[0].toString();
                      }
                      if (excel.tables["Sayfa1"].rows[0][6].props[0] == "Cuma") {

                        dersprogramiCuma.add(excel.tables["Sayfa1"].rows[i][1]
                            .props[0].toString());
                        dersprogramiCuma.add(excel.tables["Sayfa1"].rows[i][6]
                            .props[0].toString());
                        //_firebaseIslemleri.ogretmenDersPorgramiAta(ProgramMapCuma, "10");
                        // dersprogramiCuma.clear();
                        sinifid=excel.tables["Sayfa1"].rows[i][0].props[0].toString();
                      }
                      if (excel.tables["Sayfa1"].rows[0][7].props[0] ==
                          "Cumartesi") {

                        dersprogramiCumartesi.add(excel.tables["Sayfa1"].rows[i][1].props[0].toString());
                        dersprogramiCumartesi.add(excel.tables["Sayfa1"].rows[i][7].props[0].toString());
                        // _firebaseIslemleri.ogretmenDersPorgramiAta(ProgramMapCumartesi, "10");
                        //dersprogramiCumartesi.clear();
                        sinifid=excel.tables["Sayfa1"].rows[i][0].props[0].toString();
                      }
                      if (excel.tables["Sayfa1"].rows[0][8].props[0] == "Pazar") {

                        dersprogramiPazar.add(excel.tables["Sayfa1"].rows[i][1]
                            .props[0].toString());
                        dersprogramiPazar.add(excel.tables["Sayfa1"].rows[i][8]
                            .props[0].toString());
                        // _firebaseIslemleri.ogretmenDersPorgramiAta(ProgramMapPazar, "10");
                        // dersprogramiPazar.clear();

                        print("i :"+i.toString()+" toplamrows:"+toplamrows.toString());
                        if(sinifid!=""){
                          if( toplamrows==i+1){

                            veritabanikayit(sinifid);
                          }
                        }
                        sinifid=excel.tables["Sayfa1"].rows[i][0].props[0].toString();

                      }

                      print("/////////////");
                    }





                    setState(() {

                    });
                  } else {

                  }
                },
                child: Container(
                  width: 180,
                  height: 180,
                  child: Icon(Icons.add,size: 30,color: Colors.black,),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.black,width: 3),
                    borderRadius: BorderRadius.all(
                        Radius.circular(20.0)
                    ),
                  ),
                ),
              ),
            ),
          ),

          Column(
            children: [

              Container(
                width: MediaQuery.of(context).size.width,
                height: 400,
                child: StreamBuilder<QuerySnapshot>(
                  stream: FirebaseFirestore.instance.collection("siniflar").doc("sinifid.toString()").collection("program").orderBy('gun').snapshots(),
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



        ],
      ),
    );
  }

  void veritabanikayit(String sinifid){
    _firebaseIslemleri.ogrenciDersPorgramiAta(ProgramMapPazartesi, sinifid.toString());
    _firebaseIslemleri.ogrenciDersPorgramiAta(ProgramMapSali, sinifid.toString());
    _firebaseIslemleri.ogrenciDersPorgramiAta(ProgramMapCarsamba, sinifid.toString());
    _firebaseIslemleri.ogrenciDersPorgramiAta(ProgramMapPersembe, sinifid.toString());
    _firebaseIslemleri.ogrenciDersPorgramiAta(ProgramMapCuma, sinifid.toString());
    _firebaseIslemleri.ogrenciDersPorgramiAta(ProgramMapCumartesi, sinifid.toString());
    _firebaseIslemleri.ogrenciDersPorgramiAta(ProgramMapPazar, sinifid.toString());

    dersprogramiPazar.clear();
    dersprogramiCumartesi.clear();
    dersprogramiCuma.clear();
    dersprogramiPersembe.clear();
    dersprogramiCarsamba.clear();
    dersprogramiSali.clear();
    dersprogramiSali.clear();
  }

  Widget program(DocumentSnapshot _card) {
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


              _card['program'].length==3 ?  DersProgramiCard( sinif: _card['program'][2],saatbaslangic: _card['program'][0],saatbitis: _card['program'][1],ders: _card['program'][1],) :

              _card['program'].length==6 ?
              Column(
                children: [
                  DersProgramiCard( sinif: _card['program'][2],saatbaslangic: _card['program'][0],saatbitis: _card['program'][0]+"40",ders: _card['program'][1],),
                  DersProgramiCard( sinif: _card['program'][6],saatbaslangic: _card['program'][4],saatbitis: _card['program'][5],ders: _card['program'][7],),
                ],
              ) :

              _card['program'].length==9 ?  Column(
                children: [
                  DersProgramiCard( sinif: _card['program'][2],saatbaslangic: _card['program'][0],saatbitis: _card['program'][1],ders: _card['program'][3],),
                  DersProgramiCard( sinif: _card['program'][6],saatbaslangic: _card['program'][4],saatbitis: _card['program'][5],ders: _card['program'][7],),
                  DersProgramiCard( sinif: _card['program'][10],saatbaslangic: _card['program'][8],saatbitis: _card['program'][9],ders: _card['program'][11],),
                ],
              ) :

              _card['program'].length==12 ?  Column(
                children: [
                  DersProgramiCard( sinif: _card['program'][2],saatbaslangic: _card['program'][0],saatbitis: _card['program'][1],ders: _card['program'][3],),
                  DersProgramiCard( sinif: _card['program'][6],saatbaslangic: _card['program'][4],saatbitis: _card['program'][5],ders: _card['program'][7],),
                  DersProgramiCard( sinif: _card['program'][10],saatbaslangic: _card['program'][8],saatbitis: _card['program'][9],ders: _card['program'][11],),
                  DersProgramiCard( sinif: _card['program'][14],saatbaslangic: _card['program'][12],saatbitis: _card['program'][13],ders: _card['program'][15],),
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
