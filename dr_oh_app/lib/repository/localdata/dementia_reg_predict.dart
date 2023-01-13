import 'dart:convert';

import 'package:http/http.dart' as http;

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
        'http://192.168.10.213:8080/dementiareg?Age=$age&EDUC=$edu1&SES=$wage1&MMSE=$total&SexCode=$gender1');
    var response = await http.get(url);
    var dataConvertedJSON = json.decode(utf8.decode(response.bodyBytes));
    String resultReg = dataConvertedJSON['result'];
    print("resultReg");
    print(resultReg);
    return resultReg;
  }
}
