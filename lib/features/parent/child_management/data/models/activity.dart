enum Activity { speechTherapy, reading, singing }

extension ActivityExtension on Activity {
  String get name => toString().split('.').last;

  static Activity fromString(String value) {
    return Activity.values.firstWhere((e) => e.name == value);
  }
}
