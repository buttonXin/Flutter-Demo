import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class VideoPage extends StatefulWidget {
  String? _name;

  String? get getName => _name;

  @override
  _VideoPageState createState() => _VideoPageState();

  VideoPage({Key? key}) : super(key: key);
}

class _VideoPageState extends State<VideoPage> {
  String videoUrl =
      'http://jzvd.nathen.cn/342a5f7ef6124a4a8faf00e738b8bee4/cf6d9db0bd4d41f59d09ea0a81e918fd-5287d2089db37e62345123a1be272f8b.mp4';

  late VideoPlayerController _videoPlayerController;
  late VideoPlayerController _controller;
  Future<void>? _initializeVideoPlayerFuture;
  bool loading = false;

  @override
  void initState() {
    // Create an store the VideoPlayerController. The VideoPlayerController
    // offers several different constructors to play videos from assets, files,
    // or the internet.
    _videoPlayerController = VideoPlayerController.network(
      'https://flutter.github.io/assets-for-api-docs/assets/videos/butterfly.mp4',
    );

    _initializeVideoPlayerFuture = _videoPlayerController.initialize();

    playStart(true);

    super.initState();
  }

  playStart(bool initialLoad) async {

    if (!loading) {
      setState(() {
        loading = true;
      });


      if (!initialLoad) {
        await _videoPlayerController.pause();
        await _videoPlayerController.seekTo(Duration(seconds: 0));
      }
      VideoPlayerController videoPlayer =
      VideoPlayerController.network(videoUrl);
      await videoPlayer.initialize();

      double aspectRatio =
          videoPlayer.value.size.width / videoPlayer.value.size.height;


    }


  }


  @override
  void dispose() {
    // Ensure disposing of the VideoPlayerController to free up resources.
    _controller.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Butterfly Video'),
      ),
      // Use a FutureBuilder to display a loading spinner while waiting for the
      // VideoPlayerController to finish initializing.
      body: FutureBuilder(
        future: _initializeVideoPlayerFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            // If the VideoPlayerController has finished initialization, use
            // the data it provides to limit the aspect ratio of the video.
            return Column(
              children: [
                AspectRatio(
                  aspectRatio: _controller.value.aspectRatio,
                  // Use the VideoPlayer widget to display the video.
                  child: VideoPlayer(_controller),
                ),
                Text(
                    '时间长度 ${_controller.value.duration.inMinutes}:${_controller.value.duration.inSeconds}'),
              ],
            );
          } else {
            // If the VideoPlayerController is still initializing, show a
            // loading spinner.
            return Center(child: CircularProgressIndicator());
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Wrap the play or pause in a call to `setState`. This ensures the
          // correct icon is shown.
          setState(() {
            // If the video is playing, pause it.
            if (_controller.value.isPlaying) {
              _controller.pause();
            } else {
              // If the video is paused, play it.
              _controller.play();
            }
          });
        },
        // Display the correct icon depending on the state of the player.
        child: Icon(
          _controller.value.isPlaying ? Icons.pause : Icons.play_arrow,
        ),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}


