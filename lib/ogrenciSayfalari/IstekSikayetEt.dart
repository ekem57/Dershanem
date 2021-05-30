import 'package:dershane/common/loadingscreen.dart';
import 'package:dershane/common/myButton.dart';
import 'package:dershane/extensions/renkler.dart';
import 'package:dershane/firebase/firebase_database.dart';
import 'package:dershane/locator.dart';
import 'package:dershane/user_state/ogrenci_model_service.dart';
import 'package:flutter/material.dart';
import 'package:dershane/extensions/size_extention.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';


class IstekSikayetEt extends StatefulWidget {
  @override
  _IstekSikayetEtState createState() => _IstekSikayetEtState();
}


class _IstekSikayetEtState extends State<IstekSikayetEt> {


  final aciklamaController = TextEditingController();

  FirestoreDBService _firebaseIslemleri = locator<FirestoreDBService>();

  bool _loadingVisible = false;
  Future<void> _changeLoadingVisible() async {
    setState(() {
      _loadingVisible = !_loadingVisible;
    });
  }

  @override
  Widget build(BuildContext context) {


    return Scaffold(

      extendBody: true,
      backgroundColor: Renkler.backGroundColor,
      appBar:  AppBar(
        backgroundColor: Renkler.backGroundColor,
        elevation: 0,
        iconTheme: new IconThemeData(color: Renkler.appbarIconColor),
        toolbarHeight: 70.0.h,
        title: Center(

          child: Padding(
            padding:  EdgeInsets.only(right: 40.0.w),
            child: Text(
                "İstek - Şikayet",
                style: TextStyle(
                    color:  Renkler.appbarTextColor,
                    fontWeight: FontWeight.w700,
                    fontFamily: "OpenSans",
                    fontStyle:  FontStyle.normal,
                    fontSize: 20.0.spByWidth
                ),
                textAlign: TextAlign.center
            ),
          ),
        ),


      ),
      body: LoadingScreen(
        inAsyncCall: _loadingVisible,
        child: ClipRRect(
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


                SizedBox(
                  height: 10.0.h,
                ),


                Padding(
                  padding:  EdgeInsets.symmetric(horizontal: 30.0.w),
                  child: TextFormField(
                    controller: aciklamaController,
                    keyboardType: TextInputType.text,
                    autocorrect: false,
                    maxLines: 5,
                    textInputAction: TextInputAction.next,
                    style: TextStyle(fontSize: 15.0.spByWidth),
                    decoration: InputDecoration(
                      labelText: "Açıklama",
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
                      final _ogrenciModel = Provider.of<OgrenciModel>(context, listen: false);
                      SystemChannels.textInput.invokeMethod('TextInput.hide');
                      await _changeLoadingVisible();
                      Map<String, dynamic> IstekBilgileri = Map();

                      IstekBilgileri['gonderenEmail'] = _ogrenciModel.user.email;
                      IstekBilgileri['gonderenFoto'] = _ogrenciModel.user.avatarImageUrl;
                      IstekBilgileri['gonderenIsim'] = _ogrenciModel.user.adsoyad;
                      IstekBilgileri['gonderenTelefon'] = _ogrenciModel.user.telefon;
                      IstekBilgileri['sikayet'] = aciklamaController.text;
                      IstekBilgileri['userid'] = _ogrenciModel.user.userId;
                      IstekBilgileri['tarih'] = DateTime.now();

                    bool veri =  await _firebaseIslemleri.ogrenciIstekSikayet(IstekBilgileri, _ogrenciModel.user.userId);

                      if(veri)
                      {
                        await _changeLoadingVisible();
                        Fluttertoast.showToast(
                          msg: "Tavsiye Verildi.",
                          toastLength: Toast.LENGTH_LONG,
                          gravity: ToastGravity.CENTER,
                          textColor: Colors.white,
                          backgroundColor: Colors.green,
                        );
                        aciklamaController.clear();
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
      ),



    );
  }




}
