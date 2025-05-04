import 'package:voca_grow_app/core/utils/utils.dart';
import 'character_model.dart';

final List<CharacterModel> listCharacters = [
  CharacterModel(
    id: '1',
    imagePath: Assets.imagesWoodyCharacter,
    name: 'Woody',
    isMale: true,
    description: 'A brave cowboy who loves adventure.',
  ),
  CharacterModel(
    id: '2',
    imagePath: Assets.imagesSnowCharacter,
    name: 'Snow',
    isMale: false,
    description: 'A friendly snowman who loves winter fun.',
  ),
  CharacterModel(
    id: '3',
    imagePath: Assets.imagesSpidermanCharacter,
    name: 'Spiderman',
    isMale: true,
    description: 'A superhero who swings through the city.',
  ),
  CharacterModel(
    id: '4',
    imagePath: Assets.imagesElsasCharacter,
    name: 'Elsa',
    isMale: false,
    description: 'A queen with magical ice powers.',
  ),
];
