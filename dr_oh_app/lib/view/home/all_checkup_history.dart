import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dr_oh_app/model/user.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class AllCheckupHistory extends StatelessWidget {
  const AllCheckupHistory({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('전체 검진기록'),
        elevation: 0,
      ),
      body: Center(
        child: Column(
          children: [
            CustomRadio(),
          ],
        ),
      ),
    );
  }
}

// Desc: 검진기록 항목별 구분 라디오버튼
// Date: 2023-01-10
class CustomRadio extends StatefulWidget {
  const CustomRadio({super.key});

  @override
  State<CustomRadio> createState() => _CustomRadioState();
}

class _CustomRadioState extends State<CustomRadio> {
  int value = 0;

  Widget _customRadioButton(String text, int index) {
    return SizedBox(
      height: 30,
      width: 65,
      child: OutlinedButton(
        onPressed: () {
          setState(() {
            value = index;
          });
        },
        child: Text(
          text,
          style: TextStyle(
              color: (value == index) ? Colors.green : Colors.black,
              fontSize: 12),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        _customRadioButton('전체', 0),
        _customRadioButton('당뇨병', 1),
        _customRadioButton('뇌졸중', 2),
        _customRadioButton('치매', 3),
      ],
    );
  }
}
