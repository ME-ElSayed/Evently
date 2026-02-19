import 'package:eventsmanager/features/events/data/models/invite_status.dart';

class EventInviteModel {
  final int id;
  final InviteStatus status;
  final DateTime createdAt;

  final int roleId;
  final int senderId;
  final int receiverId;
  final int eventId;

  final InviteReceiverModel receiver;

  EventInviteModel({
    required this.id,
    required this.status,
    required this.createdAt,
    required this.roleId,
    required this.senderId,
    required this.receiverId,
    required this.eventId,
    required this.receiver,
  });

  factory EventInviteModel.fromJson(Map<String, dynamic> json) {
    return EventInviteModel(
      id: json['id'],
      status: InviteStatus.fromString(json['status']),
      createdAt: DateTime.parse(json['createdAt']),
      roleId: json['roleId'],
      senderId: json['senderId'],
      receiverId: json['receiverId'],
      eventId: json['eventId'],
      receiver: InviteReceiverModel.fromJson(json['receiver']),
    );
  }
}
class InviteReceiverModel {
  final int id;
  final String name;
  final String username;
  final String email;
  final String governorate;
  final String? profileImageUrl;

  InviteReceiverModel({
    required this.id,
    required this.name,
    required this.username,
    required this.email,
    required this.governorate,
    this.profileImageUrl,
  });

  factory InviteReceiverModel.fromJson(Map<String, dynamic> json) {
    return InviteReceiverModel(
      id: json['id'],
      name: json['name'],
      username: json['username'],
      email: json['email'],
      governorate: json['governorate'],
      profileImageUrl: json['profileImageUrl'],
    );
  }
}