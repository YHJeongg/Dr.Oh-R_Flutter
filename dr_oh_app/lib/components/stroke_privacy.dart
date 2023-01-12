import 'package:flutter/material.dart';
import 'package:get/get.dart';

class StrokePrivacy extends StatefulWidget {
  final PageController pageController;
  const StrokePrivacy({super.key, required this.pageController});

  @override
  State<StrokePrivacy> createState() => _StrokePrivacyState();
}

class _StrokePrivacyState extends State<StrokePrivacy> {
  late bool agreeterm; // 개인정보 수집/이용 체크
  late bool agreenotice; // 주의사항 체크
  late ScrollController _scrollController; // 스크롤바 컨트롤러 (개인정보 수집/이용)
  late ScrollController _scrollController2; // 스크롤바 컨트롤러 (주의사항)

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    agreeterm = false;
    agreenotice = false;
    _scrollController = ScrollController();
    _scrollController2 = ScrollController();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        const Padding(
          padding: EdgeInsets.all(8.0),
          child: Text(
            '약관 및 주의사항',
            style: TextStyle(
              fontSize: 35,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        // ------------------------------------------------------------------
        // Date: 2023-01-12, SangwonKim
        // Desc: 개인정보 수집/이용 동의 -> 스타일 수정
        SizedBox(
          width: Get.width,
          child: Column(
            children: [
              Row(
                children: [
                  Checkbox(
                    value: agreeterm,
                    onChanged: (value) {
                      setState(() {
                        agreeterm = value!;
                      });
                    },
                  ),
                  const Text(
                    '개인정보 수집/이용 동의',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              Container(
                color: Theme.of(context).primaryColorLight,
                height: Get.height / 100 * 24,
                child: Scrollbar(
                  controller: _scrollController,
                  thumbVisibility: true,
                  thickness: 15,
                  child: ListView(
                    controller: _scrollController,
                    shrinkWrap: true,
                    children: [
                      ListTile(
                        title: Center(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: const [
                              Text(
                                '- 수집하는 개인정보 항목',
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              Text(
                                  '필수항목: 교육연수, 성별, 생년월일, 위치정보, 장소이름, 층수, 각 검사에 대한 답변'),
                              Text('선택항목: 성명, 이메일, 연락처'),
                              Text(
                                '- 개인정보의 보유 및 이용기간',
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              Text('이용목적 달성 시 폐기'),
                              Text(
                                '- 동의 거부권리 안내',
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              Text(
                                  '신청인은 본 개인정보 수집에 대한 동의를 거부하실 수 있으며, 본 개인정보에 대해 거부할 경우 자가검사 등의 서비스 제공이 제한됩니다.'),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
        // ------------------------------------------------------------------
        // Date: 2023-01-12, SangwonKim
        // Desc: 주의사항 -> 스타일 수정
        SizedBox(
          width: Get.width,
          child: Column(
            children: [
              Row(
                children: [
                  Checkbox(
                    value: agreenotice,
                    onChanged: (value) {
                      setState(() {
                        agreenotice = value!;
                      });
                    },
                  ),
                  const Text(
                    '주의사항',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              Container(
                color: Theme.of(context).primaryColorLight,
                height: Get.height / 100 * 20,
                child: Scrollbar(
                  controller: _scrollController2,
                  thumbVisibility: true,
                  thickness: 15,
                  child: ListView(
                    controller: _scrollController2,
                    shrinkWrap: true,
                    children: [
                      ListTile(
                        title: Center(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: const [
                              Text('- 본 검사는 인공지능을 이용한 예측으로 오류가 있을 수 있습니다.'),
                              Text('- 검사 결과의 오류에 대한 어떠한 문제에도 책임을 지지 않습니다.'),
                              Text('- 보다 정확한 검사를 위해 만 18세 이상에게 권장합니다.'),
                              Text('- 각 답변을 솔직하게 작성해 주세요.'),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(
          height: 40,
        ),
        // ------------------------------------------------------------------
        // Date: 2023-01-12, SangwonKim
        // Desc: 다음 버튼 -> 스타일 수정
        SizedBox(
          height: Get.height / 100 * 8,
          child: ElevatedButton(
            onPressed: agreeterm && agreenotice
                ? () {
                    //if로 한번 더 감싸기(개인정보보호법 둘 다 클릭 완료 시 넘어감)
                    if (widget.pageController.hasClients) {
                      widget.pageController.animateToPage(
                        1,
                        duration: const Duration(milliseconds: 400),
                        curve: Curves.easeInOut,
                      );
                    }
                  }
                : null,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                Text(
                  '다음',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 2,
                  ),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 16)
      ],
    );
  }
}
