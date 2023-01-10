import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';

class EditMemberInfo extends StatefulWidget {
  const EditMemberInfo({super.key});

  @override
  State<EditMemberInfo> createState() => _EditMemberInfoState();
}

// Desc: 회원정보 수정 항목
// Date: 2023-01-09
Widget _joinText(String txt, dynamic obscure) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
    children: [
      Column(
        children: [
          Text(
            txt,
            style: const TextStyle(fontSize: 17),
          ),
        ],
      ),
      Column(
        children: [obscure],
      ),
    ],
  );
}

// Desc: 회원정보 수정 TextField
// Date: 2023-01-10
Widget _editInfo() {
  return SizedBox(
    width: Get.width / 2.1,
    height: 70,
    child: TextField(
      onChanged: (value) {
        //--
      },
    ),
  );
}

// Desc: 회원정보 수정 TextField
// Date: 2023-01-10
Widget _editPW() {
  return SizedBox(
    width: Get.width / 2.1,
    height: 70,
    child: TextField(
      onChanged: (value) {
        //--
      },
      obscureText: true,
    ),
  );
}

class _EditMemberInfoState extends State<EditMemberInfo> {
  TextEditingController dateController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('회원정보 수정'),
        elevation: 0,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _joinText('새 비밀번호', _editPW()),
            _joinText('비밀번호 확인', _editPW()),
            _joinText('생년월일', _editBirthday()),
            _joinText('이메일', _editInfo()),
            ElevatedButton(onPressed: () {}, child: const Text('수정'))
          ],
        ),
      ),
    );
  }

  // Desc: 생년월일 DatePickerDialog
  // Date: 2023-01-10
  void _showDatePickerPop() {
    Future<DateTime?> selectedDate = showDatePicker(
      context: context,
      initialDate: DateTime.now(), //초기값
      firstDate: DateTime(2000), //시작일
      lastDate: DateTime.now().add(Duration(days: 30)), //마지막일
      builder: (BuildContext context, Widget? child) {
        return Theme(
          data: ThemeData.dark(), //다크 테마
          child: child!,
        );
      },
    );
    selectedDate.then(
        (value) => dateController.text = value.toString().substring(0, 10));
  }

  // Desc: 생년월일 수정 TextField
  // Date: 2023-01-10
  Widget _editBirthday() {
    return SizedBox(
      width: Get.width / 2.1,
      height: 70,
      child: TextField(
        controller: dateController,
        onTap: () {
          _showDatePickerPop();
        },
      ),
    );
  }
}
