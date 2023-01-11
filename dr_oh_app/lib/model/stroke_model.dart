// Date: 2023-01-09, SangwonKim
// Desc: 뇌졸중검사 Model
class StrokeModel {
  final int seq;
  final String question;

  StrokeModel({
    required this.seq,
    required this.question,
  });

  // factory StrokeModel.fromJson(Map<String, dynamic> json) {
  //   return StrokeModel(
  //     seq: json['seq'],
  //     question: json['question'],
  //   );
  // }

  // Map<String, dynamic> toMap() {
  //   return {
  //     'seq': seq,
  //     'question': question,
  //   };
  // }

}
