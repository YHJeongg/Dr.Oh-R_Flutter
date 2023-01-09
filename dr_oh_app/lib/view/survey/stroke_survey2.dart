import 'package:flutter/material.dart';

// Date: 2023-01-09, SangwonKim
// Desc: 임시<<
class StrokeSurvey2 extends StatelessWidget {
  StrokeSurvey2({super.key});

  final PageController _pageController = PageController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('뇌졸중 검사'),
          elevation: 1,
        ),
        body: const PageViewWidget2());
  }
}

class PageViewWidget2 extends StatelessWidget {
  const PageViewWidget2({super.key});

  @override
  Widget build(BuildContext context) {
    // 이 자리에 firebase 설문정보 가져오기 <<
    List<String> pageName = ["First Page1", "Second Page2", "Third Page3"];
    int currentPage = 0;

    final PageController controller =
        PageController(initialPage: 0, viewportFraction: 1);
    return PageView.builder(
      controller: controller,
      // onPageChanged: (value) {
      //   currentPage = value;
      // },
      itemCount: pageName.length,
      itemBuilder: (context, index) {
        return Container(
          // color: Colors.blue.withOpacity(index * 0.1),
          child: Center(
            child: Text(
              pageName[index],
              style: TextStyle(fontSize: 50),
            ),
          ),
        );
      },
    );
  }
}

/// This is the stateless widget that the main application instantiates.
class PageViewWidget extends StatefulWidget {
  const PageViewWidget({Key? key}) : super(key: key);

  @override
  _PageViewWidgetState createState() => _PageViewWidgetState();
}

class _PageViewWidgetState extends State<PageViewWidget> {
  int currentPage = 0;
  List<String> pageName = ["First Page", "Second Page", "Third Page"];

  final PageController controller =
      PageController(initialPage: 0, viewportFraction: 1);

  @override
  Widget build(BuildContext context) {
    return PageView.builder(
      controller: controller,
      onPageChanged: (value) {
        setState(() {
          currentPage = value;
        });
      },
      itemCount: pageName.length,
      itemBuilder: (context, index) {
        return Container(
          // color: Colors.blue.withOpacity(index * 0.1),
          child: Center(
            child: Text(
              pageName[index],
              style: TextStyle(fontSize: 50),
            ),
          ),
        );
      },
    );
  }
}
