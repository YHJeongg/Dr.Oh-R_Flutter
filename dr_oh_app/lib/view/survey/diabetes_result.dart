import 'package:dr_oh_app/app.dart';
import 'package:dr_oh_app/components/diabetes_bar_chart_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DResult extends StatefulWidget {
  final String result;
  const DResult({super.key, required this.result});

  @override
  State<DResult> createState() => _DResultState();
}

class _DResultState extends State<DResult> {
  late double result;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    result = double.parse(widget.result) * 100;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text(
            '예측 결과',
          ),
          elevation: 1,
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  result >= 75
                      ? '위험'
                      : result >= 50
                          ? '주의'
                          : result >= 25
                              ? '관심'
                              : '안전',
                  style: const TextStyle(
                    fontSize: 30,
                  ),
                ),
              ),
              const SizedBox(height: 12),
              Text(
                '${(double.parse(widget.result) * 100).round()}',
                style: const TextStyle(
                  fontSize: 50,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    '0',
                    style: TextStyle(
                      fontSize: 30,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(15),
                    child: Container(
                      width: 200,
                      height: 50,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: const Color(0xCCCCE6C4),
                      ),
                      child: Row(
                        children: [
                          Container(
                            width: double.parse(widget.result) * 200,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: result >= 75
                                    ? Colors.red
                                    : result >= 50
                                        ? Colors.orange
                                        : result >= 25
                                            ? Colors.indigo
                                            : Colors.green
                                // const Color(0xFF5B9D46),
                                ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const Text(
                    '100',
                    style: TextStyle(
                      fontSize: 30,
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              // Date: 2023-01-11, SangwonKim
              // Desc: 연령대별 당뇨병 위험도 차트
              const DiabetesBarChartWidget(),
              const SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: ElevatedButton(
                  onPressed: () {
                    Get.off(const App());
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [Text('처음으로')],
                  ),
                ),
              ),
            ],
          ),
        ));
  }
}
