import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dr_oh_app/repository/localdata/user_repository.dart';
import 'package:dr_oh_app/view/login.dart';
import 'package:dr_oh_app/viewmodel/auth_controller.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SignOut extends StatefulWidget {
  const SignOut({super.key});

  @override
  State<SignOut> createState() => _SignOutState();
}

class _SignOutState extends State<SignOut> {
  bool isChecked = false;
  final firestore = FirebaseFirestore.instance;

  TextEditingController pwController = TextEditingController();
  late String id = '';

  _initSharedPreferences() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      id = prefs.getString('id').toString();
    });
  }

  @override
  void initState() {
    super.initState();
    _initSharedPreferences();
  }

  Color getColor(Set<MaterialState> states) {
    const Set<MaterialState> interactiveStates = <MaterialState>{
      MaterialState.pressed,
      MaterialState.hovered,
      MaterialState.focused,
    };
    if (states.any(interactiveStates.contains)) {
      return Colors.blue;
    }
    return Colors.red;
  }

  Widget checkBox() {
    return Checkbox(
      checkColor: Colors.white,
      fillColor: MaterialStateProperty.resolveWith(getColor),
      value: isChecked,
      onChanged: (bool? value) {
        setState(() {
          isChecked = value!;
        });
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('회원 탈퇴'),
        elevation: 0,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Padding(
              padding: EdgeInsets.all(50.0),
              child: Text(
                "Dr. Oh",
                style: TextStyle(
                    color: Color(0xFF99CD89),
                    fontSize: 50,
                    fontWeight: FontWeight.bold),
              ),
            ),
            Container(
              width: 300,
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                border: Border.all(
                  style: BorderStyle.solid,
                  width: 1,
                ),
                borderRadius: BorderRadius.circular(5),
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 1,
                    blurRadius: 1,
                  ),
                ],
              ),
              child: Column(
                children: [
                  const Text(
                    '서비스 탈퇴 전에 확인하세요\n계정을 삭제하면 진단기록을 포함한 모든 Dr.Oh 설정이 초기화됩니다.',
                    textAlign: TextAlign.center,
                  ),
                  const Text(
                    '또한 즐겨찾기와 내가 쓴 글을 확인할 수 없습니다.\n삭제하시겠습니까?',
                    textAlign: TextAlign.center,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      checkBox(),
                      const Text('계정을 삭제합니다'),
                    ],
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(50.0),
              child: ElevatedButton(
                  onPressed: () {
                    isChecked ? _deleteDialog(context) : null;
                  },
                  child: const Text('확인')),
            )
          ],
        ),
      ),
    );
  }

  _deleteDialog(BuildContext context) {
    showDialog(
        context: context,
        builder: ((context) {
          return AlertDialog(
            title: const Text('회원 탈퇴'),
            content: SizedBox(
              height: 200,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text('탈퇴를 위해 비밀번호를 입력해주세요'),
                  // 비밀번호 입력받고 맞으면 deleteUser();
                  TextField(
                      controller: pwController,
                      obscureText: true,
                      decoration: const InputDecoration(
                        hintText: '비밀번호 입력',
                      )),
                  ElevatedButton(
                    onPressed: () {
                      // 삭제 버튼 누르면 정보 삭제되고 로그인으로 이동

                      UserRepository rep = UserRepository();

                      AuthController.to.loginIdUser(id, pwController.text).then(
                        (value) {
                          if (value?.id == id &&
                              value?.password == pwController.text) {
                            // 비밀번호 맞는 경우
                            rep.deleteUser();
                            Get.offAll(const Login());
                          } else {
                            // 비밀번호 틀린 경우
                            showDialog(
                                context: context,
                                builder: ((context) {
                                  return const AlertDialog(
                                    title: Text('비밀번호를 확인해주세요'),
                                  );
                                }));
                          }
                        },
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red,
                    ),
                    child: const Text(
                      '삭제',
                    ),
                  )
                ],
              ),
            ),
          );
        }));
  }
}
