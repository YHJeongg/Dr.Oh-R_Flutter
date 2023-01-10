import 'dart:convert';

import 'package:http/http.dart' as http;

class StrokePredict {
  //Date: 2023-01-10, SangwonKim
  //Desc: 뇌졸중 예측
  Future<String> predict(
    int age,
    double height,
    double weight,
    String highBp,
    String everMarried,
    int workType,
    String residenceType,
    String smoke,
  ) async {
    double bmi = weight / (height * height * 0.01 * 0.01);
    var url = Uri.parse(
        'http://192.168.10.213:8080/stroke?age=$age&bmi=$bmi&highBp=$highBp&everMarried=$everMarried&workType=$workType&residenceType=$residenceType&smoke=$smoke');
    var response = await http.get(url);
    var dataConvertedJSON = json.decode(utf8.decode(response.bodyBytes));
    String result = dataConvertedJSON['result'];

    return result;
  }
}
