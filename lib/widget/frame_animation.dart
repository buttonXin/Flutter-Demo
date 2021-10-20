import 'package:flutter/material.dart';

class FrameImageAnimation extends StatefulWidget {
  final List<String> imageAssets;
  final double? width;
  final double? height;
  Duration? duration;

  FrameImageAnimation(this.imageAssets,
      {this.width, this.height, this.duration, Key? key})
      : assert(imageAssets != null),
        super(key: key);

  @override
  State<StatefulWidget> createState() {
    return new _WOActionImageState();
  }
}

class _WOActionImageState extends State<FrameImageAnimation> {
  late bool _disposed;
  late Duration _duration;
  late int _imageIndex;
  late Container _container;

  @override
  void initState() {
    super.initState();
    _disposed = false;
    _duration = widget.duration ?? Duration(milliseconds: 400);
    _imageIndex = 0;
    _container = Container(height: widget.height, width: widget.width);
    _updateImage();
  }

  void _updateImage() {
    if (_disposed || widget.imageAssets.isEmpty) {
      return;
    }

    setState(() {
      if (_imageIndex>= widget.imageAssets.length) {
        _imageIndex = 0;
      }
      _container = Container(
          child: Image.asset(widget.imageAssets[_imageIndex]),
          height: widget.height,
          width: widget.width);
      _imageIndex++;
    });
    Future.delayed(_duration, () {
      _updateImage();
    });
  }

  @override
  void dispose() {
    super.dispose();
    _disposed = true;
    widget.imageAssets.clear();
  }

  @override
  Widget build(BuildContext context) {
    return _container;
  }
}
