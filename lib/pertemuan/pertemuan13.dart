import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:video_player/video_player.dart';

class AudioVideo extends StatefulWidget {
  const AudioVideo({super.key});

  @override
  State<AudioVideo> createState() => _AudioVideoState();
}

class _AudioVideoState extends State<AudioVideo> {
  final AudioPlayer player = AudioPlayer();
  late VideoPlayerController _controller;

  @override
  void initState() {
    super.initState();
    // Membaca file video 'nopal.mp4' dari folder web/
    _controller = VideoPlayerController.networkUrl(
      Uri.parse('nopal.mp4'),
    )..initialize().then((_) {
      setState(() {});
    });
  }

  @override
  void dispose() {
    player.dispose();
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Audio & Video Player Lokal")),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 20),
            const Text("Audio Player", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: () async {
                    // Membaca file audio 'antihero.mp3' dari folder web/
                    await player.play(UrlSource('antihero.mp3'));
                  },
                  child: const Text("Play Audio"),
                ),
                const SizedBox(width: 10),
                ElevatedButton(
                  onPressed: () async {
                    await player.pause();
                  },
                  child: const Text("Pause Audio"),
                ),
                const SizedBox(width: 10),
                ElevatedButton(
                  onPressed: () async {
                    await player.stop();
                  },
                  child: const Text("Stop Audio"),
                ),
              ],
            ),
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 20),
              child: Divider(),
            ),
            const Text("Video Player", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
            const SizedBox(height: 10),
            _controller.value.isInitialized
                ? AspectRatio(
              aspectRatio: _controller.value.aspectRatio,
              child: VideoPlayer(_controller),
            )
                : const CircularProgressIndicator(),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  icon: const Icon(Icons.play_arrow),
                  onPressed: () {
                    _controller.play();
                  },
                ),
                IconButton(
                  icon: const Icon(Icons.pause),
                  onPressed: () {
                    _controller.pause();
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