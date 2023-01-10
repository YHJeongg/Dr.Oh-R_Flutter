import 'package:dr_oh_app/app.dart';
import 'package:dr_oh_app/view/join.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../viewmodel/auth_controller.dart';

// Date: 2023-01-09, jyh
// 화면 디자인 구성완료, API(카카오, 구글) 연동 전
class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

// 구글 로그인
Future<UserCredential> signInWithGoogle() async {
  // Trigger the authentication flow
  final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

  // Obtain the auth details from the request
  final GoogleSignInAuthentication? googleAuth =
      await googleUser?.authentication;

  // Create a new credential
  final credential = GoogleAuthProvider.credential(
    accessToken: googleAuth?.accessToken,
    idToken: googleAuth?.idToken,
  );

  // Once signed in, return the UserCredential
  return await FirebaseAuth.instance.signInWithCredential(credential);
}

class _LoginState extends State<Login> {
  late TextEditingController idCont;
  late TextEditingController pwCont;
  late bool _passwordVisible;

  @override
  void initState() {
    super.initState();
    idCont = TextEditingController();
    pwCont = TextEditingController();
    _passwordVisible = false;
  }

  Widget _idTextField(
      TextEditingController txtCont, String label, bool obsTxt) {
    return TextField(
      controller: txtCont,
      obscureText: obsTxt,
      decoration: InputDecoration(
        labelText: label,
        labelStyle: const TextStyle(
          color: Colors.black,
          fontSize: 15,
        ),
        filled: true,
        fillColor: Theme.of(context).primaryColorLight,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
          borderSide: const BorderSide(
            width: 0,
            style: BorderStyle.none,
          ),
        ),
      ),
    );
  }

  Widget _passwdTextField(
      TextEditingController txtCont, String label, bool obsTxt) {
    return TextField(
      controller: txtCont,
      obscureText: obsTxt,
      decoration: InputDecoration(
        labelText: label,
        labelStyle: const TextStyle(
          color: Colors.black,
          fontSize: 15,
        ),
        filled: true,
        fillColor: Theme.of(context).primaryColorLight,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
          borderSide: const BorderSide(
            width: 0,
            style: BorderStyle.none,
          ),
        ),
        suffixIcon: IconButton(
          icon: Icon(
            _passwordVisible ? Icons.visibility : Icons.visibility_off,
            color: Theme.of(context).primaryColorDark,
          ),
          onPressed: () {
            setState(
              () {
                _passwordVisible = !_passwordVisible;
              },
            );
          },
        ),
      ),
    );
  }

  Widget _loginBtn() {
    return SizedBox(
      width: Get.width,
      child: ElevatedButton(
        onPressed: () async {
          AuthController.to.loginIdUser(idCont.text, pwCont.text);
          final prefs = await SharedPreferences.getInstance();
          if (prefs.getString('id') == idCont.text) {
            Get.offAll(() => const App());
          }
        },
        child: const Text('로그인'),
      ),
    );
  }

  Widget _findPwBtn() {
    return Container(
      alignment: Alignment.centerRight,
      child: TextButton(
        onPressed: () {},
        child: const Text(
          '비밀번호를 잊으셨나요?',
          style: TextStyle(
            color: Colors.blue,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        body: SingleChildScrollView(
          child: SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(height: 100),
                  const Text(
                    "Dr. Oh",
                    style: TextStyle(
                        color: Color(0xFF99CD89),
                        fontSize: 50,
                        fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: Get.height / 10),
                  _idTextField(idCont, '아이디', false),
                  const SizedBox(height: 20),
                  _passwdTextField(pwCont, '비밀번호', !_passwordVisible),
                  _findPwBtn(),
                  const SizedBox(height: 10),
                  _loginBtn(),
                  const SizedBox(height: 20),
                  const Text('또는'),
                  const SizedBox(height: 30),
                  // API연동전 임시 Text
                  const TextButton(
                    onPressed: signInWithGoogle,
                    child: Text(
                      '구글로 계속하기',
                      style: TextStyle(
                        color: Colors.blue,
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    '카카오로 계속하기',
                    style: TextStyle(
                      color: Colors.blue,
                    ),
                  ),
                  const SizedBox(height: 30),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const Text(
                        '계정이 없으신가요?',
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const Join(),
                            ),
                          );
                        },
                        child: const Text(
                          '가입하기',
                          style: TextStyle(
                            color: Colors.blue,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
