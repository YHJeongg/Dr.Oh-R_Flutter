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
  late String normal;
  late String lightNormal;
  late String abNormal;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    normal = '정상';
    lightNormal = '경도 치매';
    abNormal = '치매';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text(
            '치매 예측 결과',
          ),
        ),
        body: Center(
          child: Column(
            children: [
              Text('예측 결과는 ${widget.result}입니다.'),
              const SizedBox(
                height: 30,
              ),
              Text('예측 결과는 ${widget.result == '0.0' ? normal : widget.result == '0.5' ? lightNormal : abNormal}입니다.'),
             
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
