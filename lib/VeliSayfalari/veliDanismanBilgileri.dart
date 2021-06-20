import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dershane/common/dersProgramiCard.dart';
import 'package:dershane/common/myButton.dart';
import 'package:dershane/common/myfloatingButton.dart';
import 'package:dershane/common/resimsizCard.dart';
import 'package:dershane/extensions/renkler.dart';
import 'package:dershane/firebase/firebase_database.dart';
import 'package:dershane/locator.dart';
import 'package:dershane/user_state/veli_model_service.dart';
import 'package:dershane/yoneticiSayfalari/ogretmeneDanismanlikAta.dart';
import 'package:flutter/material.dart';
import 'package:dershane/extensions/size_extention.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';


class VeliDanismanBilgileri extends StatefulWidget {

  @override
  _VeliDanismanBilgileriState createState() => _VeliDanismanBilgileriState();
}

class _VeliDanismanBilgileriState extends State<VeliDanismanBilgileri> with SingleTickerProviderStateMixin {
  TabController _tabController;
  String dogumtarih;
   DateFormat formatter;
  @override
  void initState() {
    super.initState();
    _tabController = new TabController(length: 2, vsync: this);

    _tabController.addListener(() {
      setState(() {
        print("Tab Index ${_tabController.index}");
      });
    });
    formatter = DateFormat('yyyy-MM-dd');

  }

  FirestoreDBService _firestoreDBService = locator<FirestoreDBService>();
  PageController _controller = PageController(initialPage: 0);
  @override
  Widget build(BuildContext context) {
    final _veliModel = Provider.of<VeliModel>(context, listen: true);

    return Scaffold(

      backgroundColor:  Renkler.appbarGroundColor,
      appBar: AppBar(
        title: Text("Öğrencinin Danışmanı"),
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
        child:
        StreamBuilder<DocumentSnapshot>(
          stream: FirebaseFirestore.instance.collection("ogretmen").doc("BSmKRNS5KRWk3EOjAhSGgBlTIm33").snapshots(),
          builder: (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
            if (!snapshot.hasData) {
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
                dogumtarih = formatter.format(_card['dogumTarihi'].toDate());

                return  Column(children: [

                  Container(
                      width: 120.0.w,
                      height: 120.0.h,
                      margin: EdgeInsets.all(
                          10.0.w
                      ),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(100.0),
                          boxShadow:[
                            BoxShadow(
                                color: Color.fromARGB(60, 0, 0, 0),
                                blurRadius: 5.0,
                                offset: Offset(3.0, 3.0)
                            )
                          ],
                          image: DecorationImage(
                            fit: BoxFit.fill,
                            image: _card['avatarImageUrl'].toString() == "null" ? _card['avatarImageUrl'].toString() == ""  ? AssetImage("assets/image/userprofil.png") : AssetImage("assets/image/userprofil.png")  : NetworkImage(_card['avatarImageUrl'].toString()),
                          )
                      )
                  ),
                  SizedBox(height: 10.0.h,),

                  Center(child: Text(_card['adSoyad'].toString(),style: TextStyle(fontWeight: FontWeight.bold,fontSize: 22),)),

                  SizedBox(height: 20.0.h,),

                  Padding(
                    padding:  EdgeInsets.symmetric(horizontal: 30.0.w),
                    child: Row(children: [
                      Text("E-mail:",style: TextStyle(fontSize: 16.0.spByWidth,fontWeight: FontWeight.bold),),
                      SizedBox(width: 20.0.w,),
                      Text(_card['email'],style: TextStyle(fontSize: 16.0.spByWidth,fontWeight: FontWeight.bold),),
                    ],),
                  ),

                  SizedBox(height: 10.0.h,),

                  Padding(
                    padding:  EdgeInsets.symmetric(horizontal: 30.0.w),
                    child: Row(children: [
                      Text("Telefon:",style: TextStyle(fontSize: 16.0.spByWidth,fontWeight: FontWeight.bold),),
                      SizedBox(width: 20.0.w,),
                      Text(_card['telefon'],style: TextStyle(fontSize: 16.0.spByWidth,fontWeight: FontWeight.bold),),
                    ],),
                  ),

                  SizedBox(height: 10.0.h,),

                  Padding(
                    padding:  EdgeInsets.symmetric(horizontal: 30.0.w),
                    child: Row(children: [
                      Text("Cinsiyet:",style: TextStyle(fontSize: 16.0.spByWidth,fontWeight: FontWeight.bold),),
                      SizedBox(width: 20.0.w,),
                      Text(_card['cinsiyet'],style: TextStyle(fontSize: 16.0.spByWidth,fontWeight: FontWeight.bold),),
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
                      Text(_card['brans'],style: TextStyle(fontSize: 16.0.spByWidth,fontWeight: FontWeight.bold),),
                    ],),
                  ),


                ],);
              },
            );
          },
        ),

      ),
    );
  }


}
