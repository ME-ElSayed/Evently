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
