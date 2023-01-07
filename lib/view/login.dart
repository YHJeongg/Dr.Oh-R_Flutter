import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  late TextEditingController idCont;
  late TextEditingController pwCont;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    idCont = TextEditingController();
    pwCont = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          '로그인',
        ),
      ),
      body: Center(
        child: Column(
          children: [
            TextField(
              controller: idCont,
              decoration: const InputDecoration(
                labelText: 'ID',
              ),
            ),
            TextField(
              controller: pwCont,
              decoration: const InputDecoration(
                labelText: 'PW',
              ),
            ),
            ElevatedButton.icon(
              onPressed:
                  (idCont.text.trim().isEmpty && pwCont.text.trim().isEmpty)
                      ? null
                      : () {
                        _login();
                      },
              icon: const Icon(
                Icons.login,
              ),
              label: const Text(
                '로그인',
              ),
            ),
          ],
        ),
      ),
    );
  }

  //Functions

  //Desc: 로그인 버튼 눌렀을 때
  //Date: 2023-01-07
  _login() async{

  }
}
