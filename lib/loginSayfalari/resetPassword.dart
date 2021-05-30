import 'package:dershane/common/myButton.dart';
import 'package:dershane/common/myInput.dart';
import 'package:dershane/extensions/renkler.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:dershane/extensions/size_extention.dart';

class ResetPassword extends StatefulWidget {
  @override
  _ResetPasswordState createState() => _ResetPasswordState();
}

class _ResetPasswordState extends State<ResetPassword> {
  String _email;
  FirebaseAuth _auth = FirebaseAuth.instance;
  String mesaj = "";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        iconTheme: new IconThemeData(color: Colors.black),
        title:  Text("Sifremi Unuttum",style: TextStyle(fontSize: 30,fontWeight:FontWeight.bold ,color: Colors.black),),
      ),
      body: Center(
        child: ListView(

          children: <Widget>[

            SizedBox(height: 60,),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Myinput(hintText: "E-mail", satir: 1, controller: null,onchange: email, onSaved: null,icon: Icon(Icons.email,color: Colors.green,),validate:validateEmail),
            ),

            Padding(
              padding: EdgeInsets.only(left: 10),
              child:  MyButton(text: "Gönder", butonColor: Renkler.onayButonColor,width: 220.0.w,height: 43.0.h,
                onPressed: (){
                  _sifremiUnuttum(_email);
              },),

            ),

            SizedBox(height: 10,),

          ],
        ),
      ),
    );
  }
  void email(String value) {
    _email=value;
  }
  String validateEmail(String value) {
    Pattern pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regex = new RegExp(pattern);
    if (!regex.hasMatch(value))
      return 'Email geçersiz';
    else
      return null;
  }


  void _sifremiUnuttum(String mail) {
    print(mail);
    _auth.sendPasswordResetEmail(email: mail).then((v){
      setState(() {

        mesaj += "\nSıfırlama maili gönderildi";
      });
    }).catchError((hata){

      setState(() {

        mesaj += "\nŞifremi unuttum mailinde hata $hata";
      });
    });

  }
}
