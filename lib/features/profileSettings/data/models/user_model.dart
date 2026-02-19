class UserModel {
  final int id;
  final String name;
  final String username;
  final String email;
  final String governorate;
  final String? profileImageUrl;
  final bool isVerified;
  final DateTime createdAt;

  const UserModel({
    required this.id,
    required this.name,
    required this.username,
    required this.email,
    required this.governorate,
    this.profileImageUrl,
    required this.isVerified,
    required this.createdAt,
  });

  // ==================== FROM API RESPONSE ====================
  /// Pass `response['data']['user']` here
  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'],
      name: json['name'],
      username: json['username'],
      email: json['email'],
      governorate: json['governorate'],
      profileImageUrl: json['profileImageUrl'],
      isVerified: json['isVerified'] ?? false,
      createdAt: DateTime.parse(json['createdAt']),
    );
  }

  // ==================== TO JSON (for SharedPreferences) ====================

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'username': username,
      'email': email,
      'governorate': governorate,
      'profileImageUrl': profileImageUrl,
      'isVerified': isVerified,
      'createdAt': createdAt.toIso8601String(),
    };
  }

  // ==================== COPY WITH ====================

  UserModel copyWith({
    String? name,
    String? username,
    String? email,
    String? governorate,
    String? profileImageUrl,
    bool? isVerified,
  }) {
    return UserModel(
      id: id,
      name: name ?? this.name,
      username: username ?? this.username,
      email: email ?? this.email,
      governorate: governorate ?? this.governorate,
      profileImageUrl: profileImageUrl ?? this.profileImageUrl,
      isVerified: isVerified ?? this.isVerified,
      createdAt: createdAt,
    );
  }
}