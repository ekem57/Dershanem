import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dershane/LandingPage.dart';
import 'package:dershane/common/loadingscreen.dart';
import 'package:dershane/common/myButton.dart';
import 'package:dershane/common/myInput.dart';
import 'package:dershane/extensions/renkler.dart';
import 'package:dershane/extensions/size_extention.dart';
import 'package:dershane/firebase/fire_auth_hatalar.dart';
import 'package:dershane/firebase/firebase_auth_service.dart';
import 'package:dershane/firebase/firebase_database.dart';
import 'package:dershane/locator.dart';
import 'package:dershane/model/ogrenci.dart';
import 'package:dershane/model/ogretmenModel.dart';
import 'package:dershane/model/veliModel.dart';
import 'package:dershane/model/yoneticiModel.dart';
import 'package:dershane/repository/ogrenci_repo.dart';
import 'package:dershane/repository/ogretmen_repo.dart';
import 'package:dershane/repository/veli_repo.dart';
import 'package:dershane/user_state/ogrenci_model_service.dart';
import 'package:dershane/user_state/ogretmen_model_service.dart';
import 'package:dershane/user_state/veli_model_service.dart';
import 'package:dershane/user_state/yonetici_model_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_masked_text/flutter_masked_text.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:provider/provider.dart';

class Kayit_Sayfasi extends StatefulWidget {
  String kayitTuru;
  Kayit_Sayfasi({@required this.kayitTuru});
  @override
  _Kayit_SayfasiState createState() => _Kayit_SayfasiState();
}

class _Kayit_SayfasiState extends State<Kayit_Sayfasi> {

  bool isValid = false;

  final TextEditingController _adsoyadcontroller = TextEditingController();
  final TextEditingController _emailcontroller = TextEditingController();
  final TextEditingController _sifrecontroller = TextEditingController();
  final TextEditingController _sifretekrarcontroller = TextEditingController();
  final TextEditingController _ogrenciId = TextEditingController();

  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;


  OgretmenRepo _ogretmenRepo = locator<OgretmenRepo>();
  FirestoreDBService _firestoreDBService = locator<FirestoreDBService>();
  OgrenciRepo _ogrenciRepo = locator<OgrenciRepo>();
  VeliRepo _veliRepo = locator<VeliRepo>();
  FirebaseAuthService _firebaseAuthService = locator<FirebaseAuthService>();

  var controller = new MaskedTextController(mask: '000-000-00-00');
  var _phoneNumberController2 = new MaskTextInputFormatter(mask: '### - ### - ## - ##', filter: { "#": RegExp(r'[0-9]') });
  bool isCodeSent = false;
  String ogrenimDurumu="İlk Öğretim";
  String userbolum="Matematik Fen";
  String cinsiyet="Erkek";
  String sinif="1.Sınıf";
  String ogretmenbrans="Matematik";
  String _sifre;
  String _sifretekrar;
  String il = "Seciniz";
  String okul = "Seciniz";

  bool _autoValidate = false;
  final _formKey1 = GlobalKey<FormState>();


  DateTime _dateTime=DateTime.now();
  final f = new DateFormat('yyyy-MM-dd');

 static List<String> okulList=["Seciniz"];

