class Login {
  late String Username;
  late String Password;

  Login(this.Username, this.Password);

  Login.fromMap(Map<String, dynamic> map) {
    this.Username = map["Username"];
    this.Password = map["Password"];
  }

  Map<String, dynamic> toMap() {
    return {
      "Username": this.Username,
      "Password": this.Password,
    };
  }
}
