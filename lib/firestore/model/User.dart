class User{
  static const String collection = "User";
  String? id;
  String? fullName;
  int? age;
  String? phoneNumber;
  String? emailAddress;
  User({this.id,this.fullName,this.age,this.phoneNumber,this.emailAddress});

  User.fromFirestore(Map<String,dynamic>? data){
    fullName = data?["FullName"];
    id = data?["id"];
    age = data?["age"];
    phoneNumber = data?["PhoneNumber"];
    emailAddress = data?["EmailAddress"];
  }
  Map<String,dynamic>toFirestore(){
    return{
      "FullName":fullName,
      "id":id,
      "age":age,
      "PhoneNumber":phoneNumber,
      "EmailAddress":emailAddress
    };
  }
}