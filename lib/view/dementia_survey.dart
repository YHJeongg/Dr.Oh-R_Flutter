import 'package:flutter/material.dart';

//임시
const List<String> list = <String>['One', 'Two', 'Three', 'Four'];
const List<Widget> gender = <Widget>[Text('여자'), Text('남자')];

class DementiaSurvey extends StatelessWidget {
  DementiaSurvey({super.key});

  final PageController controller = PageController();
  final bool _isChecked = false;
  String dropdownValue = list.first; //임시
  final List<bool> _selectedGender = <bool>[true, false];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('치매 검사'),
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
        //-----1st page(개인정보보호법)-------
        return PageView(children: <Widget>[
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
                  children: [
                    Checkbox(
                      value: _isChecked,
                      onChanged: (value) {
                        //provider
                      },
                    ),
                    const Text('개인정보보호법')
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
                child: Row(
                  children: [
                    Checkbox(
                      value: _isChecked,
                      onChanged: (value) {
                        //provider
                      },
                    ),
                    Text('개인정보보호법')
                  ],
                ),
              ),
              Container(
                child: Column(
                  children: [
                    ElevatedButton(
                        onPressed: () {
                          //
                        },
                        child: Text('다음'))
                  ],
                ),
              ), //1st END
            ],
          ),

          //-------2nd page(설문 시작 전 질문 사항) --------
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
                    Container(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[_gender()],
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                child: Column(
                  children: [
                    ElevatedButton(
                        onPressed: () {
                          //
                        },
                        child: Text('다음'))
                  ],
                ),
              ),
            ],
          ),
        ]);
      },
    );
  } //_pages

//dropdown buttons(교육연수, 연봉, 생년월일)
  Widget _dropDownBtn(String hintText) {
    return DropdownButtonFormField(
      decoration: InputDecoration(
          hintText: hintText,
          border: const OutlineInputBorder(
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

//성별 토글 버튼
  Widget _gender() {
    return ToggleButtons(
      //direction: vertical ? Axis.vertical : Axis.horizontal,
      onPressed: (int index) {
        //
        // for (int i = 0; i < _selectedGender.length; i++) {
        //     _selectedGender[i] = i == index;
        //   }
      },
      borderRadius: const BorderRadius.all(Radius.circular(8)),
      //selectedBorderColor: Colors.red[700],
      //selectedColor: Colors.white,
      //fillColor: Colors.red[200],
      //color: Colors.red[400],
      constraints: const BoxConstraints(
        minHeight: 40.0,
        minWidth: 80.0,
      ),
      isSelected: _selectedGender,
      children: gender,
    );
  }
} //End
