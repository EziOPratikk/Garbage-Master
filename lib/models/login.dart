class Login {
  late String Username;
  late String Password;

  Login(this.Username, this.Password);

  Login.fromMap(Map<String, dynamic> map) {
    Username = map["username"];
    Password = map["password"];
  }

  Map<String, dynamic> toMap() {
    return {
      "username": Username,
      "password": Password,
    };
  }
}
