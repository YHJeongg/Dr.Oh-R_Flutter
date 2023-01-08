import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class Medication extends StatelessWidget {
  const Medication({super.key});
  Widget _datePicker() {
    return Container(
        padding: const EdgeInsets.only(top: 50, bottom: 50),
        height: 200,
        width: 180,
        child: CupertinoTheme(
          data: const CupertinoThemeData(
            textTheme: CupertinoTextThemeData(
              dateTimePickerTextStyle: TextStyle(
                fontSize: 12,
              ),
            ),
          ),
          child: CupertinoDatePicker(
            mode: CupertinoDatePickerMode.date,
            onDateTimeChanged: (value) {},
          ),
        ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('투약이력 입력'),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              Wrap(
                direction: Axis.horizontal,
                children: [
                  _datePicker(),
                  _datePicker(),
                ],
              ),
              const Text('기간'),
              ElevatedButton(onPressed: () {}, child: const Text('저장'))
            ],
          ),
        ),
      ),
    );
  }
}
