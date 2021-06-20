import 'package:flutter/material.dart';
import 'package:dershane/extensions/size_extention.dart';


class OgrenciDersProgramiCard extends StatelessWidget {

  final String ders;
  final String saatbaslangic;
  final String saatbitis;
  final VoidCallback onPressed;



  OgrenciDersProgramiCard(
      {Key key,

        @required this.ders,
        @required this.saatbaslangic,
        @required this.saatbitis,
        @required this.onPressed,
      });

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
              color: Colors.transparent),
          child: Card(
            elevation: 3,
            child: Column(
              children: [
                SizedBox(height: 10,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Column(
                      children: [
                        Text(saatbaslangic,style: TextStyle(fontWeight: FontWeight.bold,fontSize: 15.0.spByWidth),),
                        SizedBox(height: 10,),
                        Text(saatbitis,style: TextStyle(fontWeight: FontWeight.bold,fontSize: 15.0.spByWidth),),
                      ],
                    ),



                  ],
                ),
                SizedBox(height: 10,),
              ],
            ),
          ),
        ),
      ),
    ) ;

  }
}
