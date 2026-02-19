class EventModel {
  final int id;
  final String name;
  final String? description;
  final String? latitude;
  final String? longitude;
  final String governorate;
  final PaymentMethod? paymentMethod;
  final String? price;
  final DateTime startAt;
  final int duration;
  final int maxAttendees;
  final String? imageUrl;
  final EventVisibility? visibility;
  final EventState? state;
  final DateTime? createdAt;
  final int ownerId;
  final int currentAttendees;

  // Detailed-only fields
  final String? attendanceCode;
  final bool? attended;
  final EventOwner? owner;
  final EventRole? role;
  final List<EventPermission>? permissions;

  EventModel({
    required this.id,
    required this.name,
    this.description,
    this.latitude,
    this.longitude,
    required this.governorate,
    this.paymentMethod,
    this.price,
    required this.startAt,
    required this.duration,
    required this.maxAttendees,
    this.imageUrl,
    this.visibility,
    this.state,
    this.createdAt,
    required this.ownerId,
    required this.currentAttendees,
    this.attendanceCode,
    this.attended,
    this.owner,
    this.role,
    this.permissions,
  });

  factory EventModel.fromJson(Map<String, dynamic> json) {
    return EventModel(
      id: json['id'] as int,
      name: json['name'] as String,
      description: json['description'] as String?,
      latitude: json['latitude']?.toString(),
      longitude: json['longitude']?.toString(),
      governorate: json['governorate'] as String,
      paymentMethod: PaymentMethod.fromString(json['paymentMethod'] as String?),
      price: json['price']?.toString(),
      startAt: DateTime.parse(json['startAt'] as String),
      duration: json['duration'] as int,
      maxAttendees: json['maxAttendees'] as int,
      imageUrl: json['imageUrl'] as String?,
      visibility: EventVisibility.fromString(json['visibility'] as String?),
      state: EventState.fromString(json['state'] as String?),
      createdAt: json['createdAt'] != null
          ? DateTime.parse(json['createdAt'] as String)
          : null,
      ownerId: (json['ownerId'] as num?)?.toInt() ?? 0,
      currentAttendees: (json['currentAttendees'] as int?) ?? 0,
      attendanceCode: json['attendanceCode'] as String?,
      attended: json['attended'] as bool?,
      owner: json['owner'] != null ? EventOwner.fromJson(json['owner']) : null,
      role: EventRole.fromString(json['role'] as String?),
      permissions: json['permissions'] != null
          ? (json['permissions'] as List)
              .map((p) => EventPermission.fromString(p as String))
              .whereType<EventPermission>()
              .toList()
          : null,
    );
  }

  factory EventModel.dummy() => EventModel(
        id: 0,
        name: 'Loading Event Title',
        description: 'Loading description text that fills the space nicely.',
        imageUrl: '',
        createdAt: DateTime.now(),
        attended: false,
        governorate: '',
        startAt: DateTime.now(),
        duration: 0,
        maxAttendees: 1,
        ownerId: 0,
        currentAttendees: 0,
      );
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'latitude': latitude,
      'longitude': longitude,
      'governorate': governorate,
      'paymentMethod': paymentMethod?.value,
      'price': price,
      'startAt': startAt.toIso8601String(),
      'duration': duration,
      'maxAttendees': maxAttendees,
      'imageUrl': imageUrl,
      'visibility': visibility?.value,
      'state': state?.value,
      'createdAt': createdAt?.toIso8601String(),
      'ownerId': ownerId,
      'currentAttendees': currentAttendees,
      'attendanceCode': attendanceCode,
      'attended': attended,
      'owner': owner?.toJson(),
      'role': role?.value,
      'permissions': permissions?.map((p) => p.value).toList(),
    };
  }

  EventModel copyWith({
    int? id,
    String? name,
    String? description,
    String? latitude,
    String? longitude,
    String? governorate,
    PaymentMethod? paymentMethod,
    String? price,
    DateTime? startAt,
    int? duration,
    int? maxAttendees,
    String? imageUrl,
    EventVisibility? visibility,
    EventState? state,
    DateTime? createdAt,
    int? ownerId,
    int? currentAttendees,
    String? attendanceCode,
    bool? attended,
    EventOwner? owner,
    EventRole? role,
    List<EventPermission>? permissions,
  }) {
    return EventModel(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
      latitude: latitude ?? this.latitude,
      longitude: longitude ?? this.longitude,
      governorate: governorate ?? this.governorate,
      paymentMethod: paymentMethod ?? this.paymentMethod,
      price: price ?? this.price,
      startAt: startAt ?? this.startAt,
      duration: duration ?? this.duration,
      maxAttendees: maxAttendees ?? this.maxAttendees,
      imageUrl: imageUrl ?? this.imageUrl,
      visibility: visibility ?? this.visibility,
      state: state ?? this.state,
      createdAt: createdAt ?? this.createdAt,
      ownerId: ownerId ?? this.ownerId,
      currentAttendees: currentAttendees ?? this.currentAttendees,
      attendanceCode: attendanceCode ?? this.attendanceCode,
      attended: attended ?? this.attended,
      owner: owner ?? this.owner,
      role: role ?? this.role,
      permissions: permissions ?? this.permissions,
    );
  }

  EventModel merge(EventModel other) {
    return EventModel(
      id: id,
      name: name,
      description: description ?? other.description,
      latitude: latitude ?? other.latitude,
      longitude: longitude ?? other.longitude,
      governorate: governorate,
      paymentMethod: paymentMethod ?? other.paymentMethod,
      price: price ?? other.price,
      startAt: startAt,
      duration: duration,
      maxAttendees: maxAttendees,
      imageUrl: imageUrl ?? other.imageUrl,
      visibility: visibility ?? other.visibility,
      state: state ?? other.state,
      createdAt: createdAt ?? other.createdAt,
      ownerId: ownerId,
      currentAttendees: other.currentAttendees,
      attendanceCode: attendanceCode ?? other.attendanceCode,
      attended: attended ?? other.attended,
      owner: owner ?? other.owner,
      role: role ?? other.role,
      permissions: permissions ?? other.permissions,
    );
  }
}

