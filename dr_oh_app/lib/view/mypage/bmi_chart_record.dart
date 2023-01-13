import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dr_oh_app/components/line_chart_widget.dart';
import 'package:dr_oh_app/components/logout_btn.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class BmiChartRecord extends StatefulWidget {
  const BmiChartRecord({super.key});

  @override
  State<BmiChartRecord> createState() => _BmiChartRecordState();
}

class _BmiChartRecordState extends State<BmiChartRecord> {
  late String id;

  @override
  void initState() {
    super.initState();
    id = '';
    _initSharedPreferences();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('BMI 차트 기록'),
        elevation: 1,
        actions: const [LogoutBtn()],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance
                  // >>>1st Try<<
                  .collection('result')
                  .where('category', isEqualTo: "BMI")
                  .where('userid', isEqualTo: id)
                  // .orderBy('date', descending: true) // 최신 10개 를 위해서 dsc으로 가져오기
                  .limit(10) // 10개만 가져오기
                  .snapshots(includeMetadataChanges: true),

              // >>>2st Try<<<
              // .collection('users').doc().collection('dimentia_p')
              // .where('id', isEqualTo: id)
              // // .where('category', isEqualTo: '뇌졸중')
              // // .orderBy('date', descending: false)
              // .limit(10)
              // .snapshots(includeMetadataChanges: true),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return const Center(child: CircularProgressIndicator());
                }
                if (snapshot.hasError) {
                  return const Text('Error');
                }
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Text('Loading');
                }
                if (snapshot.data == null) {
                  return const Text('Empty');
                }
                List listChart = snapshot.data!.docs.map((e) {
                  return {
                    'dateValue': e['date'],
                    'resultValue': e['result'],
                  };
                }).toList();

                return LineChartWidget(id: id, listChart: listChart);
              }),
        ),
      ),
    );
  }

  // --- Functions ---
  // -----------------------------------------------------------------------
  // Date: 2023--01-12, SangwonKim
  // Desc: SharedPreferences -> id 가져오기
  _initSharedPreferences() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      id = prefs.getString('id').toString();
    });
  }
} // End





// Date: 2023-01-12, SangwonKim
// ---- 하기 내용 component 폴더 / line_chart_widget.dart 로 옮김 : Class화 완료 -----



// // -------------------------------------------------------------------------
// // Date: 2023-01-12, SangwonKim
// // Desc: 차트그리기
// class LineChartWidget extends StatefulWidget {
  
//   final String id; // 유저 아이디 선언
//   final List listChart; // 유저 진단 결과 리스트 선언 ***

//   const LineChartWidget(
//       {super.key, required this.id, required this.listChart});

//   @override
//   State<LineChartWidget> createState() => _LineChartWidgetState();
// }

// class _LineChartWidgetState extends State<LineChartWidget> {

//   List<Color> gradientColors = [
//     const Color(0xff23b6e6),
//     const Color(0xff02d39a),
//   ];

//   bool showAvg = false; // 평균보여주기 유무

//   @override
//   Widget build(BuildContext context) {
//     return Stack(
//       children: <Widget>[
//         AspectRatio(
//           aspectRatio: 1.00,
//           child: DecoratedBox(
//             decoration: const BoxDecoration(
//               borderRadius: BorderRadius.all(Radius.circular(12)),
//               color: Color(0xFFCCE6C4),
//             ),
//             child: Padding(
//                 padding: const EdgeInsets.only(
//                   right: 18,
//                   left: 12,
//                   top: 36,
//                   bottom: 20,
//                 ),
//                 child: LineChart(
//                   // mainData: 꺽은선 그래프
//                   showAvg
//                       ? avgData(widget.listChart) // 유저 평균
//                       : mainData(widget.listChart), // 유저 날짜별 위험도 기록
//                 )),
//           ),
//         ),
//         SizedBox(
//           width: 60,
//           height: 34,
//           child: TextButton(
//             onPressed: () {
//               setState(() {
//                 showAvg = !showAvg;
//               });
//             },
//             child: Text(
//               '평균',
//               style: TextStyle(
//                 fontSize: 14,
//                 fontWeight: FontWeight.w600,
//                 color: showAvg
//                     ? Colors.deepOrange.withOpacity(0.5)
//                     : Colors.deepOrange,
//               ),
//             ),
//           ),
//         ),
//       ],
//     );
//   }

