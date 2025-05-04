import 'package:flutter/material.dart';
import 'package:livekit_client/livekit_client.dart'
    as livekit
    show ConnectionState;
import 'package:provider/provider.dart';
import 'package:livekit_components/livekit_components.dart'
    hide DisconnectButton;
import 'package:voca_grow_app/core/widgets/widgets.dart';
import 'package:voca_grow_app/features/child/assistant/assistant.dart';

/// Possible states for the control bar UI
/// - disconnected: Not connected to a LiveKit room
/// - connected: Successfully connected and streaming
/// - transitioning: Currently connecting or disconnecting
enum Configuration { disconnected, connected, transitioning }

/// The main control interface for the voice assistant
/// Handles:
/// - Connecting to LiveKit rooms
/// - Disconnecting from rooms
/// - Toggling microphone
/// - Displaying audio visualization
class ControlBar extends StatefulWidget {
  final Future<void> Function(RoomContext roomContext)? onConnectSuccess;
  const ControlBar({super.key, this.onConnectSuccess});

  @override
  State<ControlBar> createState() => _ControlBarState();
}

class _ControlBarState extends State<ControlBar> {
  // Track connection state transitions
  bool isConnecting = false;
  bool isDisconnecting = false;

  // Helper to determine the current UI configuration based on connection state
  Configuration get currentConfiguration {
    if (isConnecting || isDisconnecting) {
      return Configuration.transitioning;
    }

    // Check the LiveKit room's connection state
    final roomContext = context.read<RoomContext>();
    if (roomContext.room.connectionState ==
        livekit.ConnectionState.disconnected) {
      return Configuration.disconnected;
    } else {
      return Configuration.connected;
    }
  }

  /// Connects to a LiveKit room by:
  /// 1. Generating random room/participant names
  /// 2. Getting connection details from TokenService
  /// 3. Connecting to the room using RoomContext
  /// 4. Enabling the microphone
  Future<void> connect() async {
    final roomContext = context.read<RoomContext>();
    final tokenService = context.read<TokenService>();

    setState(() {
      isConnecting = true;
    });

    try {
      // Generate random room and participant names
      // In a real app, you'd likely use meaningful names
      final roomName =
          'room-${(1000 + DateTime.now().millisecondsSinceEpoch % 9000)}';
      final participantName =
          'user-${(1000 + DateTime.now().millisecondsSinceEpoch % 9000)}';

      // Get connection details from token service
      final connectionDetails = await tokenService.fetchConnectionDetails(
        roomName: roomName,
        participantName: participantName,
      );

      if (connectionDetails == null) {
        throw Exception('Failed to get connection details');
      }

      // Connect to the LiveKit room
      await roomContext.connect(
        url: connectionDetails.serverUrl,
        token: connectionDetails.participantToken,
      );

      // if (mounted) {
      //   ScaffoldMessenger.of(context).showSnackBar(
      //     SnackBar(
      //       content: Text(
      //         'Successfully connected to the room: ${roomContext.room.name}',
      //       ),
      //       backgroundColor: Colors.green,
      //     ),
      //   );
      // }

      await widget.onConnectSuccess?.call(roomContext);

      // Enable the microphone after connecting
    } catch (error) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              'Failed to connect to the room. Please try again: [$error]',
            ),
            backgroundColor: Theme.of(context).colorScheme.errorContainer,
          ),
        );
      }
    } finally {
      setState(() {
        isConnecting = false;
      });
    }
  }

  /// Disconnects from the current LiveKit room
  Future<void> disconnect() async {
    final roomContext = context.read<RoomContext>();

    setState(() {
      isDisconnecting = true;
    });

    await roomContext.disconnect();

    setState(() {
      isDisconnecting = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Spacer(),

        // Show different buttons based on connection state
        Builder(
          builder: (context) {
            switch (currentConfiguration) {
              case Configuration.disconnected:
                return SubmitButtonWidget(
                  text: 'Start a Conversation'.toUpperCase(),
                  onPressed: connect,
                  width: 250,
                  height: 50,
                );

              case Configuration.connected:
                return Row(
                  children: [
                    const AudioControls(),
                    const SizedBox(width: 16),
                    DisconnectButton(onPressed: disconnect),
                  ],
                );

              case Configuration.transitioning:
                return SubmitButtonWidget(
                  text:
                      (isConnecting ? 'Connecting…' : 'Disconnecting…')
                          .toUpperCase(),
                  isLoading: true,
                  onPressed: null,
                  width: 250,
                  height: 50,
                );
            }
          },
        ),

        const Spacer(),
      ],
    );
  }
}
