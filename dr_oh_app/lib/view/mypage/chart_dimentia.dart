

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dr_oh_app/components/dementia_answer_list.dart';
import 'package:dr_oh_app/components/logout_btn.dart';
import 'package:dr_oh_app/model/dementia_chart_message.dart';
import 'package:dr_oh_app/model/firebase_dementia.dart';
import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DementiaChartData extends StatefulWidget {
  const DementiaChartData({super.key});

  @override
  State<DementiaChartData> createState() => _StrokeChartRecordState();
}

class _StrokeChartRecordState extends State<DementiaChartData> {
  late String id;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    id = '';
    _initSharedPreferences();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('치매 그래프'),
        elevation: 1,
        actions: const [LogoutBtn()],
      ),
      body: Center(
        // child: LineChartSample2(doc: null,),

        child: _readAction(id)
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

  // -----------------------------------------------------------------------
  // Date: 2023--01-12, SangwonKim
  // Desc: _buildItemWidget
  Widget _buildItemWidget(DocumentSnapshot doc) {
    // final student = Student(
    //     code: doc['code'],
    //     name: doc['name'],
    //     dept: doc['dept'],
    //     phone: doc['phone']);
    return Dismissible(
      direction: DismissDirection.endToStart,
      background: Container(
        color: Colors.red,
        alignment: Alignment.centerRight,
        child: const Icon(Icons.delete_forever),
      ),
      key: ValueKey(doc),
      onDismissed: (direction) {
        FirebaseFirestore.instance.collection('students').doc(doc.id).delete();
      },
      child: Container(
        color: Colors.amberAccent,
        child: GestureDetector(
            // onTap: () {
            //   Message.id = doc.id;
            //   Message.code = doc['code']; // *** Key 값 아닌건 적어줘야한다.
            //   Message.name = doc['name']; // *** Key 값 아닌건 적어줘야한다.
            //   Message.dept = doc['dept']; // *** Key 값 아닌건 적어줘야한다.
            //   Message.phone = doc['phone']; // *** Key 값 아닌건 적어줘야한다.
            //   Navigator.push(
            //       context,
            //       MaterialPageRoute(
            //         builder: (context) => const Update(),
            //       ));
            // },
            // child: Card(
            //   child: ListTile(
            //     title: Text(
            //         '학번 : ${student.code}\n이름 : ${student.name}\n학과 : ${student.dept}\n전화번호 : ${student.phone}'),
            //   ),
            // ),
            ),
      ),
    );
  }
}

// -------------------------------------------------------------------------

class LineChartSample2 extends StatefulWidget {
  final DocumentSnapshot doc; // DocumentSnapshot doc
  const LineChartSample2({super.key, required this.doc});

  @override
  State<LineChartSample2> createState() => _LineChartSample2State();
}

class _LineChartSample2State extends State<LineChartSample2> {
  late int num1;
  late List? numList;

  List<Color> gradientColors = [
    const Color(0xff23b6e6),
    const Color(0xff02d39a),
  ];

