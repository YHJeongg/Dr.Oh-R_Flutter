import 'package:dr_oh_app/components/line_chart.dart';
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
            Text('당뇨 그래프'),
            Container(
              decoration: BoxDecoration(border: Border()),
              child: CustomPaint(
                size: Size(250, 200),
                painter: LineChart(
                    lineColor: Colors.black,
                    lineWidth: 5,
                    pointColor: Colors.black,
                    pointSize: 8,
                    points: [1, 2, 3, 4, 5, 5, 4, 4, 2, 1]),
                child: GestureDetector(
                  onTap: () {},
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
