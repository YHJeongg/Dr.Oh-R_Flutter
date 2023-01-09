import 'package:dr_oh_app/model/stroke_survey_model.dart';

// Date: 2023-01-09, SangwonKim
// Desc: 뇌졸중검사 뷰모델
class StrokeSurveyViewModel {
  late StrokeSurveyModel strokeSurvey;

  StrokeSurveyViewModel({required this.strokeSurvey});

  int get seq {
    return strokeSurvey.seq;
  }

  String get question {
    return strokeSurvey.question;
  }
}
