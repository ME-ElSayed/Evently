class EventManagerModel {
  final int id;
  final String name;
  final String username;
  final String email;
  final String governorate;
  final String? profileImageUrl;

  EventManagerModel({
    required this.id,
    required this.name,
    required this.username,
    required this.email,
    required this.governorate,
    this.profileImageUrl,
  });

  factory EventManagerModel.fromJson(Map<String, dynamic> json) {
    return EventManagerModel(
      id: json['id'],
      name: json['name'],
      username: json['username'],
      email: json['email'],
      governorate: json['governorate'],
      profileImageUrl: json['profileImageUrl'],
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
    };
  }
}