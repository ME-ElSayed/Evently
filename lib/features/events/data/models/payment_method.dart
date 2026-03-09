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