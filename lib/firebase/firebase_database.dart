import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dershane/model/ogretmenModel.dart';
import 'package:dershane/model/ogrenci.dart';
import 'package:dershane/model/veliModel.dart';
import 'package:dershane/model/yoneticiModel.dart';

class FirestoreDBService  {


  final FirebaseFirestore _firebaseDB = FirebaseFirestore.instance;

  @override
  Future<bool> saveOgrenci(Ogrenci user) async {
    await _firebaseDB
        .collection("ogrenci")
        .doc(user.userId)
        .set(user.toMap());
    return true;
  }

  @override
  Future<bool> saveOgretmen(Ogretmen user) async {
    await _firebaseDB
        .collection("ogretmen")
        .doc(user.userId)
        .set(user.toMap());
    return true;
  }

  @override
  Future<bool> saveYonetici(Yonetici user) async {
    await _firebaseDB
        .collection("yonetici")
        .doc(user.userId)
        .set(user.toMap());
    return true;
  }

  @override
  Future<bool> saveVeli(Veli user) async {
    await _firebaseDB
        .collection("veli")
        .doc(user.userId)
        .set(user.toMap());
    return true;
  }

  @override
  Future<List<String>> okulGetir() async {
    List<String> okulListesi=[];
   QuerySnapshot querySnapshot = await _firebaseDB.collection("okullar").get();
    print("okullar gelen :"+querySnapshot.docs.length.toString());
    for(DocumentSnapshot item in querySnapshot.docs){
      okulListesi.add(item['okul'].toString());
    }
    return okulListesi;
  }



  @override
  Future<Ogrenci> readOgrenci(String userID, String email) async {
    DocumentSnapshot _okunanUser = await _firebaseDB.collection("ogrenci").doc(userID).get();
    Map<String, dynamic> _okunanUserBilgileriMap = _okunanUser.data();
    if(_okunanUser.data!=null){
      Ogrenci _okunanUserNesnesi;
        _okunanUserNesnesi = Ogrenci.fromMap(_okunanUserBilgileriMap);
      print("Okunan user nesnesi :" + _okunanUserNesnesi.toString());
      return _okunanUserNesnesi;
    }else{
      return null;
    }

  }


  @override
  Future<Veli> readVeli(String userID, String email) async {
    DocumentSnapshot _okunanUser = await _firebaseDB.collection("veli").doc(userID).get();
    Map<String, dynamic> _okunanUserBilgileriMap = _okunanUser.data();
    if(_okunanUser.data!=null){
      Veli _okunanUserNesnesi;
      _okunanUserNesnesi = Veli.fromMap(_okunanUserBilgileriMap);
      print("Okunan user nesnesi :" + _okunanUserNesnesi.toString());
      return _okunanUserNesnesi;
    }else{
      return null;
    }
  }

  @override
  Future<Ogretmen> readOgretmen(String userID, String email) async {
    DocumentSnapshot _okunanUser = await _firebaseDB.collection("ogretmen").doc(userID).get();
    Map<String, dynamic> _okunanUserBilgileriMap = _okunanUser.data();
    if(_okunanUser.data!=null){
      Ogretmen _okunanUserNesnesi;
      _okunanUserNesnesi = Ogretmen.fromMap(_okunanUserBilgileriMap);
      print("Okunan user nesnesi :" + _okunanUserNesnesi.toString());
      return _okunanUserNesnesi;
    }else{
      return null;
    }
  }

  @override
  Future<Yonetici> readYonetici(String userID, String email) async {
    DocumentSnapshot _okunanUser = await _firebaseDB.collection("yonetici").doc(userID).get();
    Map<String, dynamic> _okunanUserBilgileriMap = _okunanUser.data();
    if(_okunanUser.data!=null){
      Yonetici _okunanUserNesnesi;
      _okunanUserNesnesi = Yonetici.fromMap(_okunanUserBilgileriMap);
      print("Okunan user nesnesi :" + _okunanUserNesnesi.toString());
      return _okunanUserNesnesi;
    }else{
      return null;
    }
  }



  @override
  Future<bool> yoneticiDuyuruPaylas(Map<String,dynamic> card,String docid,String duyuruTur) async {
    if(duyuruTur=="Genel Duyuru"){
    await _firebaseDB
        .collection("duyurular")
        .doc(docid)
        .set(card);
    }else{
      await _firebaseDB
          .collection("ogretmenlerDuyuru")
          .doc(docid)
          .set(card);
    }
    return true;
  }


  @override
  Future<bool> ogretmeneSinifAta(Map<String,dynamic> card,String docid,String ogretmenId,String danisman) async {
    await _firebaseDB
        .collection("ogretmen")
        .doc(ogretmenId)
        .collection("danismanliklar")
        .doc(docid)
        .set(card);

    await _firebaseDB
        .collection("siniflar")
        .doc(card['sinif'].toString().toLowerCase())
        .update({'danisman':danisman,'danismanvarmi':true});

    return true;
  }


