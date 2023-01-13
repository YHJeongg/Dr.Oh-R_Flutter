import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dr_oh_app/model/hospital_visit_model.dart';
import 'package:dr_oh_app/viewmodel/my_history_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HospitalListview extends StatefulWidget {
  const HospitalListview({super.key});

  @override
  State<HospitalListview> createState() => _HospitalListviewState();
}

class _HospitalListviewState extends State<HospitalListview> {
  late String id = '';
  MyHistoryViewModel _myHistoryViewModel = MyHistoryViewModel();

  _initSharedPreferences() async {
    final prefs = await SharedPreferences.getInstance();

    setState(() {
      id = prefs.getString('id').toString();
    });
    _myHistoryViewModel.getHospital(id);
  }

  Widget _buildItemWidget(DocumentSnapshot doc) {
    final HospitalVisitModel hospital = HospitalVisitModel(
      date: doc['date'],
      hospital: doc['hospital'],
      purpose: doc['purpose'],
    );
    return ListTile(
      title: hospital.date.toString().isNotEmpty
          ? Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    '${hospital.date}',
                    style: const TextStyle(
                      fontSize: 10,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    '${hospital.hospital}',
                    style: const TextStyle(
                      fontSize: 10,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    '${hospital.purpose}',
                    style: const TextStyle(
                      fontSize: 10,
                    ),
                  ),
                ),
              ],
            )
          : Column(
              children: const [
                Text(
                  '입력된 신체정보가 없습니다.',
                  style: TextStyle(
                    fontSize: 10,
                  ),
                ),
              ],
            ),
    );
  }

  @override
  void initState() {
    super.initState();
    _initSharedPreferences();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('users')
            .where('id', isEqualTo: id)
            .snapshots(),
        builder: ((context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          final documents = snapshot.data!.docs;
          var docId = documents.first.id;

          print(FirebaseFirestore.instance
              .collection('users')
              .where('id', isEqualTo: id)
              .get());

          return ListView(
            children: documents.map((e) => _buildItemWidget(e)).toList(),
          );
        }),
      ),
    );
  }
}
