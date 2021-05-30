import 'package:flutter/material.dart';
import 'package:dershane/extensions/size_extention.dart';


class SinavSonucCard extends StatelessWidget {
  final String baslik;
  final String icerik;
  String tarih;
  final VoidCallback onPressed;



  SinavSonucCard(
      {Key key,
        this.baslik,
        this.icerik,
        this.tarih,
        this.onPressed,
      })
      : assert(baslik != null ),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return   Padding(
      padding: EdgeInsets.symmetric(horizontal: 21.0.w,vertical: 10.0.h),
      child:  GestureDetector(
        onTap: (){},
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
                Column(
                  children: [
                    Text(baslik,style: TextStyle(fontSize: 16.0.spByWidth,fontWeight: FontWeight.bold),),
                    SizedBox(height: 10.0.h,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Column(
                          children: [
                            Text("Sayısal",style: TextStyle(fontSize: 15.0.spByWidth),),
                            SizedBox(height: 10,),
                            Text("436.444",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 15.0.spByWidth),),
                          ],
                        ),

                        Column(
                          children: [
                            Text("Eşit Ağırlık",style: TextStyle(fontSize: 15.0.spByWidth),),
                            SizedBox(height: 10,),
                            Text("436.444",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 15.0.spByWidth)),
                          ],
                        ),

                        Column(
                          children: [
                            Text("Sözel",style: TextStyle(fontSize: 15.0.spByWidth),),
                            SizedBox(height: 10,),
                            Text("436.444",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 15.0.spByWidth)),
                          ],
                        ),
                      ],
                    ),
                    SizedBox(height: 20.0.h,),
                    Padding(
                      padding:  EdgeInsets.only(left: 15),
                      child: Row(
                        children: [
                          Text("Toplam Katılımcı:  ",style: TextStyle(fontSize: 15.0.spByWidth)),
                          Text("12032",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 15.0.spByWidth)),
                        ],
                      ),
                    ),

                    SizedBox(height: 10.0.h,),
                    Padding(
                      padding:  EdgeInsets.only(left: 15),
                      child: Row(
                        children: [
                          Text("Sıralaman:  ",style: TextStyle(fontSize: 15.0.spByWidth)),
                          Text("1436",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 15.0.spByWidth)),
                        ],
                      ),
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
