import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dr_oh_app/components/dementia_answer_list.dart';
import 'package:dr_oh_app/model/firebase_dementia.dart';
import 'package:flutter/material.dart';

class DementiaSurveySecond extends StatelessWidget {
  const DementiaSurveySecond({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('치매 검사'),
        elevation: 0,
      ),
      body: firestore(),
    );
  }//build

  //---------------Widget---------------


  //firestore
  Widget firestore() {
    return StreamBuilder<QuerySnapshot>(
      //firestore에서 데이터 가져오기
      stream: FirebaseFirestore.instance
          .collection('Dementia')
          .orderBy('seq', descending: false)
          .snapshots(),
      //화면 구성
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return const Center(child: CircularProgressIndicator());
        }
        final documents = snapshot.data!.docs;

        return ListView(
            shrinkWrap: true,
            scrollDirection: Axis.vertical,
            children:
                documents.map((e) => _buildItemWidget(e, documents)).toList());
      },
    );
  } //firestore read data

//read questions from firestore
  Widget _buildItemWidget(
    DocumentSnapshot doc, List<QueryDocumentSnapshot<Object?>> docF) {
    
    DementiaAnswer answerList = DementiaAnswer();
    
    final dementia = Dementia(seq: doc['seq'], question: doc['question']);
    

    return ListView.builder(
      scrollDirection: Axis.vertical,
      shrinkWrap: true, 
      physics: const AlwaysScrollableScrollPhysics(),
      itemCount: docF.length,
      itemBuilder: (context, index) {
    return Column(
        mainAxisSize: MainAxisSize.min,
      children: [
        Flexible(
          
          child: ListTile(
            title: Text('${dementia.seq}번 ${dementia.question}'),
            subtitle: answerList.dementiaAnswer[dementia.seq-1]
          ),
        ),
      ],
    );
      },);
  } //_buildItemWidget




}//end