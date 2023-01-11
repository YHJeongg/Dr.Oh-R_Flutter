import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dr_oh_app/components/dementia_answer_final.dart';
import 'package:dr_oh_app/components/dementia_answer_list.dart';
import 'package:dr_oh_app/model/firebase_dementia.dart';
import 'package:dr_oh_app/repository/localdata/dementia_predict.dart';
import 'package:dr_oh_app/view/survey/dementia_result.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DementiaSurveySecond extends StatefulWidget {
  const DementiaSurveySecond({super.key});

  @override
  State<DementiaSurveySecond> createState() => _DementiaSurveySecondState();
}

class _DementiaSurveySecondState extends State<DementiaSurveySecond> {
  

  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('치매 검사'),
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            firestore(context),
          
          ],
        )),
    );

  } //build

  //---------------Widget---------------

  Widget firestore(BuildContext context) {
    return SingleChildScrollView(
      child: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: Column(
          children: [
            StreamBuilder<QuerySnapshot>(
              //firestore에서 데이터 가져오기
              stream: FirebaseFirestore.instance
                  //parameter로 설문지 DB table 이름만 변경하면 됩니다.
                  .collection('Dementia_small')
                  .orderBy('seq', descending: false)
                  .snapshots(),
              //화면 구성
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return const Center(child: CircularProgressIndicator());
                }
                final documents = snapshot.data!.docs;
          
                return SizedBox(
                  width: 500,
                  height: 600,
                  child: ListView(
                      
                      scrollDirection: Axis.vertical,
                      children: documents
                          .map((index) => _buildItemWidget(index))
                          .toList()),
                );
              },
            ),
            ElevatedButton(
              onPressed: () async {
                
                DementiaPredict predict = DementiaPredict();
                String result = await predict.predict(
                  DementiaAnswerFinal.age,
                  DementiaAnswerFinal.total,
                  DementiaAnswerFinal.edu1,
                  DementiaAnswerFinal.wage1,
                  DementiaAnswerFinal.gender1,
                   );

                Get.off(DementiaResult(result:result));
              },
              child: const Text(
                '진단',
              ),
            ),
          ],
        ),
      ),
    );
  } //firestore read data


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
          const SizedBox(
            height: 30,
          ),
          Text('${dementia.seq}. ${dementia.question}'),
          const SizedBox(
            height: 30,
          ),
          answerList.dementiaAnswerTest[dementia.seq - 1],
          const SizedBox(
            height: 20,
          ),
          
        ],
      ),
      
    );
  } //_buildItemWidget


}//end