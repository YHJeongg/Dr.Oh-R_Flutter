import 'package:flutter/cupertino.dart';

class SurveyDiaViewModel with ChangeNotifier {
  int index=0;
  String fqvalue='';

  void showNext(){
    index++;
    notifyListeners();
  }

  void answerFirst(String value){
    fqvalue=value;
    notifyListeners();
  }
}