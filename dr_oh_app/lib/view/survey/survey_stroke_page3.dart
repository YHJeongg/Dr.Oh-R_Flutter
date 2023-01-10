import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dr_oh_app/model/survey_stroke_model.dart';
import 'package:dr_oh_app/viewmodel/stroke_survey_list_view_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

import '../../components/stroke_answer_list.dart';
import '../../model/survey_stroke_message.dart';

// Date: 2023-01-09, SangwonKim
// Desc: 임시<<
class SurveyStrokePage3 extends StatefulWidget {
  const SurveyStrokePage3({super.key});

  @override
  State<SurveyStrokePage3> createState() => _SurveyStrokePage3State();
}

class _SurveyStrokePage3State extends State<SurveyStrokePage3> {
  late PageController _pageController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _pageController = PageController(initialPage: 0);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('뇌졸중 검사'),
        elevation: 1,
      ),
      body: Center(
        child: PageView.builder(
          controller: _pageController,
          itemBuilder: (context, index) {
            return Center(
              child: StreamBuilder<QuerySnapshot>(
                  stream: FirebaseFirestore.instance
                      .collection('Stroke')
                      .orderBy('seq', descending: false)
                      .snapshots(),
                  builder: (context, snapshot) {
                    if (!snapshot.hasData) {
                      return const Center(child: CircularProgressIndicator());
                    }
                    final documents = snapshot.data!.docs;
                    return ListView(
                      children:
                          documents.map((e) => _buildItemWidget(e)).toList(),
                    );
                  }),
            );
          },
        ),
      ),
    );
  }

  // --- Functions ---
  Widget _buildItemWidget(DocumentSnapshot doc) {
    final strokeSurveyModel =
        SurveyStrokeModel(seq: doc['seq'], question: doc['question']);
    return Container(
      color: Colors.amberAccent,
      child: GestureDetector(
        onTap: () {
          SurveyStrokeMessage.seq = doc['seq'];
          SurveyStrokeMessage.question =
              doc['question']; // *** Key 값 아닌건 적어줘야한다.
          // Navigator.push(
          //     context,
          //     MaterialPageRoute(
          //       builder: (context) => const Update(),
          //     ));
        },
        child: Card(
          child: ListTile(
            title: Column(
              children: [
                Text(
                  '${strokeSurveyModel.seq}번 : ${strokeSurveyModel.question}',
                ),
                // _answerList(),
                StrokeAnswerList().strokeAnswerList[strokeSurveyModel.seq-1]
              ],
            ),
          ),
        ),
      ),
    );
  }

  // Widget _answerList() {
  //   return ListView.builder(
  //     itemCount: 5,
  //     itemBuilder: (context, index) {
        
  //     },
  //   );
  // }
} // End
