import 'package:equatable/equatable.dart';
import 'user_type.dart';

class UserModel extends Equatable {
  final String id;
  final String name;
  final String email;
  final String? password;
  final String? parentEmail;
  final UserType userType;

  const UserModel({
    required this.id,
    required this.name,
    required this.email,
    this.password,
    this.parentEmail,
    required this.userType,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'] ?? '',
      name: json['name'] ?? '',
      email: json['email'] ?? '',
      password: json['password'] ?? '',
      parentEmail: json['parentEmail'] ?? '',
      userType: UserType.values.firstWhere(
        (e) => e.toString() == json['userType'],
        orElse: () => UserType.none,
      ),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'password': password,
      'parentEmail': parentEmail,
      'userType': userType.toString(),
    };
  }

  UserModel copyWith({
    String? id,
    String? name,
    String? email,
    String? password,
    String? parentEmail,
    UserType? userType,
  }) {
    return UserModel(
      id: id ?? this.id,
      name: name ?? this.name,
      email: email ?? this.email,
      password: password ?? this.password,
      parentEmail: parentEmail ?? this.parentEmail,
      userType: userType ?? this.userType,
    );
  }

  static const empty = UserModel(
    id: '',
    name: '',
    email: '',
    password: '',
    parentEmail: '',
    userType: UserType.none,
  );

  bool get isEmpty => this == UserModel.empty;
  bool get isNotEmpty => this != UserModel.empty;

  @override
  List<Object?> get props => [id, name, email, password, parentEmail, userType];

  @override
  String toString() {
    return 'UserModel(id: $id, name: $name, email: $email, password: $password, parentEmail: $parentEmail, userType: $userType)';
  }
}
