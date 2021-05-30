import 'package:flutter/material.dart';
import 'package:dershane/extensions/size_extention.dart';


class DuyuruCard extends StatelessWidget {
  final String baslik;
  final String icerik;
  String tarih;
  final VoidCallback onPressed;



  DuyuruCard(
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
    return Padding(
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
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Align(
                    alignment: Alignment.topRight,
                    child: Text(tarih,style: TextStyle(fontWeight: FontWeight.bold,fontSize: 14.2.spByWidth))),
              ),

              Padding(
                padding:  EdgeInsets.symmetric(horizontal: 10.0.w),
                child: Align(
                    alignment: Alignment.topLeft,
                    child: Text(baslik,style: TextStyle(fontWeight: FontWeight.bold,fontSize: 15.2.spByWidth),textAlign: TextAlign.left,)),
              ),
              SizedBox(height: 5.0.h,),
              Padding(
                padding:  EdgeInsets.symmetric(horizontal: 5.0.w),
                child: Align(
                    alignment: Alignment.topLeft,
                    child: Text(icerik,style: TextStyle(fontSize: 13.2.spByWidth),textAlign: TextAlign.left,)),
              ),
              SizedBox(height: 10.0.h,),
            ],
          ),
        ),
      ),
    ) ;

  }
}
