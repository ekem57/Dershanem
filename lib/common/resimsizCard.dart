import 'package:flutter/material.dart';
import 'package:dershane/extensions/size_extention.dart';


class ResimsizCard extends StatelessWidget {
  final String baslik;
  final String icerik;
  String tarih;
  final VoidCallback onPressed;



   ResimsizCard(
      {Key key,
        @required this.baslik,
        @required this.icerik,
         this.tarih,
        @required this.onPressed,
      })
      : assert(baslik != null ),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return  Padding(
      padding: EdgeInsets.symmetric(horizontal: 21.0.w,vertical: 10.0.h),
      child:  GestureDetector(
        onTap: onPressed,
        child: Container(
          width: MediaQuery.of(context).size.width,

          alignment: Alignment.center,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(11.70.w)),
              boxShadow: [
                BoxShadow(
                    color: const Color(0x26000000),
                    offset: Offset(0, 0),
                    blurRadius: 5.50,
                    spreadRadius: 0.5)
              ],
              color: Theme.of(context).backgroundColor),
          child: ListTile(
            title: Text(
              baslik,
              style: TextStyle(
                  color: const Color(0xff343633),
                  fontWeight: FontWeight.w600,
                  fontFamily: "OpenSans",
                  fontStyle: FontStyle.normal,
                  fontSize: 17.7.spByWidth),
            ),
            trailing:Text(
              tarih,
              style: TextStyle(
                  color: const Color(0xff343633),
                  fontWeight: FontWeight.w600,
                  fontFamily: "OpenSans",
                  fontStyle: FontStyle.normal,
                  fontSize: 12.0.spByWidth),
            ),
            subtitle: icerik.length < 200 ? Text(
              icerik,
              style: TextStyle(
                  color: const Color(0xff343633),
                  fontWeight: FontWeight.w600,
                  fontFamily: "OpenSans",
                  fontStyle: FontStyle.normal,
                  fontSize: 14.0.spByWidth),
            ) :
            Text(
              icerik.substring(0,199),
              style: TextStyle(
                  color: const Color(0xff343633),
                  fontWeight: FontWeight.w600,
                  fontFamily: "OpenSans",
                  fontStyle: FontStyle.normal,
                  fontSize: 14.0.spByWidth),
            ),

          ),
        ),
      ),
    ) ;

  }
}
