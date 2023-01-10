import 'package:dr_oh_app/app.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

// Date: 2023-01-10, SangwonKim
// Desc: 설문결과 페이지
class StrokeResultPage extends StatefulWidget {
  final String result;
  const StrokeResultPage({super.key, required this.result});

  @override
  State<StrokeResultPage> createState() => _StrokeResultPageState();
}

class _StrokeResultPageState extends State<StrokeResultPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('예측 결과'),
        elevation: 1,
      ),
      body: Center(
        child: Column(
          children: [
            Text(
              '예측 결과는 ${widget.result}입니다.',
            ),
            ElevatedButton(
              onPressed: () {
                Get.off(const App());
              },
              child: const Text('처음으로'),
            ),
          ],
        ),
      ),
    );
  }
}
