class ProfileModel {
  String? name;

  String? email;

  String? phone_number;

  String? gender;

  String? age;

  bool? check;

  ProfileModel(
      {this.name,
      this.email,
      this.phone_number,
      this.age,
      this.gender,
      this.check=false});

  ProfileModel.fromJson(Map<String, dynamic> json) {
    name = json["name"];
    email = json["email"];
    phone_number = json["phone_number"];
    gender = json["gender"];
    age = json["age"];
    check = json["check"];
  }

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map["name"] = name;
    map["email"] = email;
    map["phone_number"] = phone_number;
    map["gender"] = gender;
    map["age"] = age;
    map["check"] = check;
    return map;
  }
}