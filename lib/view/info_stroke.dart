import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class InfoStroke extends StatelessWidget {
  const InfoStroke({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('뇌졸중 정보'),
        elevation: 0,
      ),
    );
  }
}