  bool showAvg = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    num1 = (double.parse(widget.doc['result'][0]) * 100).round();
    numList = [];
    // 가져온 결과 갯수만큼 리스트에 저장하기
    for (int i = 0; i < widget.doc['result'].toString().length; i++) {
      numList!.add((double.parse(widget.doc['result'].toString()) * 100).round());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        AspectRatio(
          aspectRatio: 1.20,
          child: DecoratedBox(
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.all(
                Radius.circular(18),
              ),
              color: Color(0xff232d37),
            ),
            child: Padding(
              padding: const EdgeInsets.only(
                right: 18,
                left: 12,
                top: 24,
                bottom: 12,
              ),
              child: LineChart(
                showAvg ? avgData() : mainData(numList!),
              ),
            ),
          ),
        ),
        SizedBox(
          width: 60,
          height: 34,
          child: TextButton(
            onPressed: () {
              setState(() {
                showAvg = !showAvg;
              });
            },
            child: Text(
              'avg',
              style: TextStyle(
                fontSize: 12,
                color: showAvg ? Colors.white.withOpacity(0.5) : Colors.white,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget bottomTitleWidgets(double value, TitleMeta meta) {
    const style = TextStyle(
      color: Color(0xff68737d),
      fontWeight: FontWeight.bold,
      fontSize: 16,
    );
    Widget text;
    switch (value.toInt()) {
      case 2:
        text = const Text('MAR', style: style);
        break;
      case 5:
        text = const Text('JUN', style: style);
        break;
      case 8:
        text = const Text('SEP', style: style);
        break;
      default:
        text = const Text('', style: style);
        break;
    }

    return SideTitleWidget(
      axisSide: meta.axisSide,
      child: text,
    );
  }

  Widget leftTitleWidgets(double value, TitleMeta meta) {
    const style = TextStyle(
      color: Color(0xff67727d),
      fontWeight: FontWeight.bold,
      fontSize: 15,
    );
    String text;
    switch (value.toInt()) {
      case 1:
        text = '10K';
        break;
      case 3:
        text = '30k';
        break;
      case 5:
        text = '50k';
        break;
      default:
        return Container();
    }

    return Text(text, style: style, textAlign: TextAlign.left);
  }

  LineChartData mainData(List list) {
    
    return LineChartData(
      gridData: FlGridData(
        show: true,
        drawVerticalLine: true,
        horizontalInterval: 1,
        verticalInterval: 1,
        getDrawingHorizontalLine: (value) {
          return FlLine(
            color: const Color(0xff37434d),
            strokeWidth: 1,
          );
        },
        getDrawingVerticalLine: (value) {
          return FlLine(
            color: const Color(0xff37434d),
            strokeWidth: 1,
          );
        },
      ),
      titlesData: FlTitlesData(
        show: true,
        rightTitles: AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        topTitles: AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        bottomTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            reservedSize: 30,
            interval: 1,
            getTitlesWidget: bottomTitleWidgets,
          ),
        ),
        leftTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            interval: 1,
            getTitlesWidget: leftTitleWidgets,
            reservedSize: 42,
          ),
        ),
      ),
      borderData: FlBorderData(
        show: true,
        border: Border.all(color: const Color(0xff37434d)),
      ),
      minX: 0,
      // X축 갯수 - 기록의 갯수로?
      maxX: 10,
      minY: 0,
      // Y축 갯수
      maxY: 100,
      lineBarsData: [
        LineChartBarData(
          // ******* (x,y)의 좌표 설정하기 *******
          spots: [
            for(int i=0; i<numList!.length; i++)...[
            FlSpot(i.toDouble(), double.parse(numList![i].toString())),
            
            ]
            // FlSpot(1, numList![1]),
            // FlSpot(2, numList![2]),
            // FlSpot(3, numList![3]),
            // FlSpot(4, numList![4]),
            // FlSpot(5, numList![5]),
            // FlSpot(6, numList![6]),
            // FlSpot(7, numList![7]),
            // FlSpot(8, numList![8]),
            // FlSpot(9, numList![9]),
            // FlSpot(10, numList![10]),
          ],
          isCurved: true,
          gradient: LinearGradient(
            colors: gradientColors,
          ),
          barWidth: 5,
          isStrokeCapRound: true,
          dotData: FlDotData(
            show: false,
          ),
          belowBarData: BarAreaData(
            show: true,
            gradient: LinearGradient(
              colors: gradientColors
                  .map((color) => color.withOpacity(0.3))
                  .toList(),
            ),
          ),
        ),
      ],
    );
  }

