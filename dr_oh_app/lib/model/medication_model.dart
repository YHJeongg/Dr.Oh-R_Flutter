class MedicationModel {
  String? firstDate;
  String? lastDate;
  String? hospital;
  String? disease;
  String? pill;
  MedicationModel(
      {this.firstDate, this.lastDate, this.hospital, this.disease, this.pill});

  factory MedicationModel.fromJson(Map<String, dynamic> json) {
    return MedicationModel(
      firstDate: json["firstDate"] == null ? '' : json["firstDate"] as String,
      lastDate: json["lastDate"] == null ? '' : json["lastDate"] as String,
      hospital: json["hospital"] == null ? '' : json["hospital"] as String,
      disease: json["disease"] == null ? '' : json["disease"] as String,
      pill: json["pill"] == null ? '' : json["pill"] as String,
    );
  }
  Map<String, dynamic> toMap() {
    return {
      'firstDate': firstDate,
      'lastDate': lastDate,
      'hospital': hospital,
      'disease': disease,
      'pill': pill,
    };
  }
}
