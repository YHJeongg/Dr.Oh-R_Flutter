import 'package:dr_oh_app/components/dementia_answer_list.dart';
import 'package:flutter/material.dart';

class DementiaSurveyTest extends StatefulWidget {
  
 DementiaSurveyTest({super.key});


  @override
  State<DementiaSurveyTest> createState() => _DementiaSurveyTestState();
}

class _DementiaSurveyTestState extends State<DementiaSurveyTest> {

 PageController _nextController = PageController();
 DementiaAnswer answerList = DementiaAnswer();

@override
  void initState() {
    // TODO: implement initState
    super.initState();
    _nextController = PageController();

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('test'),
        elevation: 0,
      ),

      body: Center(
        child: PageView.builder(
          controller: PageController(
        initialPage: 0, //시작 페이지
      ),
          itemBuilder: (context, index) {
            return PageView(
              
              controller: _nextController,
              children: [
                answerList.dementiaAnswer[0],
                answerList.dementiaAnswer[1],
              ],
            );
          },),
      )
    );
  }
}