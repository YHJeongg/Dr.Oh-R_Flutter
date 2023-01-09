import 'package:get/get.dart';

import '../viewmodel/bottom_nav_controller.dart';

// Date: 2023-01-07, jyh
class InitBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(BottomNavController(), permanent: true);
  }
}
