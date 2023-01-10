import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dr_oh_app/components/dementia_answer_list.dart';
import 'package:dr_oh_app/model/dementia_message.dart';
import 'package:dr_oh_app/model/firebase_dementia.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DementiaSurveySecond extends StatefulWidget {
  const DementiaSurveySecond({super.key});

  @override
  State<DementiaSurveySecond> createState() => _DementiaSurveySecondState();
}

class _DementiaSurveySecondState extends State<DementiaSurveySecond> {
  late PageController _pageController;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: 0);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('치매 검사'),
        elevation: 0,
      ),
      body: firestore(),
    );

  } //build

  //---------------Widget---------------

  //firestore
  Widget firestore() {
    return StreamBuilder<QuerySnapshot>(
      //firestore에서 데이터 가져오기
      stream: FirebaseFirestore.instance
          .collection('Dementia_small')
          .orderBy('seq', descending: false)
          .snapshots(),
      //화면 구성
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return const Center(child: CircularProgressIndicator());
        }
        final documents = snapshot.data!.docs;

        return SingleChildScrollView(
          // width: 500,
          // height: 600,
          child: ListView(
              shrinkWrap: true,
              scrollDirection: Axis.vertical,
              children:
                  documents.map((e) => _buildItemWidget(e)).toList()),
        );
      },

    );
  }


//read questions from firestore
  Widget _buildItemWidget(
    DocumentSnapshot doc) {
    DementiaAnswer answerList = DementiaAnswer();

    final dementia = Dementia(seq: doc['seq'], question: doc['question']);
print(dementia.seq);

    return SingleChildScrollView(
      // height: 100,
      // width: 100,
      
      child: Column(
        children: [
          SizedBox(
            height: 30,
          ),
          Text('${dementia.seq}. ${dementia.question}'),
          SizedBox(
            height: 30,
          ),
          answerList.dementiaAnswerTest[dementia.seq - 1]
        ],
      ),
    );
  } //_buildItemWidget


}//end