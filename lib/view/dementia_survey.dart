import 'package:flutter/material.dart';

//임시
const List<String> list = <String>['One', 'Two', 'Three', 'Four'];

class DementiaSurvey extends StatelessWidget {
  DementiaSurvey({super.key});

  final PageController controller = PageController();
  final bool _isChecked = false;
  final TextEditingController educController = TextEditingController();
  String dropdownValue = list.first;

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
                      width: 300,
                      child: TextField(
                        controller: educController,
                        decoration: InputDecoration(
                            border: OutlineInputBorder(), hintText: "교육 연수 입력"),
                      ),
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    SizedBox(
                      width: 300,
                      child: DropdownButton<String>(
                        value: dropdownValue,
                        elevation: 16,
                        // style: const TextStyle(color: Colors.deepPurple),
                        
                        onChanged: (String? value) {
                          // This is called when the user selects an item.
                          //
                        },
                        items: list.map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ]);
      },
    );
  }
} //End
