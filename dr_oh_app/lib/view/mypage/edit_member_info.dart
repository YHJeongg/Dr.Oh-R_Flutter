import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dr_oh_app/app.dart';
import 'package:dr_oh_app/components/logout_btn.dart';
import 'package:dr_oh_app/components/message_popup.dart';
import 'package:dr_oh_app/model/user.dart';
import 'package:dr_oh_app/repository/localdata/user_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class EditMemberInfo extends StatefulWidget {
  final UserModel user;
  const EditMemberInfo({super.key, required this.user});

  @override
  State<EditMemberInfo> createState() => _EditMemberInfoState();
}

class _EditMemberInfoState extends State<EditMemberInfo> {
  List<String> _dropdownList = ['naver.com', 'gmail.com', 'daum.net', '직접 입력'];
  String _selectedDropdown = 'naver.com';
  RegExp idpwReg = RegExp(r"^[0-9a-z]{8,}$");
  RegExp emailReg = RegExp(r"^[0-9a-z]+$");

  TextEditingController nameController = TextEditingController();
  TextEditingController idController = TextEditingController();
  TextEditingController passwordController1 = TextEditingController();
  TextEditingController passwordController2 = TextEditingController();
  TextEditingController dateController = TextEditingController();
  TextEditingController emailController = TextEditingController();

// Desc: 기존 정보 (Text Field 상의)
// Date: 2023-01-10

  late String id = '';

  late String atSign = '@';

  late bool pwcheck;
  late bool correctpw;
  late bool correctName;
  late bool correctEmail;

// Desc: 회원정보 수정 항목 + 텍스트필드 조인
// Date: 2023-01-09
  Widget _joinText(String txt, dynamic tf) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Text(
          txt,
          style: const TextStyle(fontSize: 18),
        ),
        tf,
      ],
    );
  }

// Desc: 이름 수정 TextField
// Date: 2023-01-10
  Widget _editName(String hint) {
    return SizedBox(
        height: 70,
        width: 270,
        child: TextField(
          controller: nameController,
          textAlign: TextAlign.center,
          decoration: InputDecoration(hintText: hint),
          onChanged: (value) {
            if (value.isEmpty) {
              setState(() {
                correctName = false;
              });
            } else {
              correctName = true;
            }
          },
        ));
  }

// Desc: 아이디 수정 TextField
// Date: 2023-01-10
  Widget _editID(String hint) {
    return SizedBox(
      height: 70,
      width: 250,
      child: TextField(
        controller: idController,
        readOnly: true,
        textAlign: TextAlign.center,
        decoration: InputDecoration(hintText: hint),
      ),
    );
  }

// Desc: 비밀번호 수정 TextField
// Date: 2023-01-10
  Widget _editPW() {
    return SizedBox(
      width: 220,
      height: 70,
      child: TextField(
        controller: passwordController1,
        onChanged: (value) {
          if (idpwReg.hasMatch(value.trim())) {
            setState(() {
              correctpw = true;
            });
          } else {
            setState(() {
              correctpw = false;
            });
          }
        },
        obscureText: true,
        textAlign: TextAlign.center,
      ),
    );
  }

// Desc: 비밀번호 확인 TextField
// Date: 2023-01-10
  Widget _confirmPW() {
    return SizedBox(
      width: 200,
      height: 70,
      child: TextField(
        controller: passwordController2,
        onChanged: (value) {
          if (value == passwordController1.text.trim()) {
            setState(() {
              pwcheck = true;
            });
          } else {
            pwcheck = false;
          }
        },
        obscureText: true,
        textAlign: TextAlign.center,
      ),
    );
  }

// Desc: 생년월일 수정 TextField
// Date: 2023-01-10
  Widget _editBirthday(String hint) {
    return SizedBox(
      height: 70,
      width: 240,
      child: TextField(
        controller: dateController,
        readOnly: true,
        onTap: () {
          _showDatePickerPop();
        },
        textAlign: TextAlign.center,
        decoration: InputDecoration(hintText: hint),
      ),
    );
  }

