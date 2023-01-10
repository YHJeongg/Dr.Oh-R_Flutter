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
  }

  //build
  Widget firestore() {
    return Center(
      child: PageView.builder(
        controller: _pageController,
        itemBuilder: (context, index) {
          return StreamBuilder<QuerySnapshot>(
            stream: FirebaseFirestore.instance
                .collection('Dementia')
                .orderBy('seq', descending: false)
                .snapshots(),
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return const Center(child: CircularProgressIndicator());
              }
              final documents = snapshot.data!.docs;
              return ListView(
                children: documents.map((e) => _buildItemWidget(e)).toList(),
              );
            },
          );
        },
      ),
    );
  }

  //firestore read data
  Widget _buildItemWidget(DocumentSnapshot doc) {
    final dementia = Dementia(seq: doc['seq'], question: doc['question']);

    return Container(
      color: Colors.amberAccent,
      child: GestureDetector(
        onTap: () {
          // DementiaMessage.seq = doc['seq'];
          // DementiaMessage.question = doc['question']; // *** Key 값 아닌건 적어줘야한다.
        },
        child: Card(
          child: ListTile(
            title: Column(
              children: [
                Text(
                  '${dementia.seq}번 : ${dementia.question}',
                ),
                DementiaAnswer().dementiaAnswer[1]
              ],
            ),
          ),
        ),
      ),
    );
  }

  // ListView.builder(
  //   scrollDirection: Axis.vertical,
  //   shrinkWrap: true,
  //   physics: const AlwaysScrollableScrollPhysics(),
  //   itemCount: docF.length,
  //   itemBuilder: (context, index) {
  //     return Column(
  //       mainAxisSize: MainAxisSize.min,
  //       children: [
  //         Flexible(
  //           child: ListTile(
  //               title: Text('${dementia.seq}번 ${dementia.question}'),
  //               subtitle: answerList.dementiaAnswer[dementia.seq - 1]),
  //         ),
  //       ],
  //     );
  //   },
  // );
  // }
}//end