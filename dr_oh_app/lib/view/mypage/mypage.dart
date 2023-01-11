import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dr_oh_app/model/user.dart';
import 'package:dr_oh_app/view/mypage/chart_diabetes.dart';
import 'package:dr_oh_app/view/mypage/edit_member_info.dart';
import 'package:dr_oh_app/view/mypage/sign_out.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

// Date: 2023-01-08, jyh
// 화면구성중
class MyPage extends StatefulWidget {
  const MyPage({super.key});

  @override
  State<MyPage> createState() => _MyPageState();
}

class _MyPageState extends State<MyPage> {
  String id = '';
  Widget _head(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(7),
          color: const Color(0xFF99CD89),
        ),
        width: Get.width,
        height: 30,
        child: Padding(
          padding: const EdgeInsets.only(left: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _profile(String name, String gender, String birthdate, String email) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30),
      child: Container(
        decoration: BoxDecoration(
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
        width: Get.width,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  SizedBox(
                    height: 35,
                    child: TextButton(
                      onPressed: () {
                        Get.to(() => const EditMemberInfo());
                      },
                      child: const Text(
                        '수정',
                        style: TextStyle(
                          fontSize: 14,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const Divider(thickness: 0.5, height: 1, color: Colors.grey),
              const SizedBox(height: 10),
              _profileContent('이름', name, 4),
              const SizedBox(height: 10),
              const Divider(thickness: 0.5, height: 1, color: Colors.grey),
              const SizedBox(height: 10),
              _profileContent('성별', gender, 4),
              const SizedBox(height: 10),
              const Divider(thickness: 0.5, height: 1, color: Colors.grey),
              const SizedBox(height: 10),
              _profileContent('생년월일', birthdate, 5.2),
              const SizedBox(height: 10),
              const Divider(thickness: 0.5, height: 1, color: Colors.grey),
              const SizedBox(height: 10),
              _profileContent('이메일', email, 4.5),
              const SizedBox(height: 10),
            ],
          ),
        ),
      ),
    );
  }

  Widget _profileContent(String title, String content, double width) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          title,
          style: const TextStyle(
            color: Colors.black,
            fontSize: 14,
          ),
        ),
        SizedBox(width: Get.width / width),
        Text(
          content,
          style: const TextStyle(
            color: Colors.black,
            fontSize: 14,
          ),
        ),
      ],
    );
  }

  Widget _userInfo() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 27),
      child: Column(
        children: <Widget>[
          Card(
            elevation: 4,
            child: Column(
              children: <Widget>[
                _btnContentActions(
                  "즐겨찾기한 병원",
                  const Icon(
                    Icons.local_hospital,
                    color: Color(0xFF99CD89),
                  ),
                  const SignOut(),
                ),
                const Divider(),
                _btnContentActions(
                  "내가 쓴 글",
                  const Icon(
                    Icons.payment,
                    color: Color(0xFF99CD89),
                  ),
                  const SignOut(),
                ),
                const Divider(),
                _btnContentActions(
                  "회원 탈퇴",
                  const Icon(
                    Icons.info_outline,
                    color: Color(0xFF99CD89),
                  ),
                  const SignOut(),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _additionalInfo() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 27),
      child: Column(
        children: <Widget>[
          Card(
            elevation: 4,
            child: Column(
              children: <Widget>[
                _btnContentActions(
                  "당뇨병 그래프",
                  const Icon(
                    Icons.bar_chart,
                    color: Color(0xFF99CD89),
                  ),
                  const ChartDiabetes(),
                ),
                const Divider(),
                _btnContentActions(
                  "뇌졸중 그래프",
                  const Icon(
                    Icons.show_chart,
                    color: Color(0xFF99CD89),
                  ),
                  const SignOut(),
                ),
                const Divider(),
                _btnContentActions(
                  "치매 그래프",
                  const Icon(
                    Icons.area_chart,
                    color: Color(0xFF99CD89),
                  ),
                  const SignOut(),
                ),
                const Divider(),
                _btnContentActions(
                  "BMI 그래프",
                  const Icon(
                    Icons.pie_chart,
                    color: Color(0xFF99CD89),
                  ),
                  const SignOut(),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _btnContentActions(String text, Icon icon, dynamic? path) {
    return ListTile(
      leading: icon == null ? const Icon(Icons.error) : icon,
      title: Text(text),
      trailing: const Icon(
        Icons.arrow_forward_ios,
        size: 15,
        color: Colors.grey,
      ),
      onTap: () {
        Get.to(path);
      },
    );
  }

  // Desc: 회원정보 가져오기
  Widget _getMemberInfo(DocumentSnapshot doc) {
    final user = UserModel(
      name: doc['name'],
      gender: doc['gender'],
      birthdate: doc['birthdate'],
      email: doc['email'],
    );
    return _profile(user.name.toString(), user.gender.toString(),
        user.birthdate.toString(), user.email.toString());
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
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('마이 페이지'),
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 30),
            _head('기본정보'),
            const SizedBox(height: 3),
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

                return documents.map((e) => _getMemberInfo(e)).first;
              }),
            ),
            const SizedBox(height: 30),
            _head('추가정보'),
            _additionalInfo(),
            const SizedBox(height: 30),
            _head('사용자정보'),
            _userInfo(),
            const SizedBox(height: 30),
            const Text(
              "Dr. Oh",
              style: TextStyle(
                  color: Color(0xFF99CD89),
                  fontSize: 24,
                  fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 5),
            const Text(
              "Version 0.0.1",
              style: TextStyle(
                fontSize: 18,
                color: Colors.grey,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
