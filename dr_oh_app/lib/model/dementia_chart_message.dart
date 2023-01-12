import 'dart:convert';

class DementiaChart {

  String? date;
  String? dementiaP;
  
  DementiaChart({
    this.date,
    this.dementiaP,
  });
  

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'date': date,
      'dementiaP': dementiaP,
    };
  }

  factory DementiaChart.fromMap(Map<String, dynamic> map) {
    return DementiaChart(
      date: map['date'] != null ? map['date'] as String : null,
      dementiaP: map['dementiaP'] != null ? map['dementiaP'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory DementiaChart.fromJson(String source) => DementiaChart.fromMap(json.decode(source) as Map<String, dynamic>);




}
