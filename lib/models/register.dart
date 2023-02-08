class Register {
  late String FName;
  String? MName;
  late String LName;
  late String Email;
  late String Username;
  late String Password;
  late int Ward;

  Register(this.FName, this.MName, this.LName, this.Email, this.Username,
      this.Password, this.Ward);

  // Map to Object for Deserialization
  Register.fromMap(Map<String, dynamic> map) {
    FName = map["FName"];
    MName = map["MName"];
    LName = map["LName"];
    Email = map["Email"];
    Username = map["Username"];
    Password = map["Password"];
    Ward = map["Ward"];
  }

  // Object to Map for Serialization
  Map<String, dynamic> toMap() {
    return {
      "FName": FName,
      "MName": MName,
      "LName": LName,
      "Email": Email,
      "Username": Username,
      "Password": Password,
      "Ward": Ward,
    };
  }
}
