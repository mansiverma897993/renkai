import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import '../../../core/theme/app_colors.dart';

class MeditationPlayerScreen extends StatefulWidget {
  final String title;
  final bool isAmbient;

  const MeditationPlayerScreen({
    super.key,
    required this.title,
    this.isAmbient = false,
  });

  @override
  State<MeditationPlayerScreen> createState() => _MeditationPlayerScreenState();
}

class _MeditationPlayerScreenState extends State<MeditationPlayerScreen> {
  late AudioPlayer _audioPlayer;
  bool _isPlaying = false;
  Duration _duration = Duration.zero;
  Duration _position = Duration.zero;

  @override
  void initState() {
    super.initState();
    _audioPlayer = AudioPlayer();
    _initAudio();
  }

  Future<void> _initAudio() async {
    try {
      // Using a valid open source soothing audio for demo purposes.
      // In production, this would grab from the backend or local assets.
      final url = widget.isAmbient 
          ? 'https://cdn.pixabay.com/download/audio/2022/02/07/audio_c6f2df63da.mp3?filename=forest-wind-and-birds-6861.mp3'
          : 'https://cdn.pixabay.com/download/audio/2022/01/18/audio_82c6107386.mp3?filename=relaxing-music-vol1-124477.mp3';

      await _audioPlayer.setUrl(url);

      _audioPlayer.playerStateStream.listen((state) {
        if (mounted) {
          setState(() {
            _isPlaying = state.playing;
          });
        }
      });

      _audioPlayer.durationStream.listen((d) {
        if (mounted && d != null) {
          setState(() {
            _duration = d;
          });
        }
      });

      _audioPlayer.positionStream.listen((p) {
        if (mounted) {
          setState(() {
            _position = p;
          });
        }
      });
      
      // Auto-play
      _audioPlayer.play();
    } catch (e) {
      debugPrint("Error loading audio: $e");
    }
  }

  @override
  void dispose() {
    _audioPlayer.dispose();
    super.dispose();
  }

  String _formatDuration(Duration d) {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    return "${twoDigits(d.inMinutes)}:${twoDigits(d.inSeconds.remainder(60))}";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.keyboard_arrow_down_rounded, color: Colors.black, size: 40),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 300,
              height: 300,
              decoration: BoxDecoration(
                color: widget.isAmbient ? Colors.grey[200] : const Color(0xFFFFC107).withOpacity(0.2),
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(color: (widget.isAmbient ? Colors.grey : const Color(0xFFFFC107)).withOpacity(0.3), blurRadius: 40, spreadRadius: 10)
                ],
                image: DecorationImage(
                  image: NetworkImage(
                    widget.isAmbient 
                      ? 'https://images.unsplash.com/photo-1518173946687-a4c8892bbd9f?q=80&w=300' // Nature
                      : 'https://images.unsplash.com/photo-1544367567-0f2fcb009e0b?q=80&w=300', // Meditation
                  ),
                  fit: BoxFit.cover,
                  colorFilter: ColorFilter.mode(Colors.black.withOpacity(0.2), BlendMode.darken),
                )
              ),
            ),
            const SizedBox(height: 50),
            Text(
              widget.title,
              style: const TextStyle(fontSize: 28, fontWeight: FontWeight.w900, color: Colors.black),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 10),
            Text(
              widget.isAmbient ? 'Ambient Soundscape' : 'Guided Session',
              style: TextStyle(fontSize: 16, color: Colors.grey[600], fontWeight: FontWeight.w500),
            ),
            const SizedBox(height: 40),
            
            // Progress Bar
            SliderTheme(
              data: SliderThemeData(
                trackHeight: 6,
                activeTrackColor: AppColors.primary,
                inactiveTrackColor: Colors.grey[300],
                thumbColor: AppColors.primary,
                overlayColor: AppColors.primary.withOpacity(0.2),
                thumbShape: const RoundSliderThumbShape(enabledThumbRadius: 8),
              ),
              child: Slider(
                min: 0.0,
                max: _duration.inMilliseconds.toDouble(),
                value: _position.inMilliseconds.toDouble().clamp(0.0, _duration.inMilliseconds.toDouble()),
                onChanged: (val) {
                  _audioPlayer.seek(Duration(milliseconds: val.toInt()));
                },
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(_formatDuration(_position), style: TextStyle(color: Colors.grey[600], fontWeight: FontWeight.w600)),
                Text(_formatDuration(_duration), style: TextStyle(color: Colors.grey[600], fontWeight: FontWeight.w600)),
              ],
            ),
            const SizedBox(height: 30),
            
            // Controls
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                IconButton(
                  icon: const Icon(Icons.replay_10_rounded, size: 36),
                  color: Colors.black87,
                  onPressed: () {
                    _audioPlayer.seek(_position - const Duration(seconds: 10));
                  },
                ),
                GestureDetector(
                  onTap: () {
                    if (_isPlaying) {
                      _audioPlayer.pause();
                    } else {
                      _audioPlayer.play();
                    }
                  },
                  child: Container(
                    padding: const EdgeInsets.all(20),
                    decoration: const BoxDecoration(
                      color: AppColors.primary,
                      shape: BoxShape.circle,
                      boxShadow: [BoxShadow(color: Colors.black26, blurRadius: 10, offset: Offset(0, 5))],
                    ),
                    child: Icon(_isPlaying ? Icons.pause_rounded : Icons.play_arrow_rounded, color: Colors.white, size: 40),
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.forward_10_rounded, size: 36),
                  color: Colors.black87,
                  onPressed: () {
                    _audioPlayer.seek(_position + const Duration(seconds: 10));
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
