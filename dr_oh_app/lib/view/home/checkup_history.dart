import 'package:dr_oh_app/components/logout_btn.dart';
import 'package:dr_oh_app/viewmodel/checkup_history_view_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CheckupHistory extends StatelessWidget {
  CheckupHistory({super.key});

  CheckupHistoryViewModel checkupHistoryViewModel = CheckupHistoryViewModel();

  @override
  Widget build(BuildContext context) {
    // Desc: 조회한 날짜 표시
    var selectedDate = Get.arguments;
    return Scaffold(
      appBar: AppBar(
        title: const Text('검진기록 조회'),
        elevation: 1,
        actions: const [LogoutBtn()],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              '검진날짜: ${selectedDate.toString().substring(0, 10)}',
              style: const TextStyle(fontSize: 20),
            ),
            StreamBuilder(
                stream: checkupHistoryViewModel.stream,
                builder: ((context, snapshot) {
                  return Column(
                    children: [
                      Text('검진항목: ${checkupHistoryViewModel.name.toString()}'),
                      Text(
                          '검진결과: ${checkupHistoryViewModel.result.toString()}'),
                    ],
                  );
                })),
          ],
        ),
      ),
    );
  }
}
