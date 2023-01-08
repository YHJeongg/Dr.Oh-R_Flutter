import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class HospitalVisit extends StatefulWidget {
  const HospitalVisit({super.key});

  @override
  State<HospitalVisit> createState() => _HospitalVisitState();
}

class _HospitalVisitState extends State<HospitalVisit> {
  TextEditingController hospitalController = TextEditingController();
  TextEditingController dateController = TextEditingController();
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
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              Container(
                  padding: const EdgeInsets.only(top: 50, bottom: 50),
                  height: 200,
                  width: 300,
                  child: CupertinoDatePicker(
                    mode: CupertinoDatePickerMode.date,
                    onDateTimeChanged: (value) {
                      dateController.text = value.toString().substring(0, 10);
                    },
                  )),
              Padding(
                padding: const EdgeInsets.only(left: 20, right: 20),
                child: TextField(
                  controller: dateController,
                  readOnly: true,
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
              ElevatedButton(onPressed: () {}, child: const Text('추가'))
            ],
          ),
        ),
      ),
    );
  }
}
