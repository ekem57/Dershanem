import 'package:dershane/firebase/firebase_auth_service.dart';
import 'package:dershane/firebase/firebase_database.dart';
import 'package:dershane/repository/ogrenci_repo.dart';
import 'package:dershane/repository/ogretmen_repo.dart';
import 'package:dershane/repository/veli_repo.dart';
import 'package:dershane/repository/yonetici_repo.dart';
import 'package:get_it/get_it.dart';


GetIt locator = GetIt.instance;

void setupLocator() {

  locator.registerLazySingleton(() => FirebaseAuthService());
  locator.registerLazySingleton(() => FirestoreDBService());
  locator.registerLazySingleton(() => YoneticiRepo());
  locator.registerLazySingleton(() => OgrenciRepo());
  locator.registerLazySingleton(() => VeliRepo());
  locator.registerLazySingleton(() => OgretmenRepo());


}
