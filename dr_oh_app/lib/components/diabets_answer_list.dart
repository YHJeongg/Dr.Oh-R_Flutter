import 'package:flutter/material.dart';

class DAnswer {
  List<Widget> dAnserList = const [FirstA(), SecondA(), FirstA(), ThirdA(),FifthA()];
}

class FirstA extends StatefulWidget {
  const FirstA({super.key});

  @override
  State<FirstA> createState() => _FirstAState();
}

class _FirstAState extends State<FirstA> {
  late String favalue;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    favalue = 'yes';
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Radio(
          value: "Yes",
          groupValue: favalue,
          onChanged: (value) {
            setState(() {
              favalue = value!;
            });
          },
        ),
        Radio(
          value: "No",
          groupValue: favalue,
          onChanged: (value) {
            setState(() {
              favalue = value!;
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
          },
        )
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
        Checkbox(
          value: first,
          onChanged: (value) {
            setState(() {
              first = value!;
            });
          },
        ),
        Checkbox(
          value: second,
          onChanged: (value) {
            setState(() {
              second = value!;
            });
          },
        ),
        Checkbox(
          value: third,
          onChanged: (value) {
            setState(() {
              third = value!;
            });
          },
        ),
        Checkbox(
          value: fourth,
          onChanged: (value) {
            setState(() {
              first=false;
              second=false;
              third=false;
              fourth=value!;
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
    dayCont=TextEditingController();
  }
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(
          width: 100,
          child: TextField(
            controller: dayCont,
            keyboardType: TextInputType.number,
          ),
        ),
      ],
    );
  }
}
