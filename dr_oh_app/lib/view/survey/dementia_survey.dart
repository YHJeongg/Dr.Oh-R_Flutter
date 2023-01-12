import 'package:dr_oh_app/components/diabetes_privacy.dart';
import 'package:dr_oh_app/components/logout_btn.dart';
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
        title: const Text('치매 검사'),
        elevation: 1,
        actions: const [LogoutBtn()],
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: _pages(),
      ),
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
        Column(
          children: const [

            SizedBox(
              height: 30
            ),
            Text('치매 검사를 ',
             style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30, color:  Color(0xFF5B9D46),),
             ),
             Text('시작하시겠습니까?',
             style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30, color:  Color(0xFF5B9D46),),
             ),
             SizedBox(height: 30),
             Text('본 질문은 치매의 진단을 예측하는 것으로 \n치매 진단을 목적으로 하지 않습니다. \n정확한 진단을 위해서는 가까운 병원이나 \n보건소에 방문하시기 바랍니다.',
             style: TextStyle(color: Colors.red),)
          ],
        ),
        SizedBox(
          height: 30,
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
          SizedBox(
            width: 350,
            height: 250,
            child: Image.asset('images/dementiaStartPage.jpg')),
            SizedBox(height: 30,),
            ElevatedButton(
                onPressed: () => Get.off(const DementiaPersonal()),
                child: const Text('설문하러 가기',
                style: TextStyle(fontSize: 30, color: Colors.white,
                fontWeight: FontWeight.bold, 
                )),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF5B9D46),
                  minimumSize: Size(150, 80)
                ),
                
                ),

          ],
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
              duration: const Duration(milliseconds: 400),
              curve: Curves.easeInOut,
            );
          }
        },
        child: const Text('다음'));
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