  @override
  void initState() {
    super.initState();
    okulList=["Seciniz"];
   _firestoreDBService.okulGetir().then(( value) {
     print("gelen okul son"+value.last);
     okulList.addAll(value);
     setState(() {

     });

   });


  }
  bool _loadingVisible = false;
  Future<void> _changeLoadingVisible() async {
    setState(() {
      _loadingVisible = !_loadingVisible;
    });
  }
  @override
  Widget build(BuildContext context) {
    final _modelogrenci = Provider.of<OgrenciModel>(context);
    final _modelogretmen = Provider.of<OgretmenModel>(context);
    final _modelveli= Provider.of<VeliModel>(context);
    final _modelyonetici= Provider.of<YoneticiModel>(context);
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios,
          ),
          color: Colors.black,
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: LoadingScreen(
        inAsyncCall: _loadingVisible,
        child: ListView(

          children: <Widget>[
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[


                Form(
                  key: _formKey1,
                  autovalidate: _autoValidate,
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      SizedBox(height: 10,),
                      Center(child: Text("KAYIT SAYFASI",style: TextStyle(fontSize: 30,fontWeight: FontWeight.bold),)),

                      Myinput(hintText: "Ad Soyad", satir: 1, controller: _adsoyadcontroller, onSaved: null,icon: Icon(Icons.accessibility,color: Colors.green,),validate:validateName,keybordType: TextInputType.name,passwordVisible: false),
                      Myinput(hintText: "E-mail", satir: 1, controller: _emailcontroller, icon: Icon(Icons.accessibility,color: Colors.green),validate: validateEmail,keybordType: TextInputType.emailAddress,passwordVisible: false),
                      Myinput(hintText: "Şifre", satir: 1, controller: _sifrecontroller, onSaved: null,icon: Icon(Icons.lock,color: Colors.green),validate: validateSifre,keybordType: TextInputType.visiblePassword,passwordVisible: true),
                      Myinput(hintText: "Şifre Tekrar", satir: 1, controller: _sifretekrarcontroller, onSaved:null,icon: Icon(Icons.lock,color: Colors.green),validate: validateSifre,keybordType: TextInputType.visiblePassword,passwordVisible: true),
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
                      widget.kayitTuru ==  "Veli" ? SizedBox(height: 20.0.h,) : Container(),
                      widget.kayitTuru ==  "Veli" ? Myinput(hintText: "Öğrenci Numarası", satir: 1, controller: _ogrenciId, onSaved:null,icon: Icon(Icons.school,color: Colors.green),keybordType: TextInputType.number,passwordVisible: false) :Container(),

                      widget.kayitTuru !=  "Veli" ? widget.kayitTuru == "Yonetim" ? SizedBox(height: 20.0.h,) : Container() : Container(),
                      widget.kayitTuru !=  "Veli" ?  widget.kayitTuru == "Yonetim" ?
                      Padding(
                        padding:  EdgeInsets.only(left: 25.0.w,bottom: 10.0.h),
                        child: Text("Doğum Tarihi:",style: TextStyle(fontSize: 18.0.spByWidth),),
                      ) :Container() :Container(),
                      widget.kayitTuru !=  "Veli" ?   widget.kayitTuru == "Yonetim" ? GestureDetector(
                        onTap: () {
                          showModalBottomSheet(
                              context: context,
                              builder: (BuildContext bc){
                                return  Container(
                                    height: MediaQuery.of(context).copyWith().size.height / 3,
                                    child: CupertinoDatePicker(

                                      onDateTimeChanged: (DateTime newdate) {
                                        setState(() {
                                          _dateTime = newdate;
                                        });
                                      },
                                      maximumYear: 2021,
                                      initialDateTime: DateTime.now(),
                                      mode: CupertinoDatePickerMode.date,
                                    ));
                              }
                          );

                        },
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 17),
                          child: DropdownButtonFormField(
                            onTap: () {
                              showModalBottomSheet(
                                  context: context,
                                  builder: (BuildContext bc){
                                    return  Container(
                                        height: MediaQuery.of(context).copyWith().size.height / 3,
                                        child: CupertinoDatePicker(

                                          onDateTimeChanged: (DateTime newdate) {
                                            setState(() {
                                              _dateTime = newdate;
                                            });
                                          },
                                          maximumYear: 2021,
                                          initialDateTime: DateTime.now(),
                                          mode: CupertinoDatePickerMode.date,
                                        ));
                                  }
                              );

                            },
                            hint: Text( _dateTime == null ? "" : formatTheDate(_dateTime, format: DateFormat("dd.MM.y")),),

                            decoration: new InputDecoration(

                              enabledBorder:OutlineInputBorder(
                                borderRadius: BorderRadius.all(Radius.circular(30)),

                              ),
                              prefixIcon:  Icon(
                              Icons.date_range,
                              size: 25.0.w,
                              color: Colors.green,
                            ),
                              fillColor: Colors.white,
                              focusColor: Renkler.reddetButonColor,
                              errorStyle: Theme.of(context)
                                  .textTheme
                                  .caption
                                  .copyWith(fontSize: 12.0.spByWidth, color: Colors.red),

                            ),

                          ),
                        ),
                      ) : Container() : Container(),
                      SizedBox(height: 20.0.h,),
                      widget.kayitTuru ==  "Ogretmen" ? Padding(
                        padding:  EdgeInsets.only(left: 25.0.w,bottom: 10.0.h),
                        child: Text("Brans:",style: TextStyle(fontSize: 18.0.spByWidth),),
                      ) :Container(),
                      widget.kayitTuru ==  "Ogretmen" ?
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
                          value: ogretmenbrans,
                          items: ["Matematik", "Türkçe", "Sosyal", "Fen","Fizik","Kimya","Biyoloji"].map((e) {
                            return DropdownMenuItem(value: e , child: Text(e));
                          }).toList(),
                          onChanged: (newValue) {
                            ogretmenbrans = newValue;
                          },
                        ),
                      ) :
                          Container(),
                      widget.kayitTuru ==  "Ogrenci" ? Padding(
                        padding:  EdgeInsets.only(left: 25.0.w,bottom: 10.0.h),
                        child: Text("Öğrenim Durumu:",style: TextStyle(fontSize: 18.0.spByWidth),),
                      ) :Container(),
                      widget.kayitTuru ==  "Ogrenci" ?  Padding(
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
                          value: ogrenimDurumu,
                          items: ["İlk Öğretim", "Orta Öğretim", "Lise", "Mezun"].map((e) {
                            return DropdownMenuItem(value: e , child: Text(e));
                          }).toList(),
                          onChanged: (newValue) {
                            ogrenimDurumu = newValue;
                          },
                        ),
                      ):Container(),
                      widget.kayitTuru ==  "Ogrenci" ?  SizedBox(height: 20.0.h,) : Container(),
                      widget.kayitTuru ==  "Ogrenci" ? Padding(
                        padding:  EdgeInsets.only(left: 25.0.w,bottom: 10.0.h),
                        child: Text("Sınıf:",style: TextStyle(fontSize: 18.0.spByWidth),),
                      ) :Container(),
                      widget.kayitTuru ==  "Ogrenci" ?
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
                      ):Container(),
                      widget.kayitTuru ==  "Ogrenci" ? SizedBox(height: 20.0.h,) : Container(),
                      widget.kayitTuru ==  "Ogrenci" ? Padding(
                        padding:  EdgeInsets.only(left: 25.0.w,bottom: 10.0.h),
                        child: Text("Bolüm:",style: TextStyle(fontSize: 18.0.spByWidth),),
                      ) :Container(),
                      widget.kayitTuru ==  "Ogrenci" ?  Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 17),
                        child:  DropdownButtonFormField(

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
                         value: userbolum,
                          items: ["Matematik Fen","Türkçe Matematik", "Sözel"].map((e) {
                            return DropdownMenuItem(value: e, child: Text(e));
                          }).toList(),
                          onChanged: (newValue) {
                            userbolum = newValue;
                          },
                        ),
                      ):Container(),
                      widget.kayitTuru ==  "Ogrenci" ? SizedBox(height: 20.0.h,):Container(),
                      widget.kayitTuru ==  "Ogrenci" ? Padding(
                        padding:  EdgeInsets.only(left: 25.0.w,bottom: 10.0.h),
                        child: Text("Okul:",style: TextStyle(fontSize: 18.0.spByWidth),),
                      ) :Container(),
                      widget.kayitTuru ==  "Ogrenci" ? Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 17),
                        child:  DropdownButtonFormField(

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
                          value: okul,
                          items: okulList.map((e) {
                            print(e);
                            return DropdownMenuItem(value: e, child: Text(e));
                          }).toList(),
                          onChanged: (newValue) {
                            print(newValue);
                            okul = newValue;
                          },
                        ),
                      ):Container(),
                      SizedBox(height: 20.0.h,),
                      Padding(
                        padding:  EdgeInsets.only(left: 25.0.w,bottom: 10.0.h),
                        child: Text("Cinsiyet:",style: TextStyle(fontSize: 18.0.spByWidth),),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 17),
                        child:  DropdownButtonFormField(

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
                          value: cinsiyet,
                          items: ["Erkek","Kadın"].map((e) {
                            return DropdownMenuItem(value: e, child: Text(e));
                          }).toList(),
                          onChanged: (newValue) {

                              cinsiyet = newValue;


                          },
                        ),
                      ),
                      SizedBox(height: 30.0.h,),
                      Center(
                        child: MyButton(text: "Kayıt Ol", fontSize: 18.0.spByWidth,butonColor: Renkler.onayButonColor,width: 300.0.w,height: 50.0.h,
                          onPressed: () async {
                            if (_formKey1.currentState.validate()) {

                              bool emailkontrol = await emailchecked();
                              if(!emailkontrol){
                                Fluttertoast.showToast(
                                  msg: "Bu email daha önce kullanılmış!",
                                  toastLength: Toast.LENGTH_LONG,
                                  gravity: ToastGravity.BOTTOM,
                                  textColor: Colors.black,
                                  backgroundColor: Colors.white,
                                );
                              }else {
                                SystemChannels.textInput.invokeMethod('TextInput.hide');
                                await _changeLoadingVisible();
                                if(widget.kayitTuru=="Ogretmen"){
                                  print("öğretmene girdi");
                                  Ogretmen _ogretmen= Ogretmen(telefon: "+90"+controller.text.replaceAll('-', ''),email:_emailcontroller.text,adsoyad: _adsoyadcontroller.text,brans:ogretmenbrans ,cinsiyet: cinsiyet,dogumTarihi: _dateTime,);


                                  try{
                                    Ogretmen ogretmen = await _modelogretmen.createUserWithEmailandPasswordOgretmen(_emailcontroller.text, _sifrecontroller.text, _ogretmen);
                                    print("ogretmen kayit gelen user:"+ogretmen.toString());
                                    if(ogretmen!=null){
                                      Navigator.of(context).push(MaterialPageRoute(builder: (context) => LandingPage()));
                                    }
                                  }catch(e){

                                    Fluttertoast.showToast(
                                      msg: Hatalar.goster(e.toString()),
                                      toastLength: Toast.LENGTH_LONG,
                                      gravity: ToastGravity.BOTTOM,
                                      textColor: Colors.black,
                                      backgroundColor: Colors.white,
                                    );


                                    await _changeLoadingVisible();
                                  }

                                }else if(widget.kayitTuru=="Ogrenci"){
                                  print("ogrenciye girdi");
                                  Ogrenci _ogr= Ogrenci(telefon: "+90"+controller.text.replaceAll('-', ''),email:_emailcontroller.text,adsoyad: _adsoyadcontroller.text,bolum: userbolum,sinif: sinif,cinsiyet: cinsiyet,dogumTarihi: _dateTime,okul: okul  );
                                      try{
                                      Ogrenci ogr= await _modelogrenci.createUserWithEmailandPasswordOgrenci(_emailcontroller.text, _sifrecontroller.text, _ogr);
                                        if(ogr!=null){
                                          Navigator.of(context).push(MaterialPageRoute(builder: (context) => LandingPage()));
                                        }
                                      }catch(e){
                                        Fluttertoast.showToast(
                                          msg: Hatalar.goster(e.toString()),
                                          toastLength: Toast.LENGTH_LONG,
                                          gravity: ToastGravity.BOTTOM,
                                          textColor: Colors.black,
                                          backgroundColor: Colors.white,
                                        );
                                        await _changeLoadingVisible();
                                      }


                                }else if(widget.kayitTuru=="Veli"){
                                  print("veli girdi");
                                  Veli _veli= Veli(telefon: "+90"+controller.text.replaceAll('-', ''),email:_emailcontroller.text,adsoyad: _adsoyadcontroller.text,cinsiyet: cinsiyet,danisman: null,ogrencisininIdsi: _ogrenciId.text);

                                  try{
                                    Veli veli= await _modelveli.createUserWithEmailandPasswordVeli(_emailcontroller.text, _sifrecontroller.text, _veli);
                                    if(veli!=null){
                                      Navigator.of(context).push(MaterialPageRoute(builder: (context) => LandingPage()));
                                    }
                                  }catch(e){
                                    Fluttertoast.showToast(
                                      msg: Hatalar.goster(e.toString()),
                                      toastLength: Toast.LENGTH_LONG,
                                      gravity: ToastGravity.BOTTOM,
                                      textColor: Colors.black,
                                      backgroundColor: Colors.white,
                                    );
                                    await _changeLoadingVisible();
                                  }
                                }
                                else if(widget.kayitTuru=="Yonetici"){

                                  Yonetici _yonetici= Yonetici(telefon: "+90"+controller.text.replaceAll('-', ''),email:_emailcontroller.text,adsoyad: _adsoyadcontroller.text,hesaponay: false);

                                  try{
                                    Yonetici yonetici= await _modelyonetici.createUserWithEmailandPasswordYonetici(_emailcontroller.text, _sifrecontroller.text, _yonetici);
                                    if(yonetici!=null){
                                      Navigator.of(context).push(MaterialPageRoute(builder: (context) => LandingPage()));
                                    }
                                  }catch(e){

                                    Fluttertoast.showToast(
                                      msg: Hatalar.goster(e.toString()),
                                      toastLength: Toast.LENGTH_LONG,
                                      gravity: ToastGravity.BOTTOM,
                                      textColor: Colors.black,
                                      backgroundColor: Colors.white,
                                    );

                                    await _changeLoadingVisible();
                                  }
                                }

                              }
                            }
                          },),
                      ),
                      SizedBox(height: 80.0.h,),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      )
    );
  }

  Future<bool> emailchecked() async {
    QuerySnapshot qn= await FirebaseFirestore.instance.collection("users").where("email",isEqualTo: _emailcontroller.text).get();
    if( qn.docs.length > 0 ){
      return false ;
    }else{
      return true;
    }

  }


  String formatTheDate(DateTime selectedDate, {DateFormat format}) {
    final DateTime now = selectedDate;
    final DateFormat formatter = format ?? DateFormat('dd.MM.y', "tr_TR");
    final String formatted = formatter.format(now);
    initializeDateFormatting("tr_TR");
    return formatted;
  }




  void sifre(String value) {
    _sifre=value.trim();
  }
  void sifretekrar(String value) {
    _sifretekrar=value.trim();
  }


  String validateName(String value) {
    if (value.length < 3)
      return 'İsminiz en az 3 karakter olmalıdır.';
    else
      return null;
  }

  String validateSurname(String value) {
    if (value.length < 3)
      return 'Soyisminiz en az 3 karakter olmalıdır.';
    else
      return null;
  }

  String validateNick(String value)  {

    if (value.length < 3)
      return 'Kullanıcı adınız en az 3 karakter olmalıdır.';
    else{

    }
  }

  String validate()  {

    if (_phoneNumberController2.getUnmaskedText().length == 11) {
      return 'Lütfen 11 Haneli Telefon Numaranızı Giriniz';
    }else
      return null;
  }

  Future<bool> nicknamecheck(String nick) async {
    final result = await FirebaseFirestore.instance
        .collection('users')
        .where('userName', isEqualTo: nick)
        .get();
    return result.docs.isEmpty;
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

  String validateSifre(String value)  {

    if (value.length < 6)
      return 'Şifreniz 6 karakterden daha az olamaz.';
    else if (_sifre != _sifretekrar)
      return "Şifreler aynı olmalıdır.";
    else
      return null;

  }

  String validateTel(String value)  {

    if (_phoneNumberController2.getUnmaskedText().length != 11)
      return 'Lütfen 11 Haneli Telefon Numaranızı Giriniz';
    else
      return null;

  }

  Future<bool> emailcheck(String email) async {

    final result = await FirebaseFirestore.instance
        .collection('users')
        .where('email', isEqualTo: email)
        .get();
    return result.docs.isEmpty;
  }


  void showToast(message, Color color) {
    print(message);

    Fluttertoast.showToast(

        msg: message,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: color,
        textColor: Colors.white,
        fontSize: 16.0);
  }




}

