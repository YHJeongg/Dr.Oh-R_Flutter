import 'package:dr_oh_app/model/model.dart';
import 'package:dr_oh_app/view/information/info_bmi_result.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class InfoBmiCalc extends StatefulWidget {
  const InfoBmiCalc({super.key});

  @override
  State<InfoBmiCalc> createState() => _InfoBmiCalcState();
}

// Date: 2023-01-08, SangwonKim
// Desc: BMI Calculator
class _InfoBmiCalcState extends State<InfoBmiCalc> {
  late int numAge; // 나이
  late int numWeight; // 몸무게
  late int numHeight; // 키
  late bool switchGender; // 성별
  late double bmiResult; // BMI 결과
  late String bmiResultStr; // BMI 분류결과
  late String bmiResultContent; // BMI 분류결과 별 내용
  late String bmiResultImage; // BMI 분류결과 별 이미지

  @override
  void initState() {
    super.initState();
    numAge = 30; // 사용자 정보 가져오기 <<
    numWeight = 70; // 사용자 정보 가져오기 <<
    numHeight = 170; // 사용자 정보 가져오기 <<
    switchGender = false; // 사용자 정보 가져오기 <<
    bmiResult = 0;
    bmiResultStr = '';
    bmiResultContent = '';
    bmiResultImage = '';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('BMI 계산'),
        // backgroundColor: const Color.fromARGB(0, 255, 255, 255),
        elevation: 1,
      ),
      body: Padding(
        padding: const EdgeInsets.all(14.0),
        child: Center(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 0, 0, 14),
                child: Row(
                  children: [
                    Container(
                      width: 194,
                      height: 240,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16),
                        color: Colors.transparent.withOpacity(0.1),
                      ),
                      child: Column(
                        children: [
                          const SizedBox(
                            height: 20,
                          ),
                          const Text(
                            'Age',
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(
                            height: 12,
                          ),
                          Text(
                            numAge.toString(),
                            style: const TextStyle(fontSize: 80),
                          ),
                          const SizedBox(
                            height: 12,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              FloatingActionButton(
                                elevation: 0,
                                heroTag: 'btn1',
                                onPressed: () {
                                  minusAge();
                                },
                                backgroundColor:
                                    // Theme.of(context).primaryColorDark,
                                    const Color.fromARGB(255, 96, 139, 109),
                                foregroundColor: Colors.black,
                                child: const Icon(
                                  Icons.remove,
                                  size: 36,
                                ),
                              ),
                              FloatingActionButton(
                                elevation: 0,
                                heroTag: 'btn2',
                                onPressed: () {
                                  plusAge();
                                },
                                backgroundColor:
                                    const Color.fromARGB(255, 96, 139, 109),
                                foregroundColor: Colors.black,
                                child: const Icon(
                                  Icons.add,
                                  size: 36,
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                    const SizedBox(
                      width: 14,
                    ),
                    Container(
                      width: 194,
                      height: 240,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16),
                        color: Colors.transparent.withOpacity(0.1),
                      ),
                      child: Column(
                        children: [
                          const SizedBox(
                            height: 20,
                          ),
                          const Text(
                            'Weight',
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(
                            height: 12,
                          ),
                          Text(
                            numWeight.toString(),
                            style: const TextStyle(fontSize: 80),
                          ),
                          const SizedBox(
                            height: 12,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              FloatingActionButton(
                                elevation: 0,
                                heroTag: 'btn3',
                                onPressed: () {
                                  minusWeight();
                                },
                                backgroundColor:
                                    const Color.fromARGB(255, 96, 139, 109),
                                foregroundColor: Colors.black,
                                child: const Icon(
                                  Icons.remove,
                                  size: 36,
                                ),
                              ),
                              FloatingActionButton(
                                elevation: 0,
                                heroTag: 'byn4',
                                onPressed: () {
                                  plusWeight();
                                },
                                backgroundColor:
                                    const Color.fromARGB(255, 96, 139, 109),
                                foregroundColor: Colors.black,
                                child: const Icon(
                                  Icons.add,
                                  size: 36,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                  ],
                ),
              ),
              Container(
                width: 404,
                height: 240,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  color: Colors.transparent.withOpacity(0.1),
                ),
                child: Column(
                  children: [
                    const SizedBox(
                      height: 20,
                    ),
                    const Text(
                      'Height',
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(
                      height: 12,
                    ),
                    Text(
                      numHeight.toString(),
                      style: const TextStyle(fontSize: 80),
                    ),
                    const SizedBox(
                      height: 12,
                    ),
                    Slider(
                      value: numHeight.toDouble(),
                      min: 80,
                      max: 200,
                      divisions: 120,
                      activeColor: const Color.fromARGB(255, 96, 139, 109),
                      label: numHeight.round().toStringAsFixed(0),
                      onChanged: (double value) {
                        setState(() {
                          numHeight = value.toInt();
                        });
                      },
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 12,
              ),
              Container(
                width: 404,
                height: 140,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  color: Colors.transparent.withOpacity(0.1),
                ),
                child: Column(
                  children: [
                    const SizedBox(
                      height: 20,
                    ),
                    const Text(
                      'Gender',
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(
                      height: 12,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        const SizedBox(
                          width: 32,
                        ),
                        const Text(
                          'Male',
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                        Switch(
                          value: switchGender,
                          activeColor: const Color.fromARGB(255, 211, 89, 67),
                          onChanged: (value) {
                            onClickedGender();
                          },
                        ),
                        const Text(
                          'Female',
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(
                          width: 16,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 12,
              ),
              ElevatedButton(
                onPressed: () {
                  checkBmi();
                  Message.bmiResult = bmiResult;
                  Get.to(const InfoBmiResult());
                  // Navigator.pushNamed(context, '/BmiResult');
                  // Navigator.of(context).pushNamed('/BmiResult');
                },
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16)),
                  // elevation: 0,
                  // backgroundColor: const Color.fromARGB(255, 96, 139, 109),
                  // foregroundColor: Colors.black,
                ),
                child: SizedBox(
                  height: 100,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Text(
                        'CHECK',
                        style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 2),
                      ),
                    ],
                  ),
                ),
              ),
              // Text(
              //   bmiResult.toString(),
              // ),
            ],
          ),
        ),
      ),
    );
  }

  // --- Functions ---
  plusAge() {
    setState(() {
      numAge++;
    });
  }

  minusAge() {
    setState(() {
      numAge--;
    });
  }

  plusWeight() {
    setState(() {
      numWeight++;
    });
  }

  minusWeight() {
    setState(() {
      numWeight--;
    });
  }

  onClickedGender() {
    setState(() {
      if (switchGender == true) {
        switchGender = false;
      } else {
        switchGender = true;
      }
    });
  }

  checkBmi() {
    bmiResult = double.parse(
        (numWeight / (numHeight * numHeight) * 10000).toStringAsFixed(1));
    if (bmiResult < 18.5) {
      bmiResultStr = 'UnderWeight';
      bmiResultContent =
          '저체중이라고 해도 대체로 건강한 상태이지만\n영양부족의 위험성이 있음\n평소 건강 상의 문제가 없으나 영양부족의 이유로\n몸이 허약하고, 체력이 약함\n빈혈이 있다면 정기적으로 건강검진을 해보는 것을 추천';
      if (switchGender == false) {
        bmiResultImage = 'images/underweight_male.png';
      } else {
        bmiResultImage = 'images/underweight_female.png';
      }
    } else if (bmiResult <= 24.9) {
      bmiResultStr = 'Normal Weight';
      bmiResultContent = '건강한 상태\n이 상태를 유지하기를 추천';
      if (switchGender == false) {
        bmiResultImage = 'images/normalweight_male.png';
      } else {
        bmiResultImage = 'images/normalweight_female.png';
      }
    } else if (bmiResult <= 29.9) {
      bmiResultStr = 'OverWeight';
      bmiResultContent = '건강함\n혹은 건강문제가 조금씩 증가하는 단계';
      if (switchGender == false) {
        bmiResultImage = 'images/overweight_male.png';
      } else {
        bmiResultImage = 'images/overweight_female.png';
      }
    } else if (bmiResult <= 39.9) {
      bmiResultStr = 'Obesity';
      bmiResultContent = '건강상태 나빠질 우려 있음\n조심해야 하는 단계';
      if (switchGender == false) {
        bmiResultImage = 'images/obesity_male.png';
      } else {
        bmiResultImage = 'images/obesity_female.png';
      }
    } else {
      bmiResultStr = 'Extreme Obesity';
      bmiResultContent =
          '건강 상태가 위험한 단계\n고혈압, 당뇨, 암 등의 질병 발병 가능성이 높음\n정기적으로 건강검진이 필요한 대상';
      if (switchGender == false) {
        bmiResultImage = 'images/extremeobesity_male.png';
      } else {
        bmiResultImage = 'images/extremeobesity_female.png';
      }
    }
    Message.bmiResultStr = bmiResultStr;
    Message.bmiResultContent = bmiResultContent;
    Message.bmiResultImage = bmiResultImage;
  }
} // End
