import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dr_oh_app/model/user.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';

class EditMemberInfo extends StatefulWidget {
  const EditMemberInfo({super.key});

  @override
  State<EditMemberInfo> createState() => _EditMemberInfoState();
}

class _EditMemberInfoState extends State<EditMemberInfo> {
  List<String> _dropdownList = ['naver.com', 'gmail.com', 'daum.net', '직접 입력'];
  String _selectedDropdown = 'naver.com';

  TextEditingController nameController = TextEditingController();
  TextEditingController idController = TextEditingController();
  TextEditingController passwordController1 = TextEditingController();
  TextEditingController passwordController2 = TextEditingController();
  TextEditingController dateController = TextEditingController();
  TextEditingController emailController = TextEditingController();

  // Desc: 기존 정보 (Text Field 상의)
  // Date: 2023-01-10
  late String name;
  late String id;
  late String password;
  late String birthdate;
  late String email;

  // Desc: 회원정보 수정 항목
// Date: 2023-01-09
  Widget _joinText(String txt, dynamic type) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Text(
          txt,
          style: const TextStyle(fontSize: 18),
        ),
        type,
      ],
    );
  }

// Desc: 이름, 아이디 수정 TextField
// Date: 2023-01-10
  Widget _editName(bool readOnly) {
    return SizedBox(
      width: Get.width / 1.45,
      height: 70,
      child: TextField(
        controller: nameController,
        readOnly: true,
        onChanged: (value) {
          //--
        },
        textAlign: TextAlign.center,
      ),
    );
  }

  Widget _editID(bool readOnly) {
    return SizedBox(
      width: Get.width / 1.6,
      height: 70,
      child: TextField(
        controller: idController,
        readOnly: true,
        onChanged: (value) {
          //--
        },
        textAlign: TextAlign.center,
      ),
    );
  }

// Desc: 비밀번호 수정 TextField
// Date: 2023-01-10
  Widget _editPW() {
    return SizedBox(
      width: Get.width / 1.8,
      height: 70,
      child: TextField(
        controller: passwordController1,
        onChanged: (value) {
          //--
        },
        obscureText: true,
        textAlign: TextAlign.center,
      ),
    );
  }

  Widget _confirmPW() {
    return SizedBox(
      width: Get.width / 1.95,
      height: 70,
      child: TextField(
        controller: passwordController2,
        onChanged: (value) {
          //--
        },
        obscureText: true,
        textAlign: TextAlign.center,
      ),
    );
  }

  // Desc: 생년월일 수정 TextField
  // Date: 2023-01-10
  Widget _editBirthday() {
    return SizedBox(
      width: Get.width / 1.65,
      height: 70,
      child: TextField(
        controller: dateController,
        onTap: () {
          _showDatePickerPop();
        },
        textAlign: TextAlign.center,
      ),
    );
  }

  Widget _editEmail() {
    return Flexible(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          SizedBox(
            width: Get.width / 2.9,
            height: 70,
            child: TextField(
              onChanged: (value) {
                //--
              },
              textAlign: TextAlign.center,
            ),
          ),
          SizedBox(
            height: 70,
            width: 10,
            child: TextField(
              controller: emailController,
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
          Padding(
            padding: const EdgeInsets.only(left: 20.0, top: 10, bottom: 10),
            child: DropdownButton(
                elevation: 0,
                value: _selectedDropdown,
                items: _dropdownList.map((String item) {
                  return DropdownMenuItem<String>(
                    value: item,
                    child: Text(
                      item,
                      style: TextStyle(fontSize: 14),
                    ),
                  );
                }).toList(),
                onChanged: ((dynamic value) {
                  setState(() {
                    _selectedDropdown = value;
                    if (_selectedDropdown == '직접 입력') {
                      emailController.text = ' ';
                    } else {
                      emailController.text = '';
                    }
                  });
                })),
          )
        ],
      ),
    );
  }

  // void _getMemberInfo(DocumentSnapshot doc) {
  //   final user = UserModel(
  //     name: doc['name'],
  //     id: doc['id'],
  //     birthdate: doc['birthdate'],
  //     email: doc['email'],
  //   );

  //   name = user.name.toString();
  //   id = user.id.toString();
  //   birthdate = user.birthdate.toString();
  //   email = user.email.toString();
  // }

  // DocumentSnapshot? _streamBuilder() {
  //   StreamBuilder<QuerySnapshot>(
  //     stream: FirebaseFirestore.instance
  //         .collection('users')
  //         .where('id', isEqualTo: 'qwer')
  //         .snapshots(),
  //     builder: ((BuildContext? context, dynamic snapshot) {
  //       try {
  //         if (!snapshot.hasData) {
  //           return const Center(
  //             child: CircularProgressIndicator(),
  //           );
  //         }
  //         final documents = snapshot.data!.docs;
  //         return documents.map((e) => _getMemberInfo(e));
  //       } catch (e) {
  //         return snapshot;
  //       }
  //     }),
  //   );
  // }

  // @override
  // void initState() {
  //   // TODO: implement initState
  //   super.initState();
  //   dynamic doc = _streamBuilder();
  //   _getMemberInfo(doc);
  //   nameController.text = name;
  // }

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
            Container(
              width: 350,
              padding: const EdgeInsets.all(20),
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
                  _joinText('이름', _editName(true)),
                  _joinText('아이디', _editID(true)),
                  _joinText('새 비밀번호', _editPW()),
                  _joinText('비밀번호 확인', _confirmPW()),
                  _joinText('생년월일', _editBirthday()),
                  _joinText('이메일', _editEmail()),
                ],
              ),
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
}