//   Widget bottomTitleWidgets(double value, TitleMeta meta) {
//     const style = TextStyle(
//       color: Colors.black,
//       // fontWeight: FontWeight.bold,
//       fontSize: 12,
//       letterSpacing: -1,
//     );
//     // 위젯 텍스트 선언
//     Widget text = const Text('');

//     // Date: 2023-01-13, SangwonKim
//     // Desc: 날짜 가져오기
//     for (int i = 0; i < widget.listChart.length; i++) {
//       if (value.toInt() == i) {
//         text = Text(
//           widget.listChart[widget.listChart.length - i - 1]['dateValue']
//               .toString()
//               .replaceFirst('-', '\n'),
//           style: style,
//         );
//       }
//     }

//     // --- 기존 방식 ---
//     // switch (value.toInt()) {
//     //   case 2:
//     //     text = const Text('22.12.12', style: style);
//     //     break;
//     //   case 5:
//     //     text = const Text('JUN', style: style);
//     //     break;
//     //   case 8:
//     //     text = const Text('SEP', style: style);
//     //     break;
//     //   default:
//     //     text = const Text('', style: style);
//     //     break;
//     // }

//     return SideTitleWidget(
//       axisSide: meta.axisSide,
//       child: text,
//     );
//   }

//   // Y축 요소 설정하기 -> 0 ~ 100 설정
//   Widget leftTitleWidgets(double value, TitleMeta meta) {
//     const style = TextStyle(
//       color: Colors.black,
//       // fontWeight: FontWeight.bold,
//       fontSize: 14,
//     );
//     String text;
//     switch (value.toInt()) {
//       case 0:
//         text = '0';
//         break;
//       case 1:
//         text = '10';
//         break;
//       case 2:
//         text = '20';
//         break;
//       case 3:
//         text = '30';
//         break;
//       case 4:
//         text = '40';
//         break;
//       case 5:
//         text = '50';
//         break;
//       case 6:
//         text = '60';
//         break;
//       case 7:
//         text = '70';
//         break;
//       case 8:
//         text = '80';
//         break;
//       case 9:
//         text = '90';
//         break;
//       case 10:
//         text = '100';
//         break;
//       default:
//         return Container();
//     }

//     return Text(text, style: style, textAlign: TextAlign.left);
//   }

//   // ------------------------------------------------------------------------------------------
//   // Date: 2023-01-13, SangwonKim
//   // Desc: 메인 차트
//   LineChartData mainData(List listChart) {
//     return LineChartData(
//       gridData: FlGridData(
//         show: true,
//         drawVerticalLine: true,
//         horizontalInterval: 1,
//         verticalInterval: 1,
//         getDrawingHorizontalLine: (value) {
//           return FlLine(
//             color: const Color(0xff37434d),
//             strokeWidth: 0.5,
//           );
//         },
//         getDrawingVerticalLine: (value) {
//           return FlLine(
//             color: const Color(0xff37434d),
//             strokeWidth: 0.5,
//           );
//         },
//       ),
//       titlesData: FlTitlesData(
//         show: true,
//         rightTitles: AxisTitles(
//           sideTitles: SideTitles(showTitles: false),
//         ),
//         topTitles: AxisTitles(
//           sideTitles: SideTitles(showTitles: false),
//         ),
//         bottomTitles: AxisTitles(
//           sideTitles: SideTitles(
//             showTitles: true,
//             reservedSize: 36,
//             interval: 1,
//             getTitlesWidget: bottomTitleWidgets,
//           ),
//         ),
//         leftTitles: AxisTitles(
//           sideTitles: SideTitles(
//             showTitles: true,
//             interval: 1,
//             getTitlesWidget: leftTitleWidgets,
//             reservedSize: 42,
//           ),
//         ),
//       ),
//       borderData: FlBorderData(
//         show: true,
//         border: Border.all(color: const Color(0xff37434d)),
//       ),
//       // X축 min, max
//       minX: 0,
//       maxX: 9,
//       // Y축 min, max
//       minY: 0,
//       maxY: 10,
//       lineBarsData: [
//         LineChartBarData(
//           // ******* (x,y)의 좌표 설정하기 *******
//           spots: [
//             for (int i = 0; i < listChart.length; i++) ...[
//               FlSpot(
//                   i.toDouble(),
//                   double.parse(listChart[listChart.length - i - 1]
//                               ['resultValue']
//                           .toString()) *
//                       100 /
//                       10),
//             ],
//             // FlSpot(3, 3),
//           ],
//           // isCurved: true, // 커브주기
//           // gradient: LinearGradient(colors: gradientColors),
//           barWidth: 4,
//           isStrokeCapRound: true,
//           dotData: FlDotData(show: true), // 점 보여주기
//           belowBarData: BarAreaData(
//             show: true,
//             gradient: LinearGradient(
//               colors: gradientColors
//                   .map((color) => color.withOpacity(0.2)) // 그래프 아래 투명도
//                   .toList(),
//             ),
//           ),
//         ),
//       ],
//     );
//   }

