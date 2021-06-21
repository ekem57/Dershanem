import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:etkinlik_kafasi/extensions/color_data.dart';
import 'package:etkinlik_kafasi/models/group_chat_model.dart';
import 'package:etkinlik_kafasi/service/user_state_service.dart';
import 'package:flutter/material.dart';
import 'package:etkinlik_kafasi/extensions/size_extension.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import "package:provider/provider.dart";

class GroupChatPage extends StatefulWidget {
  final String documentId;
  final String eventOwnerId;
  final int deactivatedTime;

  const GroupChatPage({Key key, this.documentId, this.eventOwnerId, this.deactivatedTime}) : super(key: key);

  @override
  _GroupChatPageState createState() => _GroupChatPageState();
}

class _GroupChatPageState extends State<GroupChatPage> {
  final messageController = TextEditingController();
  final scrollController = ScrollController();
  CollectionReference chatRef;
  Stream<QuerySnapshot> chatStream;
  StreamSubscription<QuerySnapshot<Map<String, dynamic>>> usersBlockedFromChat;
  bool isBlocked = false;
  bool isAdmin = false;
  bool isActive = true;

  @override
  void initState() {
    super.initState();
    chatStream = FirebaseFirestore.instance
        .collection('etkinlik')
        .doc(widget.documentId)
        .collection("groupChat")
        .orderBy("date", descending: false)
        .limit(500)
        .snapshots();
    var userId = context.read<UserModel>().user.userId;
    isAdmin = widget.eventOwnerId == userId;
    listenForBlockedUser(userId);
    chatRef = FirebaseFirestore.instance
        .collection('etkinlik')
        .doc(widget.documentId)
        .collection("groupChat")
        .withConverter<GroupChatModel>(
          fromFirestore: (snapshot, _) => GroupChatModel.fromMap(snapshot.data()),
          toFirestore: (chat, _) => chat.toJson(),
        );
  }

