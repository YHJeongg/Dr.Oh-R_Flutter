import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';

class EditMemberInfo extends StatefulWidget {
  const EditMemberInfo({super.key});

  @override
  State<EditMemberInfo> createState() => _EditMemberInfoState();
}

Widget _joinText(String txt) {
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
        children: [
          SizedBox(
            width: Get.width / 2.1,
            height: 70,
            child: TextField(
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

class _EditMemberInfoState extends State<EditMemberInfo> {
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
            _joinText('비밀번호'),
            _joinText('생년월일'),
            _joinText('이메일'),
          ],
        ),
      ),
    );
  }
}
