import 'package:dershane/common/loadingscreen.dart';
import 'package:dershane/common/myButton.dart';
import 'package:dershane/firebase/firebase_database.dart';
import 'package:dershane/locator.dart';
import 'package:dershane/user_state/ogrenci_model_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_masked_text/flutter_masked_text.dart';
import 'package:dershane/extensions/size_extention.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';


class TelefonNumarasiGuncelle extends StatefulWidget {
  @override
  _TelefonNumarasiGuncelleState createState() => _TelefonNumarasiGuncelleState();
}
var controller = new MaskedTextController(mask: '000-000-00-00');
FirestoreDBService _firestoreDBService = locator<FirestoreDBService>();
class _TelefonNumarasiGuncelleState extends State<TelefonNumarasiGuncelle> {
  bool _loadingVisible = false;
  Future<void> _changeLoadingVisible() async {
    setState(() {
      _loadingVisible = !_loadingVisible;
    });
  }
  @override
  Widget build(BuildContext context) {
    final _ogrenciModel = Provider.of<OgrenciModel>(context, listen: true);
    return Scaffold(
      appBar: AppBar(),
      body: LoadingScreen(
        inAsyncCall: _loadingVisible,
        child: Column(
          children: [
            SizedBox(height: 40.0.h,),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 17,vertical: 10),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(50),
                  boxShadow: <BoxShadow>[
                    BoxShadow(color: Colors.grey.withOpacity(0.8), offset: const Offset(4, 4), blurRadius: 8),
                  ],
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: SizedBox(
                    height: 60,
                    child: Padding(
                      padding: const EdgeInsets.only(top: 0, left: 0),
                      child: TextFormField(

                        controller:  controller,
                        autocorrect: false,
                        keyboardType: TextInputType.number,
                        style: const TextStyle(
                          color: const Color(0xff343633),
                          fontWeight: FontWeight.w600,
                          fontFamily: "OpenSans",
                          fontStyle: FontStyle.normal,
                          fontSize: 20.0,),
                        cursorColor: Colors.blue,
                        decoration: InputDecoration(
                          prefixIcon:  Icon(
                            Icons.phone_android_sharp,
                            size: 25.0.w,
                            color: Colors.green,
                          ),
                          errorStyle: TextStyle(fontSize: 12),
                          border: InputBorder.none,
                          // contentPadding:  const EdgeInsets.only(top: 40,left: 30),
                          hintText: "5xx - xxx - xx - xx",
                          hintStyle: TextStyle(
                              color: Colors.black87,
                              fontSize: 20
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(height: 20.0.h,),
            MyButton(text: "Güncelle", onPressed: () async {
              SystemChannels.textInput.invokeMethod('TextInput.hide');
              await _changeLoadingVisible();
              _ogrenciModel.user.telefon="+90"+controller.text;
             bool veri= await _firestoreDBService.ogrenciTelefonGuncelle(_ogrenciModel.user.userId,"+90"+controller.text);

              if(veri)
              {
                await _changeLoadingVisible();
                Fluttertoast.showToast(
                  msg: "Güncelleme Tamamlandı.",
                  toastLength: Toast.LENGTH_LONG,
                  gravity: ToastGravity.BOTTOM,
                  textColor: Colors.white,
                  backgroundColor: Colors.green,
                );

              }

            }, textColor: Colors.white, fontSize: 16.0.spByWidth, width: 280.0.w, height: 45.0.h),

          ],
        ),
      ),
    );
  }
}
