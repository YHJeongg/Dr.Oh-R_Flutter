import 'package:flutter/material.dart';
import 'package:get/get.dart';

// Date: 2023-01-08, jyh
// 화면구성중
class MyPage extends StatelessWidget {
  const MyPage({super.key});

  Widget _head(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(7),
          color: Colors.blue,
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

  Widget _profile() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: const Color(0xFF99CD89),
        ),
        width: Get.width,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(height: 10),
              _profileContent('이름', '정윤현', 4),
              const SizedBox(height: 10),
              const Divider(thickness: 0.5, height: 1, color: Colors.black),
              const SizedBox(height: 10),
              _profileContent('성별', '남', 4),
              const SizedBox(height: 10),
              const Divider(thickness: 0.5, height: 1, color: Colors.black),
              const SizedBox(height: 10),
              _profileContent('생년월일', '1996-01-26', 5.2),
              const SizedBox(height: 10),
              const Divider(thickness: 0.5, height: 1, color: Colors.black),
              const SizedBox(height: 10),
              _profileContent('이메일', 'test@naver.com', 4.5),
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('MyPage'),
        elevation: 0,
      ),
      body: Column(
        children: [
          const SizedBox(height: 30),
          _head('기본정보'),
          const SizedBox(height: 1),
          _profile(),
          const SizedBox(height: 30),
          _head('추가정보'),
        ],
      ),
    );
  }
}
