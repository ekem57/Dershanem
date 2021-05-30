import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dershane/common/duyuruSayfasi.dart';
import 'package:dershane/common/loadingscreen.dart';
import 'package:dershane/common/myButton.dart';
import 'package:dershane/common/myfloatingButton.dart';
import 'package:dershane/common/resimli_card.dart';
import 'package:dershane/common/resimsizCard.dart';
import 'package:dershane/extensions/renkler.dart';
import 'package:dershane/firebase/firebase_database.dart';
import 'package:dershane/kullaniciSayfalari/ogrenciSayfasi.dart';
import 'package:dershane/locator.dart';
import 'package:dershane/user_state/ogretmen_model_service.dart';
import 'package:dershane/yoneticiSayfalari/ogrenciSec.dart';
import 'package:flutter/material.dart';
import 'package:dershane/extensions/size_extention.dart';
import 'package:flutter/services.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:provider/provider.dart';


class SinifaOgrenciAta extends StatefulWidget {
  final DocumentSnapshot card;

  SinifaOgrenciAta({ @required this.card});
  @override
  _SinifaOgrenciAtaState createState() => _SinifaOgrenciAtaState();
}

class _SinifaOgrenciAtaState extends State<SinifaOgrenciAta> with SingleTickerProviderStateMixin {


  FirestoreDBService _firebaseIslemleri = locator<FirestoreDBService>();

  final sinifController = TextEditingController();

  bool _loadingVisible = false;
  Future<void> _changeLoadingVisible() async {
    setState(() {
      _loadingVisible = !_loadingVisible;
    });
  }
  TabController _tabController;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(child: Icon(Icons.add,),onPressed: (){
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => OgrenciSec(
                card: widget.card,
              )),
        );
      },),
      backgroundColor:  Renkler.appbarGroundColor,
      appBar: AppBar(
        title: Text(widget.card['sinif'].toString()+"  Sınıfı"),
        elevation: 0.0,
        brightness: Brightness.dark,
        toolbarHeight: 80.0.h,
        backgroundColor: Renkler.appbarGroundColor,
      ),

      body: LoadingScreen(
        inAsyncCall: _loadingVisible,
        child: Container(
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
          child:  ListView(
            children: [

              StreamBuilder<QuerySnapshot>(
                stream: FirebaseFirestore.instance.collection("siniflar").doc(widget.card.id).collection("ogrenciler").snapshots(),
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
                      final DocumentSnapshot _cardYonetici = snapshot.data.docs[index];

                      return StreamBuilder<DocumentSnapshot>(
                        stream: FirebaseFirestore.instance.collection("ogrenci").doc(_cardYonetici.id).snapshots(),
                        builder: (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
                          if (!snapshot.hasData)
                            return Center(
                              child: CircularProgressIndicator(),
                            );

                          return ListView.builder(
                            shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics(),
                            itemCount: 1,
                            itemBuilder: (_, int index) {
                              final DocumentSnapshot _card = snapshot.data;

                              return  Slidable(
                                actionPane: SlidableDrawerActionPane(),
                                actionExtentRatio: 0.45,
                                child: ResimliCard(
                                    textSubtitle: null,
                                    textTitle: _card['adSoyad'].toString(),
                                    onPressed: () {

                                    },
                                    fontSize: 12,
                                    img: _card['avatarImageUrl'].toString(),
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
                                          await _card.reference.update({'danisman':"Boşta",'dershaneSinifi':"Bosta"});
                                          await _cardYonetici.reference.delete();
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
                      );
                    },
                  );
                },
              ),
              SizedBox(height: 40.0.h,),

            ],
          ),
        ),
      ),
    );
  }


}