//   // ------------------------------------------------------------------------------------------
//   // Date: 2023-01-13, SangwonKim
//   // Desc: 평균 차트
//   LineChartData avgData(List listChart) {
//     // Date: 2023-01-13, SangwonKim
//     // Desc: 평균 구하기
//     double sumResult = 0;
//     double avgResult = 0;
//     for (int i = 0; i < listChart.length; i++) {
//       sumResult = sumResult +
//           (double.parse(listChart[i]['resultValue'].toString()) * 100 / 10);
//     }
//     avgResult = sumResult / listChart.length;

//     return LineChartData(
//       lineTouchData: LineTouchData(enabled: false),
//       gridData: FlGridData(
//         show: true,
//         drawHorizontalLine: true,
//         verticalInterval: 1,
//         horizontalInterval: 1,
//         getDrawingVerticalLine: (value) {
//           return FlLine(
//             color: const Color(0xff37434d),
//             strokeWidth: 0.5,
//           );
//         },
//         getDrawingHorizontalLine: (value) {
//           return FlLine(
//             color: const Color(0xff37434d),
//             strokeWidth: 0.5,
//           );
//         },
//       ),
//       titlesData: FlTitlesData(
//         show: true,
//         bottomTitles: AxisTitles(
//           sideTitles: SideTitles(
//             showTitles: true,
//             reservedSize: 36,
//             getTitlesWidget: bottomTitleWidgets,
//             interval: 1,
//           ),
//         ),
//         leftTitles: AxisTitles(
//           sideTitles: SideTitles(
//             showTitles: true,
//             getTitlesWidget: leftTitleWidgets,
//             reservedSize: 42,
//             interval: 1,
//           ),
//         ),
//         topTitles: AxisTitles(
//           sideTitles: SideTitles(showTitles: false),
//         ),
//         rightTitles: AxisTitles(
//           sideTitles: SideTitles(showTitles: false),
//         ),
//       ),
//       borderData: FlBorderData(
//         show: true,
//         border: Border.all(color: const Color(0xff37434d)),
//       ),
//       minX: 0,
//       maxX: 9,
//       minY: 0,
//       maxY: 10,
//       lineBarsData: [
//         LineChartBarData(
//           spots: [
//             for (int i = 0; i < listChart.length; i++) ...[
//               FlSpot(i.toDouble(), avgResult),
//             ],
//             // FlSpot(0, 3.44),
//             // FlSpot(2.6, 3.44),
//             // FlSpot(4.9, 3.44),
//             // FlSpot(6.8, 3.44),
//             // FlSpot(8, 3.44),
//             // FlSpot(9.5, 3.44),
//             // FlSpot(11, 3.44),
//           ],
//           isCurved: true,
//           gradient: LinearGradient(
//             colors: [
//               ColorTween(begin: gradientColors[0], end: gradientColors[1])
//                   .lerp(0.2)!,
//               ColorTween(begin: gradientColors[0], end: gradientColors[1])
//                   .lerp(0.2)!,
//             ],
//           ),
//           barWidth: 5,
//           isStrokeCapRound: true,
//           dotData: FlDotData(
//             show: false,
//           ),
//           belowBarData: BarAreaData(
//             show: true,
//             gradient: LinearGradient(
//               colors: [
//                 ColorTween(begin: gradientColors[0], end: gradientColors[1])
//                     .lerp(0.2)!
//                     .withOpacity(0.2),
//                 ColorTween(begin: gradientColors[0], end: gradientColors[1])
//                     .lerp(0.2)!
//                     .withOpacity(0.2),
//               ],
//             ),
//           ),
//         ),
//       ],
//     );
//   }
// }
