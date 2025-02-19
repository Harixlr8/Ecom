class LoginRegisterResponse {
  final Token token;
  final String userId;
  final String message;

  LoginRegisterResponse({
    required this.token,
    required this.userId,
    required this.message,
  });

  factory LoginRegisterResponse.fromJson(Map<String, dynamic> json) {
    return LoginRegisterResponse(
      token: Token.fromJson(json['token']),
      userId: json['user_id'] ?? '',
      message: json['message'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'token': token.toJson(),
      'user_id': userId,
      'message': message,
    };
  }
}

class Token {
  final String access;

  Token({required this.access});

  factory Token.fromJson(Map<String, dynamic> json) {
    return Token(access: json['access'] ?? '');
  }

  Map<String, dynamic> toJson() {
    return {
      'access': access,
    };
  }
}
