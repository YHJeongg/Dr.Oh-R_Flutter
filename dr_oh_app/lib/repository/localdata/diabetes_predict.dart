import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dr_oh_app/model/diabetes_message.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

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

        // iphone ip
        'http://localhost:8080/diabetes?age=$age&bmi=$bmi&physact=$physact&genhealth=$genhealth&hdattack=$hdattack&highbp=$highbp&stroke=$stroke&physhealth=$physhealth&diffwalk=$diffwalk');
        // android ip
        // 'http://192.168.10.213:8080/diabetes?age=$age&bmi=$bmi&physact=$physact&genhealth=$genhealth&hdattack=$hdattack&highbp=$highbp&stroke=$stroke&physhealth=$physhealth&diffwalk=$diffwalk');

    var response = await http.get(url);
    var dataConvertedJSON = await json.decode(utf8.decode(response.bodyBytes));
    String result = dataConvertedJSON['result'];

    //답변 항목 초기화
    DiabetesMessage.age = 0;
    DiabetesMessage.height = 0;
    DiabetesMessage.weight = 0;
    DiabetesMessage.physact = 'FALSE';
    DiabetesMessage.diffwalk = 'FALSE';
    DiabetesMessage.hdattack = false;
    DiabetesMessage.highbp = false;
    DiabetesMessage.hdattack = false;
    DiabetesMessage.physhealth.text = '';
    DiabetesMessage.isComplete = false;

    _saveResult(result);

    return result;
  }

  //Desc: 검사 결과 저장
  //Date: 2023-01-11
  _saveResult(String result) async {
    final prefs = await SharedPreferences.getInstance();
    String id = prefs.getString('id')!;
    String date = DateTime.now().toString().substring(0, 10);

    FirebaseFirestore.instance.collection('result').add({
      'result': (double.parse(result)*100).toString(),
      'userid': id,
      'date': date,
      'category': '당뇨병'
    });
  }
}
