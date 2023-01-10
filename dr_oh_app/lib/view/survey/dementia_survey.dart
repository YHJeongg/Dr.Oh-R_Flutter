import 'package:dr_oh_app/components/diabetes_privacy.dart';
import 'package:dr_oh_app/view/survey/dementia_survey2.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

//임시
List<String> edu = <String>['초등학교 졸업', '중학교 졸업', '고등학교 졸업', '대학(2~4년제)', '대학원 이상'];
List<String> wage = <String>['사무직 및 영업직', '소규모 자영업자', '현장(숙련)작업자','미숙련 작업자','학생, 가정주부'];
List<Widget> gender = <Widget>[Text('여자'), Text('남자')];

class DementiaSurvey extends StatelessWidget {
  DementiaSurvey({super.key});

  final PageController _nextController = PageController();
  final bool _isChecked = false;
  final String dropdownValue = edu.first; //임시
  final List<bool> _selectedGender = <bool>[true, false];
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
          
          //-------2nd page(설문 시작 전 질문 사항) 이건 당뇨, 뇌졸중이랑 다른 부분이라 따로 위젯을 안뺐음(필요하면 뺌) --------
          Column(
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
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Text(
                        '검사 시행 전 검사를 받는 분의\n교육 수준을 파악하기 위해\n아래와 같은 정보를 입력해 주시기\n바랍니다.',
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                    ],
                  )),
              Container(
                //container design은 크기 보려고 임시로 해놨습니다.
                alignment: Alignment.center,
                margin: EdgeInsets.fromLTRB(20, 20, 20, 20),
                height: 350,
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
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: 30,
                    ),
                    SizedBox(width: 300, child: _dropDownBtn(edu, '교육 연수')),
                    SizedBox(
                      height: 20,
                    ),
                    SizedBox(width: 300, child: _dropDownBtn(wage,'연봉(단위: 만원)')),
                    SizedBox(
                      height: 20,
                    ),
                    // SizedBox(
                    //   width: 300,
                    //   child: _dropDownBtn('생년월일'),
                    // ),
                    SizedBox(
                      height: 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[_gender()],
                    ),
                  ],
                ),
              ),
              Column(
                children: [_btnNext(2)],
              ),
            ],
          ), //2nd page End

          //--------- 3rd page(검사 시작 전 확인 페이지)----------

          surveyStart()
          //3rd page End
        ]);
      },
    );
  } //_pages

