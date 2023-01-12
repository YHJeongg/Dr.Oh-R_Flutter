import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dr_oh_app/components/diabetes_privacy.dart';
import 'package:dr_oh_app/components/diabetes_user_info.dart';
import 'package:dr_oh_app/components/diabets_answer_list.dart';
import 'package:dr_oh_app/components/logout_btn.dart';
import 'package:dr_oh_app/model/diabetes_message.dart';
import 'package:dr_oh_app/model/firebase_dementia.dart';
import 'package:dr_oh_app/repository/localdata/diabetes_predict.dart';
import 'package:dr_oh_app/view/survey/diabetes_result_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

//Date: 2023-01-09 anna
class DiabetesSurveyPage extends StatelessWidget {
  final String surveyName;
  final PageController _nextController = PageController();
  final PageController surveyCont = PageController();

  DiabetesSurveyPage({
    Key? key,
    required this.surveyName,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(surveyName),
        elevation: 1,
        actions: const [LogoutBtn()],
      ),
      // Date: 2023-01-11, SangwonKim
      // Desc: Padding 추가함
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: _pages(),
      ),
    );
  }

//-------------page Widget----------
  Widget _pages() {
    return PageView.builder(
      physics: const NeverScrollableScrollPhysics(),
      controller: PageController(
        initialPage: 0, //시작 페이지
      ),
      itemBuilder: (BuildContext context, int index) {
        return PageView(
          controller: _nextController,
          physics: const NeverScrollableScrollPhysics(),
          reverse: false,
          children: [
            //-----1st page(개인정보보호법)-------
            DiaPrivacy(pageCont: _nextController),
            DUserInfo(pageCont: _nextController),
            //설문 시작
            firestore(context),
          ],
        );
      },
    );
  } //_pages

//----------widget--------------

  //firestore
  Widget firestore(BuildContext context) {
    return SingleChildScrollView(
      child: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: Column(
          children: [
            const Padding(
              padding: EdgeInsets.all(20),
              child: Text(
                '문진표',
                style: TextStyle(
                  fontSize: 40,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            StreamBuilder<QuerySnapshot>(
              //firestore에서 데이터 가져오기
              stream: FirebaseFirestore.instance

                  //parameter로 설문지 DB table 이름만 변경하면 됩니다.
                  .collection('Diabetes')
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
                  height: 500,
                  child: ListView(
                      controller: surveyCont,
                      scrollDirection: Axis.vertical,
                      children: documents
                          .map((index) => _buildItemWidget(index))
                          .toList()),
                );
              },
            ),
            ElevatedButton(
              onPressed: !DiabetesMessage.isComplete
                  ? null
                  : () async {
                      DiabetesPredict predict = DiabetesPredict();
                      String result = await predict.predict(
                          DiabetesMessage.age,
                          DiabetesMessage.height,
                          DiabetesMessage.weight,
                          DiabetesMessage.physact,
                          DiabetesMessage.diffwalk,
                          DiabetesMessage.genhealth,
                          DiabetesMessage.hdattack,
                          DiabetesMessage.highbp,
                          DiabetesMessage.stroke,
                          int.parse(DiabetesMessage.physhealth.text));
                      Get.off(DiabetesResultPage(result: result));
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
  Widget _buildItemWidget(DocumentSnapshot doc) {
    final dementia = Dementia(seq: doc['seq'], question: doc['question']);
    DAnswer answer = DAnswer();

    return SizedBox(
      height: 100,
      width: 100,
      child: Column(
        children: [
          Text('${dementia.seq}. ${dementia.question}'),
          answer.dAnserList[dementia.seq - 1],
        ],
      ),
    );
  }
}
