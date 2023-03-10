class Users {
  late String FName;
  String? MName;
  late String LName;
  late String Email;
  late String Username;
  late String? Password;
  late int Ward;
  String? Phone;
  late String Image;

  Users(this.FName, this.MName, this.LName, this.Email, this.Username,
      this.Password, this.Ward, this.Phone, this.Image);

  // Map to Object for Deserialization
  Users.fromMap(Map<String, dynamic> map) {
    FName = map["fName"];
    MName = map["mName"];
    LName = map["lName"];
    Email = map["email"];
    Username = map["username"];
    Password = map["password"];
    Ward = map["ward"];
    Phone = map["phone"];
    Image = map["image"];
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
      "phone": Phone,
      "image": Image,
    };
  }
}
