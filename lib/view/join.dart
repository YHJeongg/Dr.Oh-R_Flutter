import 'package:flutter/material.dart';

class Join extends StatefulWidget {
  const Join({super.key});

  @override
  State<Join> createState() => _JoinState();
}

class _JoinState extends State<Join> {
  RegExp idpwReg=RegExp(r"^[0-9a-z]{8,}$");//영문 소문자, 숫자만으로 8자리 이상
  late TextEditingController idCont;
  late TextEditingController pwCont;
  late TextEditingController pwcheckCont;
  late TextEditingController nameCont;
  late TextEditingController ageCont;
  late bool idcheck;
  late bool pwcheck;
  late bool correctid;
  late bool correctpw;

  @override
  void initState() {
    super.initState();
    idCont=TextEditingController();
    pwCont=TextEditingController();
    pwcheckCont=TextEditingController();
    nameCont=TextEditingController();
    ageCont=TextEditingController();
    idcheck = true;
    pwcheck = false;
    correctid = false;
    correctpw = false;
  }
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            '회원가입',
          ),
        ),
        body: SingleChildScrollView(
          child: Center(
            child: Column(
              children: [
                const SizedBox(
                  height: 50,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        SizedBox(
                          height: 35,
                        ),
                        SizedBox(
                          height: 70,
                          child: Text(
                            'ID:   ',
                            style: TextStyle(
                              fontSize: 25,
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 70,
                          child: Text(
                            '비밀번호:   ',
                            style: TextStyle(
                              fontSize: 25,
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 70,
                          child: Text(
                            '비밀번호 확인:   ',
                            style: TextStyle(
                              fontSize: 25,
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 70,
                          child: Text(
                            '이름:   ',
                            style: TextStyle(
                              fontSize: 25,
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 70,
                          child: Text(
                            '생년월일:   ',
                            style: TextStyle(
                              fontSize: 25,
                            ),
                          ),
                        ),
                      ],
                    ),
                    //---------------------------------------
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                          width: 200,
                          height: 70,
                          child: TextField(
                            controller: idCont,
                            onChanged: (value) {
                              //--
                            },
                            decoration: InputDecoration(
                              labelText: idCont.text.isNotEmpty
                                  ? correctid
                                      ? !idcheck
                                          ? '중복된 ID입니다'
                                          : '사용 가능한 ID입니다.'
                                      : '사용 불가능한 ID입니다.'
                                  : '알파벳 소문자와 숫자를 조합하여 13자 이내',
                              labelStyle: const TextStyle(
                                fontSize: 12,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 200,
                          height: 70,
                          child: TextField(
                            controller: pwCont,
                            decoration: InputDecoration(
                              labelText: pwCont.text.trim().isNotEmpty
                                  ? correctpw
                                      ? '사용 가능한 비밀번호입니다.'
                                      : '사용 불가능한 비밀번호입니다.'
                                  : '알파벳 소문자와 숫자를 조합하여 15자 이내',
                              labelStyle: const TextStyle(
                                fontSize: 12,
                              ),
                            ),
                            obscureText: true,
                            onChanged: (value) {
                              if (value.trim() == pwcheckCont.text.trim()) {
                                setState(() {
                                  pwcheck = true;
                                });
                              } else {
                                setState(() {
                                  pwcheck = false;
                                });
                              }
                              if (idpwReg.hasMatch(value.trim()) &&
                                  value.length < 15) {
                                setState(() {
                                  correctpw = true;
                                });
                              } else {
                                setState(() {
                                  correctpw = false;
                                });
                              }
                            },
                          ),
                        ),
                        SizedBox(
                          width: 200,
                          height: 70,
                          child: TextField(
                            controller: pwcheckCont,
                            obscureText: true,
                            onChanged: (value) {
                              if (pwCont.text.trim() ==
                                  pwcheckCont.text.trim()) {
                                setState(() {
                                  pwcheck = true;
                                });
                              } else {
                                setState(() {
                                  pwcheck = false;
                                });
                              }
                            },
                            decoration: InputDecoration(
                              labelText: pwCont.text.trim().isNotEmpty
                                  ? pwcheck
                                      ? '비밀번호가 일치합니다.'
                                      : '비밀번호가 일치하지 않습니다.'
                                  : '비밀번호를 다시 한 번 입력하세요',
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 200,
                          height: 70,
                          child: TextField(
                            controller: nameCont,
                            decoration:
                                const InputDecoration(labelText: '이름을 입력하세요'),
                          ),
                        ),
                        SizedBox(
                          width: 200,
                          height: 70,
                          child: TextField(
                            controller: ageCont,
                            keyboardType: TextInputType.number,
                            onChanged: (value) {
                              //--
                            },
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 20, 0, 20),
                  child: ElevatedButton(
                    onPressed: nameCont.text.trim().isNotEmpty&&pwcheck&&idcheck&&correctid?
                    () {
                      //--
                      }
                    :null,
                    child: const Text(
                      '회원가입',
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}