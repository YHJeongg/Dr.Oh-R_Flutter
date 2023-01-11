import 'dart:convert';

import 'package:http/http.dart' as http;

class StrokePredict {
  //Date: 2023-01-10, SangwonKim
  //Desc: 뇌졸중 예측
  Future<String> predict(
    String sex,
    int age,
    double height,
    double weight,
    int highBp,
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
        'http://192.168.35.37:8080/stroke?sex=$sex&age=$age&bmi=$bmi&highBp=$highBp&heartDisease=$heartDisease&everMarried=$everMarried&workType=$workType&residenceType=$residenceType&smoke=$smoke');
        // 유승 ip
        // 'http://192.168.35.37:8080/stroke?sex=$sex&age=$age&bmi=$bmi&highBp=$highBp&heartDisease=$heartDisease&everMarried=$everMarried&workType=$workType&residenceType=$residenceType&smoke=$smoke');

    var response = await http.get(url);
    var dataConvertedJSON = json.decode(utf8.decode(response.bodyBytes));
    String result = dataConvertedJSON['result'];

    return result;
  }
}
