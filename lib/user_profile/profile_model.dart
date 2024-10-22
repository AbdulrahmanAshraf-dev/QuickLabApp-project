class ProfileModel {
  String? name;
  String? email;
  String? phoneNumber;
  String? gender;
  String? age;
  bool? check;
  bool? isAdmin;
  String? image;
  String?id;

  ProfileModel(
      {this.name,
      this.image,
      this.email,
      this.phoneNumber,
      this.age,
      this.gender,
      this.isAdmin = false,
      this.check = false,
      this.id,});

  ProfileModel.fromJson(Map<String, dynamic> json, this.id) {
    name = json["name"];
    image = json["image"];
    email = json["email"];
    phoneNumber = json["phone_number"];
    gender = json["gender"];
    age = json["age"];
    check = json["check"];
    isAdmin = json["isAdmin"];
  }

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map["name"] = name;
    map["email"] = email;
    map["phone_number"] = phoneNumber;
    map["gender"] = gender;
    map["age"] = age;
    map["isAdmin"] = isAdmin;
    map["check"] = check;
    map["image"] = image;
    map["isAdmin"] = false;
    return map;
  }
}
