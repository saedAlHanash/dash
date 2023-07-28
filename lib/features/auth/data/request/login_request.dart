class LoginRequest {
  LoginRequest({
    this.userNameOrEmailAddress,
    this.password,
  });

  String? userNameOrEmailAddress;
  String? password;

  factory LoginRequest.fromJson(Map<String, dynamic> json) {
    return LoginRequest(
      userNameOrEmailAddress: json["userName"] ?? "",
      password: json["password"] ?? "",
    );
  }

  Map<String, dynamic> toJson() => {
        "userName": userNameOrEmailAddress,
        "password": password,
      };
}

