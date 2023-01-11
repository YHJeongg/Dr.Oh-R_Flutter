import 'package:flutter/material.dart';
import '../model/survey_stroke_message.dart';

// Date: 2023-01-10, SangwonKim
// Desc: 뇌졸중 설문조사 유저 기본정보 가져오는 class
class StrokeUserInfo extends StatefulWidget {
  final PageController pageController;
  const StrokeUserInfo({super.key, required this.pageController});

  @override
  State<StrokeUserInfo> createState() => _StrokeUserInfoState();
}

class _StrokeUserInfoState extends State<StrokeUserInfo> {
  late bool sexSwitchValue; // 유저 성별
  late TextEditingController ageController; // 유저 나이
  late TextEditingController heightController; // 유저 키
  late TextEditingController weightController; // 유저 몸무게
  int currentYear = DateTime.now().year; // 현재 년도
  RegExp ageReg = RegExp(r"^[0-9]{4}$"); // 정규화 검사: 숫자만 4자리
  late bool correctYear; // 년도 확인
  late bool correctHeight; // 키 확인
  late bool correctWeight; // 몸무게 확인

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    sexSwitchValue = false;
    ageController = TextEditingController();
    heightController = TextEditingController();
    weightController = TextEditingController();
    correctYear = false;
    correctWeight = false;
    correctHeight = false;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            children: [
              const Text(
                '신체 정보 입력',
                style: TextStyle(
                  fontSize: 30,
                ),
              ),
              const SizedBox(height: 120),
              // 성별 입력받기
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    '남자 ',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      // color: Colors.blueAccent,
                    ),
                  ),
                  Switch(
                    value: sexSwitchValue,
                    onChanged: (value) {
                      setState(() {
                        sexSwitchValue = !sexSwitchValue;
                      });
                    },
                  ),
                  const Text(
                    ' 여자',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      // color: Colors.redAccent,
                    ),
                  ),
                ],
              ),
              // 출생년도 입력받기
              SizedBox(
                width: 100,
                child: TextField(
                  controller: ageController,
                  keyboardType: TextInputType.number,
                  onChanged: (value) {
                    if (ageReg.hasMatch(value) &&
                        int.parse(value) <= currentYear) {
                      setState(() {
                        correctYear = true;
                      });
                    } else {
                      setState(() {
                        correctYear = false;
                      });
                    }
                  },
                  decoration: InputDecoration(
                    labelText: ageController.text.trim().isEmpty
                        ? '출생년도 4자리'
                        : correctYear
                            ? ''
                            : '출생년도를 정확히 입력하세요.',
                  ),
                ),
              ),
              // 키 입력받기
              SizedBox(
                width: 100,
                child: TextField(
                  controller: heightController,
                  keyboardType: const TextInputType.numberWithOptions(
                    decimal: true,
                  ),
                  decoration: const InputDecoration(
                    labelText: '키(cm)',
                  ),
                  onChanged: (value) {
                    if (value.isEmpty) {
                      setState(() {
                        correctHeight = false;
                      });
                    } else {
                      setState(() {
                        correctHeight = true;
                      });
                    }
                  },
                ),
              ),
              // 몸무게 입력받기
              SizedBox(
                width: 100,
                child: TextField(
                  controller: weightController,
                  keyboardType: const TextInputType.numberWithOptions(
                    decimal: true,
                  ),
                  decoration: const InputDecoration(
                    labelText: '몸무게(kg)',
                  ),
                  onChanged: (value) {
                    if (value.isEmpty) {
                      setState(() {
                        correctWeight = false;
                      });
                    } else {
                      setState(() {
                        correctWeight = true;
                      });
                    }
                  },
                ),
              ),
              const SizedBox(
                height: 16,
              ),
              // 다음 버튼 -> 본 설문페이지로 넘어가기
              ElevatedButton(
                onPressed: correctYear && correctHeight && correctWeight
                    ? () {
                        //if로 한번 더 감싸기(개인정보보호법 둘 다 클릭 완료 시 넘어감)
                        if (widget.pageController.hasClients) {
                          SurveyStrokeMessage.sex =
                              (sexSwitchValue ? 'female' : 'male').toString();
                          SurveyStrokeMessage.age = currentYear -
                              int.parse(ageController.text.trim());
                          SurveyStrokeMessage.height =
                              double.parse(heightController.text.trim());
                          SurveyStrokeMessage.weight =
                              double.parse(weightController.text.trim());
                          widget.pageController.animateToPage(
                            2,
                            duration: const Duration(milliseconds: 400),
                            curve: Curves.easeInOut,
                          );
                        }
                      }
                    : null,
                child: const Text('다음'),
              ),
            ],
          ),
        ),
      ),
    );
  }
} // End
