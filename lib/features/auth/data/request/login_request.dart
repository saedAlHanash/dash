class LoginRequest {
  LoginRequest({
    this.email,
    this.password,
  });

  String? email;
  String? password;

  factory LoginRequest.fromJson(Map<String, dynamic> json) {
    return LoginRequest(
      email: json["userNameOrEmailAddress"] ?? "",
      password: json["password"] ?? "",
    );
  }

  Map<String, dynamic> toJson() => {
        "userNameOrEmailAddress": email,
        "password": password,
        "rememberClient": true,
      };
}
