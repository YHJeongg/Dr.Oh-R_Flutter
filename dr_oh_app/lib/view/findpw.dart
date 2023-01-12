import 'package:flutter/material.dart';

class Findpw extends StatefulWidget {
  const Findpw({super.key});

  @override
  State<Findpw> createState() => _FindpwState();
}

class _FindpwState extends State<Findpw> {
  late TextEditingController nameCont;
  late TextEditingController ageCont;
  late TextEditingController idCont;

  @override
  void initState() {
    super.initState();
    nameCont = TextEditingController();
    ageCont = TextEditingController();
    idCont = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          title: const Text(
            '비밀번호 찾기',
          ),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                width: 200,
                height: 70,
                child: TextField(
                  controller: idCont,
                  decoration: const InputDecoration(
                    labelText: "ID",
                  ),
                ),
              ),
              SizedBox(
                width: 200,
                height: 70,
                child: TextField(
                  controller: nameCont,
                  decoration: const InputDecoration(
                    labelText: "이름",
                  ),
                ),
              ),
              SizedBox(
                width: 200,
                height: 70,
                child: TextField(
                  controller: ageCont,
                  decoration: const InputDecoration(
                    labelText: "생년월일",
                  ),
                ),
              ),
              ElevatedButton(
                onPressed: nameCont.text.trim().isNotEmpty &&
                        ageCont.text.isNotEmpty &&
                        idCont.text.isNotEmpty
                    ? () {
                        //--
                      }
                    : null,
                child: const Text('비밀번호 찾기'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
