import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class DementiaPredictReg {
  Future<String> predict(
    int age,
    int total,
    int edu1,
    int wage1,
    int gender1,
  ) async {
    print(age);
    print(total);
    print(edu1);
    print(wage1);
    print(gender1);

    var url = Uri.parse(
        'http://localhost:8080/dementiareg?Age=$age&EDUC=$edu1&SES=$wage1&MMSE=$total&SexCode=$gender1');
    var response = await http.get(url);
    var dataConvertedJSON = json.decode(utf8.decode(response.bodyBytes));
    String resultReg = dataConvertedJSON['result'];
    print("resultReg");
    print(resultReg);
    _saveResult(resultReg); // 검사 결과 저장
    return resultReg;
  }


  // --- Functions ---
  // --------------------------------------------------------------------------------
  
  //Desc: clao 검사 결과 저장하기
  _saveResult(String result) async {
    
    // SharedPreferences를 통해 로그인한 사용자 id 가져오기
    final prefs = await SharedPreferences.getInstance();
    String id = prefs.getString('id')!;
    String date = DateTime.now().toString().substring(0, 10);

    // Stroke 데이터 업데이트하기
    FirebaseFirestore.instance.collection('result').add({
      'result': (double.parse(result)*100).toString(),
      'userid': id,
      'date': date,
      'category': '치매'
    });
  }

}
