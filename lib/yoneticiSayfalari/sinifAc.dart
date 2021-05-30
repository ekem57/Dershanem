import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dershane/common/loadingscreen.dart';
import 'package:dershane/common/myButton.dart';
import 'package:dershane/common/myfloatingButton.dart';
import 'package:dershane/common/resimsizCard.dart';
import 'package:dershane/extensions/renkler.dart';
import 'package:dershane/firebase/firebase_database.dart';
import 'package:dershane/locator.dart';
import 'package:flutter/material.dart';
import 'package:dershane/extensions/size_extention.dart';
import 'package:flutter/services.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';


class SinifAc extends StatefulWidget {
  final DocumentSnapshot card;

  SinifAc({ @required this.card});
  @override
  _SinifAcState createState() => _SinifAcState();
}

class _SinifAcState extends State<SinifAc> with SingleTickerProviderStateMixin {
  TabController _tabController;
  String dogumtarih;
  @override
  void initState() {
    super.initState();

  }

  FirestoreDBService _firebaseIslemleri = locator<FirestoreDBService>();

  final sinifController = TextEditingController();

  bool _loadingVisible = false;
  Future<void> _changeLoadingVisible() async {
    setState(() {
      _loadingVisible = !_loadingVisible;
    });
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor:  Renkler.appbarGroundColor,
      appBar: AppBar(
        title: Text("Yeni Sınıf Aç"),
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
          child:  Column(
            children: [

              Padding(
                padding:  EdgeInsets.symmetric(horizontal: 30.0.w),
                child: TextFormField(
                  controller: sinifController,
                  keyboardType: TextInputType.text,
                  autocorrect: false,
                  maxLines: 2,
                  textInputAction: TextInputAction.next,
                  style: TextStyle(fontSize: 15.0.spByWidth),
                  decoration: InputDecoration(
                    labelText: "Sınıf Adı",
                    labelStyle: Theme.of(context).textTheme.caption.copyWith(fontSize: 20.0.spByWidth),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                        color: Theme.of(context).primaryColor,
                        width: 0,
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 10.0.h,),
              Padding(
                padding:  EdgeInsets.symmetric(horizontal: 30.0.w,vertical: 20.0.h),
                child: MyButton(text: "Gönder",
                  onPressed: () async {

                    SystemChannels.textInput.invokeMethod('TextInput.hide');
                    await _changeLoadingVisible();

                    DocumentReference ref= FirebaseFirestore.instance.collection("etidolustur").doc();

                    Map<String, dynamic> SinifAc = Map();


                    SinifAc['sinif'] = sinifController.text;
                    SinifAc['danismanvarmi'] = false;



                    bool veri =  await   _firebaseIslemleri.sinifAc(SinifAc, sinifController.text);
                    if(veri)
                    {
                      await _changeLoadingVisible();
                      Fluttertoast.showToast(
                        msg: "Sinif Açıldı.",
                        toastLength: Toast.LENGTH_LONG,
                        gravity: ToastGravity.BOTTOM,
                        textColor: Colors.white,
                        backgroundColor: Colors.green,
                      );
                      sinifController.clear();
                    }


                  },
                  textColor: Colors.black,
                  fontSize: 17,
                  width: MediaQuery.of(context).size.width,
                  height: 45.0.h,butonColor: Renkler.onayButonColor,
                ),
              ),

              SizedBox(height: 40.0.h,),

            ],
          ),
        ),
      ),
    );
  }


}
