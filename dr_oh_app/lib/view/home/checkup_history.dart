import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dr_oh_app/components/logout_btn.dart';
import 'package:dr_oh_app/viewmodel/checkup_history_view_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CheckupHistory extends StatelessWidget {
  CheckupHistory({super.key});

  CheckupHistoryViewModel checkupHistoryViewModel = CheckupHistoryViewModel();

  @override
  Widget build(BuildContext context) {
    // Desc: 조회한 날짜 표시
    var selectedDate = Get.arguments;

    return ListBody(
      selectedDate: selectedDate,
    );
  }
}

class ListBody extends StatefulWidget {
  final selectedDate;
  const ListBody({super.key, required this.selectedDate});

  @override
  State<ListBody> createState() => _ListBodyState();
}

class _ListBodyState extends State<ListBody> {
  late String id = '';
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _initSharedPreferences();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('검진기록 조회'),
        elevation: 1,
        actions: const [LogoutBtn()],
      ),
      body: StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance
              .collection('result')
              .where('userid', isEqualTo: id)
              .where('date',
                  isEqualTo: widget.selectedDate.toString().substring(0, 10))
              .snapshots(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return const Center(child: CircularProgressIndicator());
            }
            final documents = snapshot.data!.docs;
            return ListView(
              children: documents.map((e) => _buildItemWidget(e)).toList(),
            );
          }),
    );
  }

  _initSharedPreferences() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      id = prefs.getString('id').toString();
    });
  }

  Widget _buildItemWidget(DocumentSnapshot doc) {
    return Dismissible(
      direction: DismissDirection.endToStart,
      background: Container(
        color: Colors.red,
        alignment: Alignment.centerRight,
        child: const Icon(Icons.delete_forever),
      ),
      key: ValueKey(doc),
      onDismissed: (direction) {
        FirebaseFirestore.instance.collection('result').doc(doc.id).delete();
      },
      child: Card(
        child: ListTile(
          title: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(4.0),
                child: Text(
                  '날짜 : ${doc['date']}',
                  style: const TextStyle(
                    fontSize: 25,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(4.0),
                child: Text(
                  '검사항목 : ${doc['category']}',
                  style: const TextStyle(
                    fontSize: 25,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(4.0),
                child: Text(
                  '검사결과 : ${(double.parse(doc['result'].toString())).round()}',
                  style: const TextStyle(
                    fontSize: 25,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
