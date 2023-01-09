import 'package:flutter/material.dart';

// Date: 2023-01-09, SangwonKim
// Desc: 임시<<
class StrokeSurvey extends StatelessWidget {
  StrokeSurvey({super.key});

  final PageController _pageController = PageController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('뇌졸중 검사'),
          elevation: 1,
        ),
        body: _pages());
  }

// --- Widgets ---
  Widget _pages() {
    return PageView.builder(
      controller: PageController(initialPage: 0), // 시작 페이지
      itemCount: 5,
      itemBuilder: (BuildContext context, int index) {
        return PageView(
          controller: _pageController,
          children: [
            Text('1_Q'),
          ],
        );
      },
    );
  }
}//end