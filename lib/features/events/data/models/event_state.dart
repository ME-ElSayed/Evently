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