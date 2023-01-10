import '../model/survey_stroke_model.dart';

// Date: 2023-01-09, SangwonKim
// Desc: 뇌졸중검사 뷰모델
class StrokeSurveyViewModel {
  late SurveyStrokeModel strokeSurvey;

  StrokeSurveyViewModel({required this.strokeSurvey});

  int get seq {
    return strokeSurvey.seq;
  }

  String get question {
    return strokeSurvey.question;
  }
}
