import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

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
  late TextEditingController ageCont;
  late bool idcheck;
  late bool pwcheck;
  late bool correctid;
  late bool correctpw;

  @override
  void initState() {
    super.initState();
    idCont = TextEditingController();
    pwCont = TextEditingController();
    pwcheckCont = TextEditingController();
    nameCont = TextEditingController();
    ageCont = TextEditingController();
    idcheck = true;
    pwcheck = false;
    correctid = false;
    correctpw = false;
  }

  Widget _joinText() {
    return Column(
      children: const [
        Text('아이디'),
        Text('이름'),
        Text('비밀번호'),
        Text('비밀번호 확인'),
        Text('이메일'),
        Text('출생연도'),
        Text('성별'),
      ],
    );
  }

  Widget _joinTextField() {
    return Column(
      children: [],
    );
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
          elevation: 0,
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
                      children: [
                        _joinText(),
                      ],
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 20, 0, 20),
                  child: ElevatedButton(
                    onPressed: nameCont.text.trim().isNotEmpty &&
                            pwcheck &&
                            idcheck &&
                            correctid
                        ? () {
                            //--
                          }
                        : null,
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
