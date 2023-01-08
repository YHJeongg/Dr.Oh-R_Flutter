import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class HospitalVisit extends StatefulWidget {
  const HospitalVisit({super.key});

  @override
  State<HospitalVisit> createState() => _HospitalVisitState();
}

class _HospitalVisitState extends State<HospitalVisit> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('최근 내원이력'),
      ),
      body: Center(
        child: Column(
          children: [
            ListView.builder(
                itemCount: 1,
                itemBuilder: ((context, index) {
                  return Text('내원이력');
                }))
          ],
        ),
      ),
    );
  }
}