  @override
  void dispose() {
    usersBlockedFromChat.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Renkler.appbarGroundColor,
        title: Text("Grup Sohbeti"),
        actions: [
          Visibility(
            visible: context.read<UserModel>().user.userId == widget.eventOwnerId,
            child: PopupMenuButton<String>(
              onSelected: (value) {
                setState(() {
                  if (value == "Aç")
                    isActive = true;
                  else
                    isActive = false;
                });
                setChatStatus(isActive);
              },
              icon: Icon(Icons.more_vert),
              itemBuilder: (_) => <PopupMenuEntry<String>>[
                !isActive
                    ? const PopupMenuItem<String>(
                        value: "Aç",
                        child: Text('Sohbeti Aç'),
                      )
                    : const PopupMenuItem<String>(
                        value: "Kapat",
                        child: Text('Sohbeti Kapat'),
                      ),
              ],
            ),
          )
        ],
      ),
      backgroundColor: Theme.of(context).backgroundColor,
      body: Column(
        children: [
          StreamBuilder<QuerySnapshot>(
              stream: chatStream,
              builder: (_, snapshot) {
                if (snapshot.hasError) return Text(snapshot.error.toString());
                if (snapshot.connectionState == ConnectionState.waiting) return Text("Yükleniyor...");
                if (snapshot.hasData) {
                  Timer(
                    Duration(seconds: 1),
                        () => scrollController.jumpTo(scrollController.position.maxScrollExtent),
                  );
                  return Expanded(
                    child: ListView.builder(
                      controller: scrollController,
                      itemCount: snapshot.data.docs.length,
                      itemBuilder: (context, index) => messageTile(
                        context,
                        documentId: snapshot.data.docs[index].id,
                        model: GroupChatModel.fromMap(
                          snapshot.data.docs[index].data(),
                        ),
                      ),
                    ),
                  );
                }
                return Text("Yükleniyor...");
              }),
          listenForChatSettings(context)
        ],
      ),
    );
  }

  Widget listenForChatSettings(BuildContext context) {
    return StreamBuilder<DocumentSnapshot>(
        stream: FirebaseFirestore.instance.collection('etkinlik').doc(widget.documentId).snapshots(),
        builder: (_, snapshot) {
          if (snapshot.hasData) {
            try {
              snapshot.data.get("chatSettings");
            } on StateError catch (e) {
              return enterMessageText(context);
            }
            var document = snapshot.data["chatSettings"];
            var deactivatedTime = DateTime.fromMillisecondsSinceEpoch(widget.deactivatedTime);
            print(deactivatedTime);
            isActive = document["enable"] && DateTime.now().isBefore(deactivatedTime);
            if (isActive)
              return enterMessageText(context);
            else
              return Container();
          }
          return Container();
        });
  }

  void listenForBlockedUser(String userId) {
    usersBlockedFromChat = FirebaseFirestore.instance
        .collection('etkinlik')
        .doc(widget.documentId)
        .collection("usersBlockedFromChat")
        .where("userId", isEqualTo: userId)
        .snapshots()
        .listen((event) {
      isBlocked = event.docs.length > 0;
      if (isBlocked) Navigator.of(context).pop();
    });
  }

  Future setChatStatus(bool status) {
    return FirebaseFirestore.instance
        .collection('etkinlik')
        .doc(widget.documentId)
        .update({"chatSettings.enable": status});
  }

  Widget enterMessageText(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(bottom: 8.0.h, left: 8.0.w, right: 8.0.w),
      child: Row(
        children: <Widget>[
          Flexible(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(21.5.h)),
                  boxShadow: [
                    BoxShadow(color: const Color(0x47000000), offset: Offset(0, 2), blurRadius: 11, spreadRadius: 0)
                  ],
                  color: Theme.of(context).backgroundColor,
                ),
                child: TextField(
                  controller: messageController,
                  cursorColor: Colors.blueGrey,
                  style: new TextStyle(
                    fontSize: 16.0,
                    color: Colors.black,
                  ),
                  maxLines: 4,
                  minLines: 1,
                  decoration: InputDecoration(
                    fillColor: Colors.white,
                    filled: true,
                    hintText: "Mesajınızı Yazın",
                    border: new OutlineInputBorder(
                        borderRadius: new BorderRadius.circular(30.0), borderSide: BorderSide.none),
                  ),
                ),
              ),
            ),
          ),
          GestureDetector(
            onTap: () async {
              if (messageController.text == "") return;
              if (isBlocked) return;
              var user = context.read<UserModel>().user;
              await sendMessage(GroupChatModel(
                  message: messageController.text,
                  senderName: user.adsoyad,
                  senderUserId: user.userId,
                  date: FieldValue.serverTimestamp()));
              scrollController.animateTo(
                scrollController.position.maxScrollExtent + 100,
                curve: Curves.easeOut,
                duration: const Duration(milliseconds: 200),
              );
              setState(() {
                messageController.text = "";
              });
            },
            child: Container(
              width: 42.0.w,
              height: 42.0.w,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(color: const Color(0x70000000), offset: Offset(1, 2), blurRadius: 8, spreadRadius: 0)
                  ],
                  color: Colors.green),
              child: Icon(
                Icons.send,
                color: Colors.black,
                size: 18.0.h,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget messageTile(BuildContext context, {GroupChatModel model, String documentId}) {
    var myUserId = context.read<UserModel>().user.userId;
    var myTile = ListTile(
        minVerticalPadding: 0,
        title: Text(
          model.message,
          textAlign: TextAlign.right,
        ));

    var senderTile = ListTile(
      title: Text(model.senderName + ":"),
      subtitle: Text(model.message),
      onLongPress: () {
        if (!isAdmin) return;
        showBlockedAlert(context, model.senderUserId);
      },
    );

    var slideableMyTile = Slidable(
      actionPane: SlidableDrawerActionPane(),
      child: myTile,
      secondaryActions: [
        IconSlideAction(
          caption: 'Sil',
          color: Colors.blue,
          icon: Icons.delete_forever,
          onTap: () => deleteMessage(documentId),
        ),
      ],
    );
    var adminSenderTile = Slidable(
      actionPane: SlidableDrawerActionPane(),
      child: senderTile,
      secondaryActions: [
        IconSlideAction(
          caption: 'Sil',
          color: Colors.blue,
          icon: Icons.delete_forever,
          onTap: () => deleteMessage(documentId),
        ),
      ],
    );

    return model.senderUserId == myUserId
        ? slideableMyTile
        : isAdmin
            ? adminSenderTile
            : senderTile;
  }

  Future sendMessage(GroupChatModel model) {
    return chatRef.add(model);
  }

  Future deleteMessage(String documentId) {
    return chatRef.doc(documentId).delete();
  }

  void showBlockedAlert(BuildContext context, String userId) {
    showGeneralDialog(
        context: context,
        barrierLabel: '',
        barrierDismissible: false,
        pageBuilder: (_animation, _secondaryAnimation, _child) {
          return AlertDialog(
            backgroundColor: Colors.white,
            title: Text("Kullanıcı Engellensin mi?", textAlign: TextAlign.center),
            content: Text("Engellenen kullanıcılar bir daha mesaj atamayacaklar!", textAlign: TextAlign.center),
            actions: [
              Container(
                child: TextButton(
                  child: Text("İptal", textAlign: TextAlign.start),
                  onPressed: () => Navigator.of(context).pop(),
                ),
              ),
              TextButton(child: Text("Engelle"), onPressed: () async {}),
            ],
          );
        });
  }
}
