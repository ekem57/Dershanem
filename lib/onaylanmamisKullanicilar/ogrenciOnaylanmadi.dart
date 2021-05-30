import 'package:dershane/common/myButton.dart';
import 'package:dershane/user_state/ogrenci_model_service.dart';
import 'package:flutter/material.dart';
import 'package:dershane/extensions/size_extention.dart';
import 'package:provider/provider.dart';
class OgrenciOnaylanmadi extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final _ogrenciModel = Provider.of<OgrenciModel>(context, listen: true);
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Center(child: Text("Öğrenci Hesabınız Onay Aşamasındadır.",style: TextStyle(fontSize: 17.0.spByWidth),)),
          SizedBox(height: 10,),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Center(child: Text("Hesabınız onaylandıktan sonra giriş işleminiz tamamlanacaktır.",style: TextStyle(fontSize: 17.0.spByWidth))),
          ),
          SizedBox(height: 30.0.h,),
          MyButton(text: "Çıkış Yap", onPressed: (){
            _ogrenciModel.signOut();
          }, textColor: Colors.white, fontSize: 15.0.spByWidth, width: 270.0.w, height: 45.0.h)
        ],
      ),
    );
  }
}
