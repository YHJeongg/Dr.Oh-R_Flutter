import 'dart:convert';

import 'package:http/http.dart' as http;

class DiabetesPredict {
  //Desc: 당뇨병 예측
  //Date: 2023-01-10
  Future<String> predict(
      int age,
      double height,
      double weight,
      String physact,
      String diffwalk,
      int genhealth,
      bool hdattack,
      bool highbp,
      bool stroke,
      int physhealth) async {
    double bmi = weight / (height * height * 0.01 * 0.01);
    var url = Uri.parse(
        'http://192.168.10.213:8080/diabetes?age=$age&bmi=$bmi&physact=$physact&genhealth=$genhealth&hdattack=$hdattack&highbp=$highbp&stroke=$stroke&physhealth=$physhealth&diffwalk=$diffwalk');
    var response = await http.get(url);
    var dataConvertedJSON = json.decode(utf8.decode(response.bodyBytes));
    String result = dataConvertedJSON['result'];

    return result;
  }
}
