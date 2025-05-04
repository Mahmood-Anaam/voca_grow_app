import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:livekit_client/livekit_client.dart';
import 'package:livekit_components/livekit_components.dart';
import 'package:voca_grow_app/features/child/assistant/assistant.dart';

/// Audio controls shown when connected
class AudioControls extends StatelessWidget {
  const AudioControls({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<RoomContext>(
      builder: (context, roomContext, _) {
        final isMicEnabled = roomContext.isMicrophoneEnabled ?? false;
        final micTrack =
            roomContext.localParticipant
                    ?.getTrackPublicationBySource(TrackSource.microphone)
                    ?.track
                as AudioTrack?;

        return Container(
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.primary.withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(8),
          ),
          padding: const EdgeInsets.only(right: 12),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              IconButton(
                icon: Icon(
                  isMicEnabled ? Icons.mic : Icons.mic_off,
                  color: Theme.of(context).colorScheme.primary,
                ),
                onPressed: () {
                  roomContext.localParticipant?.setMicrophoneEnabled(
                    !isMicEnabled,
                  );
                },
              ),
              LocalAudioVisualizer(
                audioTrack: micTrack,
                color: Theme.of(context).colorScheme.primary,
              ),
            ],
          ),
        );
      },
    );
  }
}