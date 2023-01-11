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

  late String normalComment;
  late String lightComment;
  late String abNormalComment;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    normal = '정상';
    lightNormal = '경도 치매';
    abNormal = '치매';

    normalComment = '님 정상입니다. 가벼운 산책이나 요가 등 운동을 꾸준히 하시면 치매 예방에 도움이 됩니다.';
    lightComment = '님 경도 치매가 의심됩니다. 가까운 병원을 알려드릴게요.';
    abNormalComment = '님 치매가 의심됩니다. 가까운 병원을 알려드릴게요';
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
