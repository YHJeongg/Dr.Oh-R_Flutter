import 'package:dr_oh_app/view/body_info.dart';
import 'package:dr_oh_app/view/checkup_history.dart';
import 'package:dr_oh_app/view/hospital_visit.dart';
import 'package:dr_oh_app/view/medication.dart';
import 'package:dr_oh_app/viewmodel/home_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:get/instance_manager.dart';
import 'package:get/route_manager.dart';

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  // Desc: Calendar Date Picker
  // 검진기록이 있는 날짜 선택, 조회용
  // 2023-01-07, youngjin lee
  Widget _calendar() {
    DateTime selectedDate = DateTime.now();
    return Column(
      children: [
        CalendarDatePicker(
          initialDate: selectedDate,
          firstDate: DateTime(2000),
          lastDate: DateTime.now(),
          onDateChanged: ((value) {
            selectedDate = value;
            print(selectedDate);
          }),
        ),
        ElevatedButton(
          onPressed: () {
            Get.to(
              () => CheckupHistory(),
              arguments: selectedDate,
            );
          },
          child: const Text(
            '검진기록 조회',
          ),
        )
      ],
    );
  }

  // Desc: 홈화면 섹션 구분 박스
  // 2023-01-07, youngjin lee
  BoxDecoration _borderBox() {
    return BoxDecoration(
      border: Border.all(
        style: BorderStyle.solid,
        width: 1,
      ),
      borderRadius: const BorderRadius.all(
        Radius.circular(10),
      ),
    );
  }

  Widget _sizedBox() {
    return const SizedBox(
      height: 20,
    );
  }

  Widget _welcome() {
    return const Padding(
      padding: EdgeInsets.all(15),
      child: Text('님 건강한 하루 되세요'),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: const Text('Home'),
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              _welcome(),
              Container(
                decoration: _borderBox(),
                width: 350,
                child: _calendar(),
              ),
              _sizedBox(),
              Container(
                decoration: _borderBox(),
                width: 350,
                child: Column(
                  children: [
                    const Text('신체정보가 없습니다'),
                    ElevatedButton(
                      onPressed: () {
                        Get.to(() => const BodyInfo());
                      },
                      child: const Text(
                        '입력하러 가기',
                      ),
                    ),
                  ],
                ),
              ),
              _sizedBox(),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(
                    decoration: _borderBox(),
                    width: 165,
                    child: Column(
                      children: [
                        const Text('최근 내원이력'),
                        Row(
                          children: [],
                        ),
                        ElevatedButton(
                          onPressed: () {
                            Get.to(() => const HospitalVisit());
                          },
                          child: const Text(
                            '추가',
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    decoration: _borderBox(),
                    width: 165,
                    child: Column(
                      children: [
                        const Text('최근 투약이력'),
                        Row(
                          children: [],
                        ),
                        ElevatedButton(
                          onPressed: () {
                            Get.to(() => const Medication());
                          },
                          child: const Text(
                            '추가',
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              _sizedBox(),
            ],
          ),
        ),
      ),
    );
  }
}
