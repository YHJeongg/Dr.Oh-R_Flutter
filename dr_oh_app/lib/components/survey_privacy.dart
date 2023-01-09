import 'package:flutter/material.dart';

//Date: 2023-01-09 anna
class SurveyPrivacy extends StatelessWidget {
  
  final String surveyName;
  final bool _isChecked = false;
  final PageController _nextController = PageController();

 SurveyPrivacy(
      {Key? key,
      required this.surveyName,
      
      })
      : super(key: key);



@override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(surveyName),
        elevation: 1,
      ),

      body: _pages(),
    );
  }


  Widget _pages() {
    return 
    PageView.builder(
      controller: PageController(
        initialPage: 0, //시작 페이지
      ),
      itemBuilder: (BuildContext context, int index) {
        return PageView(controller: _nextController, children: <Widget>[
          //-----1st page(개인정보보호법)-------
          _privacyAct(),
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
                                Text('필수항목: 교육연수, 성별, 생년월일, 위치정보, 장소이름, 층수, 각 검사에 대한 답변'),
                                Text('선택항목: 성명, 이메일, 연락처'),
                                Text('-제공받는 자의 개인정보 보유 및 이용 기간'),
                                Text('이용목적 달성 시 폐기'),
                                Text('-동의 거부권리 안내'),
                                Text('신청인은 본 개인정보 수집에 대한 동의를 거부하실 수 있으며, 본 개인정보에 대해 거부할 경우 자가검사 등의 서비스 제공이 제한됩니다.'),
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
  }//privateAct

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
  }//btnNext

}