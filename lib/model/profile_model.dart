class UserProfile {
  final String name;
  final String phoneNumber;

  UserProfile({required this.name, required this.phoneNumber});

  // Factory method to create a UserProfile from JSON
  factory UserProfile.fromJson(Map<String, dynamic> json) {
    return UserProfile(
      name: json['name'] ?? '',
      phoneNumber: json['phone_number'] ?? '',
    );
  }
}
