enum Gender { male, female }

extension GenderExtension on Gender {
  String get name => toString().split('.').last;

  static Gender fromString(String value) {
    return Gender.values.firstWhere((e) => e.name == value);
  }
}
