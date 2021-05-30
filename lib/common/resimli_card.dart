import 'package:flutter/material.dart';
import 'package:dershane/extensions/size_extention.dart';

class ResimliCard extends StatelessWidget {
  final String textSubtitle;
  final String textTitle;
  final String tarih;
  final String img;
  final VoidCallback onPressed;
  final double fontSize;
  final Color color;


  const ResimliCard(
      {Key key,
        @required this.textSubtitle,
        @required this.textTitle,
        @required this.onPressed,
        @required this.fontSize,
        @required this.img,
        @required this.tarih,
         this.color,
      })
      : assert(textTitle != null ),
        super(key: key);

  @override
  Widget build(BuildContext context) {

    return textSubtitle != null ? Padding(
      padding:
      EdgeInsets.symmetric(horizontal: 21.0.w, vertical: 7.0.h),
      child:  GestureDetector(
        onTap: onPressed,
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: 66.0.h,
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
              color: color == null ? Colors.white : color),
          child: ListTile(
            title: Text(
              textTitle,
              style: TextStyle(
                  color: const Color(0xff343633),
                  fontWeight: FontWeight.w600,
                  fontFamily: "OpenSans",
                  fontStyle: FontStyle.normal,
                  fontSize: 16.7.h),
            ),
            leading: CircleAvatar(
              backgroundColor: Colors.white,
              backgroundImage: img == "null" ? AssetImage("assets/image/userprofil.png")  : NetworkImage(img),
              radius: 26.0.w,
            ),
            trailing: Padding(
              padding: EdgeInsets.only(top: 4.0.h),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    tarih.toString(),
                    style: TextStyle(
                        color: const Color(0xff343633),
                        fontWeight: FontWeight.w400,
                        fontFamily: "Arial",
                        fontStyle: FontStyle.normal,
                        fontSize: 12.3.spByWidth),
                  ),
                ],
              ),
            ),

            subtitle: Text(
              textSubtitle.toString(),
              style: TextStyle(
                  color: const Color(0xff343633),
                  fontWeight: FontWeight.w400,
                  fontFamily: "OpenSans",
                  fontStyle: FontStyle.normal,
                  fontSize: 13.3.spByWidth),
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ),
      ),
    ) :
    Padding(
      padding:
      EdgeInsets.symmetric(horizontal: 21.0.w, vertical: 7.0.h),
      child:  GestureDetector(
        onTap: onPressed,
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: 66.0.h,
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
              color: color == null ? Colors.white : color),
          child: ListTile(
            title: Text(
              textTitle,
              style: TextStyle(
                  color: const Color(0xff343633),
                  fontWeight: FontWeight.w600,
                  fontFamily: "OpenSans",
                  fontStyle: FontStyle.normal,
                  fontSize: 16.7.h),
            ),
            leading: CircleAvatar(
              backgroundColor: Colors.white,
              backgroundImage: img == "null" ? AssetImage("assets/image/userprofil.png") : NetworkImage(img),
              radius: 26.0.w,
            ),


          ),
        ),
      ),
    );
  }
}
