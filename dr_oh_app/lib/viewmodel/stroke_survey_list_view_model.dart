import 'package:dr_oh_app/repository/localdata/stroke_survey_db.dart';
import 'package:dr_oh_app/viewmodel/stroke_survey_view_model.dart';
import 'package:flutter/cupertino.dart';

class StrokeSurveyListViewModel extends ChangeNotifier {
  List<StrokeSurveyViewModel> strokeSurveys = <StrokeSurveyViewModel>[];

  Future<void> queryStrokeSurveys() async {
    final results = await StrokeSurveyDB().queryJSONData();
    strokeSurveys = results.map((item) => StrokeSurveyViewModel(strokeSurvey: item)).toList();
    notifyListeners();
  }
}
