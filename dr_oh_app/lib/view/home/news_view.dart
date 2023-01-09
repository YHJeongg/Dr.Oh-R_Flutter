import 'package:dr_oh_app/components/news_provider.dart';
import 'package:dr_oh_app/model/news.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class NewsView extends StatefulWidget {
  const NewsView({super.key});

  @override
  State<NewsView> createState() => _NewsViewState();
}

class _NewsViewState extends State<NewsView> {
  List<News> news = [];
  bool isLoading = true;
  NewsProvider newsProvider = NewsProvider();

  Future initNews() async {
    news = await newsProvider.getNews();
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('뉴스'),
      ),
      body: isLoading
          ? Row(
              children: [CircularProgressIndicator()],
            )
          : GridView.builder(
              scrollDirection: Axis.horizontal,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 1, childAspectRatio: 3.5),
              itemCount: news.length,
              itemBuilder: (context, index) {
                return Row(
                  children: [
                    Card(
                      elevation: 2,
                      child: Container(
                        padding: EdgeInsets.all(20),
                        height: 200,
                        width: 200,
                        child: Column(
                          children: [
                            Text(
                              news[index].title,
                              style: TextStyle(fontWeight: FontWeight.bold),
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
                  ],
                );
              }),
    );
  }
}