// Desc: 이메일 수정 TextField
// Date: 2023-01-10
  Widget _editEmail(String hint) {
    return Flexible(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          SizedBox(
            width: 240,
            height: 70,
            child: TextField(
              controller: emailController,
              onChanged: (value) {
                if (emailController.text.trim().isEmail) {
                  setState(() {
                    correctEmail = true;
                  });
                } else {
                  correctEmail = false;
                }
              },
              keyboardType: TextInputType.emailAddress,
              textAlign: TextAlign.center,
              decoration: InputDecoration(hintText: hint),
            ),
          ),
          // Padding(
          //   padding: const EdgeInsets.only(left: 20.0, top: 10, bottom: 10),
          //   child: DropdownButton(
          //     elevation: 0,
          //     value: _selectedDropdown,
          //     items: _dropdownList.map((String item) {
          //       return DropdownMenuItem<String>(
          //         value: item,
          //         child: Text(
          //           item,
          //           style: const TextStyle(fontSize: 14),
          //         ),
          //       );
          //     }).toList(),
          //     onChanged: ((dynamic value) {
          //       setState(() {
          //         _selectedDropdown = value;
          //         if (_selectedDropdown == '직접 입력') {
          //           atSign = '';
          //         } else {
          //           atSign = '@';
          //         }
          //       });
          //       if ((atSign == '' && emailController.text.trim().isEmail) |
          //           (atSign == '@' &&
          //               emailReg.hasMatch(emailController.text.trim()))) {
          //         setState(() {
          //           correctEmail = true;
          //         });
          //       } else {
          //         correctEmail = false;
          //       }
          //     }),
          //   ),
          // ),
        ],
      ),
    );
  }

  // Desc: 생년월일 DatePickerDialog
  // Date: 2023-01-10
  void _showDatePickerPop() async {
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
        dateController.text = dateTime.toString().substring(0, 10);
      });
    });
  }

  _initSharedPreferences() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      id = (prefs.getString('id') ?? "");
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _initSharedPreferences();
    idController.text = widget.user.id.toString();
    dateController.text = widget.user.birthdate.toString();
    emailController.text = widget.user.email.toString();
    nameController.text = widget.user.name.toString();
    correctName = true;
    correctpw = false;
    pwcheck = false;
    correctEmail = true;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text('회원정보 수정'),
          elevation: 1,
          actions: const [LogoutBtn()],
        ),
        body: SingleChildScrollView(
          child: Center(
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
                      StreamBuilder<QuerySnapshot>(
                        stream: FirebaseFirestore.instance
                            .collection('users')
                            .where('id', isEqualTo: id)
                            .snapshots(),
                        builder: ((context, snapshot) {
                          if (!snapshot.hasData) {
                            return const Center(
                              child: CircularProgressIndicator(),
                            );
                          }
                          final documents = snapshot.data!.docs;

                          return documents.map(((e) {
                            final user = UserModel(
                              name: e['name'],
                              id: e['id'],
                              birthdate: e['birthdate'],
                              email: e['email']
                                  .substring(0, e['email'].indexOf('@')),
                            );
                            return Column(
                              children: [
                                _joinText(
                                    '이름', _editName(user.name.toString())),
                                _joinText('아이디', _editID(user.id.toString())),
                                _joinText('새 비밀번호', _editPW()),
                                _joinText('비밀번호 확인', _confirmPW()),
                                _joinText('생년월일',
                                    _editBirthday(user.birthdate.toString())),
                                _joinText(
                                    '이메일', _editEmail(user.email.toString())),
                              ],
                            );
                          })).first;
                        }),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 50.0),
                  child: ElevatedButton(
                      onPressed:
                          correctName && correctpw && pwcheck && correctEmail
                              ? () {
                                  _dialog();
                                }
                              : null,
                      child: const Text('수정')),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  //Desc: Dialog
  //Date: 2023-01-12
  _dialog() {
    showDialog(
      context: Get.context!,
      builder: (context) => MessagePopup(
        title: '시스템',
        message: '회원정보를 수정하시겠습니까?',
        okCallback: () {
          UserRepository usrr = UserRepository();
          usrr.updateUser(nameController.text, passwordController1.text,
              emailController.text, dateController.text);
          Get.to(const App());
        },
        cancelCallback: () {
          Get.back();
        },
      ),
    );
  }
}
