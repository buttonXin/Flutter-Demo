// debounce.dart

import 'dart:async';

/// 函数防抖
///
/// [func]: 要执行的方法
/// [delay]: 要迟延的时长
Function debounce(
  Function func, [
  Duration delay = const Duration(milliseconds: 2000),
]) {
  Timer? timer;
  Function target = () {
    if (timer?.isActive ?? false) {
      timer?.cancel();
    }
    timer = Timer(delay, () {
      func?.call();
    });
  };
  return target;
}

/// 防抖
/// example
/// ```dart
/// @params _fn    回掉函数
/// @params delay  间隔时间
/// debounce(() {}, 2)
/// ```
Function debounce2(Function _fn, int delay) {
  Timer? _time;
  return () {
    if (_time != null) {
      _time!.cancel();
      _time = Timer(Duration(milliseconds: delay * 1000), () {
        _fn();
      });
    } else {
      _time = Timer(Duration(milliseconds: delay * 1000), () {
        _fn();
      });
    }
  };
}

DateTime? lastPopTime;

bool fastClick() {
  // 防重复提交
  if (lastPopTime == null ||
      DateTime.now().difference(lastPopTime!) > Duration(seconds: 2)) {
    lastPopTime = DateTime.now();
    return false;
  } else {
    return true;
  }
}
