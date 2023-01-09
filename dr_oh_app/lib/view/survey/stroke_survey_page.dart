import 'package:dr_oh_app/viewmodel/stroke_survey_list_view_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

class StrokeSurveyPage extends StatefulWidget {
  const StrokeSurveyPage({super.key});

  @override
  State<StrokeSurveyPage> createState() => _StrokeSurveyPageState();
}

class _StrokeSurveyPageState extends State<StrokeSurveyPage> {
  @override
  Widget build(BuildContext context) {
    final vm = Provider.of<StrokeSurveyListViewModel>(context);
    vm.queryStrokeSurveys();

    // final strokeSurveyListViewModel = Get.put(StrokeSurveyListViewModel());

    return Scaffold(
      appBar: AppBar(
        title: const Text('뇌졸중 검사'),
      ),
    );
  }
}
