import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dr_oh_app/components/stroke_answer_list.dart';
import 'package:dr_oh_app/model/survey_stroke_model.dart';
import 'package:dr_oh_app/view/survey/stroke_result_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../components/stroke_privacy.dart';
import '../../components/stroke_user_info.dart';
import '../../model/survey_stroke_message.dart';
import '../../repository/localdata/stroke_predict.dart';

// Date: 2023-01-10, SangwonKim
// Desc: 뇌졸중 검사 페이지
class SurveyStrokePage extends StatelessWidget {
  final String surveyName;
  final PageController _pageController = PageController();
  final PageController _surveyController = PageController();

  SurveyStrokePage({
    Key? key,
    required this.surveyName,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(surveyName),
        elevation: 1,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: _pages(),
      ),
    );
  }

// --- Widgets ---

// ------------------------------------------------------------------------
// Date: 2023-01-10, SangwonKim
// Desc: 페이지 위젯
  Widget _pages() {
    return PageView.builder(
      physics: const NeverScrollableScrollPhysics(),
      controller: PageController(
        initialPage: 0,
      ),
      itemBuilder: (BuildContext context, int index) {
        return PageView(
          controller: _pageController,
          physics: const NeverScrollableScrollPhysics(),
          reverse: false,
          children: [
            // 1. 개인정보보호법 동의 입력받기 페이지
            StrokePrivacy(pageController: _pageController),
            // 2. 사용자 정보 입력받기 페이지
            StrokeUserInfo(
              pageController: _pageController,
            ),
            // 3. 설문 입력받기 페이지
            _surveyFromFirestore(context),
          ],
        );
      },
    );
  } // _pages

  // ------------------------------------------------------------------------
  // Date: 2023-01-10, SangwonKim
  // Desc: Firebase에서 설문질문 가져오기 위젯
  Widget _surveyFromFirestore(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          const Text(
            '문진표',
            style: TextStyle(
              fontSize: 30,
            ),
          ),
          const SizedBox(height: 16),
          // Firestore에서 질문목록가져와서 _buildItemWidget로 넘겨주기
          StreamBuilder<QuerySnapshot>(
            stream: FirebaseFirestore.instance
                .collection('Stroke')
                .orderBy('seq', descending: false)
                .snapshots(),
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
              final documents = snapshot.data!.docs;
              return SizedBox(
                width: 500,
                height: 600,
                child: ListView(
                  controller: _surveyController,
                  scrollDirection: Axis.vertical,
                  children: documents
                      .map((index) => _buildItemWidget(index))
                      .toList(),
                ),
              );
            },
          ),
          // 진단 버튼 누르기 -> Rserve로 보내서 머신러닝 실행
          ElevatedButton(
            onPressed: () async {
              if (SurveyStrokeMessage.hypertension == '' ||
                  SurveyStrokeMessage.heartDisease == '' ||
                  SurveyStrokeMessage.everMarried == '' ||
                  SurveyStrokeMessage.workType == '' ||
                  SurveyStrokeMessage.residenceType == '' ||
                  SurveyStrokeMessage.smoke == '') {
                Get.snackbar(
                  '안내',
                  '문진답변을 확인해주세요',
                  backgroundColor: Colors.redAccent,
                  snackPosition: SnackPosition.BOTTOM,
                  duration: const Duration(seconds: 1),
                );
              } else {
                StrokePredict predict = StrokePredict();
                String result = await predict.predict(
                  SurveyStrokeMessage.sex,
                  SurveyStrokeMessage.age,
                  SurveyStrokeMessage.height,
                  SurveyStrokeMessage.weight,
                  int.parse(SurveyStrokeMessage.hypertension),
                  int.parse(SurveyStrokeMessage.heartDisease),
                  int.parse(SurveyStrokeMessage.everMarried),
                  int.parse(SurveyStrokeMessage.workType),
                  int.parse(SurveyStrokeMessage.residenceType),
                  int.parse(SurveyStrokeMessage.smoke),
                );
                Get.off(StrokeResultPage(result: result)); // 설문페이지로 안돌아오게 설정
                // Date: 2023-01-11, SangwonKim
                // Desc: 사용자의 설문 입력값 초기값으로 설정해주기
                SurveyStrokeMessage.hypertension = '';
                SurveyStrokeMessage.heartDisease = '';
                SurveyStrokeMessage.everMarried = '';
                SurveyStrokeMessage.workType = '';
                SurveyStrokeMessage.residenceType = '';
                SurveyStrokeMessage.smoke = '';
              }
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                Text('진단'),
              ],
            ),
          ),
        ],
      ),
    );
  } // _questionFromFirestore

  // ------------------------------------------------------------------------
  // Date: 2023-01-10, SangwonKim
  // Desc: SurveyStrokeModel에서 질문목록 가져오기 위젯
  Widget _buildItemWidget(DocumentSnapshot doc) {
    final surveyStrokeModel =
        SurveyStrokeModel(seq: doc['seq'], question: doc['question']);
    // 답변목록 가져오기
    StrokeAnswerList answer = StrokeAnswerList();
    return Container(
      color: Colors.transparent.withOpacity(0.3),
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: ListTile(
            title: Column(
              children: [
                const SizedBox(height: 8),
                Text(
                  '${surveyStrokeModel.seq}. ${surveyStrokeModel.question}',
                  style: TextStyle(
                    color: Colors.blueGrey.shade800,
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 8),
                answer.strokeAnswerList[surveyStrokeModel.seq - 1]
              ],
            ),
          ),
        ),
      ),
    );
  } // _buildItemWidget

} // End
