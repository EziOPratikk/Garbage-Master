class Login {
  late String Username;
  late String Password;

  Login(this.Username, this.Password);

  Login.fromMap(Map<String, dynamic> map) {
    this.Username = map["username"];
    this.Password = map["password"];
  }

  Map<String, dynamic> toMap() {
    return {
      "username": this.Username,
      "password": this.Password,
    };
  }
}
