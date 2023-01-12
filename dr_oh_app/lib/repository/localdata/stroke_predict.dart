import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

// ---------------------------------------------------------------------------------
// Date: 2023-01-10, SangwonKim
// Desc: 뇌졸중 예측 class
class StrokePredict {
  Future<String> predict(
    String sex,
    int age,
    double height,
    double weight,
    int hypertension,
    int heartDisease,
    int everMarried,
    int workType,
    int residenceType,
    int smoke,
  ) async {
    double bmi = weight / (height * height * 0.01 * 0.01);

    var url = Uri.parse(
        // 상원 ip

        // 'http://192.168.10.176:8080/stroke?sex=$sex&age=$age&bmi=$bmi&hypertension=$hypertension&heartDisease=$heartDisease&everMarried=$everMarried&workType=$workType&residenceType=$residenceType&smoke=$smoke');

        // 유승 ip
         'http://192.168.55.245:8080/stroke?sex=$sex&age=$age&bmi=$bmi&hypertension=$hypertension&heartDisease=$heartDisease&everMarried=$everMarried&workType=$workType&residenceType=$residenceType&smoke=$smoke');
    // 주현 ip

    'http://localhost:8080/stroke?sex=$sex&age=$age&bmi=$bmi&hypertension=$hypertension&heartDisease=$heartDisease&everMarried=$everMarried&workType=$workType&residenceType=$residenceType&smoke=$smoke');

    var response = await http.get(url);
    var dataConvertedJSON = json.decode(utf8.decode(response.bodyBytes));
    String result = dataConvertedJSON['result'];
    _saveResult(result); // 검사 결과 저장

    return result;
  }

  // --- Functions ---
  // --------------------------------------------------------------------------------
  //Date: 2023-01-11, SangwonKim
  //Desc: 뇌졸중 검사 결과 저장하기
  _saveResult(String result) async {
    // SharedPreferences를 통해 로그인한 사용자 id 가져오기
    final prefs = await SharedPreferences.getInstance();
    String id = prefs.getString('id')!;

    String date = DateTime.now().toString().substring(0, 10);

    // Stroke 데이타 업데이트하기
    FirebaseFirestore.instance
        .collection('result')
        .add({'result': result, 'userid': id, 'date': date, 'category': '뇌졸중'});
  }
} // End
