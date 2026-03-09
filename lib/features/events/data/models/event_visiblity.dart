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