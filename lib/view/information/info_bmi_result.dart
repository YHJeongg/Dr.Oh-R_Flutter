import 'package:flutter/material.dart';

import '../model/model.dart';

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
        elevation: 0,
      ),
      body: Center(
        child: Column(
          children: [
            const SizedBox(height: 50,),
            Text(
              Message.bmiResultStr.toString(),
              style: const TextStyle(
                fontSize: 40,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(
              height: 24,
            ),
            Text(
              Message.bmiResult.toString(),
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            SizedBox(
              width: 300,
              height: 440,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    Message.bmiResultImage,
                    width: 300,
                    height: 400,
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Text(
              Message.bmiResultContent.toString(),
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                height: 1.5
              ),
            ),
          ],
        ),
      ),
    );
  }

  // --- Functions ---

} // End
