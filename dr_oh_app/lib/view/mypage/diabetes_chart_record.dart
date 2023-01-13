import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dr_oh_app/components/line_chart_widget.dart';
import 'package:dr_oh_app/components/logout_btn.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DiabetesChartRecord extends StatefulWidget {
  const DiabetesChartRecord({super.key});

  @override
  State<DiabetesChartRecord> createState() => _DiabetesChartRecordState();
}

class _DiabetesChartRecordState extends State<DiabetesChartRecord> {
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
        title: const Text('당뇨병 차트 기록'),
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
                  .where('category', isEqualTo: "당뇨병")
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
