class HospitalVisitModel {
  String? hospital;
  String? purpose;
  String? date;

  HospitalVisitModel({this.hospital, this.purpose, this.date});

  factory HospitalVisitModel.fromJson(Map<String, dynamic> json) {
    return HospitalVisitModel(
      hospital: json["hospital"] == null ? '' : json["hospital"] as String,
      purpose: json["purpose"] == null ? '' : json["purpose"] as String,
      date: json["date"] == null ? '' : json["date"] as String,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'hospital': hospital,
      'purpose': purpose,
      'date': date,
    };
  }
}
