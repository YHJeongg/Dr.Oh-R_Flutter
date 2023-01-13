import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dr_oh_app/components/line_chart_widget.dart';
import 'package:dr_oh_app/components/logout_btn.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

// -----------------------------------------------------------------
// Date: 2023-01-13, SangwonKim
// Desc: 치매 차트 기록 페이지
class DementiaChartRecord extends StatefulWidget {
  const DementiaChartRecord({super.key});

  @override
  State<DementiaChartRecord> createState() => _DementiaChartRecordState();
}

class _DementiaChartRecordState extends State<DementiaChartRecord> {
  late String id;
  late var data;

  @override
  void initState() {
    super.initState();
    id = '';
    _initSharedPreferences();
    // data = _initFirestore();
    // // _initFirestore();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('치매 차트 기록'),
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
                  .where('category', isEqualTo: "치매")
                  .where('userid', isEqualTo: id)
                  // .orderBy('date', descending: true) // 최신 10개 를 위해서 dsc으로 가져오기
                  .limit(10) // 10개만 가져오기
                  .snapshots(includeMetadataChanges: true),

                  // // >>>2st Try<<<
                  // .collection('users')
                  // .doc(data)
                  // .collection('dementia_p')
                  // // .orderBy('date', descending: false)
                  // // .limit(10)
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

  // _initFirestore() async{
  //   data = await FirebaseFirestore.instance
  //       .collection('users')
  //       .where('id', isEqualTo: id)
  //       .get();
  // }

} // End
