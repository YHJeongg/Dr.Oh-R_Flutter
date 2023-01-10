import 'dart:async';

import 'package:dr_oh_app/model/checkup_history_model.dart';

class CheckupHistoryViewModel {
  late CheckupHistoryModel _checkupHistoryModel;

  // Home화면에서 선택된 (변경된) 날짜를 감지
  StreamController<CheckupHistoryModel> controller =
      StreamController<CheckupHistoryModel>();

  Stream<CheckupHistoryModel> get stream => controller.stream;

  CheckupHistoryViewModel() {
    _checkupHistoryModel = CheckupHistoryModel();
  }

  //**
  // 이 부분에 검진 결과 불러오는 쿼리 작성하고
  // 받아서 View 변경
  // */

  //**
  // 달력에 보여줄 마지막 검진일 가져오기 (없다면 표시 X)
  // */

  DateTime get date => _checkupHistoryModel.date;
  String get name => _checkupHistoryModel.name;
  int get result => _checkupHistoryModel.result;
  void update() {
    controller.sink.add(_checkupHistoryModel);
  }
}
