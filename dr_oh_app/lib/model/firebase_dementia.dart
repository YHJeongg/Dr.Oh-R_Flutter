class Dementia{
  final int seq;
  final String question;

Dementia({
  required this.seq,
  required this.question
});

Dementia.fromMap(Map<String, dynamic> res)
    : seq = res['seq'],
      question = res['question'];


Map<String, Object?> toMap(){
  return {'seq' : seq, 'question': question};
}


}