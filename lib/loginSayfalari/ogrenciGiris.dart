import 'package:dershane/common/alertBilgilendirme.dart';
import 'package:dershane/common/loadingscreen.dart';
import 'package:dershane/common/myButton.dart';
import 'package:dershane/common/myInput.dart';
import 'package:dershane/extensions/renkler.dart';
import 'package:dershane/firebase/fire_auth_hatalar.dart';
import 'package:dershane/loginSayfalari/kayit_sayfasi.dart';
import 'package:dershane/loginSayfalari/resetPassword.dart';
import 'package:dershane/model/ogrenci.dart';
import 'package:dershane/user_state/ogrenci_model_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:dershane/extensions/size_extention.dart';
import 'package:provider/provider.dart';


class OgrenciGiris extends StatefulWidget {
  @override
  _OgrenciGirisState createState() => _OgrenciGirisState();
}

class _OgrenciGirisState extends State<OgrenciGiris> {
  final TextEditingController _emailcontroller = TextEditingController();
  final TextEditingController _sifrecontroller = TextEditingController();
  final _formKey1 = GlobalKey<FormState>();
  bool _validate = false;
  bool _loadingVisible = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: IconThemeData(color: Colors.green),
      ),
      body: LoadingScreen(
        inAsyncCall: _loadingVisible,
        child: ListView(
          children: [
            Form(
              key: _formKey1,
              autovalidate: _validate,
              child: Padding(
                padding:  EdgeInsets.only(top: 20.0.h),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [

                    Center(child: Text("Dershanem",style: GoogleFonts.patuaOne(fontSize: 45.0.spByWidth,color: Colors.green),)),
                    SizedBox(height: 10.0.h,),
                    Center(child: Text("??grenci Giris",style: GoogleFonts.patuaOne(fontSize: 30.0.spByWidth,color: Colors.black),)),
                    SizedBox(height: 50.0.h,),
                    Myinput(hintText:"E-mail" ,icon: Icon(Icons.email,color: Colors.green,),controller: _emailcontroller,keybordType: TextInputType.emailAddress,passwordVisible: false),
                    Myinput(hintText:"??ifre" ,icon: Icon(Icons.lock,color: Colors.green,),controller: _sifrecontroller,keybordType: TextInputType.emailAddress,passwordVisible: true),
                    SizedBox(height: 10.0.h,),
                    Center(
                      child: MyButton(text: "Giri??", fontSize: 18.0.spByWidth,butonColor: Renkler.onayButonColor,width: 300.0.w,height: 50.0.h,
                        onPressed: (){
                          _validateInputs(context);
                        },),
                    ),
                    SizedBox(height: 30.0.h,),
                    Center(
                      child: FlatButton(
                        onPressed: (){ Navigator.push(context, MaterialPageRoute(builder: (context) => ResetPassword()),);},
                        child: Text("??ifremi Unuttum",style: TextStyle(fontSize: 16.0.spByWidth),),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 10),
                          child: Text("Hen??z Kay??tl?? De??il Misin?",style: TextStyle(fontSize: 17.0.spByWidth),),
                        ),

                      ],
                    ),

                    Center(
                      child: FlatButton(
                        onPressed: (){ Navigator.push(context, MaterialPageRoute(builder: (context) => ResetPassword()),);},
                        child: InkWell(
                            onTap: (){
                              Navigator.push(context, MaterialPageRoute(builder: (context) => Kayit_Sayfasi(kayitTuru: "Ogrenci",)),);
                            },
                            child: Text("Kay??t Ol",style: TextStyle(fontSize: 20.0.spByWidth,color: Colors.green,fontWeight: FontWeight.bold),)),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }


  Future<void> _changeLoadingVisible() async {
    setState(() {
      _loadingVisible = !_loadingVisible;
    });
  }



  String validateEmail(String value) {
    Pattern pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regex = new RegExp(pattern);
    if (!regex.hasMatch(value))
      return 'Email Ge??ersiz';
    else
      return null;
  }
  String validateSifre(String value) {
    if (value.length<6)
      return '??ifre Ge??ersiz';
    else
      return null;
  }



  void _validateInputs(BuildContext context) async {
    final _userModel = Provider.of<OgrenciModel>(context,listen: false);

    if (_formKey1.currentState.validate()) {
      SystemChannels.textInput.invokeMethod('TextInput.hide');
      await _changeLoadingVisible();
      try {


        Ogrenci _girisYapanUser = await _userModel.signInWithEmailandPasswordOgrenci(_emailcontroller.text, _sifrecontroller.text);

        Navigator.pop(context);
        if (_girisYapanUser == null){

          setState(() {
            _loadingVisible=false;
          });
        }else{

        }

      } on FirebaseAuthException catch (e) {
        print(e.message);
        var dialogBilgi = AlertBilgilendirme(
          icerik: Hatalar.goster(e.code),
          Pressed: () {
            Navigator.pop(context);
          },
        );

        showDialog(
            context: context,
            builder: (
                BuildContext context) => dialogBilgi);

        setState(() {
          _loadingVisible=false;
        });
      }catch (e) {
        print(e.toString());
        var dialogBilgi = AlertBilgilendirme(
          icerik: "Bir Hata Olu??tu...",
          Pressed: () {
            Navigator.pop(context);
          },
        );

        showDialog(
            context: context,
            builder: (
                BuildContext context) => dialogBilgi);
        setState(() {
          _loadingVisible=false;
        });
      }

    } else {

      setState(() {
        _validate = true;
      });
    }
  }





}
