import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dr_oh_app/components/logout_btn.dart';
import 'package:dr_oh_app/components/stroke_answer_list.dart';
import 'package:dr_oh_app/model/stroke_model.dart';
import 'package:dr_oh_app/view/survey/stroke_result_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../components/stroke_privacy.dart';
import '../../components/stroke_user_info.dart';
import '../../model/stroke_message.dart';
import '../../repository/localdata/stroke_predict.dart';

// Date: 2023-01-10, SangwonKim
// Desc: 뇌졸중 검사 페이지
class StrokeSurveyPage extends StatelessWidget {
  final String surveyName;
  final PageController _pageController = PageController();
  final PageController _surveyController = PageController();

  StrokeSurveyPage({
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
          // Date: 2023-01-11, SangwonKim
          // Desc: 진단 버튼 누르기 -> Rserve로 보내서 머신러닝 실행
          ElevatedButton(
            onPressed: () async {
              if (StrokeMessage.hypertension == '' ||
                  StrokeMessage.heartDisease == '' ||
                  StrokeMessage.everMarried == '' ||
                  StrokeMessage.workType == '' ||
                  StrokeMessage.residenceType == '' ||
                  StrokeMessage.smoke == '') {
                Get.snackbar(
                  '안내',
                  '문진답변을 확인해주세요',
                  backgroundColor: Colors.redAccent,
                  snackPosition: SnackPosition.TOP,
                  duration: const Duration(seconds: 1),
                );
              } else {
                StrokePredict predict = StrokePredict();
                String result = await predict.predict(
                  StrokeMessage.sex,
                  StrokeMessage.age,
                  StrokeMessage.height,
                  StrokeMessage.weight,
                  int.parse(StrokeMessage.hypertension),
                  int.parse(StrokeMessage.heartDisease),
                  int.parse(StrokeMessage.everMarried),
                  int.parse(StrokeMessage.workType),
                  int.parse(StrokeMessage.residenceType),
                  int.parse(StrokeMessage.smoke),
                );
                // 설문페이지로 안돌아오게 설정
                Get.off(StrokeResultPage(result: result));
                // Date: 2023-01-11, SangwonKim
                // Desc: 사용자의 설문 입력값 초기값으로 설정해주기
                StrokeMessage.hypertension = '';
                StrokeMessage.heartDisease = '';
                StrokeMessage.everMarried = '';
                StrokeMessage.workType = '';
                StrokeMessage.residenceType = '';
                StrokeMessage.smoke = '';
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
  // Desc: StrokeModel에서 질문목록 가져오기 위젯
  Widget _buildItemWidget(DocumentSnapshot doc) {
    final strokeModel = StrokeModel(seq: doc['seq'], question: doc['question']);
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
                  '${strokeModel.seq}. ${strokeModel.question}',
                  style: TextStyle(
                    color: Colors.blueGrey.shade800,
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 8),
                answer.strokeAnswerList[strokeModel.seq - 1]
              ],
            ),
          ),
        ),
      ),
    );
  } // _buildItemWidget

} // End
