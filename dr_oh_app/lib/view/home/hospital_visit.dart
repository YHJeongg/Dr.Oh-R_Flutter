import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dr_oh_app/components/logout_btn.dart';
import 'package:dr_oh_app/model/hospital_visit_model.dart';
import 'package:dr_oh_app/viewmodel/my_history_view_model.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HospitalVisit extends StatefulWidget {
  const HospitalVisit({super.key});

  @override
  State<HospitalVisit> createState() => _HospitalVisitState();
}

class _HospitalVisitState extends State<HospitalVisit> {
  TextEditingController _hospitalController = TextEditingController();
  TextEditingController _dateController = TextEditingController();
  int value = 0;
  List<String> purposeGroup = ['진료', '처방', '검진'];
  String selectedPurpose = '진료';
  late String id = '';
  late String docId = '';

  _getDocId(String id) async {
    var data = await FirebaseFirestore.instance
        .collection('users')
        .where('id', isEqualTo: id)
        .get();
    docId = data.docs.first.id;
  }

  _initSharedPreferences() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      id = prefs.getString('id').toString();
    });
    _getDocId(id);
  }

  @override
  void initState() {
    super.initState();
    _initSharedPreferences();
  }

  // Desc: 내원 목적 라디오버튼
  // Date: 2023-01-10
  Widget _customRadioButton(String text, int index) {
    return OutlinedButton(
      onPressed: () {
        setState(() {
          value = index;
          selectedPurpose = purposeGroup[index];
        });
      },
      child: Text(
        text,
        style: TextStyle(
          color: (value == index) ? Colors.green : Colors.black,
        ),
      ),
    );
  }

  Widget _getHospitalVisit(DocumentSnapshot doc) {
    final hospital = doc.data().toString().contains('purpose')
        ? HospitalVisitModel(
            date: doc['date'],
            hospital: doc['hospital'],
            purpose: doc['purpose'],
          )
        : HospitalVisitModel(date: '', hospital: '', purpose: '');
    return ListTile(
      title: hospital.purpose.toString().isNotEmpty
          ? Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Column(
                  children: [
                    Container(
                      width: 350,
                      decoration: BoxDecoration(
                        border: Border.all(
                          style: BorderStyle.solid,
                          width: 1,
                        ),
                        borderRadius: BorderRadius.circular(5),
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.5),
                            spreadRadius: 1,
                            blurRadius: 1,
                          ),
                        ],
                      ),
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        '${hospital.date}\t병원명: ${hospital.hospital}\t내원목적:${hospital.purpose}',
                        style: const TextStyle(
                          fontSize: 12,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ],
                ),
              ],
            )
          : Column(
              children: const [
                Text(
                  '내원이력이 없습니다.',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('내원이력'),
        elevation: 1,
        actions: const [LogoutBtn()],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance
                  .collection('users')
                  .doc(docId)
                  .collection('HospitalVisit')
                  .snapshots(),
              builder: ((context, snapshot) {
                if (!snapshot.hasData) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
                final documents = snapshot.data!.docs;

                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ListView(
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      children:
                          documents.map((e) => _getHospitalVisit(e)).toList(),
                    ),
                  ],
                );
              }),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20, right: 20),
              child: TextField(
                controller: _dateController,
                readOnly: true,
                onTap: () {
                  _showDatePickerPop();
                },
                decoration: const InputDecoration(
                  hintText: '날짜',
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20, right: 20),
              child: TextField(
                controller: _hospitalController,
                decoration: const InputDecoration(
                  hintText: '병원명',
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                const Text('내원 목적'),
                _customRadioButton(purposeGroup[0].toString(), 0),
                _customRadioButton(purposeGroup[1].toString(), 1),
                _customRadioButton(purposeGroup[2].toString(), 2)
              ],
            ),
            ElevatedButton(
                onPressed: () {
                  HospitalVisitModel hospitalVisitModel = HospitalVisitModel(
                    hospital: _hospitalController.text,
                    date: _dateController.text,
                    purpose: selectedPurpose.toString(),
                  );
                  MyHistoryViewModel.to.addHospital(hospitalVisitModel, id);
                  Navigator.pop(context);
                },
                child: const Text('추가'))
          ],
        ),
      ),
    );
  }

  void _showDatePickerPop() {
    Future<DateTime?> selectedDate = showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime.now(),
      builder: (BuildContext context, Widget? child) {
        return Theme(
          data: ThemeData.dark(),
          child: child!,
        );
      },
    );
    selectedDate.then((value) {
      _dateController.text = value.toString().substring(0, 10);
    });
  }
}
