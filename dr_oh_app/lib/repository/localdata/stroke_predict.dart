import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class StrokePredict {
  //Date: 2023-01-10, SangwonKim
  //Desc: 뇌졸중 예측
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
    print(sex);
    print(age);
    print(height);
    print(weight);
    print(heartDisease);
    print(everMarried);
    print(workType);
    print(residenceType);
    print(smoke);

    var url = Uri.parse(
        // 상원 ip
        'http://192.168.35.33:8080/stroke?sex=$sex&age=$age&bmi=$bmi&hypertension=$hypertension&heartDisease=$heartDisease&everMarried=$everMarried&workType=$workType&residenceType=$residenceType&smoke=$smoke');
        // 유승 ip
        // 'http://192.168.35.37:8080/stroke?sex=$sex&age=$age&bmi=$bmi&hypertension=$hypertension&heartDisease=$heartDisease&everMarried=$everMarried&workType=$workType&residenceType=$residenceType&smoke=$smoke');
        // 주현 ip
        // 'http://192.168.10.92:8080/stroke?sex=$sex&age=$age&bmi=$bmi&hypertension=$hypertension&heartDisease=$heartDisease&everMarried=$everMarried&workType=$workType&residenceType=$residenceType&smoke=$smoke');

    var response = await http.get(url);
    var dataConvertedJSON = json.decode(utf8.decode(response.bodyBytes));
    String result = dataConvertedJSON['result'];

    _saveResult(result);
    
    return result;
  }

  //Desc: 검사 결과 저장
  //Date: 2023-01-11
  _saveResult(String result) async {
    final prefs = await SharedPreferences.getInstance();
    String id = prefs.getString('id')!;

    var doc1=await FirebaseFirestore.instance.collection('users').where('id',isEqualTo: id).get();
    var doc2=doc1.docs.first.id;

    FirebaseFirestore.instance
        .collection('users')
        .doc(doc2)
        .set({'Stroke': result});
  }
}
