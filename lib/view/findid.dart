import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Findid extends StatefulWidget {
  const Findid({super.key});

  @override
  State<Findid> createState() => _FindidState();
}

class _FindidState extends State<Findid> {
  late TextEditingController nameCont;
  late TextEditingController ageCont;

  @override
  void initState() {
    super.initState();
    nameCont = TextEditingController();
    ageCont = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: SingleChildScrollView(
        child: Scaffold(
          appBar: AppBar(
            title: const Text(
              'ID 찾기',
            ),
          ),
          body: Center(
            child: Column(
              children: [
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
                  onPressed:
                      nameCont.text.trim().isNotEmpty && ageCont.text.isNotEmpty
                          ? () {
                              //--
                            }
                          : null,
                  child: const Text('ID 찾기'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
