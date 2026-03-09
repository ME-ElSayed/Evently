class EventOwner {
  final int id;
  final String name;
  final String username;
  final String email;
  final String governorate;
  final String? profileImageUrl;
  final DateTime createdAt;

  EventOwner({
    required this.id,
    required this.name,
    required this.username,
    required this.email,
    required this.governorate,
    this.profileImageUrl,
    required this.createdAt,
  });

  factory EventOwner.fromJson(Map<String, dynamic> json) {
    return EventOwner(
      id: json['id'] as int,
      name: json['name'] as String,
      username: json['username'] as String,
      email: json['email'] as String,
      governorate: json['governorate'] as String,
      profileImageUrl: json['profileImageUrl'] as String?,
      createdAt: DateTime.parse(json['createdAt'] as String),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'username': username,
      'email': email,
      'governorate': governorate,
      'profileImageUrl': profileImageUrl,
      'createdAt': createdAt.toIso8601String(),
    };
  }
}
