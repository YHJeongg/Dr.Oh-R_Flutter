import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class ChartDiabetes extends StatelessWidget {
  const ChartDiabetes({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('당뇨병 그래프'),
        elevation: 0,
      ),
      body: Center(
        child: Column(
          children: [
            Container(
              child: CustomPaint(
                size: Size(200, 200),
              ),
            )
          ],
        ),
      ),
    );
  }
}
