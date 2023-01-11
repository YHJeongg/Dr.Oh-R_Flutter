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
  final bool _isChecked = false;
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
            // 개인정보보호법 동의 입력받기 페이지
            StrokePrivacy(pageController: _pageController),
            // 사용자 정보 입력받기 페이지
            StrokeUserInfo(
              pageController: _pageController,
            ),
            // 설문 입력받기 페이지
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
      child: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: Column(
          children: [
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
                StrokePredict predict = StrokePredict();
                String result = await predict.predict(
                  SurveyStrokeMessage.sex,
                  SurveyStrokeMessage.age,
                  SurveyStrokeMessage.height,
                  SurveyStrokeMessage.weight,
                  int.parse(SurveyStrokeMessage.highBp),
                  int.parse(SurveyStrokeMessage.heartDisease),
                  int.parse(SurveyStrokeMessage.everMarried),
                  int.parse(SurveyStrokeMessage.workType),
                  int.parse(SurveyStrokeMessage.residenceType),
                  int.parse(SurveyStrokeMessage.smoke),
                );
                Get.off(StrokeResultPage(result: result)); // 설문페이지로 안돌아오게 설정
                // Date: 2023-01-11, SangwonKim
                // Desc: 사용자의 설문 입력값 초기값으로 설정해주기
                SurveyStrokeMessage.highBp = '';
                SurveyStrokeMessage.heartDisease = '';
                SurveyStrokeMessage.everMarried = '';
                SurveyStrokeMessage.workType = '';
                SurveyStrokeMessage.residenceType = '';
                SurveyStrokeMessage.smoke = '';
              },
              child: const Text('진단'),
            ),
          ],
        ),
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
    // // -----
    // return Column(
    //   children: [
    //     Text('${surveyStrokeModel.seq}. ${surveyStrokeModel.question}'),
    //     answer.strokeAnswerList[surveyStrokeModel.seq - 1],
    //     const SizedBox(height: 20,)
    //   ],
    // );
  } // _buildItemWidget

// ----------------------------------------------------------------------
// //개인정보보호법 페이지
//   Widget _privacyAct() {
//     return Column(
//       children: [
//         Container(
//           alignment: Alignment.center,
//           margin: EdgeInsets.fromLTRB(20, 20, 20, 20),
//           height: 200,
//           // decoration: BoxDecoration(
//           //     color: Colors.white,
//           //     borderRadius: BorderRadius.circular(30),
//           //     boxShadow: [
//           //       BoxShadow(
//           //         color: Colors.grey.withOpacity(0.5),
//           //         spreadRadius: 5,
//           //         blurRadius: 7,
//           //         //offset: Offset(0, 2)
//           //       ),
//           //     ]),
//           child: Row(
//             children: [
//               SizedBox(
//                 width: 300,
//                 child: ExpansionTile(
//                   title: Center(
//                     child: Row(
//                       children: [
//                         Checkbox(
//                           value: _isChecked,
//                           onChanged: (value) {
//                             //
//                           },
//                         ),
//                         const Text('개인정보 수집/이용 동의'),
//                       ],
//                     ),
//                   ),
//                   // subtitle: Text('Leading expansion arrow icon'),
//                   controlAffinity: ListTileControlAffinity.leading,

