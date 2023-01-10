import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dr_oh_app/model/firebase_dementia.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

//임시
List<String> list = <String>['One', 'Two', 'Three', 'Four'];
List<Widget> gender = <Widget>[const Text('여자'), const Text('남자')];



//Date: 2023-01-09 anna
class SurveyDementia extends StatelessWidget {
  final String surveyName;
  final bool _isChecked = false;
  final PageController _nextController = PageController();
  final List questionList = [];
  //final DatabaseHandler handler;
  final List<bool> _selectedGender = <bool>[true, false];
  final String dropdownValue = list.first; //임시



  SurveyDementia({
    Key? key,
    required this.surveyName,
  }) : super(key: key);



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(surveyName),
        elevation: 0,
      ),
      body: _pages(),
    );
  }



//-------------page Widget----------
  Widget _pages() {
    return PageView.builder(
      controller: PageController(
        initialPage: 0, //시작 페이지
      ),
      itemBuilder: (BuildContext context, int index) {
        return PageView(controller: _nextController, children: <Widget>[
          //-----1st page(개인정보보호법)-------
          _privacyAct(),

          personal(),

          //설문 시작
          firestore()
        ]);
      },
    );
  } //_pages

//----------widget--------------

  //firestore
  Widget firestore() {
    return Column(
      children: [
        StreamBuilder<QuerySnapshot>(
          //firestore에서 데이터 가져오기
          stream: FirebaseFirestore.instance
              .collection('Dementia')
              .orderBy('seq', descending: false)
              .snapshots(),
          //화면 구성
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return const Center(child: CircularProgressIndicator());
            }
            final documents = snapshot.data!.docs;

            return ListView(
                shrinkWrap: true,
                scrollDirection: Axis.vertical,
                children: documents
                    .map((e) => _buildItemWidget(e, documents))
                    .toList());
          },
        ),
      ],
    );
  } //firestore read data


//read questions from firestore
  Widget _buildItemWidget(DocumentSnapshot doc, List<QueryDocumentSnapshot<Object?>> docF) {

   final dementia = Dementia(seq: doc['seq'], question: doc['question']);

    return SizedBox(
      height: Get.height,
      width: Get.width,
      child: PageView.builder(
        controller: PageController(initialPage: 0),
        itemCount: docF.length,
        itemBuilder: (BuildContext context, int index) {
          return Card(
            child: ListTile(
              title: Text(dementia.question),
            ),
          );
        },
      ),
    );
  } //_buildItemWidget



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
  } //btnNext



  Widget personal(){
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
                    SizedBox(width: 300, child: _dropDownBtn('교육 연수')),
                    SizedBox(
                      height: 20,
                    ),
                    SizedBox(width: 300, child: _dropDownBtn('연봉(단위: 만원)')),
                    SizedBox(
                      height: 20,
                    ),
                    SizedBox(
                      width: 300,
                      child: _dropDownBtn('생년월일'),
                    ),
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
          ); //2nd page End

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
//dropdown buttons(교육연수, 연봉, 생년월일)
  Widget _dropDownBtn(String hintText) {
    return DropdownButtonFormField(
      decoration: InputDecoration(
          hintText: hintText,
          border: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(10.0)))),
      items: list.map<DropdownMenuItem<String>>((String value) {
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

}
