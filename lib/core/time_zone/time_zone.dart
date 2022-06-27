class TimeZone {
  TimeZone._();

  static int setTimeZone() {
    return DateTime.now().millisecondsSinceEpoch;
  }
}
