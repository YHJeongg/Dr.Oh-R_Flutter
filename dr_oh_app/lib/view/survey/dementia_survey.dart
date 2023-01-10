import 'package:dr_oh_app/components/diabetes_privacy.dart';
import 'package:dr_oh_app/view/survey/dementia_survey_personal.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';


class DementiaSurvey extends StatelessWidget {
  DementiaSurvey({super.key});

  final PageController _nextController = PageController();
  
  //final GlobalKey expansionTileKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('치매 검사'),
        elevation: 0,
      ),
      body: _pages(),
    );
  } //build

//---------Widget-----------
  // Date: 2023-01-08, anna
  // DementiaSurvey: pageView 생성
  Widget _pages() {
    return PageView.builder(
      controller: PageController(
        initialPage: 0, //시작 페이지
      ),
      itemBuilder: (BuildContext context, int index) {
        return PageView(controller: _nextController, children: <Widget>[
          //-----1st page(개인정보보호법)-------


          DiaPrivacy(pageCont: _nextController),
          

          

          //--------- 3rd page(검사 시작 전 확인 페이지)----------

          surveyStart()
          //3rd page End
        ]);
      },
    );
  } //_pages

  Widget surveyStart() {
    return Column(
      children: [
        Container(
          alignment: Alignment.center,
          margin: EdgeInsets.fromLTRB(20, 20, 20, 20),
          height: 200,
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(30),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 5,
                  blurRadius: 7,
                  //offset: Offset(0, 2)
                ),
              ]),
          child: Column(
            children: [
              Text('치매 검사를 시작하시겠습니까?'),
            ],
          ),
        ),
        Container(
          alignment: Alignment.center,
          margin: EdgeInsets.fromLTRB(20, 20, 20, 20),
          height: 200,
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(30),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 5,
                  blurRadius: 7,
                  //offset: Offset(0, 2)
                ),
              ]),
          child: Column(
            children: [
              ElevatedButton(
                  onPressed: () => Get.off(const DementiaPersonal()),
                  child: const Text('다음 설문'))

            ],
          ),
        ),
      ],
    );
  } //surveyStart

  Widget _btnNext(int pageNum) {
    return ElevatedButton(
        onPressed: () {
          //if로 한번 더 감싸기(개인정보보호법 둘 다 클릭 완료 시 넘어감)
          if (_nextController.hasClients) {
            _nextController.animateToPage(
              pageNum,
              duration: Duration(milliseconds: 400),
              curve: Curves.easeInOut,
            );
          }
        },
        child: Text('다음'));
  } //

  // void _scrollToSelectedContent({GlobalKey? expansionTileKey}) {
  //   final keyContext = expansionTileKey!.currentContext;
  //   if (keyContext != null) {
  //     Future.delayed(Duration(milliseconds: 200)).then((value) {
  //       Scrollable.ensureVisible(keyContext,
  //           duration: Duration(milliseconds: 200));
  //     });
  //   }
  // }
} //End
