import 'package:dr_oh_app/app.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';

class DResult extends StatefulWidget {
  final String result;
  const DResult({super.key, required this.result});

  @override
  State<DResult> createState() => _DResultState();
}

class _DResultState extends State<DResult> {
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
