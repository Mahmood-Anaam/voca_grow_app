import 'package:equatable/equatable.dart';

class CharacterModel extends Equatable {
  final String id;
  final String imagePath;
  final String name;
  final bool isMale;
  final String description;

  const CharacterModel({
    required this.id,
    required this.imagePath,
    required this.name,
    required this.isMale,
    required this.description,
  });

  static var empty = CharacterModel(
    id: '',
    imagePath: '',
    name: '',
    isMale: false,
    description: '',
  );

  factory CharacterModel.fromJson(Map<String, dynamic> json) {
    return CharacterModel(
      id: json['id'] as String,
      imagePath: json['imagePath'] as String,
      name: json['name'] as String,
      isMale: json['isMale'] as bool,
      description: json['description'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'imagePath': imagePath,
      'name': name,
      'isMale': isMale,
      'description': description,
    };
  }

  bool get isEmpty => this == CharacterModel.empty;

  bool get isNotEmpty => !isEmpty;

  @override
  List<Object?> get props => [id, imagePath, name, isMale, description];

  @override
  String toString() {
    return 'CharacterModel(id: $id, imagePath: $imagePath, name: $name, isMale: $isMale, description: $description)';
  }
}
