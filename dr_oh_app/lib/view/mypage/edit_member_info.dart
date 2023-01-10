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
Widget _joinText(String txt, dynamic type) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceAround,
    children: [
      Text(
        txt,
        style: const TextStyle(fontSize: 17),
      ),
      type,
    ],
  );
}

// Desc: 비밀번호 수정 TextField
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

// Desc: 이름, 아이디 수정 TextField
// Date: 2023-01-10
Widget _editInfo(bool readOnly, bool obscure) {
  return SizedBox(
    width: Get.width / 2.1,
    height: 70,
    child: TextField(
      readOnly: true,
      onChanged: (value) {
        //--
      },
      obscureText: obscure,
    ),
  );
}

class _EditMemberInfoState extends State<EditMemberInfo> {
  List<String> _dropdownList = ['naver.com', 'gmail.com', 'daum.net', '직접 입력'];
  String _selectedDropdown = 'naver.com';
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
            _joinText('이름', _editInfo(true, false)),
            _joinText('아이디', _editInfo(true, false)),
            _joinText('새 비밀번호', _editPW()),
            _joinText('비밀번호 확인', _editPW()),
            _joinText('생년월일', _editBirthday()),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                const Text(
                  '\t\t\t\t이메일',
                  style: TextStyle(fontSize: 17),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: 125,
                      child: TextField(
                        onChanged: (value) {
                          //--
                        },
                      ),
                    ),
                    SizedBox(
                      width: 10,
                      child: TextField(
                        onChanged: (value) {
                          //--
                        },
                        readOnly: true,
                        decoration: const InputDecoration(
                          hintText: '@',
                          hintTextDirection: TextDirection.rtl,
                        ),
                      ),
                    ),
                  ],
                ),
                DropdownButton(
                    elevation: 0,
                    value: _selectedDropdown,
                    items: _dropdownList.map((String item) {
                      return DropdownMenuItem<String>(
                        child: Text('$item'),
                        value: item,
                      );
                    }).toList(),
                    onChanged: ((dynamic value) {
                      setState(() {
                        _selectedDropdown = value;
                      });
                    }))
              ],
            ),
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
      lastDate: DateTime.now().add(const Duration(days: 30)), //마지막일
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