//enums

enum PaymentMethod {
  free('FREE'),
  atEvent('AT_EVENT'),
  online('ONLINE');

  final String value;
  const PaymentMethod(this.value);

  static PaymentMethod? fromString(String? value) {
    if (value == null) return null;
    try {
      return PaymentMethod.values.firstWhere((e) => e.value == value);
    } catch (_) {
      return null;
    }
  }
}

enum EventState {
  openForRegistration('OPEN_FOR_REGISTRATION'),
  closedForRegistration('CLOSED_FOR_REGISTRATION'),
  cancelled('CANCELLED'),
  ongoing('ONGOING'),
  completed('COMPLETED');

  final String value;
  const EventState(this.value);

  static EventState? fromString(String? value) {
    if (value == null) return null;
    try {
      return EventState.values.firstWhere((e) => e.value == value);
    } catch (_) {
      return null;
    }
  }
}

enum EventVisibility {
  public('PUBLIC'),
  private('PRIVATE');

  final String value;
  const EventVisibility(this.value);

  static EventVisibility? fromString(String? value) {
    if (value == null) return null;
    try {
      return EventVisibility.values.firstWhere((e) => e.value == value);
    } catch (_) {
      return null;
    }
  }
}

enum EventRole {
  owner('OWNER'),
  manager('MANAGER'),
  attendee('ATTENDEE');

  final String value;
  const EventRole(this.value);

  static EventRole? fromString(String? value) {
    if (value == null) return null;
    try {
      return EventRole.values.firstWhere((e) => e.value == value);
    } catch (_) {
      return null;
    }
  }
}

enum EventPermission {
  viewEvent('VIEW_EVENT'),
  viewInvites('VIEW_INVITES'),
  viewAttendees('VIEW_ATTENDEES'),
  viewManagers('VIEW_MANAGERS'),
  scanCode('SCAN_CODE'),
  cancelEvent('CANCEL_EVENT'),
  closeOrOpenRegistration('CLOSE_OR_OPEN_REGISTRATION'),
  inviteAttendees('INVITE_ATTENDEES'),
  inviteManagers('INVITE_MANAGERS'),
  updateEventDetails('UPDATE_EVENT_DETAILS'),
  removeRegisteredUsers('REMOVE_REGISTERED_USERS'),
  removeManagers('REMOVE_MANAGERS');

  final String value;
  const EventPermission(this.value);

  static EventPermission? fromString(String? value) {
    if (value == null) return null;
    try {
      return EventPermission.values.firstWhere((e) => e.value == value);
    } catch (_) {
      return null;
    }
  }

  String get displayName => value
      .replaceAll('_', ' ')
      .toLowerCase()
      .split(' ')
      .map((w) => w[0].toUpperCase() + w.substring(1))
      .join(' ');
}

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
