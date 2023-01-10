import 'package:get/get.dart';

import '../model/user.dart';
import '../repository/localdata/user_repository.dart';

class AuthController extends GetxController {
  static AuthController get to => Get.find();

  Rx<UserModel> user = UserModel().obs;

  // UID 로그인 체크
  Future<UserModel?> loginUser(String uid) async {
    // DB 조회
    var userData = await UserRepository.loginUserByUid(uid);
    if (userData != null) {
      user(userData);
    }
    return userData;
  }

  void submitSignup(UserModel signupUser) async {
    var result = await UserRepository.signup(signupUser);
    if (result) {
      loginUser(signupUser.uid!);
    }
  }

  // ID, PASSWRD 로그인 체크
  Future<UserModel?> loginIdUser(String id, String pw) async {
    // DB 조회
    var userData = await UserRepository.loginUserById(id, pw);
    if (userData != null) {
      user(userData);
    }
    return userData;
  }
}
