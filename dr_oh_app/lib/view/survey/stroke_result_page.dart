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
          title: const Text(
            '예측 결과',
          ),
          elevation: 1,
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Padding(
                padding: EdgeInsets.all(8.0),
                child: Text(
                  '위험 수준',
                  style: TextStyle(
                    fontSize: 30,
                  ),
                ),
              ),
              Text(
                '${(double.parse(widget.result) * 100).round()}',
                style: const TextStyle(
                  fontSize: 50,
                ),
              ),
              const SizedBox(
                height: 50,
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
                              color: const Color(0xFF5B9D46),
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
                height: 60,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: ElevatedButton(
                  onPressed: () {
                    Get.off(const App());
                  },
                  child: const Text('처음으로'),
                ),
              ),
            ],
          ),
        ));
  }
}