//개인정보보호법 페이지
  Widget _privacyAct() {
    return Column(
      children: [
        Container(
          alignment: Alignment.center,
          margin: EdgeInsets.fromLTRB(20, 20, 20, 20),
          height: 200,
          // decoration: BoxDecoration(
          //     color: Colors.white,
          //     borderRadius: BorderRadius.circular(30),
          //     boxShadow: [
          //       BoxShadow(
          //         color: Colors.grey.withOpacity(0.5),
          //         spreadRadius: 5,
          //         blurRadius: 7,
          //         //offset: Offset(0, 2)
          //       ),
          //     ]),
          child: Row(
            children: [
              SizedBox(
                width: 300,
                child: ExpansionTile(
                  title: Center(
                    child: Row(
                      children: [
                        Checkbox(
                          value: _isChecked,
                          onChanged: (value) {
                            
                          },
                        ),
                        const Text('개인정보 수집/이용 동의'),
                      ],
                    ),
                  ),
                  // subtitle: Text('Leading expansion arrow icon'),
                  controlAffinity: ListTileControlAffinity.leading,

                  children: <Widget>[
                    SizedBox(
                      height: 140,
                      width: 350,
                      child: ListView(shrinkWrap: true, children: [
                        ListTile(
                          title: Center(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: const [
                                Text('-수집하는 개인정보 항목'),
                                Text(
                                    '필수항목: 교육연수, 성별, 생년월일, 위치정보, 장소이름, 층수, 각 검사에 대한 답변'),
                                Text('선택항목: 성명, 이메일, 연락처'),
                                Text('-개인정보의 보유 및 이용기간'),
                                Text('이용목적 달성 시 폐기'),
                                Text('-동의 거부권리 안내'),
                                Text(
                                    '신청인은 본 개인정보 수집에 대한 동의를 거부하실 수 있으며, 본 개인정보에 대해 거부할 경우 자가검사 등의 서비스 제공이 제한됩니다.'),
                                Text(
                                    '신청인은 본 개인정보 수집에 대한 동의를 거부하실 수 있으며, 본 개인정보에 대해 거부할 경우 자가검사 등의 서비스 제공이 제한됩니다.'),
                                Text(
                                    '신청인은 본 개인정보 수집에 대한 동의를 거부하실 수 있으며, 본 개인정보에 대해 거부할 경우 자가검사 등의 서비스 제공이 제한됩니다.'),
                              ],
                            ),
                          ),
                        ),
                      ]),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        Container(
          alignment: Alignment.center,
          margin: EdgeInsets.fromLTRB(20, 20, 20, 20),
          height: 200,
          // decoration: BoxDecoration(
          //     color: Colors.white,
          //     borderRadius: BorderRadius.circular(30),
          //     boxShadow: [
          //       BoxShadow(
          //         color: Colors.grey.withOpacity(0.5),
          //         spreadRadius: 5,
          //         blurRadius: 7,
          //         //offset: Offset(0, 2)
          //       ),
          //     ]),
          child: Row(
            children: [
              SizedBox(
                width: 300,
                child: ExpansionTile(
                  title: Center(
                    child: Row(
                      children: [
                        Checkbox(
                          value: _isChecked,
                          onChanged: (value) {
                            //
                          },
                        ),
                        const Text('개인정보 수집/이용 동의'),
                      ],
                    ),
                  ),
                  // subtitle: Text('Leading expansion arrow icon'),
                  controlAffinity: ListTileControlAffinity.leading,

                  children: <Widget>[
                    SizedBox(
                      height: 140,
                      width: 350,
                      child: ListView(shrinkWrap: true, children: [
                        ListTile(
                          title: Center(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: const [
                                Text('-개인정보의 제공'),
                                Text('개인정보의 제공'),
                                Text('-제공받는 자'),
                                Text('닥터 오'),
                                Text('-제공받는 자의 이용목적'),
                                Text('인공지능 자가검사 시행 및 치매정보 제공'),
                                Text(
                                    '필수항목: 교육연수, 성별, 생년월일, 위치정보, 장소이름, 층수, 각 검사에 대한 답변'),
                                Text('선택항목: 성명, 이메일, 연락처'),
                                Text('-제공받는 자의 개인정보 보유 및 이용 기간'),
                                Text('이용목적 달성 시 폐기'),
                                Text('-동의 거부권리 안내'),
                                Text(
                                    '신청인은 본 개인정보 수집에 대한 동의를 거부하실 수 있으며, 본 개인정보에 대해 거부할 경우 자가검사 등의 서비스 제공이 제한됩니다.'),
                              ],
                            ),
                          ),
                        ),
                      ]),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        Column(
          children: [_btnNext(1)],
        ),
      ],
    );
  } //privateAct

//dropdown buttons(교육연수, 연봉, 생년월일)
  Widget _dropDownBtn(List<String> category, String hintText) {
    return DropdownButtonFormField(
      decoration: InputDecoration(
          hintText: hintText,
          border: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(10.0)))),
      items: category.map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
      onChanged: (value) {
        //
      },
    );
  }

//성별 토글 버튼
  Widget _gender() {
    return ToggleButtons(
      //direction: vertical ? Axis.vertical : Axis.horizontal,
      onPressed: (int index) {
        for (int i = 0; i < _selectedGender.length; i++) {
          _selectedGender[i] = i == index;
        }
      },
      borderRadius: BorderRadius.all(Radius.circular(8)),
      //selectedBorderColor: Colors.red[700],
      //selectedColor: Colors.white,
      //fillColor: Colors.red[200],
      //color: Colors.red[400],
      constraints: BoxConstraints(
        minHeight: 40.0,
        minWidth: 150.0,
      ),
      isSelected: _selectedGender,
      children: gender,
    );
  } //_gender

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
                  onPressed: () => Get.off(const DementiaSurveySecond()),
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
