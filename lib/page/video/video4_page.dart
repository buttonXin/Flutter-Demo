import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'package:videos_player/model/control.model.dart';
import 'package:videos_player/model/video.model.dart';
import 'package:videos_player/util/theme.util.dart';
import 'package:videos_player/videos_player.dart';

class Video4Page extends StatefulWidget {
  Video4Page({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _Video4PageState createState() => _Video4PageState();
}

class _Video4PageState extends State<Video4Page> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: VideosPlayer(
        networkVideos: [
          new NetworkVideo(
              id: "2",
              name: "Elephant Dream",
              videoUrl:
              "https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ElephantsDream.mp4",
              thumbnailUrl:
              "https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/images/ElephantsDream.jpg",
              videoControl: new NetworkVideoControl(
                fullScreenByDefault: true,
              )),
          new NetworkVideo(
              id: "3",
              name: "Big Buck Bunny",
              videoUrl:
              "https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/BigBuckBunny.mp4",
              thumbnailUrl:
              "https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/images/BigBuckBunny.jpg",
              videoControl: new NetworkVideoControl(autoPlay: true)),
          new NetworkVideo(
              id: "4",
              name: "For Bigger Blazes",
              videoUrl:
              "https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ForBiggerBlazes.mp4",
              thumbnailUrl:
              "https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/images/ForBiggerBlazes.jpg"),
          new NetworkVideo(
              id: "5",
              name: "For Bigger Escape",
              videoUrl:
              "https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ForBiggerEscapes.mp4",
              thumbnailUrl:
              "https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/images/ForBiggerEscapes.jpg"),
          new NetworkVideo(
              id: "6",
              name: "For Bigger Fun",
              videoUrl:
              "https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ForBiggerFun.mp4",
              thumbnailUrl:
              "https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/images/ForBiggerFun.jpg"),
          new NetworkVideo(
              id: "7",
              name: "For Bigger Joyrides",
              videoUrl:
              "https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ForBiggerJoyrides.mp4",
              thumbnailUrl:
              "https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/images/ForBiggerJoyrides.jpg"),
        ],
        playlistStyle: Style.Style2,
      ),
    );
  }
}
