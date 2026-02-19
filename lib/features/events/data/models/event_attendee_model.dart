class EventAttendeeModel {
  final int id;
  final String name;
  final String username;
  final String email;
  final String governorate;
  final String? profileImageUrl;

  final bool attended;
  final DateTime? verifiedAt;
  final VerifierModel? verifier;

  EventAttendeeModel({
    required this.id,
    required this.name,
    required this.username,
    required this.email,
    required this.governorate,
    required this.attended,
    this.profileImageUrl,
    this.verifiedAt,
    this.verifier,
  });

  factory EventAttendeeModel.fromJson(Map<String, dynamic> json) {
    return EventAttendeeModel(
      id: json['id'],
      name: json['name'],
      username: json['username'],
      email: json['email'],
      governorate: json['governorate'],
      profileImageUrl: json['profileImageUrl'],
      attended: json['attended'] ?? false,
      verifiedAt: json['verifiedAt'] != null
          ? DateTime.parse(json['verifiedAt'])
          : null,
      verifier: json['verifier'] != null
          ? VerifierModel.fromJson(json['verifier'])
          : null,
    );
  }

  bool get isVerified => verifiedAt != null;
  bool get hasVerifier => verifier != null;
}

class VerifierModel {
  final int id;
  final String name;
  final String username;
  final String email;
  final String governorate;
  final String? profileImageUrl;

  VerifierModel({
    required this.id,
    required this.name,
    required this.username,
    required this.email,
    required this.governorate,
    this.profileImageUrl,
  });

  factory VerifierModel.fromJson(Map<String, dynamic> json) {
    return VerifierModel(
      id: json['id'],
      name: json['name'],
      username: json['username'],
      email: json['email'],
      governorate: json['governorate'],
      profileImageUrl: json['profileImageUrl'],
    );
  }
}