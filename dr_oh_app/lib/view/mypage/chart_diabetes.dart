import 'package:dr_oh_app/components/line_chart.dart';
import 'package:dr_oh_app/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class ChartDiabetes extends StatefulWidget {
  ChartDiabetes({super.key});

  @override
  State<ChartDiabetes> createState() => _ChartDiabetesState();
}

class _ChartDiabetesState extends State<ChartDiabetes> {
  late List<double> points = [1, 2, 3, 4, 5, 5, 4, 4, 2, 1];
  late FocusNode _node;
  bool _focused = false;
  @override
  void initState() {
    super.initState();
    _node = FocusNode(debugLabel: 'Button');
    _node.addListener(_handleFocusChange);
  }

  void _handleFocusChange() {
    if (_node.hasFocus != _focused) {
      setState(() {
        _focused = _node.hasFocus;
      });
    }
  }

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
              height: 200,
              width: 300,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.green,
              ),
              child: GestureDetector(
                onTapDown: (detail) {
                  print("onTapDown:(${detail.localPosition})");
                },
                onTapUp: (detail) {
                  print("onTapUp(${detail.localPosition})");
                },
                onHorizontalDragUpdate: (detail) {
                  print("onHorizontalDragUpdate:(${detail.localPosition})");
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CustomPaint(
                      size: Size(250, 200),
                      isComplex: true,
                      painter: LineChart(
                        lineColor: Colors.black,
                        lineWidth: 5,
                        pointColor: Colors.black,
                        pointSize: 8,
                        points: points,
                      ),
                      // child: Container(),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
