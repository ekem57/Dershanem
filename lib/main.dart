import 'package:dershane/LandingPage.dart';
import 'package:dershane/extensions/size_config.dart';
import 'package:dershane/locator.dart';
import 'package:dershane/loginSayfalari/kullaniciSecim.dart';
import 'package:dershane/user_state/ogrenci_model_service.dart';
import 'package:dershane/user_state/ogretmen_model_service.dart';
import 'package:dershane/user_state/veli_model_service.dart';
import 'package:dershane/user_state/yonetici_model_service.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  //TODO ios GoogleService-Info.plist eklenecek
  await Firebase.initializeApp();


  setupLocator();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
      .then((_) {
    runApp( MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => OgrenciModel()),
        ChangeNotifierProvider(create: (_) => VeliModel()),
        ChangeNotifierProvider(create: (_) => OgretmenModel()),
        ChangeNotifierProvider(create: (_) => YoneticiModel()),
      ],
      child: MyApp(),
    ));
  });

}
class MyApp extends StatefulWidget {

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

  }
  @override
  Widget build(BuildContext context) {

    return MaterialApp(
        title: 'Dershanem',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          backgroundColor: const Color(0xffffffff),
          buttonColor: const Color(0xff3ecf8e),
          canvasColor: const Color(0xffffffff),
          visualDensity: VisualDensity.adaptivePlatformDensity,
          sliderTheme: SliderThemeData(
            thumbShape: RoundSliderThumbShape(enabledThumbRadius: 0.0),
            disabledActiveTrackColor: Colors.red[700],
          ),
          textTheme: TextTheme(
            button: TextStyle(
              fontSize: 18.0,
              color: const Color(0xff8b1afe),
              fontFamily: "OpenSans",
              fontWeight: FontWeight.w500,
              letterSpacing: 1.0,
            ),
            headline1: TextStyle(color: const Color(0xFFFFFFFF), fontSize: 20.0, fontFamily: "OpenSans"),
            caption: TextStyle(color: const Color(0xff343633), fontSize: 20.0, fontFamily: "OpenSans"),

          ),
          iconTheme: IconThemeData(
            color: const Color(0xff8b1afe),
          ),
        ),


        locale: const Locale('tr', "TR"),

        home:  LandingPage());
  }
}
