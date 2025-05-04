import 'package:equatable/equatable.dart';
import 'package:voca_grow_app/features/auth/data/models/user_type.dart';
import 'gender.dart';
import 'activity.dart';

class ChildModel extends Equatable {
  final String id;
  final String name;
  final Gender gender;
  final DateTime birthDate;
  final List<Activity> availableActivities;
  final String email;
  final String password;
  final String parentEmail;

  const ChildModel({
    required this.id,
    required this.name,
    required this.gender,
    required this.birthDate,
    required this.availableActivities,
    required this.email,
    required this.password,
    required this.parentEmail,
  });

  factory ChildModel.fromJson(Map<String, dynamic> json) {
    return ChildModel(
      id: json['id'],
      name: json['name'],
      gender: GenderExtension.fromString(json['gender']),
      birthDate: DateTime.parse(json['birthDate']),
      availableActivities:
          List<String>.from(
            json['availableActivities'] ?? [],
          ).map((e) => ActivityExtension.fromString(e)).toList(),
      email: json['email'],
      password: json['password'],
      parentEmail: json['parentEmail'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'gender': gender.name,
      'birthDate': birthDate.toIso8601String(),
      'availableActivities': availableActivities.map((e) => e.name).toList(),
      'email': email,
      'password': password,
      'parentEmail': parentEmail,
      'userType': UserType.child.toString(),
    };
  }

  static var empty = ChildModel(
    id: '',
    name: '',
    gender: Gender.male,
    birthDate: DateTime(2000, 1, 1),
    availableActivities: const [],
    email: '',
    password: '',
    parentEmail: '',
  );

  bool get isEmpty => this == ChildModel.empty;
  bool get isNotEmpty => this != ChildModel.empty;

  @override
  List<Object?> get props => [
    id,
    name,
    gender,
    birthDate,
    availableActivities,
    email,
    password,
    parentEmail,
  ];
}
