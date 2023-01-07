import 'package:dr_oh_app/view/hospital.dart';
import 'package:dr_oh_app/view/information.dart';
import 'package:dr_oh_app/view/mypage.dart';
import 'package:dr_oh_app/view/survey.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'view/home.dart';
import 'viewmodel/bottom_nav_controller.dart';

class App extends GetView<BottomNavController> {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: controller.willPopAction,
      child: Obx(
        () => Scaffold(
          body: IndexedStack(
            index: controller.pageIndex.value, // 현재 페이지 확인
            children: const [
              Home(),
              Survey(),
              Hospital(),
              Information(),
              MyPage(),
            ],
          ),
          bottomNavigationBar: BottomNavigationBar(
            type: BottomNavigationBarType.fixed,
            showSelectedLabels: false,
            showUnselectedLabels: false,
            currentIndex: controller.pageIndex.value, // items의 몇번째 페이지인지 지정
            elevation: 0,
            // Date: 2023-01-07, SangwonKim
            // Desc: 임시 : 내비게이션바 바탕색 -> transparent사용 -> DarkMode에 용이
            backgroundColor: Colors.transparent.withOpacity(0.1),
            onTap: controller.changeBottomNav,
            items: const [
              BottomNavigationBarItem(
                icon: Icon(Icons.home),
                activeIcon: Icon(Icons.home),
                label: 'Home',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.content_paste),
                activeIcon: Icon(Icons.content_paste),
                label: 'Survey',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.local_hospital),
                activeIcon: Icon(Icons.local_hospital),
                label: 'Hospital',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.info_outline),
                activeIcon: Icon(Icons.info_outline),
                label: 'Information',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.account_box_rounded),
                activeIcon: Icon(Icons.account_box_rounded),
                label: 'MyPage',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
