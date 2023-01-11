import 'package:dr_oh_app/model/diabetes_message.dart';
import 'package:flutter/material.dart';

class DAnswer {
  List<Widget> dAnserList = const [
    FirstA(),
    SecondA(),
    FirstA(),
    FourthA(),
    FifthA()
  ];
}

class FirstA extends StatefulWidget {
  const FirstA({super.key});

  @override
  State<FirstA> createState() => _FirstAState();
}

class _FirstAState extends State<FirstA> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text(
          '예',
        ),
        Radio(
          value: "TRUE",
          groupValue: DiabetesMessage.physact,
          onChanged: (value) {
            setState(() {
              DiabetesMessage.physact = value!;
            });
          },
        ),
        const SizedBox(
          width: 20,
        ),
        const Text(
          '아니오',
        ),
        Radio(
          value: "FALSE",
          groupValue: DiabetesMessage.physact,
          onChanged: (value) {
            setState(() {
              DiabetesMessage.physact = value!;
            });
          },
        ),
      ],
    );
  }
}

class SecondA extends StatefulWidget {
  const SecondA({super.key});

  @override
  State<SecondA> createState() => _SecondAState();
}

class _SecondAState extends State<SecondA> {
  late double score;
  late RangeValues values;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    score = 1;
    values = const RangeValues(0, 6);
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text(
          '안 좋음',
        ),
        Slider(
          value: score,
          divisions: 4,
          min: 1,
          max: 5,
          label: score.toString(),
          onChanged: (value) {
            setState(() {
              score = value;
            });
            DiabetesMessage.genhealth=value;
          },
        ),
        const Text(
          '좋음',
        ),
      ],
    );
  }
}

class ThirdA extends StatefulWidget {
  const ThirdA({super.key});

  @override
  State<ThirdA> createState() => _ThirdAState();
}

class _ThirdAState extends State<ThirdA> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text(
          '예',
        ),
        Radio(
          value: "TRUE",
          groupValue: DiabetesMessage.diffwalk,
          onChanged: (value) {
            setState(() {
              DiabetesMessage.diffwalk = 'TRUE';
            });
          },
        ),
        const SizedBox(
          width: 20,
        ),
        const Text(
          '아니오',
        ),
        Radio(
          value: "FALSE",
          groupValue: DiabetesMessage.diffwalk,
          onChanged: (value) {
            setState(() {
              DiabetesMessage.diffwalk = 'FALSE';
            });
          },
        ),
      ],
    );
  }
}

class FourthA extends StatefulWidget {
  const FourthA({super.key});

  @override
  State<FourthA> createState() => _FourthAState();
}

class _FourthAState extends State<FourthA> {
  late bool first;
  late bool second;
  late bool third;
  late bool fourth;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    first = false;
    second = false;
    third = false;
    fourth = false;
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text(
          '고혈압',
        ),
        Checkbox(
          value: DiabetesMessage.highbp,
          onChanged: (value) {
            setState(() {
              DiabetesMessage.highbp = value!;
              fourth = false;
            });
          },
        ),
        const Text(
          '뇌졸중',
        ),
        Checkbox(
          value: DiabetesMessage.stroke,
          onChanged: (value) {
            setState(() {
              DiabetesMessage.stroke = value!;
              fourth = false;
            });
          },
        ),
        const Text(
          '심장 질환',
        ),
        Checkbox(
          value: DiabetesMessage.hdattack,
          onChanged: (value) {
            setState(() {
              DiabetesMessage.hdattack = value!;
              fourth = false;
            });
          },
        ),
        const Text(
          '해당 없음',
        ),
        Checkbox(
          value: fourth,
          onChanged: (value) {
            setState(() {
              DiabetesMessage.highbp = false;
              DiabetesMessage.stroke = false;
              DiabetesMessage.hdattack = false;
              fourth = value!;
            });
          },
        ),
      ],
    );
  }
}

class FifthA extends StatefulWidget {
  const FifthA({super.key});

  @override
  State<FifthA> createState() => _FifthAState();
}

class _FifthAState extends State<FifthA> {
  late TextEditingController dayCont;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    dayCont = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(
          width: 100,
          child: TextField(
            controller: DiabetesMessage.physhealth,
            keyboardType: TextInputType.number,
          ),
        ),
      ],
    );
  }
}
