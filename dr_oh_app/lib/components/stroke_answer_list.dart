import 'package:flutter/material.dart';

class StrokeAnswerList {
  List<Widget> dAnserList = const [
    YesNoAnswer(),
    YesNoAnswer(),
    WorkTypeAnswer(),
    ResidenceTypeAnswer(),
    YesNoAnswer(),
  ];
}

// yes,no 문제
class YesNoAnswer extends StatefulWidget {
  const YesNoAnswer({super.key});

  @override
  State<YesNoAnswer> createState() => _YesNoAnswerState();
}

class _YesNoAnswerState extends State<YesNoAnswer> {
  late bool ynvalue;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    ynvalue = false;
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text('예'),
        Radio(
          value: "1",
          groupValue: ynvalue,
          onChanged: (ynvalue) {
            setState(() {
              ynvalue = ynvalue;
            });
          },
        ),
        const Text('아니오'),
        Radio(
          value: "0",
          groupValue: ynvalue,
          onChanged: (ynvalue) {
            setState(() {
              ynvalue = ynvalue!;
            });
          },
        ),
      ],
    );
  }
}

// 직업타입 답변
class WorkTypeAnswer extends StatefulWidget {
  const WorkTypeAnswer({super.key});

  @override
  State<WorkTypeAnswer> createState() => _WorkTypeAnswerState();
}

class _WorkTypeAnswerState extends State<WorkTypeAnswer> {
  late String value;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    value = '';
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('무직'),
            Radio(
              value: "0",
              groupValue: value,
              onChanged: (value) {
                setState(() {
                  value = value!;
                });
              },
            ),
            const Text('청소년'),
            Radio(
              value: "1",
              groupValue: value,
              onChanged: (value) {
                setState(() {
                  value = value!;
                });
              },
            ),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('공무원'),
            Radio(
              value: "2",
              groupValue: value,
              onChanged: (value) {
                setState(() {
                  value = value!;
                });
              },
            ),
            const Text('자영업'),
            Radio(
              value: "3",
              groupValue: value,
              onChanged: (value) {
                setState(() {
                  value = value!;
                });
              },
            ),
            const Text('사기업'),
            Radio(
              value: "4",
              groupValue: value,
              onChanged: (value) {
                setState(() {
                  value = value!;
                });
              },
            ),
          ],
        ),
      ],
    );
  }
}

// 거주지역타입 답변
class ResidenceTypeAnswer extends StatefulWidget {
  const ResidenceTypeAnswer({super.key});

  @override
  State<ResidenceTypeAnswer> createState() => _ResidenceTypeAnswerState();
}

class _ResidenceTypeAnswerState extends State<ResidenceTypeAnswer> {
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
              first = false;
              second = false;
              third = false;
              fourth = value!;
            });
          },
        ),
      ],
    );
  }
}

class SliderAnswer extends StatefulWidget {
  const SliderAnswer({super.key});

  @override
  State<SliderAnswer> createState() => _SliderAnswerState();
}

class _SliderAnswerState extends State<SliderAnswer> {
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

class CheckboxAnswer extends StatefulWidget {
  const CheckboxAnswer({super.key});

  @override
  State<CheckboxAnswer> createState() => _CheckboxAnswerState();
}

class _CheckboxAnswerState extends State<CheckboxAnswer> {
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
              first = false;
              second = false;
              third = false;
              fourth = value!;
            });
          },
        ),
      ],
    );
  }
}
