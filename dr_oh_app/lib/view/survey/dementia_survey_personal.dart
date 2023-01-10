import 'package:dr_oh_app/components/dementia_answer_final.dart';
import 'package:dr_oh_app/view/survey/dementia_survey2.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

List<String> edu = <String>[
  '초등학교 졸업',
  '중학교 졸업',
  '고등학교 졸업',
  '대학(2~4년제)',
  '대학원 이상'
];
List<String> wage = <String>[
  '사무직 및 영업직',
  '소규모 자영업자',
  '현장(숙련)작업자',
  '미숙련 작업자',
  '학생, 가정주부'
];
List<Widget> gender = <Widget>[const Text('여자'), const Text('남자')];

class DementiaPersonal extends StatefulWidget {
  const DementiaPersonal({super.key});

  @override
  State<DementiaPersonal> createState() => _DementiaPersonalState();
}

class _DementiaPersonalState extends State<DementiaPersonal> {
  late bool _isChecked;
  late String dropdownValue; //임시
  late List<bool> _selectedGender;
  final PageController _nextController = PageController();
  final TextEditingController ageController = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _isChecked = false;
    dropdownValue = edu.first;
    _selectedGender = <bool>[true, false];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('치매 진단'),
        elevation: 0,
      ),
      body: Center(
        child: //-------2nd page(설문 시작 전 질문 사항) 이건 당뇨, 뇌졸중이랑 다른 부분이라 따로 위젯을 안뺐음(필요하면 뺌) --------
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
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                  ],
                )),
            Container(
              //container design은 크기 보려고 임시로 해놨습니다.
              alignment: Alignment.center,
              margin: EdgeInsets.fromLTRB(20, 20, 20, 20),
              height: 400,
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
                  Padding(
                    padding: const EdgeInsets.all(30.0),
                    child: TextField(
                      controller: ageController,
                      decoration: InputDecoration(hintText: '나이'),
                      onChanged: (value) {
                        setState(() {
                          DementiaAnswerFinal.age = int.parse(ageController.text);
                        });
                      },
                    ),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  SizedBox(
                      width: 300,
                      child: DropdownButtonFormField(
                        decoration: InputDecoration(
                            hintText: '교육연수',
                            border: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10.0)))),
                        items:
                            edu.map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                        onChanged: (value) {
                          setState(() {
                            DementiaAnswerFinal.edu = value!;
                          });
                        },
                      )),
                  SizedBox(
                    height: 20,
                  ),
                  SizedBox(
                      width: 300,
                      child: DropdownButtonFormField(
                        decoration: InputDecoration(
                            hintText: '연봉(단위: 만원)',
                            border: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10.0)))),
                        items:
                            wage.map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                        onChanged: (value) {
                          setState(() {
                            DementiaAnswerFinal.wage = value!;
                            print(DementiaAnswerFinal.wage);
                          });
                        },
                      )),
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
              children: [
                ElevatedButton(
                    onPressed: () {
                      print(DementiaAnswerFinal.gender);
                      Get.off(const DementiaSurveySecond());
                    },
                    child: const Text('다음 설문'))
              ],
            ),
          ],
        ), //2nd page End
      ),
    );
  }

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
        setState(() {
          //DementiaAnswerFinal.edu = edu[];
        });
      },
    );
  }

//성별 토글 버튼
  Widget _gender() {
    return ToggleButtons(
      //direction: vertical ? Axis.vertical : Axis.horizontal,
      onPressed: (int index) {
        setState(() {
        for (int i = 0; i < _selectedGender.length; i++) {
          _selectedGender[i] = i == index;
          
        }
          
        });
        if (_selectedGender[0] == true) {
          DementiaAnswerFinal.gender = '여자';
        } else {
          DementiaAnswerFinal.gender = '남자';
        }
        //print(DementiaAnswerFinal.gender);
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
}
