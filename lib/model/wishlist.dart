class WishlistResponse {
  final String message;

  WishlistResponse({required this.message});

  factory WishlistResponse.fromJson(Map<String, dynamic> json) {
    return WishlistResponse(
      message: json['message'] ?? '',
    );
  }
}
