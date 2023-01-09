// Date: 2023-01-09, SangwonKim
// Desc: 뇌졸중검사 모델
class StrokeSurveyModel {
  late int seq;
  late String question;

  StrokeSurveyModel({
    required this.seq,
    required this.question,
  });

  factory StrokeSurveyModel.fromJson(Map<String, dynamic> json) {
    return StrokeSurveyModel(
      seq: json['seq'],
      question: json['question'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'seq': seq,
      'question': question,
    };
  }
}
