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