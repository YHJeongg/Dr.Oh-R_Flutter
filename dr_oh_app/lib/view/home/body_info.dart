import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dr_oh_app/components/logout_btn.dart';
import 'package:flutter/material.dart';

class BodyInfo extends StatefulWidget {
  const BodyInfo({super.key});

  @override
  State<BodyInfo> createState() => _BodyInfoState();
}

class _BodyInfoState extends State<BodyInfo> {
  TextEditingController heightController = TextEditingController();
  TextEditingController weightController = TextEditingController();
  TextEditingController bpController = TextEditingController();

  // Desc: 신체정보 입력받는 TextField
  // Date: 2023-01-11
  Widget _typeInfo(dynamic controller, String text) {
    return Padding(
      padding: const EdgeInsets.only(left: 100, right: 100),
      child: TextField(
        controller: heightController,
        keyboardType: const TextInputType.numberWithOptions(decimal: true),
        decoration: InputDecoration(
          hintText: text,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('신체정보 입력'),
        elevation: 1,
        actions: const [LogoutBtn()],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Column(
              children: [
                _typeInfo(heightController, '키'),
                _typeInfo(weightController, '몸무게'),
                _typeInfo(bpController, '혈압'),
                ElevatedButton(
                    onPressed: () {
                      addAction('qwer', '170', '20', '100');
                    },
                    child: const Text('저장'))
              ],
            ),
          ],
        ),
      ),
    );
  }

  addAction(String id, String height, String weight, String bp) {
    FirebaseFirestore.instance
        .collection('bodyinfo')
        .add({'id': id, 'height': height, 'weight': weight, 'bp': bp});
    _showDialog(context);
  }

  _showDialog(BuildContext context) {
    showDialog(
        context: context,
        builder: ((BuildContext context) {
          return AlertDialog(
            title: const Text('입력 결과'),
            content: const Text(
              '입력이 완료되었습니다.',
            ),
            actions: [
              TextButton(
                onPressed: (() {
                  Navigator.of(context).pop();
                  Navigator.pop(context);
                }),
                child: const Text(
                  'OK',
                ),
              ),
            ],
          );
        }));
  }
}
