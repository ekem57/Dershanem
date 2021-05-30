import 'package:flutter/material.dart';
import 'package:dershane/extensions/size_extention.dart';
class OgretmenOnaylanmadi extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text("Öğretmen Hesabınız Onay Aşamasındadır.",style: TextStyle(fontSize: 17.0.spByWidth),),
          Text("Hesabınız onaylandıktan sonra giriş işleminiz tamamlanacaktır.",style: TextStyle(fontSize: 17.0.spByWidth)),
        ],
      ),
    );
  }
}
