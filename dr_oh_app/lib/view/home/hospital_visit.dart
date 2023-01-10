import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get_state_manager/get_state_manager.dart';

class HospitalVisit extends StatefulWidget {
  const HospitalVisit({super.key});

  @override
  State<HospitalVisit> createState() => _HospitalVisitState();
}

class _HospitalVisitState extends State<HospitalVisit> {
  TextEditingController hospitalController = TextEditingController();
  TextEditingController dateController = TextEditingController();
  int value = 0;

  // Desc: 내원 목적 라디오버튼
  // Date: 2023-01-10
  Widget _customRadioButton(String text, int index) {
    return OutlinedButton(
      onPressed: () {
        setState(() {
          value = index;
        });
      },
      child: Text(
        text,
        style: TextStyle(
          color: (value == index) ? Colors.green : Colors.black,
        ),
      ),
    );
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    dateController.text = DateTime.now().toString().substring(0, 10);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('내원이력 입력'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 20, right: 20),
              child: TextField(
                controller: dateController,
                readOnly: true,
                onTap: () {
                  _showDatePickerPop();
                },
                decoration: const InputDecoration(
                  hintText: '날짜',
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20, right: 20),
              child: TextField(
                controller: hospitalController,
                decoration: const InputDecoration(
                  hintText: '병원명',
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                const Text('내원 목적'),
                _customRadioButton('진료', 1),
                _customRadioButton('처방', 2),
                _customRadioButton('검진', 3)
              ],
            ),
            ElevatedButton(onPressed: () {}, child: const Text('추가'))
          ],
        ),
      ),
    );
  }

  void _showDatePickerPop() {
    Future<DateTime?> selectedDate = showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime.now().add(Duration(days: 30)),
      builder: (BuildContext context, Widget? child) {
        return Theme(
          data: ThemeData.dark(),
          child: child!,
        );
      },
    );
    selectedDate.then((value) {
      dateController.text = value.toString().substring(0, 10);
    });
  }
}
