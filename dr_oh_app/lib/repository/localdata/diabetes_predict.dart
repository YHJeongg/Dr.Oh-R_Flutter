import 'dart:convert';

import 'package:dr_oh_app/model/diabetes_message.dart';
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
      double genhealth,
      bool hdattack,
      bool highbp,
      bool stroke,
      int physhealth) async {
    double bmi = weight / (height * height * 0.01 * 0.01);
    var url = Uri.parse(

        // 상원 ip
        // 'http://192.168.35.37:8080/diabetes?age=$age&bmi=$bmi&physact=$physact&genhealth=$genhealth&hdattack=$hdattack&highbp=$highbp&stroke=$stroke&physhealth=$physhealth&diffwalk=$diffwalk');
        // 유승 ip
        'http://192.168.10.213:8080/diabetes?age=$age&bmi=$bmi&physact=$physact&genhealth=$genhealth&hdattack=$hdattack&highbp=$highbp&stroke=$stroke&physhealth=$physhealth&diffwalk=$diffwalk');

    var response = await http.get(url);
    var dataConvertedJSON = await json.decode(utf8.decode(response.bodyBytes));
    String result = dataConvertedJSON['result'];

    DiabetesMessage.age = 0;
    DiabetesMessage.height = 0;
    DiabetesMessage.weight = 0;
    DiabetesMessage.physact = '';
    DiabetesMessage.diffwalk = '';
    DiabetesMessage.hdattack = false;
    DiabetesMessage.highbp = false;
    DiabetesMessage.hdattack = false;

    return result;
  }
}
