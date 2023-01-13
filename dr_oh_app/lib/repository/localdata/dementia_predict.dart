import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class DementiaPredict {
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
        'http://localhost:8080/dementia?Age=$age&EDUC=$edu1&SES=$wage1&MMSE=$total&SexCode=$gender1');
    var response = await http.get(url);
    var dataConvertedJSON = json.decode(utf8.decode(response.bodyBytes));
    String result = dataConvertedJSON['result'];
    print('result');
    print(result);
    return result;
  }



}
