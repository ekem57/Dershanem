import 'package:dershane/common/myButton.dart';
import 'package:dershane/extensions/renkler.dart';
import 'package:flutter/material.dart';
import 'package:dershane/extensions/size_extention.dart';


class AlertBilgilendirme extends StatefulWidget {
  final Color bgColor;
  final String baslik;
  final String icerik;
  final String BtnText;
  final Function Pressed;
  final double circularBorderRadius;

  AlertBilgilendirme({
    this.baslik,
    this.icerik,
    this.circularBorderRadius = 15.0,
    this.bgColor = Colors.white,
    this.BtnText,
    this.Pressed,
  })  : assert(bgColor != null),
        assert(circularBorderRadius != null);

  @override
  _AlertBilgilendirmeState createState() => _AlertBilgilendirmeState();
}

class _AlertBilgilendirmeState extends State<AlertBilgilendirme> {
  final Color positiveButonColor = Renkler.onayButonColor;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: AlertDialog(
        title: widget.baslik != null ? Text(widget.baslik) : null,
        content: widget.icerik != null
            ? Padding(
          padding:
          EdgeInsets.only(top: 30.0.h),
          child: Text(
            widget.icerik,
            style: TextStyle(
              fontSize: 15.0.spByWidth,
              fontWeight: FontWeight.w600,
              fontFamily: "OpenSans",
              height: 2,
            ),
            textAlign: TextAlign.center,
          ),
        )
            : null,
        backgroundColor: widget.bgColor,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(widget.circularBorderRadius)),
        actions: <Widget>[

          Padding(
            padding:  EdgeInsets.symmetric(horizontal: 90.0.w,vertical: 20.0.h),
            child: Center(
              child: MyButton(
                  text: "Tamam",
                  onPressed: widget.Pressed,
                  butonColor: positiveButonColor,
                  textColor: Colors.black,
                  fontSize: 12.3.spByWidth,
                  width: 120.0.w,
                  height: 29.0.h),
            ),
          ),


        ],
      ),
    );
  }
}
