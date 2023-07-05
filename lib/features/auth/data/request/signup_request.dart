class SignupRequest {
  SignupRequest({
    required this.name,
    required this.surname,
    required this.emailAddress,
    required this.phoneNumber,
    required this.password,
  });

  final String name;
  final String surname;
  final String emailAddress;
  final String phoneNumber;
  final String password;

  factory SignupRequest.fromJson(Map<String, dynamic> json) {
    return SignupRequest(
      name: json["name"] ?? "",
      surname: json["surname"] ?? "",
      emailAddress: json["emailAddress"] ?? "",
      phoneNumber: json["phoneNumber"] ?? "",
      password: json["password"] ?? "",
    );
  }

  Map<String, dynamic> toJson() => {
        "name": name,
        "surname": surname,
        "emailAddress": emailAddress,
        "phoneNumber": phoneNumber,
        "password": password,
      };
}
