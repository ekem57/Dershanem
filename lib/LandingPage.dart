import 'package:dershane/MainNavigations/ogrenciMain.dart';
import 'package:dershane/MainNavigations/ogretmenMain.dart';
import 'package:dershane/MainNavigations/veliMain.dart';
import 'package:dershane/MainNavigations/yoneticiMain.dart';
import 'package:dershane/loginSayfalari/kullaniciSecim.dart';
import 'package:dershane/user_state/ogrenci_model_service.dart';
import 'package:dershane/user_state/ogretmen_model_service.dart';
import 'package:dershane/user_state/veli_model_service.dart';
import 'package:dershane/user_state/yonetici_model_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


class LandingPage extends StatefulWidget {
  @override
  _LandingPageState createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {

  @override
  Widget build(BuildContext context) {


    final _ogrenciModel = Provider.of<OgrenciModel>(context, listen: true);
    final _veliModel = Provider.of<VeliModel>(context, listen: true);
    final _ogretmenModel = Provider.of<OgretmenModel>(context, listen: true);
    final _yoneticiModel = Provider.of<YoneticiModel>(context, listen: true);

    if (_ogrenciModel.state == OgrenciViewState.Idle) {
      if (_ogrenciModel.user == null) {

        if (_veliModel.state == VeliViewState.Idle) {
          if (_veliModel.user == null) {

            if (_yoneticiModel.state == YoneticiViewState.Idle) {
              if (_yoneticiModel.user == null) {
                if (_ogretmenModel.state == OgretmenViewState.Idle) {
                  if (_ogretmenModel.user == null) {
                    return KullaniciSecim();
                  } else {
                    return OgretmenMainNavigation(user: _ogretmenModel.user,);
                  }
                }else{
                  return Container();
                }
              } else {
                return YoneticiMainNavigation(user: _yoneticiModel.user,);
              }
            }else{
              return Container();
            }

          } else {
            return VeliMainNavigation(user: _veliModel.user,);
          }
        }else{
          return Container();
        }


      } else {
        return OgrenciMainNavigation(user: _ogrenciModel.user,);
      }
    }

    else {
      return Center(child: CircularProgressIndicator());
    }
  }

}
