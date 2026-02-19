enum NotificationType {
  reminder,
  invite,
  cancellation,
  system,
}

extension NotificationTypeX on NotificationType {
  String get value => name.toUpperCase();

  static NotificationType fromString(String value) {
    return NotificationType.values.firstWhere(
      (e) => e.value == value,
      orElse: () => NotificationType.system,
    );
  }
}

class NotificationModel {
  final int id;
  final NotificationType type;
  final DateTime createdAt;
  final int? senderId;
  final int targetId;
  final String targetType;
  final NotificationData data;
  final bool read;

  NotificationModel({
    required this.id,
    required this.type,
    required this.createdAt,
    this.senderId,
    required this.targetId,
    required this.targetType,
    required this.data,
    required this.read,
  });

  factory NotificationModel.fromJson(Map<String, dynamic> json) {
    return NotificationModel(
      id: json['id'],
      type: NotificationTypeX.fromString(json['type']),
      createdAt: DateTime.parse(json['createdAt']),
      senderId: json['senderId'],
      targetId: json['targetId'],
      targetType: json['targetType'],
      data: NotificationData.fromJson(json['data']),
      read: json['read'],
    );
  }
}

class NotificationData {
  final String title;
  final String body;
  final int? eventId;
  final String? eventName;
  final String? role;

  NotificationData({
    required this.title,
    required this.body,
    this.eventId,
    this.eventName,
    this.role,
  });

  factory NotificationData.fromJson(Map<String, dynamic> json) {
    return NotificationData(
      title: json['title'],
      body: json['body'],
      eventId: json['eventId'],
      eventName: json['eventName'],
      role: json['role'],
    );
  }
}