  @override
  Future<bool> sinifAc(Map<String,dynamic> card,String sinif) async {
    await _firebaseDB
        .collection("siniflar")
        .doc(sinif.toLowerCase())
        .set(card);
    return true;
  }

  @override
  Future<String> ogrenciIdBul(String no) async {
   QuerySnapshot veri= await _firebaseDB.collection("ogrenci").where("ogrenciNo",isEqualTo: no).get();
    return veri.docs[0].id;
  }

  @override
  Future<bool> ogrenciOnay(String ogrenciNo,String ogrenciid) async {
    await _firebaseDB
        .collection("ogrenci")
        .doc(ogrenciid)
        .update({'ogrenciNo':ogrenciNo,'hesapOnay':true});

    return true;
  }

  @override
  Future<bool> ogretmenOnay(DocumentSnapshot card) async {
    await card.reference
        .update({'hesapOnay':true});

    return true;
  }

  @override
  Future<bool> yoneticiOnay(DocumentSnapshot card) async {
    await card.reference
        .update({'hesapOnay':true});

    return true;
  }



  @override
  Future<bool> ogretmenTelefonGuncelle(String ogretmenid,String tel) async {
    await _firebaseDB
        .collection("ogretmen")
        .doc(ogretmenid)
        .update({'telefon':tel});
    return true;
  }

  @override
  Future<bool> ogretmenFotografGuncelle(String ogretmenid,String url) async {
    await _firebaseDB
        .collection("ogretmen")
        .doc(ogretmenid)
        .update({'avatarImageUrl':url});
    return true;
  }

  @override
  Future<bool> ogrenciTelefonGuncelle(String ogrenciid,String tel) async {
    await _firebaseDB
        .collection("ogrenci")
        .doc(ogrenciid)
        .update({'telefon':tel});
    return true;
  }
  @override
  Future<bool> ogrenciSinifGuncelle(String ogrenciid,String sinif) async {
    await _firebaseDB
        .collection("ogrenci")
        .doc(ogrenciid)
        .update({'sinif':sinif});
    return true;
  }

  @override
  Future<bool> ogrenciFotografGuncelle(String ogrenciid,String url) async {
    await _firebaseDB
        .collection("ogrenci")
        .doc(ogrenciid)
        .update({'avatarImageUrl':url});
    return true;
  }

  @override
  Future<bool> ogretmenDanismanlikSil(DocumentSnapshot card) async {
    await card.reference.delete();
    return true;
  }

  @override
  Future<bool> sinifOgrenciAta(Map<String,dynamic> card,DocumentSnapshot cardsinif) async {
    await _firebaseDB
        .collection("siniflar")
        .doc(cardsinif['sinif'].toLowerCase())
        .collection("ogrenciler")
        .doc(card['userid'])
        .set(card);

    await _firebaseDB
        .collection("ogrenci")
        .doc(card['userid'])
        .update({'dershaneSinifi': cardsinif['sinif'],'danisman':cardsinif['danisman'].toString().toString()});
    return true;
  }

  @override
  Future<bool> ogretmenDersPorgramiAta(Map<String,dynamic>  program,String ogretmenid) async {
    await _firebaseDB
        .collection("ogretmenprogram")
        .doc(ogretmenid)
        .collection("program")
        .doc()
        .set(program);

    return true;
  }

  @override
  Future<bool> ogrenciDersPorgramiAta(Map<String,dynamic>  program,String sinifid) async {
    await _firebaseDB
        .collection("siniflar")
        .doc(sinifid)
        .collection("program")
        .doc()
        .set(program);

    return true;
  }

  @override
  Future<bool> ogrenciSinavNotlari(Map<String,dynamic>  program,String ogrencino) async {
    QuerySnapshot ogrenciId= await _firebaseDB.collection("ogrenci").where("ogrenciNo",isEqualTo:ogrencino).get();
    print("gelen idler:"+ogrenciId.docs[0].id);
    await _firebaseDB
        .collection("ogrenci")
        .doc(ogrenciId.docs[0].id)
        .collection("sinavnotlari")
        .doc()
        .set(program);

    return true;
  }


  @override
  Future<bool> ogretmenTavsiye(Map<String,dynamic> tavsiye,String ogrenciId) async {
    await _firebaseDB
        .collection("ogrenci")
        .doc(ogrenciId)
        .collection("tavsiyeler")
        .doc()
        .set(tavsiye);
    return true;
  }

  @override
  Future<bool> ogrenciIstekSikayet(Map<String,dynamic> istek,String ogrenciId) async {
    await _firebaseDB
        .collection("yoneticitavsiye")
        .doc()
        .set(istek);
    return true;
  }


}