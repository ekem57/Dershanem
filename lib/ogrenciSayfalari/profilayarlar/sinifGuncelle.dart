import 'package:dershane/common/loadingscreen.dart';
import 'package:dershane/common/myButton.dart';
import 'package:dershane/extensions/renkler.dart';
import 'package:dershane/firebase/firebase_database.dart';
import 'package:dershane/locator.dart';
import 'package:dershane/user_state/ogrenci_model_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_masked_text/flutter_masked_text.dart';
import 'package:dershane/extensions/size_extention.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';


class SinifGuncelle extends StatefulWidget {
  @override
  _SinifGuncelleState createState() => _SinifGuncelleState();
}
var controller = new MaskedTextController(mask: '000-000-00-00');
String sinif="1.Sınıf";
FirestoreDBService _firestoreDBService = locator<FirestoreDBService>();

class _SinifGuncelleState extends State<SinifGuncelle> {
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
              padding: const EdgeInsets.symmetric(horizontal: 17),
              child: DropdownButtonFormField(

                decoration: new InputDecoration(

                  enabledBorder:OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(30)),

                  ),
                  fillColor: Colors.white,
                  focusColor: Renkler.reddetButonColor,
                  errorStyle: Theme.of(context)
                      .textTheme
                      .caption
                      .copyWith(fontSize: 12.0.spByWidth, color: Colors.red),

                ),
                value: sinif,
                items: ["1.Sınıf", "2.Sınıf", "3.Sınıf", "4.Sınıf","5.Sınıf","6.Sınıf","7.Sınıf","8.Sınıf","9.Sınıf","10.Sınıf","11.Sınıf","12.Sınıf","Mezun"].map((e) {
                  return DropdownMenuItem(value: e , child: Text(e));
                }).toList(),
                onChanged: (newValue) {
                  sinif = newValue;
                },
              ),
            ),

            SizedBox(height: 20.0.h,),
            MyButton(text: "Güncelle", onPressed: () async {
              SystemChannels.textInput.invokeMethod('TextInput.hide');
              await _changeLoadingVisible();
              _ogrenciModel.user.sinif=sinif;
            bool veri= await  _firestoreDBService.ogrenciSinifGuncelle(_ogrenciModel.user.userId,sinif);
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
