import 'package:dr_oh_app/viewmodel/home_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';

class CheckupHistory extends StatelessWidget {
  CheckupHistory({super.key});

  @override
  Widget build(BuildContext context) {
    // Desc: 조회한 날짜 표시
    var selectedDate = Get.arguments;
    return Scaffold(
      appBar: AppBar(
        title: const Text('검진기록 조회'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              '검진날짜: ${selectedDate.toString().substring(0, 10)}',
              style: const TextStyle(fontSize: 20),
            ),
          ],
        ),
      ),
    );
  }
}
