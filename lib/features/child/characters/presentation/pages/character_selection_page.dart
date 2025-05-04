import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:voca_grow_app/features/child/activities/activities.dart';
import 'package:voca_grow_app/features/child/characters/characters.dart';
import 'package:voca_grow_app/core/utils/utils.dart';
import 'package:voca_grow_app/core/widgets/widgets.dart';
import 'package:voca_grow_app/features/child/assistant/assistant.dart';

class CharacterSelectionPage extends StatefulWidget {
  final ActivitieModel activitie;
  const CharacterSelectionPage({super.key, required this.activitie});

  static Route<void> route({required ActivitieModel activitie}) {
    return MaterialPageRoute<void>(
      builder: (_) => CharacterSelectionPage(activitie: activitie),
    );
  }

  @override
  State<CharacterSelectionPage> createState() => _CharacterSelectionPageState();
}

class _CharacterSelectionPageState extends State<CharacterSelectionPage> {
  String? _lang;
  @override
  void initState() {
    super.initState();
    _loadSeetings();
  }

  Future<void> _loadSeetings() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _lang = prefs.getString('lang') ?? 'ar';
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(title: const Text('Character Selection')),
        body: ImageOverlayWidget(
          image: const AssetImage(Assets.imagesTopPolygon),
          alignment: Alignment.topLeft,
          child: ImageOverlayWidget(
            image: const AssetImage(Assets.imagesBottomPolygon),
            alignment: Alignment.bottomRight,
            child: Column(
              children: [
                Container(
                  margin: const EdgeInsets.only(top: 60),
                  child: Column(
                    children: [
                      Image.asset(Assets.imagesCharacterHeader),
                      HeaderBoxWidget(
                        title: 'Choose Your Character',
                        subtitle: 'Select a character to start your adventure!',
                        imagePath: Assets.imagesHappyMic,
                      ),
                    ],
                  ),
                ),

                const VerticalSpace(0.5),

                Expanded(
                  child: LayoutBuilder(
                    builder: (context, constraints) {
                      return GridView.builder(
                        shrinkWrap: true,
                        padding: const EdgeInsets.all(8),
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: constraints.maxWidth > 600 ? 3 : 2,
                          crossAxisSpacing: 5,
                          mainAxisSpacing: 5,
                          childAspectRatio: 0.8,
                        ),

                        itemCount: listCharacters.length,
                        itemBuilder: (context, index) {
                          final character = listCharacters[index];
                          return CardWidget(
                            imagePath: character.imagePath,
                            title: character.name,
                            description: character.description,
                            onTap: () {
                              Navigator.push(
                                context,
                                AssistantPage.route(
                                  lang: _lang!,
                                  character: character,
                                  activity: widget.activitie,
                                ),
                              );
                            },
                          );
                        },
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
