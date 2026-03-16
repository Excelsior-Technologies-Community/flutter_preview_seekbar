import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'package:flutter_preview_seekbar/flutter_preview_seekbar.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  late VideoPlayerController controller;
  double progress = 0;

  @override
  void initState() {
    super.initState();

    controller = VideoPlayerController.networkUrl(
      Uri.parse(
        "https://flutter.github.io/assets-for-api-docs/assets/videos/bee.mp4",
      ),
    )
      ..initialize().then((_) {
        setState(() {});
      });

    controller.addListener(() {
      if (controller.value.isInitialized) {
        final pos = controller.value.position.inMilliseconds;
        final dur = controller.value.duration.inMilliseconds;

        if (dur > 0) {
          setState(() {
            progress = pos / dur;
          });
        }
      }
    });
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  void seekVideo(double value) {
    final dur = controller.value.duration;
    final newPos = dur * value;
    controller.seekTo(newPos);
  }

  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Colors.black,
        body: Center(
          child: controller.value.isInitialized
              ? Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [

              /// VIDEO
              AspectRatio(
                aspectRatio: controller.value.aspectRatio,
                child: VideoPlayer(controller),
              ),

              const SizedBox(height: 20),

              /// SEEK BAR
              Padding(
                padding: const EdgeInsets.all(16),
                child: PreviewSeekbar(
                  value: progress,
                  buffer: controller.value.buffered.isNotEmpty
                      ? controller.value.buffered.last.end.inMilliseconds /
                      controller.value.duration.inMilliseconds
                      : 0,
                  duration: controller.value.duration,
                  previewChild: Container(
                    width: 120,
                    height: 60,
                    color: Colors.grey,
                    alignment: Alignment.center,
                    child: const Text(
                      "Preview",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                  onChanged: seekVideo,
                ),
              ),

              /// PLAY BUTTON
              IconButton(
                icon: Icon(
                  controller.value.isPlaying
                      ? Icons.pause
                      : Icons.play_arrow,
                  color: Colors.white,
                  size: 40,
                ),
                onPressed: () {
                  setState(() {
                    controller.value.isPlaying
                        ? controller.pause()
                        : controller.play();
                  });
                },
              )
            ],
          )
              : const CircularProgressIndicator(),
        ),
      ),
    );
  }
}