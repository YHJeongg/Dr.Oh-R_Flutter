import 'package:flutter/material.dart';

class SignOut extends StatefulWidget {
  const SignOut({super.key});

  @override
  State<SignOut> createState() => _SignOutState();
}

class _SignOutState extends State<SignOut> {
  bool isChecked = false;
  Color getColor(Set<MaterialState> states) {
    const Set<MaterialState> interactiveStates = <MaterialState>{
      MaterialState.pressed,
      MaterialState.hovered,
      MaterialState.focused,
    };
    if (states.any(interactiveStates.contains)) {
      return Colors.blue;
    }
    return Colors.red;
  }

  Widget checkBox() {
    return Checkbox(
      checkColor: Colors.white,
      fillColor: MaterialStateProperty.resolveWith(getColor),
      value: isChecked,
      onChanged: (bool? value) {
        setState(() {
          isChecked = value!;
        });
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('회원 탈퇴'),
        elevation: 0,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Padding(
              padding: EdgeInsets.all(50.0),
              child: Text(
                "Dr. Oh",
                style: TextStyle(
                    color: Color(0xFF99CD89),
                    fontSize: 50,
                    fontWeight: FontWeight.bold),
              ),
            ),
            Container(
              width: 300,
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                border: Border.all(
                  style: BorderStyle.solid,
                  width: 1,
                ),
                borderRadius: BorderRadius.circular(5),
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 1,
                    blurRadius: 1,
                  ),
                ],
              ),
              child: Column(
                children: [
                  const Text(
                    '서비스 탈퇴 전에 확인하세요\n계정을 삭제하면 진단기록을 포함한 모든 Dr.Oh 설정이 초기화됩니다.',
                    textAlign: TextAlign.center,
                  ),
                  const Text(
                    '또한 즐겨찾기와 내가 쓴 글을 확인할 수 없습니다.\n삭제하시겠습니까?',
                    textAlign: TextAlign.center,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      checkBox(),
                      Text('계정을 삭제합니다'),
                    ],
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(50.0),
              child: ElevatedButton(
                  onPressed: () {
                    if (isChecked == false) {
                    } else {
                      _deleteDialog(context);
                    }
                  },
                  child: const Text('확인')),
            )
          ],
        ),
      ),
    );
  }

  _deleteDialog(BuildContext context) {
    showDialog(
        context: context,
        builder: ((context) {
          return AlertDialog(
            title: const Text('회원 탈퇴'),
            content: SizedBox(
              height: 200,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('탈퇴를 위해 비밀번호를 입력해주세요'),
                  TextField(
                      obscureText: true,
                      decoration: InputDecoration(
                        hintText: '비밀번호 입력',
                      )),
                  ElevatedButton(
                    onPressed: () {},
                    child: Text(
                      '삭제',
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red,
                    ),
                  )
                ],
              ),
            ),
          );
        }));
  }
}
