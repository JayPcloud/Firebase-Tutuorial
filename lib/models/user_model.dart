class UserModel {

  String id;
  String email;
  String username;

  UserModel({
    required this.id,
    required this.email,
    required this.username
  });

  Map<String, dynamic> toFirestore() {
    Map<String, dynamic> map = {};
    
    map["id"] = id;
    map["email"]=email;
    map["username"]=username;

    return map;
  }

}
