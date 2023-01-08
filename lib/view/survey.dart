import 'package:dr_oh_app/view/dementia_survey.dart';
import 'package:dr_oh_app/view/diabetes_survey.dart';
import 'package:dr_oh_app/view/stroke_survey.dart';
import 'package:flutter/material.dart';

class Survey extends StatelessWidget {
  const Survey({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('survey'),
        elevation: 0,
      ),
      body: Center(
        child: Column(
          children: [
            const SizedBox(
              height: 40,
            ),
            _btn(DiabetesSurvey(), '당뇨병 검사 하러가기', context),
            const SizedBox(
              height: 40,
            ),
            _btn(StrokeSurvey(), '뇌졸중 검사 하러가기', context),
            const SizedBox(
              height: 40,
            ),
            _btn(DementiaSurvey(), '치매 검사 하러가기', context),
            ],
        ),
      ),
    );
  } //build

//---------Widget-----------
  // Date: 2023-01-08, anna
  // survey tab: 각 설문지로 보내는 버튼 생성
  Widget _btn(dynamic page, String title, BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => page),
        );
      },
      style: ElevatedButton.styleFrom(
        foregroundColor: Colors.white,
        minimumSize: const Size(300, 150),
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(20))),
        side: const BorderSide(
          color: Colors.grey,
          width: 3.0,
        ),
      ),
      child: Text(
        title,
        style: const TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 30,
        ),
      ),
    );
  } //_btn

}//End
