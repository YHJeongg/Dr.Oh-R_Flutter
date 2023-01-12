import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dr_oh_app/model/user.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserRepository {
  static Future<UserModel?> loginUserByUid(String uid) async {
    var data = await FirebaseFirestore.instance
        .collection('users')
        .where('uid', isEqualTo: uid)
        .get();

    if (data.size == 0) {
      return null;
    } else {
      return UserModel.fromJson(data.docs.first.data());
    }
  }

  static Future<bool> signup(UserModel user) async {
    try {
      await FirebaseFirestore.instance.collection('users').add(user.toMap());
      return true;
    } catch (e) {
      return false;
    }
  }

  static Future<UserModel?> loginUserById(String id, String pw) async {
    final prefs = await SharedPreferences.getInstance();
    var data = await FirebaseFirestore.instance
        .collection('users')
        .where('id', isEqualTo: id)
        .where('password', isEqualTo: pw)
        .get();

    // Document id 가져오기
    // print(data.docs.first.id);

    if (data.size == 0) {
      return null;
    } else {
      prefs.setString('id', id);
      return UserModel.fromJson(data.docs.first.data());
    }
  }
}