//                   children: <Widget>[
//                     SizedBox(
//                       height: 140,
//                       width: 350,
//                       child: ListView(shrinkWrap: true, children: [
//                         ListTile(
//                           title: Center(
//                             child: Column(
//                               crossAxisAlignment: CrossAxisAlignment.start,
//                               children: const [
//                                 Text('-수집하는 개인정보 항목'),
//                                 Text(
//                                     '필수항목: 교육연수, 성별, 생년월일, 위치정보, 장소이름, 층수, 각 검사에 대한 답변'),
//                                 Text('선택항목: 성명, 이메일, 연락처'),
//                                 Text('-개인정보의 보유 및 이용기간'),
//                                 Text('이용목적 달성 시 폐기'),
//                                 Text('-동의 거부권리 안내'),
//                                 Text(
//                                     '신청인은 본 개인정보 수집에 대한 동의를 거부하실 수 있으며, 본 개인정보에 대해 거부할 경우 자가검사 등의 서비스 제공이 제한됩니다.'),
//                                 Text(
//                                     '신청인은 본 개인정보 수집에 대한 동의를 거부하실 수 있으며, 본 개인정보에 대해 거부할 경우 자가검사 등의 서비스 제공이 제한됩니다.'),
//                                 Text(
//                                     '신청인은 본 개인정보 수집에 대한 동의를 거부하실 수 있으며, 본 개인정보에 대해 거부할 경우 자가검사 등의 서비스 제공이 제한됩니다.'),
//                               ],
//                             ),
//                           ),
//                         ),
//                       ]),
//                     ),
//                   ],
//                 ),
//               ),
//             ],
//           ),
//         ),
//         Container(
//           alignment: Alignment.center,
//           margin: EdgeInsets.fromLTRB(20, 20, 20, 20),
//           height: 200,
//           // decoration: BoxDecoration(
//           //     color: Colors.white,
//           //     borderRadius: BorderRadius.circular(30),
//           //     boxShadow: [
//           //       BoxShadow(
//           //         color: Colors.grey.withOpacity(0.5),
//           //         spreadRadius: 5,
//           //         blurRadius: 7,
//           //         //offset: Offset(0, 2)
//           //       ),
//           //     ]),
//           child: Row(
//             children: [
//               SizedBox(
//                 width: 300,
//                 child: ExpansionTile(
//                   title: Center(
//                     child: Row(
//                       children: [
//                         Checkbox(
//                           value: _isChecked,
//                           onChanged: (value) {
//                             //
//                           },
//                         ),
//                         const Text('개인정보 수집/이용 동의'),
//                       ],
//                     ),
//                   ),
//                   // subtitle: Text('Leading expansion arrow icon'),
//                   controlAffinity: ListTileControlAffinity.leading,

//                   children: <Widget>[
//                     SizedBox(
//                       height: 140,
//                       width: 350,
//                       child: ListView(shrinkWrap: true, children: [
//                         ListTile(
//                           title: Center(
//                             child: Column(
//                               crossAxisAlignment: CrossAxisAlignment.start,
//                               children: const [
//                                 Text('-개인정보의 제공'),
//                                 Text('개인정보의 제공'),
//                                 Text('-제공받는 자'),
//                                 Text('닥터 오'),
//                                 Text('-제공받는 자의 이용목적'),
//                                 Text('인공지능 자가검사 시행 및 치매정보 제공'),
//                                 Text(
//                                     '필수항목: 교육연수, 성별, 생년월일, 위치정보, 장소이름, 층수, 각 검사에 대한 답변'),
//                                 Text('선택항목: 성명, 이메일, 연락처'),
//                                 Text('-제공받는 자의 개인정보 보유 및 이용 기간'),
//                                 Text('이용목적 달성 시 폐기'),
//                                 Text('-동의 거부권리 안내'),
//                                 Text(
//                                     '신청인은 본 개인정보 수집에 대한 동의를 거부하실 수 있으며, 본 개인정보에 대해 거부할 경우 자가검사 등의 서비스 제공이 제한됩니다.'),
//                               ],
//                             ),
//                           ),
//                         ),
//                       ]),
//                     ),
//                   ],
//                 ),
//               ),
//             ],
//           ),
//         ),
//         Column(
//           children: [_btnNext(1)],
//         ),
//       ],
//     );
//   } //privateAct

//   Widget _btnNext(int pageNum) {
//     return ElevatedButton(
//         onPressed: () {
//           //if로 한번 더 감싸기(개인정보보호법 둘 다 클릭 완료 시 넘어감)
//           if (_pageController.hasClients) {
//             _pageController.animateToPage(
//               pageNum,
//               duration: Duration(milliseconds: 400),
//               curve: Curves.easeInOut,
//             );
//           }
//         },
//         child: Text('다음'));
//   } //btnNext

// }
// -------------------------------------------------------------------------

}
