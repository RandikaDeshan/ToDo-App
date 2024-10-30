class UserModel{
  final String email;
  final String password;
  final String userId;

  UserModel({
    required this.email,
    required this.password,
    required this.userId
  });

  factory UserModel.fromJson(Map<String,dynamic> json){
    return UserModel(
        email: json['email'],
        password: json['password'],
        userId: json['userId']);
  }

  Map<String,dynamic> toJson(){
    return{
      'email': email,
      'userId':userId,
      'password' : password
    };
  }

}