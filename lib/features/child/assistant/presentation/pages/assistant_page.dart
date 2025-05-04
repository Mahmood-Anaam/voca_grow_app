import 'package:flutter/material.dart';
import 'package:livekit_client/livekit_client.dart';
import 'package:livekit_components/livekit_components.dart' hide ControlBar;
import 'package:provider/provider.dart';
import 'package:voca_grow_app/features/child/assistant/assistant.dart';
import 'package:voca_grow_app/core/utils/utils.dart';
import 'package:voca_grow_app/core/widgets/widgets.dart';
import 'package:voca_grow_app/features/child/activities/activities.dart';
import 'package:voca_grow_app/features/child/characters/characters.dart';

class AssistantPage extends StatefulWidget {
  final CharacterModel character;
  final ActivitieModel activity;
  final String lang;

  const AssistantPage({
    super.key,
    required this.lang,
    required this.character,
    required this.activity,
  });

  static Route<void> route({
    String lang = 'ar',
    required CharacterModel character,
    required ActivitieModel activity,
  }) {
    return MaterialPageRoute<void>(
      builder:
          (_) => AssistantPage(
            lang: lang,
            character: character,
            activity: activity,
          ),
    );
  }

  @override
  State<AssistantPage> createState() => _AssistantPageState();
}

class _AssistantPageState extends State<AssistantPage> {
  // Create a LiveKit Room instance with audio visualization enabled
  final room = Room(roomOptions: const RoomOptions(enableVisualizer: true));

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      // Provide the TokenService and RoomContext to descendant widgets
      // TokenService handles LiveKit authentication
      // RoomContext provides LiveKit room state and operations
      providers: [
        ChangeNotifierProvider(create: (context) => TokenService()),
        ChangeNotifierProvider(create: (context) => RoomContext(room: room)),
      ],
      child: SafeArea(
        child: Scaffold(
          appBar: AppBar(title: const Text('Ai Assistant')),
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
                    child: HeaderBoxWidget(
                      title: 'Welcome to Voca Grow',
                      subtitle: 'Let\'s start learning',
                      imagePath: Assets.imagesHappyMic,
                    ),
                  ),
                  Expanded(
                    child: Center(
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          spacing: 24,
                          children: [
                            // Status widget shows the agent's audio visualization
                            ConstrainedBox(
                              constraints: const BoxConstraints(
                                maxWidth: 512,
                                minHeight: 256,
                                maxHeight: 256,
                              ),
                              child: const StatusWidget(),
                            ),
                            // Control bar handles room connection and audio controls
                            ControlBar(
                              onConnectSuccess: (roomContext) async {
                                await roomContext.localParticipant
                                    ?.setMicrophoneEnabled(true);
                                roomContext.localParticipant?.setAttributes({
                                  "lang": widget.lang,
                                  "character": widget.character.name,
                                  "activitie": widget.activity.name,
                                });
                              },
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
