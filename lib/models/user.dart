class User {
  late int _id;
  late String _userName;
  late String _mobileNumber;
  late int _ward;
  late String _email;
  late String _password;

  User(this._id, this._userName, this._mobileNumber, this._ward, this._email,
      this._password);

  int get id => _id;
  String get userName => _userName;
  String get mobileNumber => _mobileNumber;
  int get ward => _ward;
  String get email => _email;
  String get password => _password;

  set userName(String newUserName) {
    _userName = newUserName;
  }

  set mobileNumber(String newMobileNumber) {
    _mobileNumber = newMobileNumber;
  }

  set ward(int newWard) {
    _ward = newWard;
  }

  set email(String newEmail) {
    _email = newEmail;
  }

  set password(String newPassword) {
    _password = newPassword;
  }

  // Map to Object for Deserialization
  User.fromMap(Map<String, dynamic> map) {
    this._id = map["id"];
    this._userName = map["userName"];
    this._mobileNumber = map["mobileNumber"];
    this._ward = map["ward"];
    this._email = map["email"];
    this._password = map["password"];
  }

  // Object to Map for Serialization
  Map<String, dynamic> toMap() {
    return {
      "id": this._id,
      "username": this._userName,
      "mobilenumber": this._mobileNumber,
      "ward": this._ward,
      "email": this._email,
      "password": this._password,
    };
  }
}
