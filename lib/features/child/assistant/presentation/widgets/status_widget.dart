import 'package:flutter/material.dart';
import 'package:livekit_client/livekit_client.dart';
import 'package:livekit_components/livekit_components.dart'
    hide ParticipantKind, AgentState;
import 'package:provider/provider.dart';
import 'package:voca_grow_app/features/child/assistant/assistant.dart';

/// Shows a visualizer for the agent participant in the room
/// This widget:
/// 1. Finds the agent participant in the room
/// 2. Listens to their audio track
/// 3. Shows a waveform visualization of their audio
/// 4. Adjusts opacity based on agent state (speaking/thinking/listening)
class StatusWidget extends StatefulWidget {
  const StatusWidget({super.key});

  @override
  State<StatusWidget> createState() => _StatusWidgetState();
}

class _StatusWidgetState extends State<StatusWidget> {
  @override
  Widget build(BuildContext context) {
    return Consumer<RoomContext>(
      builder: (context, roomContext, child) {
        // Find the agent participant in the room
        // LiveKit supports different participant types (agent/client/subscriber)
        // We only care about the agent participant here
        return ChangeNotifierProvider.value(
          value:
              roomContext.room.remoteParticipants.values
                  .where((p) => p.kind == ParticipantKind.AGENT)
                  .firstOrNull,
          child: Consumer<RemoteParticipant?>(
            builder: (context, agentParticipant, child) {
              // If no agent participant yet, show nothing
              if (agentParticipant == null) {
                return const SizedBox.shrink();
              }

              // Listen to the agent's metadata attributes
              // These include the agent's state (speaking/thinking/listening)
              return ChangeNotifierProvider(
                create: (context) => ParticipantContext(agentParticipant),
                child: ParticipantAttributes(
                  builder: (context, attributes) {
                    // Get the agent's state from their metadata
                    // LiveKit uses a 'lk.agent.state' attribute to track this
                    final agentState = AgentState.fromString(
                      attributes?['lk.agent.state'] ?? 'initializing',
                    );

                    // Get the agent's audio track for visualization
                    final audioTrack =
                        agentParticipant
                                .audioTrackPublications
                                .firstOrNull
                                ?.track
                            as AudioTrack?;

                    // If no audio track yet, show nothing
                    if (audioTrack == null) {
                      return const SizedBox.shrink();
                    }

                    // Show the waveform with opacity based on agent state
                    return AnimatedOpacityWidget(
                      agentState: agentState,
                      child: SoundWaveformWidget(
                        audioTrack: audioTrack,
                        participant: agentParticipant,
                        options: AudioVisualizerWidgetOptions(
                          barCount: 7,
                          width: 32,
                          minHeight: 32,
                          maxHeight: 256,
                          color: Theme.of(context).primaryColor,
                        ),
                      ),
                    );
                  },
                ),
              );
            },
          ),
        );
      },
    );
  }
}
