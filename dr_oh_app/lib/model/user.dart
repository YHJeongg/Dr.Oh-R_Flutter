class UserModel {
  String? uid;
  String? id;
  String? password;
  String? name;
  String? email;
  String? birthdate;
  String? gender;

  UserModel({
    this.uid,
    this.id,
    this.password,
    this.name,
    this.email,
    this.birthdate,
    this.gender,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      uid: json["uid"] == null ? '' : json["uid"] as String,
      id: json["id"] == null ? '' : json["id"] as String,
      password: json["password"] == null ? '' : json["password"] as String,
      name: json["name"] == null ? '' : json["name"] as String,
      email: json["email"] == null ? '' : json["email"] as String,
      birthdate: json["birthdate"] == null ? '' : json["birthdate"] as String,
      gender: json["gender"] == null ? '' : json["gender"] as String,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'id': id,
      'password': password,
      'name': name,
      'email': email,
      'birthdate': birthdate,
      'gender': gender,
    };
  }

  UserModel copyWith({
    String? uid,
    String? id,
    String? password,
    String? name,
    String? email,
    String? birthdate,
    String? gender,
  }) {
    return UserModel(
      uid: uid ?? this.uid,
      id: id ?? this.id,
      password: password ?? this.password,
      name: name ?? this.name,
      email: email ?? this.email,
      birthdate: birthdate ?? this.birthdate,
      gender: gender ?? this.gender,
    );
  }
}
