import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../model/bmi_message.dart';

class InfoBmiResult extends StatefulWidget {
  const InfoBmiResult({super.key});

  @override
  State<InfoBmiResult> createState() => _InfoBmiResultState();
}

class _InfoBmiResultState extends State<InfoBmiResult> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('BMI Result'),
        elevation: 1,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: Column(
            children: [
              const SizedBox(
                height: 16,
              ),
              Text(
                BmiMessage.bmiResultStr.toString(),
                style: const TextStyle(
                  fontSize: 40,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(
                height: 24,
              ),
              Text(
                'BMI 지수\n${BmiMessage.bmiResult.toString()}',
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(
                width: Get.width/100*36,
                // height: Get.height/100*40,
                // width: 300,
                // height: 440,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      BmiMessage.bmiResultImage,
                      width: 300,
                      height: 400,
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 16,
              ),
              Text(
                BmiMessage.bmiResultContent.toString(),
                textAlign: TextAlign.center,
                style: const TextStyle(
                    fontSize: 16, fontWeight: FontWeight.bold, height: 1.5),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // --- Functions ---

} // End
