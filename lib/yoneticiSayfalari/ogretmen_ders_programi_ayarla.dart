import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dershane/common/dersProgramiCard.dart';
import 'package:dershane/firebase/firebase_database.dart';
import 'package:dershane/locator.dart';
import 'package:excel/excel.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';

class OgretmenDersProgramiAyarla extends StatefulWidget {
  @override
  _OgretmenDersProgramiAyarlaState createState() => _OgretmenDersProgramiAyarlaState();
}
FirestoreDBService _firebaseIslemleri = locator<FirestoreDBService>();

class _OgretmenDersProgramiAyarlaState extends State<OgretmenDersProgramiAyarla> {
  List<String> dersprogramiPazartesi= [];
  List<String> dersprogramiSali= [];
  List<String> dersprogramiCarsamba= [];
  List<String> dersprogramiPersembe= [];
  List<String> dersprogramiCuma= [];
  List<String> dersprogramiCumartesi= [];
  List<String> dersprogramiPazar = [];
  int ogretmenid=0;
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
  @override
  Widget build(BuildContext context) {
    return   Scaffold(
      appBar: AppBar(),
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

                      ogretmenid= double.parse(excel.tables["Sayfa1"].rows[1][0].props[0].toString()).ceil();


                      int toplamcolumns;
                      int toplamrows;
                      for (var table in excel.tables.keys) {
                        toplamcolumns = excel.tables[table].maxCols;
                        toplamrows = excel.tables[table].maxRows;
                      }
                      int a=0;
                      print("toplam columns "+toplamcolumns.toString());

                      Map<String, dynamic> ProgramMapPazartesi = Map();
                      ProgramMapPazartesi['danismanid'] = ogretmenid.toString();
                      ProgramMapPazartesi['gun'] = 1;
                      ProgramMapPazartesi['program'] = dersprogramiPazartesi;

                      Map<String, dynamic> ProgramMapSali = Map();
                      ProgramMapSali['danismanid'] = ogretmenid.toString();
                      ProgramMapSali['gun'] = 2;
                      ProgramMapSali['program'] = dersprogramiSali;

                      Map<String, dynamic> ProgramMapCarsamba = Map();
                      ProgramMapCarsamba['danismanid'] = ogretmenid.toString();
                      ProgramMapCarsamba['gun'] = 3;
                      ProgramMapCarsamba['program'] = dersprogramiCarsamba;

                      Map<String, dynamic> ProgramMapPersembe = Map();
                      ProgramMapPersembe['danismanid'] =  ogretmenid.toString();
                      ProgramMapPersembe['gun'] = 4;
                      ProgramMapPersembe['program'] = dersprogramiPersembe;

                      Map<String, dynamic> ProgramMapCuma = Map();
                      ProgramMapCuma['danismanid'] =  ogretmenid.toString();
                      ProgramMapCuma['gun'] = 5;
                      ProgramMapCuma['program'] = dersprogramiCuma;

                      Map<String, dynamic> ProgramMapCumartesi = Map();
                      ProgramMapCumartesi['danismanid'] =  ogretmenid.toString();
                      ProgramMapCumartesi['gun'] = 6;
                      ProgramMapCumartesi['program'] = dersprogramiCumartesi;

                      Map<String, dynamic> ProgramMapPazar = Map();
                      ProgramMapPazar['danismanid'] =  ogretmenid.toString();
                      ProgramMapPazar['gun'] = 7;
                      ProgramMapPazar['program'] = dersprogramiPazar;


                    for(int i=1;i<toplamrows;i++) {
                      if (excel.tables["Sayfa1"].rows[0][3].props[0] ==
                          "Pazartesi") {
                        print("1-1 " + excel.tables["Sayfa1"].rows[i][1].props[0]
                            .toString());
                        print("1-2 " + excel.tables["Sayfa1"].rows[i][2].props[0]
                            .toString());
                        print("1-3 " + excel.tables["Sayfa1"].rows[i][3].props[0]
                            .toString());

                        dersprogramiPazartesi.add(excel.tables["Sayfa1"]
                            .rows[i][1].props[0].toString());
                        dersprogramiPazartesi.add(excel.tables["Sayfa1"]
                            .rows[i][2].props[0].toString());
                        dersprogramiPazartesi.add(excel.tables["Sayfa1"]
                            .rows[i][3].props[0].toString());

                        // dersprogramiPazartesi.clear();
                      }
                      if (excel.tables["Sayfa1"].rows[0][4].props[0] == "Salı") {
                        print("1 kere salı");
                        dersprogramiSali.add(excel.tables["Sayfa1"].rows[i][1]
                            .props[0].toString());
                        dersprogramiSali.add(excel.tables["Sayfa1"].rows[i][2]
                            .props[0].toString());
                        dersprogramiSali.add(excel.tables["Sayfa1"].rows[i][4]
                            .props[0].toString());
                       // _firebaseIslemleri.ogretmenDersPorgramiAta(ProgramMapSali, "10");
                        // dersprogramiSali.clear();
                      }
                      if (excel.tables["Sayfa1"].rows[0][5].props[0] ==
                          "Çarşamba") {
                        print("1 kere çarşamba");
                        dersprogramiCarsamba.add(excel.tables["Sayfa1"].rows[i][1]
                            .props[0].toString());
                        dersprogramiCarsamba.add(excel.tables["Sayfa1"].rows[i][2]
                            .props[0].toString());
                        dersprogramiCarsamba.add(excel.tables["Sayfa1"].rows[i][5]
                            .props[0].toString());
                       // _firebaseIslemleri.ogretmenDersPorgramiAta(ProgramMapCarsamba, "10");
                        //dersprogramiCarsamba.clear();
                      }
                      if (excel.tables["Sayfa1"].rows[0][6].props[0] ==
                          "Perşembe") {
                        dersprogramiPersembe.add(excel.tables["Sayfa1"].rows[i][1]
                            .props[0].toString());
                        dersprogramiPersembe.add(excel.tables["Sayfa1"].rows[i][2]
                            .props[0].toString());
                        dersprogramiPersembe.add(excel.tables["Sayfa1"].rows[i][6]
                            .props[0].toString());
                        //_firebaseIslemleri.ogretmenDersPorgramiAta(ProgramMapPersembe, "10");
                        //dersprogramiPersembe.clear();
                      }
                      if (excel.tables["Sayfa1"].rows[0][7].props[0] == "Cuma") {
                        dersprogramiCuma.add(excel.tables["Sayfa1"].rows[i][1]
                            .props[0].toString());
                        dersprogramiCuma.add(excel.tables["Sayfa1"].rows[i][2]
                            .props[0].toString());
                        dersprogramiCuma.add(excel.tables["Sayfa1"].rows[i][7]
                            .props[0].toString());
                        //_firebaseIslemleri.ogretmenDersPorgramiAta(ProgramMapCuma, "10");
                        // dersprogramiCuma.clear();
                      }
                      if (excel.tables["Sayfa1"].rows[0][8].props[0] ==
                          "Cumartesi") {
                        dersprogramiCumartesi.add(excel.tables["Sayfa1"]
                            .rows[i][1].props[0].toString());
                        dersprogramiCumartesi.add(excel.tables["Sayfa1"]
                            .rows[i][2].props[0].toString());
                        dersprogramiCumartesi.add(excel.tables["Sayfa1"]
                            .rows[i][8].props[0].toString());
                       // _firebaseIslemleri.ogretmenDersPorgramiAta(ProgramMapCumartesi, "10");
                        //dersprogramiCumartesi.clear();
                      }
                      if (excel.tables["Sayfa1"].rows[0][9].props[0] == "Pazar") {
                        dersprogramiPazar.add(excel.tables["Sayfa1"].rows[i][1]
                            .props[0].toString());
                        dersprogramiPazar.add(excel.tables["Sayfa1"].rows[i][2]
                            .props[0].toString());
                        dersprogramiPazar.add(excel.tables["Sayfa1"].rows[i][9]
                            .props[0].toString());
                       // _firebaseIslemleri.ogretmenDersPorgramiAta(ProgramMapPazar, "10");
                        // dersprogramiPazar.clear();
                      }

                      print("/////////////");
                    }


                      print("ogretmen id:"+ excel.tables["Sayfa1"].rows[1][0].props[0].toString());
                    _firebaseIslemleri.ogretmenDersPorgramiAta(ProgramMapPazartesi, ogretmenid.toString());
                    _firebaseIslemleri.ogretmenDersPorgramiAta(ProgramMapSali, ogretmenid.toString());
                    _firebaseIslemleri.ogretmenDersPorgramiAta(ProgramMapCarsamba, ogretmenid.toString());
                    _firebaseIslemleri.ogretmenDersPorgramiAta(ProgramMapPersembe, ogretmenid.toString());
                    _firebaseIslemleri.ogretmenDersPorgramiAta(ProgramMapCuma, ogretmenid.toString());
                    _firebaseIslemleri.ogretmenDersPorgramiAta(ProgramMapCumartesi, ogretmenid.toString());
                    _firebaseIslemleri.ogretmenDersPorgramiAta(ProgramMapPazar, ogretmenid.toString());

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
                  stream: FirebaseFirestore.instance.collection("ogretmenprogram").doc(ogretmenid.toString()).collection("program").orderBy('gun').snapshots(),
                  builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
                    print("ogretemen gelen id:"  +ogretmenid.toString());
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
