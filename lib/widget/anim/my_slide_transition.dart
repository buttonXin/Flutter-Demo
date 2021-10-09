import 'package:flutter/material.dart';

class MySlideTransition extends AnimatedWidget {
  MySlideTransition({
    Key? key,
    required Animation<Offset> position,
    this.transformHitTests = true,
    this.child,
  })  : assert(position != null),
        super(key: key, listenable: position);

  Animation<Offset> get position => listenable as Animation<Offset>;
  final bool transformHitTests;
  final Widget? child;

  @override
  Widget build(BuildContext context) {
    Offset offset = position.value;

    if (position.status == AnimationStatus.reverse) {
      offset = Offset(-offset.dx, offset.dy);
    }
    return FractionalTranslation(
        translation: offset,
        transformHitTests: transformHitTests,
        child: child);
  }
}
