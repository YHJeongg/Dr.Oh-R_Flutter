import 'package:flutter/material.dart';
import 'package:get/get.dart';

// Date: 2023-01-09, jyh
// Join View 완성
class Join extends StatefulWidget {
  const Join({super.key});

  @override
  State<Join> createState() => _JoinState();
}

class _JoinState extends State<Join> {
  RegExp idpwReg = RegExp(r"^[0-9a-z]{8,}$"); //영문 소문자, 숫자만으로 8자리 이상 정규식
  late TextEditingController idCont;
  late TextEditingController pwCont;
  late TextEditingController pwcheckCont;
  late TextEditingController nameCont;
  late TextEditingController dateCont;

  late bool _checkBoxValue1;
  late bool _checkBoxValue2;

  @override
  void initState() {
    super.initState();
    idCont = TextEditingController();
    pwCont = TextEditingController();
    pwcheckCont = TextEditingController();
    nameCont = TextEditingController();
    dateCont = TextEditingController();
    _checkBoxValue1 = true;
    _checkBoxValue2 = false;
  }

  Widget _joinText(String txt) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          children: [
            Text(
              txt,
              style: const TextStyle(fontSize: 17),
            ),
          ],
        ),
        const SizedBox(width: 20),
        Column(
          children: [
            SizedBox(
              width: Get.width / 2.1,
              height: 70,
              child: TextField(
                controller: idCont,
                onChanged: (value) {
                  //--
                },
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _joinBtn() {
    return SizedBox(
      width: Get.width,
      child: ElevatedButton(
        onPressed: () {},
        child: const Text('회원가입'),
      ),
    );
  }

  Widget _genderCheckBox() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          children: const [
            Text(
              '성별',
              style: TextStyle(fontSize: 17),
            ),
          ],
        ),
        const SizedBox(width: 20),
        Column(
          children: [
            Row(
              children: [
                const Text('남자 : '),
                Checkbox(
                  value: _checkBoxValue1,
                  onChanged: (value) {
                    setState(() {
                      _checkBoxValue1 = value!;
                      _checkBoxValue2 = !value;
                    });
                  },
                ),
                const SizedBox(width: 35),
                const Text('여자 : '),
                Checkbox(
                  value: _checkBoxValue2,
                  onChanged: (value) {
                    setState(() {
                      _checkBoxValue2 = value!;
                      _checkBoxValue1 = !value;
                    });
                  },
                ),
              ],
            ),
          ],
        ),
      ],
    );
  }

  Widget _dateText() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          children: const [
            Text(
              '출생연도',
              style: TextStyle(fontSize: 17),
            ),
          ],
        ),
        const SizedBox(width: 20),
        Column(
          children: [
            SizedBox(
              width: Get.width / 2.1,
              height: 70,
              child: TextField(
                controller: dateCont,
                readOnly: true,
                onTap: () => showDatePickerPop(),
              ),
            ),
          ],
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        // appBar: AppBar(
        //   title: const Text(
        //     '회원가입',
        //   ),
        //   elevation: 0,
        // ),
        body: SingleChildScrollView(
          child: SafeArea(
            child: Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 50),
                child: Column(
                  children: [
                    const SizedBox(height: 30),
                    const Text(
                      "Dr. Oh",
                      style: TextStyle(
                          color: Color(0xFF99CD89),
                          fontSize: 50,
                          fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 30),
                    _joinText('아이디'),
                    _joinText('이름'),
                    _joinText('비밀번호'),
                    _joinText('비밀번호 확인'),
                    _joinText('이메일'),
                    _dateText(),
                    const SizedBox(height: 10),
                    _genderCheckBox(),
                    const SizedBox(height: 50),
                    _joinBtn(),
                    const SizedBox(height: 70),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const Text(
                          '계정이 있으신가요?',
                        ),
                        TextButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          child: const Text(
                            '로그인하기',
                            style: TextStyle(
                              color: Colors.blue,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  // DatePicker 띄우기
  void showDatePickerPop() {
    Future<DateTime?> selectedDate = showDatePicker(
      context: context,
      initialDate: DateTime(2022), //초기값
      firstDate: DateTime(1950), //시작일
      lastDate: DateTime(2023), //마지막일
      builder: (BuildContext context, Widget? child) {
        return Theme(
          data: ThemeData.dark(), //다크 테마
          child: child!,
        );
      },
    );

    selectedDate.then((dateTime) {
      setState(() {
        dateCont.text = dateTime.toString().substring(0, 10);
      });
    });
  }
}
