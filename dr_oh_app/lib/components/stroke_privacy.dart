import 'package:flutter/material.dart';


class StrokePrivacy extends StatefulWidget {
  final PageController pageController;
  const StrokePrivacy({super.key, required this.pageController});

  @override
  State<StrokePrivacy> createState() => _StrokePrivacyState();
}

class _StrokePrivacyState extends State<StrokePrivacy> {
  late bool agreeterm;
  late bool agreenotice;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    agreeterm = false;
    agreenotice = false;
  }

  @override
  Widget build(BuildContext context) {
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
                          value: agreeterm,
                          onChanged: (value) {
                            setState(() {
                              agreeterm = value!;
                            });
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
                          value: agreenotice,
                          onChanged: (value) {
                            setState(() {
                              agreenotice = value!;
                            });
                          },
                        ),
                        const Text('주의사항'),
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
                                Text('-본 검사는 인공지능을 이용한 예측으로 오류가 있을 수 있습니다.'),
                                Text('-검사 결과의 오류에 대한 어떠한 문제에도 책임을 지지 않습니다.'),
                                Text('-보다 정확한 검사를 위해 만 18세 이상에게 권장합니다.'),
                                Text('-각 답변을 솔직하게 작성해 주세요.'),
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
          children: [
            ElevatedButton(
              onPressed: agreeterm&&agreenotice?
              () {
                //if로 한번 더 감싸기(개인정보보호법 둘 다 클릭 완료 시 넘어감)
                if (widget.pageController.hasClients) {
                  widget.pageController.animateToPage(
                    1,
                    duration: const Duration(milliseconds: 400),
                    curve: Curves.easeInOut,
                  );
                }
              }:null,
              child: const Text(
                '다음',
              ),
            ),
          ],
        ),
      ],
    );
  }
}
