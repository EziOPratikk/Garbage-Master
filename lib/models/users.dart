class Users {
  late String FName;
  String? MName;
  late String LName;
  late String Email;
  late String Username;
  late String? Password;
  late int Ward;

  Users(this.FName, this.MName, this.LName, this.Email, this.Username,
      this.Password, this.Ward);

  // String get FName => FName;
  // String? get MName => MName;
  // String get LName => LName;
  // int get Email => Email;
  // String get Username => Username;
  // String get Password => Password;
  // int get Ward => Ward;

  // set fName(String newFName) {
  //   FName = newFName;
  // }

  // set mName(String ? newMName) {
  //   MName = newMName;
  // }

  // set lName(String newLName) {
  //   LName = newLName;
  // }

  // set email(String newEmail) {
  //   Email = newEmail;
  // }

  // set username(String newUsername) {
  //   Username = newUsername;
  // }

  // set password(String newPassword) {
  //   Password = newPassword;
  // }

  // set ward(int newWard) {
  //   Ward = newWard;
  // }
  // Map to Object for Deserialization
  Users.fromMap(Map<String, dynamic> map) {
    FName = map["fName"];
    MName = map["mName"];
    LName = map["lName"];
    Email = map["email"];
    Username = map["username"];
    Password = map["password"];
    Ward = map["ward"];
  }

  // Object to Map for Serialization
  Map<String, dynamic> toMap() {
    return {
      "fName": FName,
      "mName": MName,
      "lName": LName,
      "email": Email,
      "username": Username,
      "password": Password,
      "ward": Ward,
    };
  }
}
