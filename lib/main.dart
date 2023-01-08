import 'package:dr_oh_app/app.dart';
import 'package:dr_oh_app/components/style.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'binding/init_bindings.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // Date: 2023-01-07, SangwonKim
        // 프라이머리 스와치 컬러 : figma > primary-진하게 > colorcode: 5B9D46
        // Update Date: 2023-01-08, SangwonKim
        // color code 변경: primary > 99CD89
        primarySwatch:
            ColorService.createMaterialColor(const Color(0xFF99CD89)),
        // Date: 2023-01-07, SangwonKim
        // Desc: app바 테마 설정
        appBarTheme: AppBarTheme(
          color: Colors.grey[50],
          foregroundColor: Colors.black,
        ),
      ),
      darkTheme: ThemeData.dark(),
      initialBinding: InitBinding(),
      home: const App(),
    );
  }
}
