import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dershane/common/dersProgramiCard.dart';
import 'package:dershane/firebase/firebase_database.dart';
import 'package:dershane/locator.dart';
import 'package:excel/excel.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';

class SinavNotlari extends StatefulWidget {
  @override
  _SinavNotlariState createState() => _SinavNotlariState();
}
FirestoreDBService _firebaseIslemleri = locator<FirestoreDBService>();

class _SinavNotlariState extends State<SinavNotlari> {
  List<String> dersprogramiPazartesi= [];
  List<String> dersprogramiSali= [];
  List<String> dersprogramiCarsamba= [];
  List<String> dersprogramiPersembe= [];
  List<String> dersprogramiCuma= [];
  List<String> dersprogramiCumartesi= [];
  List<String> dersprogramiPazar = [];
  String ogrencino;
  String Sayisal;
  String Sozel;
  String EsitAgirlik;
  String SayisalSiralama;
  String SozelSiralama;
  String EsitAgirlikSiralama;
  String SinavBaslik;
  List<String> haftalikgunler = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

  }

  Map<String, dynamic> SinavNotlari = Map();



  @override
  Widget build(BuildContext context) {
    return   Scaffold(
      appBar: AppBar(
        title: Text("Öğrenci Sınav Notları"),
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

                  SinavNotlari.clear();



                  FilePickerResult result = await FilePicker.platform.pickFiles();

                  if(result != null) {
                    File file = File(result.files.single.path);
                    print("dosya yolu: "+result.files.single.path);
                    // var file = "Path_to_pre_existing_Excel_File/excel_file.xlsx";
                    var bytes = File(result.files.single.path).readAsBytesSync();
                    var excel = Excel.decodeBytes(bytes);



                    int toplamcolumns;
                    int toplamrows;
                    for (var table in excel.tables.keys) {
                      toplamcolumns = excel.tables[table].maxCols;
                      toplamrows = excel.tables[table].maxRows;
                    }
                    int a=0;
                    print("toplam columns "+toplamcolumns.toString());

                    SinavNotlari['ogrenciNo'] =  ogrencino;
                    SinavNotlari['Sayisal'] = Sayisal;
                    SinavNotlari['Sozel'] = Sozel;
                    SinavNotlari['EsitAgirlik'] = EsitAgirlik;
                    SinavNotlari['SayisalSiralama'] = SayisalSiralama;
                    SinavNotlari['SozelSiralama'] = SozelSiralama;
                    SinavNotlari['EsitAgirlikSiralama'] = EsitAgirlikSiralama;


                    print("toplam veri sutunu: "+toplamrows.toString());

                    for(int i=1;i<toplamrows;i++) {

                      ogrencino = excel.tables["Sayfa1"].rows[i][0].props[0].toString();
                      Sayisal = excel.tables["Sayfa1"].rows[i][1].props[0].toString();
                      Sozel = excel.tables["Sayfa1"].rows[i][2].props[0].toString();
                      EsitAgirlik = excel.tables["Sayfa1"].rows[i][3].props[0].toString();
                      SayisalSiralama = excel.tables["Sayfa1"].rows[i][4].props[0].toString();
                      SozelSiralama = excel.tables["Sayfa1"].rows[i][5].props[0].toString();
                      EsitAgirlikSiralama = excel.tables["Sayfa1"].rows[i][6].props[0].toString();
                      SinavBaslik = excel.tables["Sayfa1"].rows[i][7].props[0].toString();


                      SinavNotlari['ogrenciNo'] =  ogrencino;
                      SinavNotlari['Sayisal'] = Sayisal;
                      SinavNotlari['Sozel'] = Sozel;
                      SinavNotlari['EsitAgirlik'] = EsitAgirlik;
                      SinavNotlari['SayisalSiralama'] = SayisalSiralama;
                      SinavNotlari['SozelSiralama'] = SozelSiralama;
                      SinavNotlari['EsitAgirlikSiralama'] = EsitAgirlikSiralama;
                      SinavNotlari['Sinav'] = SinavBaslik;
                      SinavNotlari['toplamkatilimci'] = toplamrows.toString();

                      print("OGRENCİ Numarası:"+ogrencino);
                      print("OGRENCİ Sayısal:"+SinavBaslik);

                      await _firebaseIslemleri.ogrenciSinavNotlari(SinavNotlari,double.parse(ogrencino).ceil().toString());

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
