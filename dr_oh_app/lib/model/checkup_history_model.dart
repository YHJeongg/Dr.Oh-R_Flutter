class CheckupHistoryModel {
  DateTime _checkupHistory = DateTime.now();
  String _checkupName = '당뇨';
  int _checkupResult = 0;

  DateTime get date => _checkupHistory;
  String get name => _checkupName;
  int get result => _checkupResult;
}
