import 'dart:io';

import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class videoPage extends StatefulWidget {
  final String filePath;
  const videoPage({Key? key, required this.filePath}) : super(key: key);

  @override
  State<videoPage> createState() => _videoPageState();
}

class _videoPageState extends State<videoPage> {
  late VideoPlayerController _videoPlayerController;

  @override
  void dispose() {
    _videoPlayerController.dispose();
    super.dispose();
  }

  Future _initVideoPlayer() async {
    _videoPlayerController = VideoPlayerController.file(File(widget.filePath));
    await _videoPlayerController.initialize();
    await _videoPlayerController.setLooping(true);
    await _videoPlayerController.play();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.black87,
        appBar: AppBar(
          title: Text("Preview"),
          elevation: 0,
          backgroundColor: Colors.black26,
          actions: [
            IconButton(
              icon: Icon(Icons.check),
              onPressed: () {
                print(
                    "do something with file"); // upload video file to firebase
              },
            )
          ],
        ),
        extendBodyBehindAppBar: true,
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            FutureBuilder(
                future: _initVideoPlayer(),
                builder: (context, state) {
                  if (state.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  } else {
                    return AspectRatio(
                      aspectRatio: _videoPlayerController.value.aspectRatio,
                      child: VideoPlayer(_videoPlayerController),
                    );
                  }
                }),
          ],
        ),
      ),
    );
  }
}
