import 'package:dershane/ChattApp/alluserModel.dart';
import 'package:dershane/ChattApp/chat_view_model.dart';
import 'package:dershane/ChattApp/mesajkisiSec.dart';
import 'package:dershane/ChattApp/sohbetPage.dart';
import 'package:dershane/user_state/user_model_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MesajlarimListesi extends StatefulWidget {
  @override
  _MesajlarimListesiState createState() => _MesajlarimListesiState();
}

class _MesajlarimListesiState extends State<MesajlarimListesi> {
  bool _isLoading = false;
  ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_listeScrollListener);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Kullanicilar"),
      ),
      floatingActionButton:  Padding(
        padding: const EdgeInsets.only(bottom: 80),
        child: FloatingActionButton(
          onPressed: () {
            Navigator.of(context, rootNavigator: true).push(
              MaterialPageRoute(builder: (context) => ChattKisiSec()),
            );
          },
          child: Icon(
            Icons.add,
            size: 60.0,
            color: const Color(0xff343633),
          ),
        ),
      ),
      body: Consumer<AllUserViewModel>(
        builder: (context, model, child) {
          if (model.state == AllUserViewState.Busy) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (model.state == AllUserViewState.Loaded) {
            return RefreshIndicator(
              onRefresh: model.refresh,
              child: ListView.builder(
                controller: _scrollController,
                itemBuilder: (context, index) {

                  if (model.kullanicilarListesi.length == 0) {
                    return _kullaniciYokUi();
                  } else if (model.hasMoreLoading &&
                      index == model.kullanicilarListesi.length) {
                    return _yeniElemanlarYukleniyorIndicator();
                  } else {
                    return _userListeElemaniOlustur(index);
                  }
                },
                itemCount: model.hasMoreLoading
                    ? model.kullanicilarListesi.length +1
                    : model.kullanicilarListesi.length,
              ),
            );
          } else {
            return Container();
          }
        },
      ),
    );
  }

  Widget _kullaniciYokUi() {
    final _kullanicilarModel = Provider.of<AllUserViewModel>(context);
    return RefreshIndicator(
      onRefresh: _kullanicilarModel.refresh,
      child: SingleChildScrollView(
        physics: AlwaysScrollableScrollPhysics(),
        child: Container(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Icon(
                  Icons.supervised_user_circle,
                  color: Theme.of(context).primaryColor,
                  size: 120,
                ),
                Text(
                  "Hen??z Kullan??c?? Yok",
                  style: TextStyle(fontSize: 36),
                )
              ],
            ),
          ),
          height: MediaQuery.of(context).size.height - 150,
        ),
      ),
    );
  }

  Widget _userListeElemaniOlustur(int index) {
    final _userModel = Provider.of<UserModel>(context);
    final _tumKullanicilarViewModel = Provider.of<AllUserViewModel>(context);
    var _oankiUser = _tumKullanicilarViewModel.kullanicilarListesi[index];

   // if (_oankiUser.userId == _userModel.user.userId) {
   //   return Container();
   // }

    return GestureDetector(
      onTap: () {
        Navigator.of(context, rootNavigator: true).push(
          MaterialPageRoute(
            builder: (context) => ChangeNotifierProvider(
              create: (context) => ChatViewModel(currentUser: _userModel.user, sohbetEdilenUser: _oankiUser),
              child: SohbetPage(fotourl: _oankiUser.avatarImageUrl,userad: _oankiUser.adsoyad,userid: _oankiUser.userId,),
            ),
          ),
        );
      },
      child: Card(
        child: ListTile(
          title: Text(_oankiUser.adsoyad),
          subtitle: Text(_oankiUser.meslek),
          leading: CircleAvatar(
            backgroundColor: Colors.grey.withAlpha(40),
            backgroundImage: NetworkImage(_oankiUser.avatarImageUrl),
          ),
        ),
      ),
    );
  }

  _yeniElemanlarYukleniyorIndicator() {
    return Padding(
      padding: EdgeInsets.all(8),
      child: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }

  void dahaFazlaKullaniciGetir() async {
    if (_isLoading == false) {
      _isLoading = true;
      final _tumKullanicilarViewModel = Provider.of<AllUserViewModel>(context);
      await _tumKullanicilarViewModel.dahaFazlaUserGetir();
      _isLoading = false;
    }
  }

  void _listeScrollListener() {
    if (_scrollController.offset >= _scrollController.position.maxScrollExtent && !_scrollController.position.outOfRange) {
      print("Listenin en alt??nday??z");
      dahaFazlaKullaniciGetir();
    }
  }
}
