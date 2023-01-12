import 'package:dr_oh_app/app.dart';
import 'package:dr_oh_app/components/dementia_bar_chart_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DementiaResult extends StatefulWidget {
  final String result;
  final String resultReg;

  const DementiaResult({super.key, required this.result, required this.resultReg});

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

  late double resultReg1;

  late String id;



  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _initSharedPreferences();

    id = '';

    normal = '정상';
    lightNormal = '경도 치매';
    abNormal = '치매';

    normalComment = ' 정상입니다. 가벼운 산책이나 요가 등 운동을 꾸준히 하시면 치매 예방에 도움이 됩니다.';
    lightComment = ' 경도 치매가 의심됩니다. 가까운 병원을 알아보세요!.';
    abNormalComment = ' 치매가 의심됩니다. 가까운 병원을 알아보세요!';

    resultReg1 = double.parse(widget.resultReg)*100;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text(
            '치매 예측 결과',
          ),
            elevation: 0,
        ),
        body: Center(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(20, 50, 20, 20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                //Text('예측 결과는 ${widget.result}입니다.'),

                Text('예측 결과는 ${resultReg1}입니다.'),
                
                Text('${id}님의 예측 결과는 ${widget.result == '0' ? normal : widget.result == '0.5' ? lightNormal : abNormal}입니다.',
                style: const TextStyle(
                      fontSize: 20,
                    ),
                ),

                const DementiaBarChart(),
               
                Text('${id}님 ${widget.result == '0' ? normalComment : widget.result == '0.5' ? lightComment : abNormalComment}',
                style: const TextStyle(
                      fontSize: 20,
                    ),
                ),

                ElevatedButton(
                  onPressed: () {
                    Get.off(
                      const App(),
                    );
                  },
                  style: const ButtonStyle(
                            minimumSize: MaterialStatePropertyAll(Size(300, 60),)
                          ),
                  child: const Text(
                    '처음으로',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold,
                          color: Colors.white
                          ),
                  ),
                ),
              ],
            ),
          ),
        ));
  }


  _initSharedPreferences() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      id = (prefs.getString('id') ?? "");
    });
  }
}
