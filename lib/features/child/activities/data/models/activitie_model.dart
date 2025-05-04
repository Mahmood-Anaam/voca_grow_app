import 'package:equatable/equatable.dart';

class ActivitieModel extends Equatable {
  final String id;
  final String imagePath;
  final String name;
  final String description;

  const ActivitieModel({
    required this.id,
    required this.imagePath,
    required this.name,
    required this.description,
  });

  static var empty = ActivitieModel(
    id: '',
    imagePath: '',
    name: '',
    description: '',
  );

  factory ActivitieModel.fromJson(Map<String, dynamic> json) {
    return ActivitieModel(
      id: json['id'] as String,
      imagePath: json['imagePath'] as String,
      name: json['name'] as String,
      description: json['description'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'imagePath': imagePath,
      'name': name,
      'description': description,
    };
  }

  bool get isEmpty => this == ActivitieModel.empty;

  bool get isNotEmpty => !isEmpty;

  @override
  List<Object?> get props => [id, imagePath, name, description];

  @override
  String toString() {
    return 'ActivitieModel(id: $id, imagePath: $imagePath, name: $name, description: $description)';
  }
}
