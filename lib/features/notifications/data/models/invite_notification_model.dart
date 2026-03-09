import 'package:eventsmanager/features/events/data/models/event_model.dart';
import 'package:eventsmanager/features/events/data/models/event_owner.dart';
import 'package:eventsmanager/features/events/data/models/invite_status.dart';

class InviteNotificationModel {
  final int id;
  final int receiverId;
  final InviteStatus status;
  final DateTime createdAt;
  final EventModel event;
  final EventOwner sender;
  final String role;
  final List<String> permissions;

  InviteNotificationModel({
    required this.id,
    required this.receiverId,
    required this.status,
    required this.createdAt,
    required this.event,
    required this.sender,
    required this.role,
    required this.permissions,
  });

  factory InviteNotificationModel.fromJson(Map<String, dynamic> json) {
    return InviteNotificationModel(
      id: json['id'],
      receiverId: json['receiverId'],
      status: InviteStatus.fromString(json['status']),
      createdAt: DateTime.parse(json['createdAt']),
      event: EventModel.fromJson({
        ...json['event'],
        'role': json['role'],
        'permissions': json['permissions'],
      }),
      sender: EventOwner.fromJson({
        ...json['sender'],
        'createdAt': json['sender']['createdAt'] ?? DateTime.now().toIso8601String(),
      }),
      role: json['role'],
      permissions: List<String>.from(json['permissions'] ?? []),
    );
  }
}