  LineChartData avgData() {
    return LineChartData(
      lineTouchData: LineTouchData(enabled: false),
      gridData: FlGridData(
        show: true,
        drawHorizontalLine: true,
        verticalInterval: 1,
        horizontalInterval: 1,
        getDrawingVerticalLine: (value) {
          return FlLine(
            color: const Color(0xff37434d),
            strokeWidth: 1,
          );
        },
        getDrawingHorizontalLine: (value) {
          return FlLine(
            color: const Color(0xff37434d),
            strokeWidth: 1,
          );
        },
      ),
      titlesData: FlTitlesData(
        show: true,
        bottomTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            reservedSize: 30,
            getTitlesWidget: bottomTitleWidgets,
            interval: 1,
          ),
        ),
        leftTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            getTitlesWidget: leftTitleWidgets,
            reservedSize: 42,
            interval: 1,
          ),
        ),
        topTitles: AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        rightTitles: AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
      ),
      borderData: FlBorderData(
        show: true,
        border: Border.all(color: const Color(0xff37434d)),
      ),
      minX: 0,
      maxX: 11,
      minY: 0,
      maxY: 6,
      lineBarsData: [
        LineChartBarData(
          spots: const [
            FlSpot(0, 3.44),
            FlSpot(2.6, 3.44),
            FlSpot(4.9, 3.44),
            FlSpot(6.8, 3.44),
            FlSpot(8, 3.44),
            FlSpot(9.5, 3.44),
            FlSpot(11, 3.44),
          ],
          isCurved: true,
          gradient: LinearGradient(
            colors: [
              ColorTween(begin: gradientColors[0], end: gradientColors[1])
                  .lerp(0.2)!,
              ColorTween(begin: gradientColors[0], end: gradientColors[1])
                  .lerp(0.2)!,
            ],
          ),
          barWidth: 5,
          isStrokeCapRound: true,
          dotData: FlDotData(
            show: false,
          ),
          belowBarData: BarAreaData(
            show: true,
            gradient: LinearGradient(
              colors: [
                ColorTween(begin: gradientColors[0], end: gradientColors[1])
                    .lerp(0.2)!
                    .withOpacity(0.1),
                ColorTween(begin: gradientColors[0], end: gradientColors[1])
                    .lerp(0.2)!
                    .withOpacity(0.1),
              ],
            ),
          ),
        ),
      ],
    );
  }




}
   Widget _readAction(String id) {
    
   // String date=DateTime.now().toString().substring(0,10);

    // var data = await FirebaseFirestore.instance
    //   .collection('users')
    //   .where('id',isEqualTo: id)
    //   .get();

    //   var data1 = await FirebaseFirestore.instance
    //   .collection('users').doc(data.docs.first.id).collection('dementia_p')
    //   .get();

    //   return data1;

    return FutureBuilder(
            future: FirebaseFirestore.instance
                .collection('users')
      .where('id',isEqualTo: id)
      .get().then((value) => FirebaseFirestore.instance.collection('users').doc(value.docs.first.id).collection('dementia_p').get()),
                // .orderBy('date', descending: false)
              
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return const Center(child: CircularProgressIndicator());
              }
              final documents = snapshot.data!.docs;
              return ListView(
                children:
                    documents.map((e) => LineChartSample2(doc: e)).toList(),
              );
            });

  }// -addAction

  class Dementiaresult{
    // static Future<DementiaChart> result(String id) async{
      
    //     var data = await FirebaseFirestore.instance
    //   .collection('users')
    //   .where('id',isEqualTo: id)
    //   .get();

    //   var data2=FirebaseFirestore.instance
    //   .collection('users').doc(data.docs.first.id)
    //   .collection('dementia_p').get();
    //   return DementiaChart.fromJson(data2.);
    // }

  //   static StreamBuilder<QuerySnapshot> result(String id) async {     
  //       // FirebaseFirestore.instance
  //       // .collection('users')
  //       // .where('id',isEqualTo: id)
  //       // .get();
        



  //   var data = await FirebaseFirestore.instance
  //     .collection('users')
  //     .where('id',isEqualTo: id)
  //     .get();

  //     FirebaseFirestore.instance
  //     .collection('users').doc(data.docs.first.id)
  //     .collection('dementia_p').get();


  //   }
    
    
  //   }

  //    Widget _buildItemWidget(
  //   DocumentSnapshot doc) {

  //   DementiaAnswer answerList = DementiaAnswer();

  //   final dementia = Dementia(seq: doc['seq'], question: doc['question']);
  // print(dementia.seq);

  //   return SingleChildScrollView(
      
      
  //     child: Card(
  //       child: ListTile(
  //         title: Text('${dementia.seq}. ${dementia.question}'),
  //         subtitle: answerList.dementiaAnswerTest[dementia.seq - 1],
  //       ),

  //     )

  //   );
  // } //_buildItemWidget

  }