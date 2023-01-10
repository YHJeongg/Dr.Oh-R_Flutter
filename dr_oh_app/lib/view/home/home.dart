import 'package:dr_oh_app/components/news_api.dart';
import 'package:dr_oh_app/model/checkup_history_model.dart';
import 'package:dr_oh_app/model/news_model.dart';
import 'package:dr_oh_app/view/home/all_checkup_history.dart';
import 'package:dr_oh_app/view/home/body_info.dart';
import 'package:dr_oh_app/view/home/checkup_history.dart';
import 'package:dr_oh_app/view/home/hospital_visit.dart';
import 'package:dr_oh_app/view/home/medication.dart';
import 'package:dr_oh_app/view/mypage/edit_member_info.dart';
import 'package:dr_oh_app/view/mypage/mypage.dart';
import 'package:dr_oh_app/viewmodel/bottom_nav_controller.dart';
import 'package:dr_oh_app/viewmodel/checkup_history_view_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  //** News API
  List<NewsModel> news = [];
  bool isLoading = true;
  NewsAPI newsAPI = NewsAPI();
  // News API */

  CheckupHistoryViewModel _checkupHistoryViewModel = CheckupHistoryViewModel();

  Future initNews() async {
    news = await newsAPI.getNews();
  }

  @override
  void initState() {
    super.initState();
    initNews().then((_) {
      setState(() {
        isLoading = false;
      });
    });
  }

  // Desc: Calendar Date Picker
  // 검진기록이 있는 날짜 선택, 조회용
  // 2023-01-07, youngjin lee
  Widget _calendar() {
    DateTime selectedDate = DateTime.now();
    return Column(
      children: [
        Column(
          children: [
            SizedBox(
              height: 300,
              child: CalendarDatePicker(
                initialDate: selectedDate,
                firstDate: DateTime(2000),
                lastDate: DateTime.now(),
                onDateChanged: ((value) {
                  selectedDate = value;
                  print(selectedDate);
                }),
              ),
            ),
          ],
        ),
        ElevatedButton(
          onPressed: () {
            Get.to(
              () => CheckupHistory(),
              arguments: selectedDate,
            );
          },
          child: const Text(
            '검진기록 조회',
            style: TextStyle(color: Colors.white),
          ),
        )
      ],
    );
  }

  // Desc: 홈화면 섹션 구분 박스
  // 2023-01-07, youngjin lee
  BoxDecoration _borderBox() {
    return BoxDecoration(
      border: Border.all(
        style: BorderStyle.solid,
        width: 1,
      ),
      borderRadius: BorderRadius.circular(5),
      color: Colors.white,
      boxShadow: [
        BoxShadow(
          color: Colors.grey.withOpacity(0.5),
          spreadRadius: 1,
          blurRadius: 1,
        ),
      ],
    );
  }

  Widget _sizedBox() {
    return const SizedBox(
      height: 20,
    );
  }

  Widget _welcome() {
    return const Padding(
      padding: EdgeInsets.all(15),
      child: Text('님 건강한 하루 되세요'),
    );
  }

  // Desc: 각 박스 타이틀
  // Date: 2023-01-09
  Widget _head(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 22),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
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

  // Desc: 버튼 style
  Widget _button(dynamic path, String title) {
    return ElevatedButton(
      onPressed: () {
        Get.to(path);
      },
      child: Text(
        title,
        style: const TextStyle(color: Colors.white),
      ),
    );
  }

  // Desc: Health 카테고리 기사 헤드라인 (NewsAPI)
  // Date: 2023-01-09
  Widget _news() {
    return Container(
      decoration: _borderBox(),
      height: 180,
      width: 350,
      child: isLoading
          ? Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [CircularProgressIndicator()],
            )
          : Flex(
              direction: Axis.horizontal,
              children: [
                Expanded(
                  child: ListView.builder(
                      shrinkWrap: true,
                      scrollDirection: Axis.horizontal,
                      itemCount: news.length,
                      itemBuilder: (context, index) {
                        return Container(
                          height: 150,
                          width: 180,
                          padding: const EdgeInsets.all(15),
                          child: Card(
                            elevation: 2,
                            child: InkWell(
                              onTap: () {
                                showDialog(
                                  context: context,
                                  builder: ((context) {
                                    return Column(
                                      mainAxisSize: MainAxisSize.min,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        AlertDialog(
                                          scrollable: true,
                                          title: Text(news[index].title),
                                          content:
                                              Text(news[index].description),
                                        ),
                                      ],
                                    );
                                  }),
                                );
                              },
                              child: Column(
                                children: [
                                  Text(
                                    news[index].title,
                                    style: const TextStyle(
                                        fontWeight: FontWeight.bold),
                                    maxLines: 2,
                                  ),
                                  Text(
                                    news[index].description,
                                    maxLines: 5,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      }),
                ),
              ],
            ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: const Text('Home'),
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              Container(
                decoration: _borderBox(),
                width: 350,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    _welcome(),
                    IconButton(
                      onPressed: () {
                        Get.to(EditMemberInfo());
                      },
                      icon: const Icon(
                        Icons.arrow_forward_ios,
                        size: 15,
                      ),
                    ),
                  ],
                ),
              ),
              _sizedBox(),
              Container(
                decoration: _borderBox(),
                height: 40,
                width: 350,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    StreamBuilder(
                      stream: _checkupHistoryViewModel.stream,
                      builder: (context, snapshot) {
                        return Text(
                          '마지막 검진일은 ${_checkupHistoryViewModel.date.toString().substring(0, 10)} 입니다.',
                          style: const TextStyle(fontSize: 14),
                        );
                      },
                    ),
                    TextButton(
                        onPressed: () {
                          Get.to(AllCheckupHistory());
                        },
                        child: const Text('전체기록 보기')),
                  ],
                ),
              ),
              _sizedBox(),
              Container(
                decoration: _borderBox(),
                width: 350,
                child: _calendar(),
              ),
              _sizedBox(),
              _head('신체정보'),
              const SizedBox(height: 3),
              Container(
                decoration: _borderBox(),
                width: 350,
                child: Column(
                  children: [
                    const Text('신체정보가 없습니다'),
                    _button(const BodyInfo(), '입력하러 가기')
                  ],
                ),
              ),
              _sizedBox(),
              _head('이력조회'),
              const SizedBox(height: 3),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(
                    decoration: _borderBox(),
                    width: 165,
                    child: Column(
                      children: [
                        const Text('최근 내원이력'),
                        Row(
                          children: [],
                        ),
                        _button(const HospitalVisit(), '추가')
                      ],
                    ),
                  ),
                  Container(
                    decoration: _borderBox(),
                    width: 165,
                    child: Column(
                      children: [
                        const Text('최근 투약이력'),
                        Row(
                          children: [],
                        ),
                        _button(const Medication(), '추가')
                      ],
                    ),
                  ),
                ],
              ),
              _sizedBox(),
              _head('뉴스'),
              const SizedBox(
                height: 3,
              ),
              _news(),
            ],
          ),
        ),
      ),
    );
  }
}
