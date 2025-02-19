class VerifyUserResponse {
  final String otp;
  final Token? token;
  final bool user;

  VerifyUserResponse({
    required this.otp,
    this.token, 
    required this.user,
  });

  factory VerifyUserResponse.fromJson(Map<String, dynamic> json) {
    return VerifyUserResponse(
      otp: json['otp'],
      token: json['token'] != null ? Token.fromJson(json['token']) : null, 
      user: json['user'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "otp": otp,
      "token": token?.toJson(), 
      "user": user,
    };
  }
}

class Token {
  final String access;

  Token({required this.access});

  factory Token.fromJson(Map<String, dynamic> json) {
    return Token(access: json['access']);
  }

  Map<String, dynamic> toJson() {
    return {"access": access};
  }
}
