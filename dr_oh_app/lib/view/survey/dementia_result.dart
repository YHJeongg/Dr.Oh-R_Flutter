import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dr_oh_app/app.dart';
import 'package:dr_oh_app/components/dementia_bar_chart_widget.dart';
import 'package:dr_oh_app/components/logout_btn.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DementiaResult extends StatefulWidget {
  final String result;
  final String resultReg;

  const DementiaResult(
      {super.key, required this.result, required this.resultReg});

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
    super.initState();
    _initSharedPreferences();

    id = '';

    normal = '정상';
    lightNormal = '경도 치매';
    abNormal = '치매';

    normalComment = ' 가벼운 산책이나 요가 등 운동을 꾸준히 하시면 치매 예방에 도움이 됩니다.';
    lightComment = ' 가까운 병원을 알아보세요!.';
    abNormalComment = ' 가까운 병원을 알아보세요!';

    resultReg1 =
        double.parse((double.parse(widget.resultReg) * 100).toStringAsFixed(2));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text(
            '치매 예측 결과',
          ),
          elevation: 1,
          actions: const [LogoutBtn()],
        ),
        body: Center(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(20, 50, 20, 20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                //Text('예측 결과는 ${widget.result}입니다.'),

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('$id님의 예측 결과는 ',
                        style: const TextStyle(
                          fontSize: 20,
                        )),
                    Text(
                      widget.result == '0'
                          ? normal
                          : widget.result == '0.5'
                              ? lightNormal
                              : abNormal,
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: widget.result == '0'
                            ? Colors.blue
                            : widget.result == '0.5'
                                ? Colors.purple
                                : Colors.red,
                      ),
                    ),
                    const Text('입니다.',
                        style: TextStyle(
                          fontSize: 20,
                        )),
                  ],
                ),

                _graph(),
                Text('$resultReg1%',
                    style: const TextStyle(
                      fontSize: 15,
                    )),
                const DementiaBarChart(),

                Text(
                  '$id님 ${widget.result == '0' ? normalComment : widget.result == '0.5' ? lightComment : abNormalComment}',
                  style: const TextStyle(
                    fontSize: 20,
                  ),
                ),

                ElevatedButton(
                  onPressed: () {
                    Get.off(
                      const App(),
                    );
                    _addAction();
                  },
                  style: const ButtonStyle(
                      minimumSize: MaterialStatePropertyAll(
                    Size(300, 60),
                  )),
                  child: const Text(
                    '처음으로',
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
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
  } //_initSharedPreferences

  _addAction() async {
    String date = DateTime.now().toString().substring(0, 10);

    var data = await FirebaseFirestore.instance
        .collection('users')
        .where('id', isEqualTo: id)
        .get();

    FirebaseFirestore.instance
        .collection('users')
        .doc(data.docs.first.id)
        .collection('dementia_p')
        .add({'date': date, 'dementia_p': resultReg1});
  } // -addAction

  Widget _graph() {
    return Row(
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
                      // Date: 2023-01-11, SangwonKim
                      // Desc: 위험도 카테고리별 색상분류
                      color: resultReg1 >= 75
                          ? Colors.red
                          : resultReg1 >= 50
                              ? Colors.orange
                              : resultReg1 >= 25
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
    );
  }
}
