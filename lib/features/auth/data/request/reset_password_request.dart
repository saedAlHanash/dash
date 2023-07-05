class ResetPasswordRequest {
  ResetPasswordRequest({
    this.phoneCode ='',
    this.password ='',
  });

  String phoneCode;
  String password;

  factory ResetPasswordRequest.fromJson(Map<String, dynamic> json) {
    return ResetPasswordRequest(
      phoneCode: json['phoneCode'] ?? '',
      password: json['password'] ?? '',
    );
  }

  Map<String, dynamic> toJson() => {
        'phoneCode': phoneCode,
        'password': password,
      };
}
