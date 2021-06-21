import 'package:dershane/model/users.dart';

abstract class UserAuthBase {

  Future<Users> currentUser();

  Future<bool> signOut();

}


