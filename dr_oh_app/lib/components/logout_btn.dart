import 'package:dr_oh_app/view/login.dart';
import 'package:dr_oh_app/viewmodel/bottom_nav_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

// ------------------------------------------------------------------------
// Date: 2023-01-12, SangwonKim
// Desc: 로그아웃 버튼 클래스
class LogoutBtn extends StatefulWidget {
  const LogoutBtn({super.key});

  @override
  State<LogoutBtn> createState() => _LogoutBtnState();
}

class _LogoutBtnState extends State<LogoutBtn> {
  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: const Icon(
        Icons.logout_rounded,
      ),
      onPressed: () async {
        // Date: 2023-01-12, SangwonKim
        // Desc: SharedPreferences clear
        final pref = await SharedPreferences.getInstance();
        pref.clear();

        // Date: 2023-01-12, SangwonKim
        // Desc: 바텀내비게이션바 초기값 홈화면으로 설정 - 아직 미구현
        BottomNavController bottomNavController = BottomNavController();
        bottomNavController.bottomHistory = [0];

        Get.offAll(const Login());
      },
    );
  }
}
