import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dershane/common/duyuruSayfasi.dart';
import 'package:dershane/common/loadingscreen.dart';
import 'package:dershane/common/myButton.dart';
import 'package:dershane/common/resimsizCard.dart';
import 'package:dershane/extensions/renkler.dart';
import 'package:dershane/firebase/firebase_database.dart';
import 'package:dershane/locator.dart';
import 'package:flutter/material.dart';
import 'package:dershane/extensions/size_extention.dart';
import 'package:flutter/services.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';


class OgretmenlerSohbet extends StatefulWidget {
  final DocumentSnapshot card;

  OgretmenlerSohbet({ @required this.card});
  @override
  _OgretmenlerSohbetState createState() => _OgretmenlerSohbetState();
}

class _OgretmenlerSohbetState extends State<OgretmenlerSohbet> with SingleTickerProviderStateMixin {


  FirestoreDBService _firebaseIslemleri = locator<FirestoreDBService>();

  final sinifController = TextEditingController();

  bool _loadingVisible = false;
  Future<void> _changeLoadingVisible() async {
    setState(() {
      _loadingVisible = !_loadingVisible;
    });
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor:  Renkler.appbarGroundColor,
      appBar: AppBar(
        title: Text("Sohbet",style: TextStyle(fontSize: 18.0.spByWidth),),
        elevation: 0.0,
        brightness: Brightness.dark,
        toolbarHeight: 80.0.h,
        backgroundColor: Renkler.appbarGroundColor,
        automaticallyImplyLeading: false,
      ),

      body: LoadingScreen(
        inAsyncCall: _loadingVisible,
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,

          decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20.70),
                topRight: Radius.circular(20.70)),
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                  color: const Color(0x5c000000),
                  offset: Offset(0, 0),
                  blurRadius: 33.06,
                  spreadRadius: 4.94)
            ],
          ),
          child:  ListView(
            children: [

              Slidable(
                actionPane: SlidableDrawerActionPane(),
                actionExtentRatio: 0.45,
                child: Padding(
                  padding:
                  EdgeInsets.symmetric(horizontal: 21.0.w, vertical: 7.0.h),
                  child: GestureDetector(
                    onTap: () {

                    },
                    child: Container(
                      width: 323.3333333333333.w,
                      height: 66.0.h,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(11.70)),
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
                          "Emre Ekşisu",
                          style: TextStyle(
                              color: const Color(0xff343633),
                              fontWeight: FontWeight.w600,
                              fontFamily: "OpenSans",
                              fontStyle: FontStyle.normal,
                              fontSize: 16.7.h),
                          overflow: TextOverflow.visible,
                          maxLines: 1,
                        ),
                        leading: CircleAvatar(
                          backgroundImage: NetworkImage("https://www.doganayerkekogrenciyurdu.com/wp-content/uploads/2019/06/Untitled-1-1024x427.jpg",),
                          radius: 26.0,
                        ),

                        trailing: Padding(
                          padding: EdgeInsets.only(top: 4.0.h),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text(
                               "19:30",
                                style: TextStyle(
                                    color: const Color(0xff343633),
                                    fontWeight: FontWeight.w400,
                                    fontFamily: "Arial",
                                    fontStyle: FontStyle.normal,
                                    fontSize: 12.3.h),
                              ),
                            ],
                          ),
                        ),


                        subtitle:   Text(
                          "Merhaba",
                          style:  TextStyle(
                              color: const Color(0xff343633),
                              fontWeight: FontWeight.bold,
                              fontFamily: "OpenSans",
                              fontStyle: FontStyle.normal,
                              fontSize: 15.3.h) ,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ),
                  ),
                ),
                secondaryActions: <Widget>[

                  Container(
                    height: 70,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(20.70)),

                    ),
                    child: IconSlideAction(
                        caption: 'Sil',
                        color: Colors.red,
                        icon: Icons.delete,
                        onTap: () async {

                        }
                    ),
                  ),
                ],
              ),
              Slidable(
                actionPane: SlidableDrawerActionPane(),
                actionExtentRatio: 0.45,
                child: Padding(
                  padding:
                  EdgeInsets.symmetric(horizontal: 21.0.w, vertical: 7.0.h),
                  child: GestureDetector(
                    onTap: () {

                    },
                    child: Container(
                      width: 323.3333333333333.w,
                      height: 66.0.h,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(11.70)),
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
                          "Emre Ekşisu",
                          style: TextStyle(
                              color: const Color(0xff343633),
                              fontWeight: FontWeight.w600,
                              fontFamily: "OpenSans",
                              fontStyle: FontStyle.normal,
                              fontSize: 16.7.h),
                          overflow: TextOverflow.visible,
                          maxLines: 1,
                        ),
                        leading: CircleAvatar(
                          backgroundImage: NetworkImage("https://www.doganayerkekogrenciyurdu.com/wp-content/uploads/2019/06/Untitled-1-1024x427.jpg",),
                          radius: 26.0,
                        ),

                        trailing: Padding(
                          padding: EdgeInsets.only(top: 4.0.h),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text(
                                "19:30",
                                style: TextStyle(
                                    color: const Color(0xff343633),
                                    fontWeight: FontWeight.w400,
                                    fontFamily: "Arial",
                                    fontStyle: FontStyle.normal,
                                    fontSize: 12.3.h),
                              ),
                            ],
                          ),
                        ),


                        subtitle:   Text(
                          "Merhaba",
                          style:  TextStyle(
                              color: const Color(0xff343633),
                              fontWeight: FontWeight.bold,
                              fontFamily: "OpenSans",
                              fontStyle: FontStyle.normal,
                              fontSize: 15.3.h) ,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ),
                  ),
                ),
                secondaryActions: <Widget>[

                  Container(
                    height: 70,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(20.70)),

                    ),
                    child: IconSlideAction(
                        caption: 'Sil',
                        color: Colors.red,
                        icon: Icons.delete,
                        onTap: () async {

                        }
                    ),
                  ),
                ],
              ),
              Slidable(
                actionPane: SlidableDrawerActionPane(),
                actionExtentRatio: 0.45,
                child: Padding(
                  padding:
                  EdgeInsets.symmetric(horizontal: 21.0.w, vertical: 7.0.h),
                  child: GestureDetector(
                    onTap: () {

                    },
                    child: Container(
                      width: 323.3333333333333.w,
                      height: 66.0.h,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(11.70)),
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
                          "Emre Ekşisu",
                          style: TextStyle(
                              color: const Color(0xff343633),
                              fontWeight: FontWeight.w600,
                              fontFamily: "OpenSans",
                              fontStyle: FontStyle.normal,
                              fontSize: 16.7.h),
                          overflow: TextOverflow.visible,
                          maxLines: 1,
                        ),
                        leading: CircleAvatar(
                          backgroundImage: NetworkImage("https://www.doganayerkekogrenciyurdu.com/wp-content/uploads/2019/06/Untitled-1-1024x427.jpg",),
                          radius: 26.0,
                        ),

                        trailing: Padding(
                          padding: EdgeInsets.only(top: 4.0.h),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text(
                                "19:30",
                                style: TextStyle(
                                    color: const Color(0xff343633),
                                    fontWeight: FontWeight.w400,
                                    fontFamily: "Arial",
                                    fontStyle: FontStyle.normal,
                                    fontSize: 12.3.h),
                              ),
                            ],
                          ),
                        ),


                        subtitle:   Text(
                          "Merhaba",
                          style:  TextStyle(
                              color: const Color(0xff343633),
                              fontWeight: FontWeight.bold,
                              fontFamily: "OpenSans",
                              fontStyle: FontStyle.normal,
                              fontSize: 15.3.h) ,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ),
                  ),
                ),
                secondaryActions: <Widget>[

                  Container(
                    height: 70,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(20.70)),

                    ),
                    child: IconSlideAction(
                        caption: 'Sil',
                        color: Colors.red,
                        icon: Icons.delete,
                        onTap: () async {

                        }
                    ),
                  ),
                ],
              ),
              Slidable(
                actionPane: SlidableDrawerActionPane(),
                actionExtentRatio: 0.45,
                child: Padding(
                  padding:
                  EdgeInsets.symmetric(horizontal: 21.0.w, vertical: 7.0.h),
                  child: GestureDetector(
                    onTap: () {

                    },
                    child: Container(
                      width: 323.3333333333333.w,
                      height: 66.0.h,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(11.70)),
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
                          "Emre Ekşisu",
                          style: TextStyle(
                              color: const Color(0xff343633),
                              fontWeight: FontWeight.w600,
                              fontFamily: "OpenSans",
                              fontStyle: FontStyle.normal,
                              fontSize: 16.7.h),
                          overflow: TextOverflow.visible,
                          maxLines: 1,
                        ),
                        leading: CircleAvatar(
                          backgroundImage: NetworkImage("https://www.doganayerkekogrenciyurdu.com/wp-content/uploads/2019/06/Untitled-1-1024x427.jpg",),
                          radius: 26.0,
                        ),

                        trailing: Padding(
                          padding: EdgeInsets.only(top: 4.0.h),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text(
                                "19:30",
                                style: TextStyle(
                                    color: const Color(0xff343633),
                                    fontWeight: FontWeight.w400,
                                    fontFamily: "Arial",
                                    fontStyle: FontStyle.normal,
                                    fontSize: 12.3.h),
                              ),
                            ],
                          ),
                        ),


                        subtitle:   Text(
                          "Merhaba",
                          style:  TextStyle(
                              color: const Color(0xff343633),
                              fontWeight: FontWeight.bold,
                              fontFamily: "OpenSans",
                              fontStyle: FontStyle.normal,
                              fontSize: 15.3.h) ,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ),
                  ),
                ),
                secondaryActions: <Widget>[

                  Container(
                    height: 70,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(20.70)),

                    ),
                    child: IconSlideAction(
                        caption: 'Sil',
                        color: Colors.red,
                        icon: Icons.delete,
                        onTap: () async {

                        }
                    ),
                  ),
                ],
              ),
              Slidable(
                actionPane: SlidableDrawerActionPane(),
                actionExtentRatio: 0.45,
                child: Padding(
                  padding:
                  EdgeInsets.symmetric(horizontal: 21.0.w, vertical: 7.0.h),
                  child: GestureDetector(
                    onTap: () {

                    },
                    child: Container(
                      width: 323.3333333333333.w,
                      height: 66.0.h,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(11.70)),
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
                          "Emre Ekşisu",
                          style: TextStyle(
                              color: const Color(0xff343633),
                              fontWeight: FontWeight.w600,
                              fontFamily: "OpenSans",
                              fontStyle: FontStyle.normal,
                              fontSize: 16.7.h),
                          overflow: TextOverflow.visible,
                          maxLines: 1,
                        ),
                        leading: CircleAvatar(
                          backgroundImage: NetworkImage("https://www.doganayerkekogrenciyurdu.com/wp-content/uploads/2019/06/Untitled-1-1024x427.jpg",),
                          radius: 26.0,
                        ),

                        trailing: Padding(
                          padding: EdgeInsets.only(top: 4.0.h),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text(
                                "19:30",
                                style: TextStyle(
                                    color: const Color(0xff343633),
                                    fontWeight: FontWeight.w400,
                                    fontFamily: "Arial",
                                    fontStyle: FontStyle.normal,
                                    fontSize: 12.3.h),
                              ),
                            ],
                          ),
                        ),


                        subtitle:   Text(
                          "Merhaba",
                          style:  TextStyle(
                              color: const Color(0xff343633),
                              fontWeight: FontWeight.bold,
                              fontFamily: "OpenSans",
                              fontStyle: FontStyle.normal,
                              fontSize: 15.3.h) ,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ),
                  ),
                ),
                secondaryActions: <Widget>[

                  Container(
                    height: 70,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(20.70)),

                    ),
                    child: IconSlideAction(
                        caption: 'Sil',
                        color: Colors.red,
                        icon: Icons.delete,
                        onTap: () async {

                        }
                    ),
                  ),
                ],
              ),
              Slidable(
                actionPane: SlidableDrawerActionPane(),
                actionExtentRatio: 0.45,
                child: Padding(
                  padding:
                  EdgeInsets.symmetric(horizontal: 21.0.w, vertical: 7.0.h),
                  child: GestureDetector(
                    onTap: () {

                    },
                    child: Container(
                      width: 323.3333333333333.w,
                      height: 66.0.h,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(11.70)),
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
                          "Emre Ekşisu",
                          style: TextStyle(
                              color: const Color(0xff343633),
                              fontWeight: FontWeight.w600,
                              fontFamily: "OpenSans",
                              fontStyle: FontStyle.normal,
                              fontSize: 16.7.h),
                          overflow: TextOverflow.visible,
                          maxLines: 1,
                        ),
                        leading: CircleAvatar(
                          backgroundImage: NetworkImage("https://www.doganayerkekogrenciyurdu.com/wp-content/uploads/2019/06/Untitled-1-1024x427.jpg",),
                          radius: 26.0,
                        ),

                        trailing: Padding(
                          padding: EdgeInsets.only(top: 4.0.h),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text(
                                "19:30",
                                style: TextStyle(
                                    color: const Color(0xff343633),
                                    fontWeight: FontWeight.w400,
                                    fontFamily: "Arial",
                                    fontStyle: FontStyle.normal,
                                    fontSize: 12.3.h),
                              ),
                            ],
                          ),
                        ),


                        subtitle:   Text(
                          "Merhaba",
                          style:  TextStyle(
                              color: const Color(0xff343633),
                              fontWeight: FontWeight.bold,
                              fontFamily: "OpenSans",
                              fontStyle: FontStyle.normal,
                              fontSize: 15.3.h) ,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ),
                  ),
                ),
                secondaryActions: <Widget>[

                  Container(
                    height: 70,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(20.70)),

                    ),
                    child: IconSlideAction(
                        caption: 'Sil',
                        color: Colors.red,
                        icon: Icons.delete,
                        onTap: () async {

                        }
                    ),
                  ),
                ],
              ),
              Slidable(
                actionPane: SlidableDrawerActionPane(),
                actionExtentRatio: 0.45,
                child: Padding(
                  padding:
                  EdgeInsets.symmetric(horizontal: 21.0.w, vertical: 7.0.h),
                  child: GestureDetector(
                    onTap: () {

                    },
                    child: Container(
                      width: 323.3333333333333.w,
                      height: 66.0.h,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(11.70)),
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
                          "Emre Ekşisu",
                          style: TextStyle(
                              color: const Color(0xff343633),
                              fontWeight: FontWeight.w600,
                              fontFamily: "OpenSans",
                              fontStyle: FontStyle.normal,
                              fontSize: 16.7.h),
                          overflow: TextOverflow.visible,
                          maxLines: 1,
                        ),
                        leading: CircleAvatar(
                          backgroundImage: NetworkImage("https://www.doganayerkekogrenciyurdu.com/wp-content/uploads/2019/06/Untitled-1-1024x427.jpg",),
                          radius: 26.0,
                        ),

                        trailing: Padding(
                          padding: EdgeInsets.only(top: 4.0.h),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text(
                                "19:30",
                                style: TextStyle(
                                    color: const Color(0xff343633),
                                    fontWeight: FontWeight.w400,
                                    fontFamily: "Arial",
                                    fontStyle: FontStyle.normal,
                                    fontSize: 12.3.h),
                              ),
                            ],
                          ),
                        ),


                        subtitle:   Text(
                          "Merhaba",
                          style:  TextStyle(
                              color: const Color(0xff343633),
                              fontWeight: FontWeight.bold,
                              fontFamily: "OpenSans",
                              fontStyle: FontStyle.normal,
                              fontSize: 15.3.h) ,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ),
                  ),
                ),
                secondaryActions: <Widget>[

                  Container(
                    height: 70,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(20.70)),

                    ),
                    child: IconSlideAction(
                        caption: 'Sil',
                        color: Colors.red,
                        icon: Icons.delete,
                        onTap: () async {

                        }
                    ),
                  ),
                ],
              ),
              Slidable(
                actionPane: SlidableDrawerActionPane(),
                actionExtentRatio: 0.45,
                child: Padding(
                  padding:
                  EdgeInsets.symmetric(horizontal: 21.0.w, vertical: 7.0.h),
                  child: GestureDetector(
                    onTap: () {

                    },
                    child: Container(
                      width: 323.3333333333333.w,
                      height: 66.0.h,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(11.70)),
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
                          "Emre Ekşisu",
                          style: TextStyle(
                              color: const Color(0xff343633),
                              fontWeight: FontWeight.w600,
                              fontFamily: "OpenSans",
                              fontStyle: FontStyle.normal,
                              fontSize: 16.7.h),
                          overflow: TextOverflow.visible,
                          maxLines: 1,
                        ),
                        leading: CircleAvatar(
                          backgroundImage: NetworkImage("https://www.doganayerkekogrenciyurdu.com/wp-content/uploads/2019/06/Untitled-1-1024x427.jpg",),
                          radius: 26.0,
                        ),

                        trailing: Padding(
                          padding: EdgeInsets.only(top: 4.0.h),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text(
                                "19:30",
                                style: TextStyle(
                                    color: const Color(0xff343633),
                                    fontWeight: FontWeight.w400,
                                    fontFamily: "Arial",
                                    fontStyle: FontStyle.normal,
                                    fontSize: 12.3.h),
                              ),
                            ],
                          ),
                        ),


                        subtitle:   Text(
                          "Merhaba",
                          style:  TextStyle(
                              color: const Color(0xff343633),
                              fontWeight: FontWeight.bold,
                              fontFamily: "OpenSans",
                              fontStyle: FontStyle.normal,
                              fontSize: 15.3.h) ,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ),
                  ),
                ),
                secondaryActions: <Widget>[

                  Container(
                    height: 70,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(20.70)),

                    ),
                    child: IconSlideAction(
                        caption: 'Sil',
                        color: Colors.red,
                        icon: Icons.delete,
                        onTap: () async {

                        }
                    ),
                  ),
                ],
              ),
              SizedBox(height: 40.0.h,),

            ],
          ),
        ),
      ),
    );
  }


}
