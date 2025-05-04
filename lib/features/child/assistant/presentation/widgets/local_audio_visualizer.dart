import 'package:flutter/material.dart';
import 'package:livekit_client/livekit_client.dart';

/// Audio visualizer that displays thin bars that scale from the center
class LocalAudioVisualizer extends StatefulWidget {
  final AudioTrack? audioTrack;
  final Color color;

  const LocalAudioVisualizer({
    super.key,
    required this.audioTrack,
    this.color = Colors.red,
  });

  @override
  State<LocalAudioVisualizer> createState() => _LocalAudioVisualizerState();
}

class _LocalAudioVisualizerState extends State<LocalAudioVisualizer> {
  static const int sampleCount = 7;
  List<double> samples = List.filled(
    sampleCount,
    0.05,
  ); // Minimum scale of 0.05
  EventsListener<TrackEvent>? _listener;

  void _startVisualizer(AudioTrack? track) {
    // Clear previous listener
    _stopVisualizer();

    // Reset visualizer immediately for null tracks
    if (track == null) {
      _resetVisualizer();
      return;
    }

    _listener = track.createListener();
    _listener?.on<AudioVisualizerEvent>((e) {
      if (mounted) {
        setState(() {
          samples =
              e.event
                  .take(sampleCount)
                  .map((e) => ((e as num).toDouble() * 2).clamp(0.05, 1.0))
                  .toList();
          while (samples.length < sampleCount) {
            samples.add(0.05);
          }
        });
      }
    });
  }

  void _resetVisualizer() {
    if (mounted) {
      setState(() {
        samples = List.filled(sampleCount, 0.05);
      });
    }
  }

  @override
  void didUpdateWidget(LocalAudioVisualizer oldWidget) {
    super.didUpdateWidget(oldWidget);
    // Always call _startVisualizer, which will handle the null case properly
    _startVisualizer(widget.audioTrack);
  }

  void _stopVisualizer() {
    _listener?.dispose();
  }

  @override
  void initState() {
    super.initState();
    _startVisualizer(widget.audioTrack);
  }

  @override
  void dispose() {
    _stopVisualizer();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      // Add a SizedBox to constrain the size
      height: 44, // Provide a reasonable height
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: List.generate(
            sampleCount,
            (index) => Padding(
              padding: EdgeInsets.only(right: index < sampleCount - 1 ? 3 : 8),
              child: Transform.scale(
                scaleY:
                    index < samples.length
                        ? samples[index]
                        : 0.05, // Safely access samples
                alignment: Alignment.center,
                child: Container(
                  width: 2,
                  height: 36, // Set a fixed height for the base bar
                  color: widget.color,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
