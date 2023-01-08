import 'package:dr_oh_app/view/info_bmi.dart';
import 'package:dr_oh_app/view/info_dementia.dart';
import 'package:dr_oh_app/view/info_diabetes.dart';
import 'package:dr_oh_app/view/info_stroke.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Information extends StatelessWidget {
  const Information({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Information'),
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Center(
          child: Column(
            children: [
              // Date: 2023-01-08, SangwonKim
              // 당뇨병 정보 버튼
              ElevatedButton(
                onPressed: () {
                  Get.to(const InfoDiabetes());
                },
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16.0),
                  ),
                ),
                child: SizedBox(
                  height: 140,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Text(
                        '당뇨병 정보',
                        style: TextStyle(
                          fontSize: 24,
                          // fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              // Date: 2023-01-08, SangwonKim
              // 뇌졸중 정보 버튼
              ElevatedButton(
                onPressed: () {
                  Get.to(const InfoStroke());
                },
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16.0),
                  ),
                ),
                child: SizedBox(
                  height: 140,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Text(
                        '뇌졸중 정보',
                        style: TextStyle(
                          fontSize: 24,
                          // fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              // Date: 2023-01-08, SangwonKim
              // 치매 정보 버튼
              ElevatedButton(
                onPressed: () {
                  Get.to(const InfoDementia());
                },
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16.0),
                  ),
                ),
                child: SizedBox(
                  height: 140,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Text(
                        '치매 정보',
                        style: TextStyle(
                          fontSize: 24,
                          // fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              // Date: 2023-01-08, SangwonKim
              // BMI 정보 버튼
              ElevatedButton(
                onPressed: () {
                  Get.to(const InfoBmi());
                },
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16.0),
                  ),
                ),
                child: SizedBox(
                  height: 140,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Text(
                        'BMI 정보',
                        style: TextStyle(
                          fontSize: 24,
                          // fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),

            ],
          ),
        ),
      ),
    );
  }
}
