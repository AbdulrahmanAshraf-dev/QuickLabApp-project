class ProfileModel {
  String? name ;
  String? email ;
  String? phone_number ;
  ProfileModel({this.name, this.email, this.phone_number});
  ProfileModel.fromJson(Map<String,dynamic>json){
    name = json["name"];
    email = json["email"];
    phone_number = json["phone_number"];

  }
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map["name"] = name;
    map["email"] = email;
    map["phone_number"] = phone_number;
    return map;
  }

}