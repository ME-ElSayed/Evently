class UserSearchModel {
  final int id;
  final String name;
  final String username;
  final String email;
  final String governorate;
  final String? profileImageUrl;

  UserSearchModel({
    required this.id,
    required this.name,
    required this.username,
    required this.email,
    required this.governorate,
    this.profileImageUrl,
  });

  factory UserSearchModel.fromJson(Map<String, dynamic> json) {
    return UserSearchModel(
      id: json['id'],
      name: json['name'],
      username: json['username'],
      email: json['email'],
      governorate: json['governorate'],
      profileImageUrl: json['profileImageUrl'],
    );
  }
}