import 'package:dershane/common/myButton.dart';
import 'package:dershane/user_state/ogretmen_model_service.dart';
import 'package:flutter/material.dart';
import 'package:dershane/extensions/size_extention.dart';
import 'package:provider/provider.dart';
class OgretmenOnaylanmadi extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final _ogretmenModel = Provider.of<OgretmenModel>(context, listen: false);

    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Center(child: Text("Öğretmen Hesabınız Onay Aşamasındadır.",style: TextStyle(fontSize: 17.0.spByWidth),)),
          SizedBox(height: 10,),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Center(child: Text("Hesabınız onaylandıktan sonra giriş işleminiz tamamlanacaktır.",style: TextStyle(fontSize: 17.0.spByWidth))),
          ),
          SizedBox(height: 30.0.h,),
          MyButton(text: "Çıkış Yap", onPressed: (){
            _ogretmenModel.signOut();
          }, textColor: Colors.white, fontSize: 15.0.spByWidth, width: 270.0.w, height: 45.0.h)
        ],
      ),
    );
  }
}
