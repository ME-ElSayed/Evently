enum InviteStatus {
  pending,
  accepted,
  declined;

  factory InviteStatus.fromString(String value) {
    switch (value.toUpperCase()) {
      case 'PENDING':
        return InviteStatus.pending;
      case 'ACCEPTED':
        return InviteStatus.accepted;
      case 'DECLINED':
        return InviteStatus.declined;
      default:
        throw ArgumentError('Unknown InviteStatus: $value');
    }
  }

  /// Convert enum → backend string
  String get value {
    switch (this) {
      case InviteStatus.pending:
        return 'PENDING';
      case InviteStatus.accepted:
        return 'ACCEPTED';
      case InviteStatus.declined:
        return 'DECLINED';
    }
  }

  bool get isPending => this == InviteStatus.pending;
  bool get isAccepted => this == InviteStatus.accepted;
  bool get isDeclined => this == InviteStatus.declined;
}
