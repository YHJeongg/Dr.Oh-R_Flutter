import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../components/message_popup.dart';

// Date: 2023-01-07, jyh
// 선택된 페이지를 보기 쉽게 문자로 만듬
enum PageName { HOME, SURVEY, HOSPITAL, INFORMATION, MYPAGE }

class BottomNavController extends GetxController {
  static BottomNavController get to => Get.find();
  // 현재 페이지 기본 0번
  RxInt pageIndex = 0.obs;
  GlobalKey<NavigatorState> searchPageNaviationKey =
      GlobalKey<NavigatorState>();
  List<int> bottomHistory = [0];

  // page 관리
  void changeBottomNav(int value, {bool hasGesture = true}) {
    var page = PageName.values[value];

    // bottom_nav에서 선택된 페이지로 이동
    switch (page) {
      case PageName.HOME:
      case PageName.SURVEY:
      case PageName.HOSPITAL:
      case PageName.INFORMATION:
      case PageName.MYPAGE:
        _changePage(value, hasGesture: hasGesture);
        break;
    }
  }

  void _changePage(int value, {bool hasGesture = true}) {
    // bottom_nav에서 클릭한 페이지로 번호 지정
    pageIndex(value);

    if (!hasGesture) return;
    if (bottomHistory.last != value) {
      bottomHistory.add(value);
    }
  }

  Future<bool> willPopAction() async {
    // 최초 상태, 기본이 1개있기 때문에 쌓여있는게 없는 상태
    if (bottomHistory.length == 1) {
      // 마지막 뒤로가기 클릭 시 앱종료 팝업
      showDialog(
        context: Get.context!,
        builder: (context) => MessagePopup(
          title: '시스템',
          message: '종료하시겠습니까?',
          okCallback: () => SystemNavigator.pop(),
          cancelCallback: () => Get.back(),
        ),
      );
      return true;
    }

    // 뒤로가기 클릭시 List에 쌓여있는 value 하나씩 제거
    bottomHistory.removeLast();
    var index = bottomHistory.last;
    changeBottomNav(index);
    bottomHistory.clear();
    return false;
  }
}
