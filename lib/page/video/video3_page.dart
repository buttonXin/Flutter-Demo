import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class ChewieDemo extends StatefulWidget {
  ChewieDemo({this.title = 'Chewie Demo'});

  final String title;

  @override
  State<StatefulWidget> createState() {
    return _ChewieDemoState();
  }
}

class _ChewieDemoState extends State<ChewieDemo> {
  TargetPlatform _platform;
  VideoPlayerController _videoPlayerController1;
  VideoPlayerController _videoPlayerController2;
  ChewieController _chewieController;

  @override
  void initState() {
    super.initState();
    _videoPlayerController1 = VideoPlayerController.asset('images/lgu_tutorial_0731.mp4');
//        'http://jzvd.nathen.cn/c6e3dc12a1154626b3476d9bf3bd7266/6b56c5f0dc31428083757a45764763b0-5287d2089db37e62345123a1be272f8b.mp4');
    _videoPlayerController2 = VideoPlayerController.network(
        'https://www.sample-videos.com/video123/mp4/480/asdasdas.mp4');
    _chewieController = ChewieController(
      videoPlayerController: _videoPlayerController1,
      aspectRatio: 3 / 2,
      autoPlay: true,
      looping: false,
      // Try playing around with some of these other options:

//       showControls: false,
//      customControls: Text('data',style: TextStyle(fontSize: 30,color: Colors.white),)
      materialProgressColors: ChewieProgressColors(
        playedColor: Colors.lightGreen,
//         handleColor: Colors.blue,
//         backgroundColor: Colors.grey,
        bufferedColor: Colors.grey,
      ),
//       placeholder: Container(
//         color: Colors.grey,
//       ),
      // autoInitialize: true,
    );
  }

  @override
  void dispose() {
    _videoPlayerController1.dispose();
    _videoPlayerController2.dispose();
    _chewieController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: widget.title,
//      theme: ThemeData.light().copyWith(
//        platform: _platform ?? Theme.of(context).platform,
//      ),
      theme: ThemeData(
        brightness: Brightness.dark,
        primaryColor: Color(0xFF25252E),
        scaffoldBackgroundColor: Color(0xFF25252E),
        dividerColor: Color(0xFF141414),),
      home: WillPopScope(
        // ignore: missing_return
        onWillPop: () async {
          if(_chewieController!= null ){
            _chewieController.exitFullScreen();

          }
        },
        child: Scaffold(
//          appBar: AppBar(
//            title: Text(widget.title),
//          ),
          body: Column(
            children: <Widget>[
              Expanded(
                child: Center(
                  child: Chewie(
                    controller: _chewieController,
                  ),
                ),
              ),


            ],
          ),
        ),
      ),
    );
  }
}
