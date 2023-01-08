import 'package:flutter/material.dart';

class InfoBmi extends StatelessWidget {
  const InfoBmi({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('BMI 정보'),
        elevation: 0,
      ),
    );
  }
}