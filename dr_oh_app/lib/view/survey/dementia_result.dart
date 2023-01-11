

import 'package:dr_oh_app/app.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DementiaResult extends StatefulWidget {
  final String result;
  const DementiaResult({super.key, required this.result});

  @override
  State<DementiaResult> createState() => _DementiaResultState();
}

class _DementiaResultState extends State<DementiaResult> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text(
            '예측 결과',
          ),
        ),
        body: Center(
          child: Column(
            children: [
              Text(
                '예측 결과는 ${widget.result}입니다.',
              ),
              ElevatedButton(
                onPressed: () {
                  Get.off(
                    const App(),
                  );
                },
                child: const Text(
                  '처음으로',
                ),
              ),
            ],
          ),
        ));
  }
}
