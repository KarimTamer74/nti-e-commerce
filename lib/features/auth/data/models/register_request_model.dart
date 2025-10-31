class RegisterRequestModel {
  final String firstName, lastName, email, password;

  RegisterRequestModel({
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.password,
  });
  toJson() {
    return {
      "email": email,
      "password": password,
      "firstName": firstName,
      "LastName": lastName,
    };
  }
}
