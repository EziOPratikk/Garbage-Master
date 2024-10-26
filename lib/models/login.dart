class Login {
  late String userName;
  late String password;

  Login(this.userName, this.password);

  Login.fromMap(Map<String, dynamic> map) {
    userName = map["username"];
    password = map["password"];
  }

  Map<String, dynamic> toMap() {
    return {
      "userName": userName,
      "password": password,
    };
  }
}
